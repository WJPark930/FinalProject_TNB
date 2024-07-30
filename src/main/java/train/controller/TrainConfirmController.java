package train.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import train.model.SeatDao;
import train.model.TrainScheduleBean;
import train.model.TrainScheduleDao;

@Controller
public class TrainConfirmController {

	private final String command = "trainConfirm.train";
    private final String getPage = "trainConfirm";
    
    @Autowired
    TrainScheduleDao trainScheduleDao;
    
    @Autowired
    SeatDao seatDao;

    @RequestMapping(command)
    public String list(
    		@RequestParam("schedule_id") String schedule_id,
    		@RequestParam(value = "adults", defaultValue = "0") int adults,
            @RequestParam(value = "children", defaultValue = "0") int children,
            @RequestParam(value = "seniors", defaultValue = "0") int seniors,
            @RequestParam("dep_station_id") String dep_station_id,
            @RequestParam("arr_station_id") String arr_station_id,
            @RequestParam("depPlandTime") String depPlandTime,
            @RequestParam("selectedSeats") String selectedSeats,
            @RequestParam(value = "personQty", required = false) Integer personQty,
            Model model) {
    	
        TrainScheduleBean schedule = trainScheduleDao.getTrainSchedulesById(schedule_id);
    	
    	int adultCharge = schedule.getAdult_charge();
        int childCharge = (int) Math.ceil(adultCharge * 0.5 / 100) * 100;  
        int seniorsCharge = (int) Math.ceil(adultCharge * 0.7 / 100) * 100; 
        int totalPrice = (adults * adultCharge) + (children * childCharge) + (seniors * seniorsCharge);
        
        model.addAttribute("schedule", schedule);
        model.addAttribute("dep_station_id", dep_station_id);
        model.addAttribute("arr_station_id", arr_station_id);
        model.addAttribute("depPlandTime", depPlandTime);
        model.addAttribute("adults", adults);
        model.addAttribute("children", children);
        model.addAttribute("seniors", seniors);
        model.addAttribute("selectedSeats", selectedSeats);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("personQty", personQty);
        
    	return getPage;
    }
}