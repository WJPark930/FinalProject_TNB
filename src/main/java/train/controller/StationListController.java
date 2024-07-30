package train.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import train.model.CityBean;
import train.model.CityDao;
import train.model.StationBean;
import train.model.StationDao;

@Controller
public class StationListController {

	private final String command = "station.train";
    private final String getPage = "station";  

    @Autowired
    CityDao cityDao;
    
    @Autowired
    StationDao stationDao;
    
    @RequestMapping(command)
    public String list(
    		@RequestParam(value = "dep_station_id", required = false) String depStationId,
            @RequestParam(value = "arr_station_id", required = false) String arrStationId,
            @RequestParam(value = "depPlandTime", required = false) String depPlandTime,
            @RequestParam(value = "personQty", required = false) Integer personQty,
    		Model model) {
        
    	try {
			cityDao.scheduledUpdateCityList();
		} catch (IOException e) {
			e.printStackTrace();
		}
    	
    	stationDao.insertFixedStations();
    	
    	List<CityBean> cityList = cityDao.getCityList();
    	
    	List<StationBean> stationList;
    	
        stationList = stationDao.getStationList();

        LocalDate now = LocalDate.now();
        LocalDate maxDate = now.plusDays(5);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        model.addAttribute("stationList", stationList);
        model.addAttribute("cityList", cityList);
        model.addAttribute("now", now.format(formatter));
        model.addAttribute("maxDate", maxDate.format(formatter));
        model.addAttribute("dep_station_id", depStationId);
        model.addAttribute("arr_station_id", arrStationId);
        model.addAttribute("depPlandTime", depPlandTime);
        model.addAttribute("personQty", personQty);
        
        if(depStationId != null && arrStationId != null) {
        	model.addAttribute("depStationName", stationDao.getStationName(depStationId));
        	model.addAttribute("arrStationName", stationDao.getStationName(arrStationId));
        }

        return getPage;
    }
}
