package train.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import train.model.SeatDao;
import train.model.StationDao;
import train.model.TrainScheduleBean;
import train.model.TrainScheduleDao;

@Controller
public class TrainScheduleListController {

    private final String command = "trainSchedule.train";
    private final String getPage = "trainSchedule";
    
    @Autowired
    StationDao stationDao;

    @Autowired
    TrainScheduleDao trainScheduleDao;
    
    @Autowired
    SeatDao seatDao;

    @RequestMapping(command)
    public ModelAndView list(
    		@RequestParam("dep_station_id") String depStationId,
            @RequestParam("arr_station_id") String arrStationId,
            @RequestParam("depPlandTime") String depPlandTime,
            @RequestParam(value = "personQty", required = false) Integer personQty) throws Exception {
    	
        trainScheduleDao.truncateTrainSchedule();
    	
        LocalDate date = LocalDate.parse(depPlandTime, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        DateTimeFormatter formatt = DateTimeFormatter.ofPattern("yyyyMMdd");
        String formattedDate = date.format(formatt);
    
        trainScheduleDao.insertTrainSchedule(depStationId, arrStationId, formattedDate);
        
    	String depPlaceName = stationDao.getStationName(depStationId);
    	String arrPlaceName = stationDao.getStationName(arrStationId);

    	List<TrainScheduleBean> list = trainScheduleDao.getTrainSchedulesByChoice(depPlaceName,arrPlaceName,depPlandTime);
        
    	for (TrainScheduleBean schedule : list) {
    	    int reservedSeatsCount = seatDao.getReservedSeatCountByScheduleId(schedule.getSchedule_id());
    	    schedule.setSeat_available(40 - reservedSeatsCount);
    	}
    	
        ModelAndView mav = new ModelAndView(getPage);
        mav.addObject("depPlandTime", depPlandTime);
        mav.addObject("depPlaceName", depPlaceName);
        mav.addObject("arrPlaceName", arrPlaceName);
        mav.addObject("trainSchedules", list);
        
        mav.addObject("dep_station_id", depStationId);
        mav.addObject("arr_station_id", arrStationId);
        mav.addObject("depPlandTime", depPlandTime);
        mav.addObject("personQty", personQty);
        
        return mav;
    }
}