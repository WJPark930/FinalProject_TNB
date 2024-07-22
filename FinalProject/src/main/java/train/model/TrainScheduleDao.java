package train.model;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("TrainScheduleDao")
public class TrainScheduleDao {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    private final String namespace = "train.model.TrainSchedule";
    
    public void insertTrainSchedule(String depStationId, String arrStationId, String formattedDate) throws Exception {
    	
    	String[] trainCodes = {"00", "07", "10", "16", "17", "19"};
    	
    	for (String trainCode : trainCodes) {
            try {
                StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/TrainInfoService/getStrtpntAlocFndTrainInfo");
                urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=n20xP5BlvDWz6kPfeoouhcKgAsLAzwDjcsHaGK7LvwVfMUKr%2ByjFDw7a7Q4ZtrGLj6aYPJdy1%2Bl%2FVZgcwXRETg%3D%3D");
                urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); 
                urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); 
                urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
                urlBuilder.append("&" + URLEncoder.encode("depPlaceId", "UTF-8") + "=" + URLEncoder.encode(depStationId, "UTF-8")); 
                urlBuilder.append("&" + URLEncoder.encode("arrPlaceId", "UTF-8") + "=" + URLEncoder.encode(arrStationId, "UTF-8"));
                urlBuilder.append("&" + URLEncoder.encode("depPlandTime", "UTF-8") + "=" + formattedDate); 
                urlBuilder.append("&" + URLEncoder.encode("trainGradeCode", "UTF-8") + "=" + trainCode);
                URL url = new URL(urlBuilder.toString());
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-type", "application/json");

                BufferedReader rd;
                if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                    rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8));
                } else {
                    rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8));
                }

                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = rd.readLine()) != null) {
                    sb.append(line);
                }
                rd.close();
                conn.disconnect();

                String jsonResponse = sb.toString();
                System.out.println("API Response: " + jsonResponse);

                JSONObject jsonObject = new JSONObject(jsonResponse);
                JSONObject body = jsonObject.getJSONObject("response").getJSONObject("body");

                if (body.isNull("items")) {
                    System.out.println("No items found in the API response.");
                    continue;
                }

                Object itemsObj = body.get("items");
                JSONArray itemsArray;

                if (itemsObj instanceof JSONObject) {
                    JSONObject itemsJsonObject = (JSONObject) itemsObj;
                    if (itemsJsonObject.has("item")) {
                        Object itemObj = itemsJsonObject.get("item");
                        if (itemObj instanceof JSONArray) {
                            itemsArray = (JSONArray) itemObj;
                        } else if (itemObj instanceof JSONObject) {
                            itemsArray = new JSONArray();
                            itemsArray.put(itemObj);
                        } else {
                            System.out.println("Unexpected item data type.");
                            continue;
                        }
                    } else {
                        System.out.println("No item found in the items object.");
                        continue;
                    }
                } else {
                    System.out.println("Unexpected items data type.");
                    continue;
                }

                if (itemsArray.length() == 0) {
                    System.out.println("Items array is empty.");
                    continue;
                }

                SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
                for (int i = 0; i < itemsArray.length(); i++) {
                    JSONObject item = itemsArray.getJSONObject(i);

                    long depPlandTimeLong = item.getLong("depplandtime");
                    long arrPlandTimeLong = item.getLong("arrplandtime");

                    String depPlandTimeStr = String.format("%014d", depPlandTimeLong);
                    String arrPlandTimeStr = String.format("%014d", arrPlandTimeLong);

                    Date depPlandTime = formatter.parse(depPlandTimeStr);
                    Date arrPlandTime = formatter.parse(arrPlandTimeStr);
                    
                    // Calculate the duration
                    long durationMillis = arrPlandTime.getTime() - depPlandTime.getTime();
                    long durationHours = durationMillis / (1000 * 60 * 60);
                    long durationMinutes = (durationMillis % (1000 * 60 * 60)) / (1000 * 60);
                    String duration = String.format("%01d시간 %02d분", durationHours, durationMinutes);

                    TrainScheduleBean trainSchedule = new TrainScheduleBean(
                            item.getString("depplacename") + "-" + item.getString("arrplacename") + "-" + trainCode + "-" + item.getInt("trainno") + "-" + depPlandTimeStr,
                            item.getInt("trainno"),
                            item.getString("depplacename"),
                            item.getString("arrplacename"),
                            item.getString("traingradename"),
                            depPlandTime,
                            arrPlandTime,
                            40,
                            item.getInt("adultcharge"),
                            duration
                    );

                    sqlSessionTemplate.insert(namespace + ".insertTrainSchedule", trainSchedule);
                }

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public List<TrainScheduleBean> getTrainSchedulesByChoice(String depPlaceName, String arrPlaceName, String depPlandTime) {
        Map<String, String> map = new HashMap<String, String>();
        map.put("depPlaceName", depPlaceName);
        map.put("arrPlaceName", arrPlaceName);
        map.put("depPlandTime", depPlandTime);
        return sqlSessionTemplate.selectList(namespace + ".getTrainSchedulesByChoice", map);
    }
    
    public TrainScheduleBean getTrainSchedulesById(String schedule_id) {
    	return sqlSessionTemplate.selectOne(namespace + ".getTrainSchedulesById", schedule_id);
    }
    
    public void truncateTrainSchedule() {
        sqlSessionTemplate.delete(namespace + ".truncateTrainSchedule");
    }
    
    public void updateSeatAvailable() {
    	
    }
    
}