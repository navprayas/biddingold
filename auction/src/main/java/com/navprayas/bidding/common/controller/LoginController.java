package com.navprayas.bidding.common.controller;

import java.util.Calendar;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.navprayas.bidding.common.constant.BiddingConstants;
import com.navprayas.bidding.common.form.UserActivity;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.service.ICommonService;

@Controller
public class LoginController {

	private final static Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	@Qualifier("commonService")
	private ICommonService commonService;
	
	@RequestMapping("/home")
	public String homePageForUser(HttpServletRequest httpServletRequest) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		Collection<GrantedAuthority> authorities = auth.getAuthorities();
		String name = auth.getName();
		Object principal = auth.getPrincipal();
		Object details = auth.getDetails();	
		
		logger.info("name " + name);
		logger.info("principal " + principal);
		logger.info("details " + details);
		
		HttpSession session = httpServletRequest.getSession();
		session.setAttribute("userName", name);
		
		String pageToForward = null;
		for(GrantedAuthority authority : authorities)
		{
			Users user = commonService.getUserForUsername(name);
			UserActivity userActivity = new UserActivity();
			userActivity.setUserId(user.getUserId());
			userActivity.setLoginTime(Calendar.getInstance().getTime());
			userActivity.setSessionId(session.getId());
			if(user.getActive() == 0) {
				userActivity.setMessage("First Time Change password login.");
				commonService.saveUserActivity(userActivity);
				return "redirect:/firsttimechangepass";
			}
			if(authority.getAuthority().equalsIgnoreCase(BiddingConstants.ROLE_ADMIN)){
				userActivity.setRole(BiddingConstants.ROLE_ADMIN);
				pageToForward = "admin/home";
			}if(authority.getAuthority().equalsIgnoreCase(BiddingConstants.ROLE_OBSERVER)){ 
				userActivity.setRole(BiddingConstants.ROLE_OBSERVER);
				pageToForward = "observer/home";
			}if(authority.getAuthority().equalsIgnoreCase(BiddingConstants.ROLE_BIDDER)){
				userActivity.setRole(BiddingConstants.ROLE_BIDDER);
				pageToForward = "bidder/home";	
			}if(authority.getAuthority().equalsIgnoreCase(BiddingConstants.ROLE_SUPER_ADMIN)){
				userActivity.setRole(BiddingConstants.ROLE_SUPER_ADMIN);
				pageToForward = "admin/superAdmin";
			}
			userActivity.setMessage("Login Successful.");
			commonService.saveUserActivity(userActivity);
			
		}
		
		logger.info("pageToForward " + pageToForward);
		return "redirect:/"+pageToForward;
	}
	@RequestMapping(value = "/changepass" , method = RequestMethod.GET)
	public String changepasswd(@RequestParam(value="ChangePassMessage", required=false)String message, ModelMap map)
	{
		
		if(message!=null)
		{
			map.addAttribute("ChangePassMessage", message);
			logger.debug(message);
			return "changepass";
		}
		else
			return "changepass";
	}
	@RequestMapping(value = "/firsttimechangepass" , method = RequestMethod.GET)
	public String firstTimeChangepasswd(@RequestParam(value="ChangePassMessage", required=false)String message, ModelMap map)
	{
		
		if(message!=null)
		{
			map.addAttribute("ChangePassMessage", message);
			logger.debug(message);
			return "/common/firsttimechangepass";
		}
		else
			return "/common/firsttimechangepass";
	}
	
	@RequestMapping(value = "/firsttimechangepassconf" , method = RequestMethod.GET)
	public String firsttimechangepassconf(@RequestParam(value="ChangePassMessage", required=false)String message, ModelMap map)
	{
		if(message!=null)
		{
			map.addAttribute("ChangePassMessage", message);
			logger.debug(message);
			return "/common/firsttimechangepassconf";
		}
		else
			return "/common/firsttimechangepassconf";
	}
	//***********************First time Password Change**********************/
	@RequestMapping(value = "/firsttimechangepassword", method = RequestMethod.POST)
	public  String  firstTimeChangPasswrd(@RequestParam(value="Oldpass", required=true)String Oldpass ,
			@RequestParam(value="Newpass", required=true)String Newpass ,
		@RequestParam(value="Cnfpass", required=true)String Cnfpass, HttpServletRequest httpServletRequest){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String LoggerName = auth.getName();	
		logger.debug("********************Password Change******************");
		String Status = commonService.ChangePassword(LoggerName, Oldpass, Newpass);
		logger.debug("Status of Password Change-->" +Status);
		
		if ("error".equalsIgnoreCase(Status)) {
			return "redirect:/firsttimechangepass?ChangePassMessage=Your old password did not match.";
		} else {
			return "redirect:/firsttimechangepassconf?ChangePassMessage=Your password change was successful. Please logout and login again with new password.";
		}
	}
	//***********************First time Password Change**********************/	
	
	//***********************Password Change**********************/
	@RequestMapping(value = "/changepassword", method = RequestMethod.POST)
	public  String  ChangPasswrd(@RequestParam(value="Oldpass", required=true)String Oldpass ,
			@RequestParam(value="Newpass", required=true)String Newpass ,
		@RequestParam(value="Cnfpass", required=true)String Cnfpass, HttpServletRequest httpServletRequest){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String LoggerName = auth.getName();	
		logger.debug("********************Password Change******************");
		String Status = commonService.ChangePassword(LoggerName, Oldpass, Newpass);
		logger.debug("Status of Password Change-->" +Status);
		
		if ("error".equalsIgnoreCase(Status)) {
			return "redirect:/changepass?ChangePassMessage=Your old password did not match.";
		} else {
			return "redirect:/changepass?ChangePassMessage=Your password change was successful.";
		}
	}
	//***********************Password Change**********************/
	
	
	@RequestMapping(value = "/users/forgotPassword")
	public  String  forgotPassword(HttpServletRequest httpServletRequest){		
		return "forgotpassword";
	}
	
	@RequestMapping(value = "/users/forgotPasswordSendMail")
	public  String  forgotPasswordSendEmail(@RequestParam(value="userId", required=true)String userId, @RequestParam(value="secretAnswer", required=true)String secretAnswer,
			HttpServletRequest httpServletRequest, ModelMap modelMap){		
		String status = null;
		try {
			status = commonService.checkUserExistsAndSendPasswordMail(userId, secretAnswer);
		} catch (Exception e) {
			logger.error("Email Could not be sent", e);
			status = "error";
		}
		if ("error".equalsIgnoreCase(status))
		{
			modelMap.addAttribute("forgotPassMessage", "Problem in resetting password, Please try again Later.");			
		} else {
			modelMap.addAttribute("forgotPassMessage", "Email sent Successfully. Please try logging with new Password.");			
		}

		return "forgotpasswordConfirmation";
	}
	
}
