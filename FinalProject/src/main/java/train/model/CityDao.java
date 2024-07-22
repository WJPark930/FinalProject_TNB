package train.model;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("CityDao")
public class CityDao {

    @Autowired
    SqlSessionTemplate sqlSessionTemplate;

    private String namespace = "train.model.City";
    private final String serviceKey = "n20xP5BlvDWz6kPfeoouhcKgAsLAzwDjcsHaGK7LvwVfMUKr%2ByjFDw7a7Q4ZtrGLj6aYPJdy1%2Bl%2FVZgcwXRETg%3D%3D";

    private long lastUpdateTime = 0;
    private static final long ONE_DAY_MILLIS = 24 * 60 * 60 * 1000;

    public void scheduledUpdateCityList() throws IOException {
    	System.out.println("scheduledUpdateCityList 실행");
        long currentTime = System.currentTimeMillis();
        boolean isDataEmpty = isCityDataEmpty();
        if (isDataEmpty || (currentTime - lastUpdateTime >= ONE_DAY_MILLIS)) {
            updateCityList();
            lastUpdateTime = currentTime;
        }
    }
    
    private boolean isCityDataEmpty() {
        List<CityBean> existingCities = sqlSessionTemplate.selectList(namespace + ".getCityList");
        return existingCities == null || existingCities.isEmpty();
    }
    
    public void updateCityList() throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/TrainInfoService/getCtyCodeList"); /* URL */
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + serviceKey); /* Service Key */
        urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /* 데이터 타입(xml, json) */
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
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

        // JSON 파싱 및 데이터베이스 저장
        try {
            JSONObject jsonObject = new JSONObject(sb.toString());
            JSONArray cityArray = jsonObject.getJSONObject("response").getJSONObject("body").getJSONObject("items").getJSONArray("item");

            // 기존 데이터 조회
            List<CityBean> existingCities = sqlSessionTemplate.selectList(namespace + ".getCityList");
            Map<Integer, CityBean> existingCitiesMap = new HashMap<Integer, CityBean>();
            for (CityBean city : existingCities) {
                existingCitiesMap.put(city.getCityId(), city);
            }

            // 새로운 데이터와 비교하여 업데이트
            for (int i = 0; i < cityArray.length(); i++) {
                JSONObject city = cityArray.getJSONObject(i);
                int cityId = city.getInt("citycode");
                String cityName = city.getString("cityname");

                if (existingCitiesMap.containsKey(cityId)) {
                	// 기존 데이터에 존재하는 경우
                    CityBean existingCity = existingCitiesMap.get(cityId);
                    if (!existingCity.getCityName().equals(cityName)) {
                    	// 이름이 다르면 업데이트
                        existingCity.setCityName(cityName);
                        sqlSessionTemplate.update(namespace + ".updateCity", existingCity);
                    }
                    existingCitiesMap.remove(cityId); // 처리된 항목 제거
                } else {
                	// 기존 데이터에 없는 경우 삽입
                    CityBean newCity = new CityBean();
                    newCity.setCityId(cityId);
                    newCity.setCityName(cityName);
                    sqlSessionTemplate.insert(namespace + ".insertCity", newCity);
                }
            }

            // 기존 데이터 중 새 데이터에 없는 항목 삭제
            for (Integer cityId : existingCitiesMap.keySet()) {
                sqlSessionTemplate.delete(namespace + ".deleteCity", cityId);
            }

        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    public List<CityBean> getCityList() {
    	
    	List<CityBean> list = new ArrayList<CityBean>();
		list = sqlSessionTemplate.selectList(namespace + ".getCityList");
        return list;
    }
}