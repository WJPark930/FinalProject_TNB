package reservation.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import member.model.MemberBean;
import reservation.model.ReservationDao;
import reservation.model.RoomReservationBean;
import reservation.model.RoomReservationDao;
import reservation.model.TrainReservationBean;
import reservation.model.TrainReservationDao;
import train.model.SeatBean;
import train.model.SeatDao;
import train.model.TrainScheduleBean;
import train.model.TrainScheduleDao;

@Controller
public class TrainReservationController {

	private final String command = "trainReservation.rv";
	private final String gotoPay = "redirect:/gotoPay.pay";
	private final String loginPage = "redirect:/loginForm.mb";


	@Autowired
	TrainScheduleDao trainScheduleDao;

	@Autowired
	SeatDao seatDao;

	@Autowired
	TrainReservationDao trainReservationDao;

	@Autowired
	RoomReservationDao rrdao;

	@Autowired
	ReservationDao rdao;

	@Autowired
	TrainReservationDao trdao;


	@RequestMapping(command)
	public String action(
			@RequestParam("schedule_id") String schedule_id,
			@RequestParam("dep_station_id") String dep_station_id,
			@RequestParam("arr_station_id") String arr_station_id,
			@RequestParam("depPlandTime") String depPlandTime,
			@RequestParam(value = "adults", defaultValue = "0") int adults,
			@RequestParam(value = "children", defaultValue = "0") int children,
			@RequestParam(value = "seniors", defaultValue = "0") int seniors,
			@RequestParam("selectedSeats") String selectedSeats,
			@RequestParam("totalPrice") int train_total_price,
			Model model, HttpSession session) {


		MemberBean loginInfo = (MemberBean)session.getAttribute("loginInfo");
		if(loginInfo == null) {
			return loginPage;
		} else {

			int user_id = loginInfo.getUser_id();
			TrainScheduleBean schedule = trainScheduleDao.getTrainSchedulesById(schedule_id);
			System.out.println("user_id : " + user_id);

			TrainReservationBean trainReservation = new TrainReservationBean();
			trainReservation.setUser_id(user_id);
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
			trainReservation.setTrain_total_price(train_total_price);

			int cnt = -1;
			cnt = trdao.trainReservation(trainReservation);
			System.out.println("trainreservationcontroller cnt : " + cnt);

			RoomReservationBean rrb = new RoomReservationBean();
			rrb = rrdao.getRecentReservation();
			
			String[] seats = selectedSeats.split(",");
			
			for (String seatNo : seats) {
				SeatBean seat = new SeatBean();
				seat.setSeat_no(seatNo);
				seat.setOrder_num(rrb.getRoom_reservation_num());
				seat.setSchedule_id(schedule_id);
				seatDao.insertSeat(seat);
			}

			return gotoPay + "?room_reservation_num=" + rrb.getRoom_reservation_num();
		}
	}
}