package train.controller;

import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import train.model.SeatBean;
import train.model.SeatDao;
import train.model.TrainScheduleBean;
import train.model.TrainScheduleDao;

@Controller
public class SeatListController {

    private final String command = "seat.train";
    private final String getPage = "seat";
    
    @Autowired
    SeatDao seatDao;

    @Autowired
    TrainScheduleDao trainScheduleDao;

    @RequestMapping(command)
    public String list(
    		@RequestParam(value = "schedule_id", required = false) String scheduleId,
            @RequestParam(value = "dep_station_id", required = false) String depStationId,
            @RequestParam(value = "arr_station_id", required = false) String arrStationId,
            @RequestParam(value = "depPlandTime", required = false) String depPlandTime,
            @RequestParam(value = "personQty", required = false) Integer personQty,
            Model model
            ) {
    	
    	TrainScheduleBean schedule = trainScheduleDao.getTrainSchedulesById(scheduleId);
    	List<SeatBean> reservedSeats = seatDao.getSeatsByScheduleId(scheduleId);
    	List<String> rowList = Arrays.asList("A", "B", "C", "D");
    	
    	// 같은일정에 예약된 좌석 가져오기
    	Set<String> reservedSeatNumbers = new HashSet<String>();
    	for (SeatBean seat : reservedSeats) {
    	    reservedSeatNumbers.add(seat.getSeat_no());
    	}
    	
		model.addAttribute("schedule", schedule);
		model.addAttribute("dep_station_id", depStationId);
		model.addAttribute("arr_station_id", arrStationId);
		model.addAttribute("depPlandTime", depPlandTime);
		model.addAttribute("reservedSeatNumbers", reservedSeatNumbers);
		model.addAttribute("rowList", rowList);
		model.addAttribute("personQty", personQty);
        
    	return getPage;
    }
}