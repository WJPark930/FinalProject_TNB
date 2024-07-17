package payment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GotoCancelController {
	private final String command = "gotoCancel.pay";
	private final String gotoPage = "cancelThisPayment";
	
	@RequestMapping(command) 
	public String gotoCancel() {
		return gotoPage;
	}
}
