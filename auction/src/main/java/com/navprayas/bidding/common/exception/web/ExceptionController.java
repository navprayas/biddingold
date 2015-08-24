package com.navprayas.bidding.common.exception.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/error/**")
@Controller
public class ExceptionController {

	@RequestMapping("/error")
	public String getErrorPage() {
		return "error";
	}
}
