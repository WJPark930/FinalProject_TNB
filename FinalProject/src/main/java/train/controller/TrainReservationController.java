package train.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import train.model.SeatBean;
import train.model.SeatDao;
import train.model.TrainReservationBean;
import train.model.TrainReservationDao;
import train.model.TrainScheduleBean;
import train.model.TrainScheduleDao;

@Controller
public class TrainReservationController {

	private final String command = "trainReservationConfirm.train";
	private final String action = "trainReservationComplete.train";
    private final String getPage = "trainReservationConfirm";
    private final String gotoPage = "trainReservationComplete";
    
    @Autowired
    TrainScheduleDao trainScheduleDao;
    
    @Autowired
    SeatDao seatDao;

    @Autowired
    TrainReservationDao trainReservationDao;

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
        
    	return getPage;
    }
    
    @RequestMapping(action)
    public String action(
    		@RequestParam("schedule_id") String schedule_id,
    		@RequestParam("dep_station_id") String dep_station_id,
    		@RequestParam("arr_station_id") String arr_station_id,
    		@RequestParam("depPlandTime") String depPlandTime,
    		@RequestParam(value = "adults", defaultValue = "0") int adults,
            @RequestParam(value = "children", defaultValue = "0") int children,
            @RequestParam(value = "seniors", defaultValue = "0") int seniors,
            @RequestParam("selectedSeats") String selectedSeats,
            @RequestParam("totalPrice") int totalPrice,
            Model model) {
    	
        TrainScheduleBean schedule = trainScheduleDao.getTrainSchedulesById(schedule_id);
    	
        String[] seats = selectedSeats.split(",");
        
    	for (String seatNo : seats) {
            SeatBean seat = new SeatBean();
            seat.setSeat_no(seatNo);
            seat.setSchedule_id(schedule_id);
            seatDao.insertSeat(seat);
        }
    	
    	TrainReservationBean trainReservation = new TrainReservationBean();
    	trainReservation.setUser_id(1);
    	trainReservation.setDepPlaceName(schedule.getDepPlaceName());
    	trainReservation.setArrPlaceName(schedule.getArrPlaceName());
    	trainReservation.setDepPlandTime(schedule.getDepPlandTime());
    	trainReservation.setArrPlandTime(schedule.getArrPlandTime());
    	trainReservation.setDuration(schedule.getDuration());
    	trainReservation.setTrain_no(schedule.getTrain_no());
    	trainReservation.setTrain_type(schedule.getTrain_type());
    	trainReservation.setNum_adults(adults);
    	trainReservation.setNum_children(children);
    	trainReservation.setNum_seniors(seniors);
    	trainReservation.setSeat_no(selectedSeats);
    	trainReservation.setTrain_total_prices(totalPrice);
    	trainReservationDao.insertReservation(trainReservation);
        
    	return gotoPage;
    }
}