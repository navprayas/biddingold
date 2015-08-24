package com.navprayas.bidding.common.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.navprayas.bidding.common.form.Authorities;
import com.navprayas.bidding.common.form.FirmDetails;
import com.navprayas.bidding.common.form.UserDetails;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.form.UsersForm;
import com.navprayas.bidding.common.service.ICommonService;

@Controller
public class RegistrationController {

	private final static Logger logger = LoggerFactory
			.getLogger(RegistrationController.class);

	@Autowired
	@Qualifier("commonService")
	private ICommonService commonService;

	@RequestMapping(value = "/admin/registrationPage")
	public String registrationPageForUser(HttpServletRequest httpServletRequest) {
		return "registrationHome";
	}

	@RequestMapping(value = "/admin/registration")
	public String registerUser(HttpServletRequest httpServletRequest,
			ModelMap modelMap, UsersForm usersForm) {

		Users users = new Users();

		users.setUsername(usersForm.getUsername());
		users.setPassword(usersForm.getPassword());
		users.setEnabled(true);
		users.setEmail(usersForm.getEmail());

		String role = usersForm.getRole();
		Authorities authorities = new Authorities();
		authorities.setUsername(usersForm.getUsername());
		authorities.setAuthority(role);

		UserDetails userDetails = new UserDetails();
		String lastName = usersForm.getLastName();
		String middleName = usersForm.getMiddleName();

		userDetails.setFirstName(usersForm.getFirstName());
		// userDetails.setDateofbirth(usersForm.getDateofbirth());
		if (lastName != null) {
			userDetails.setLastName(lastName);
		}
		if (middleName != null) {
			userDetails.setMiddleName(middleName);
		}

		String status = commonService.saveUser(users, authorities, userDetails);

		StringBuilder strMessage = new StringBuilder(
				"redirect:/admin/registrationPage?registrationMessage=");
		if (status != null && "success".equals(status)) {
			strMessage.append("User Registered successfully.");
			// httpServletRequest.setAttribute("registrationMessage",
			// "User Registered successfully.");
		} else {
			strMessage
					.append("User Registration failed. Please try again later.");
			// httpServletRequest.setAttribute("registrationMessage",
			// "User Registration failed. Please try again later.");
		}

		return strMessage.toString();
	}

	@RequestMapping(value = "/admin/vendorRegistrationPage")
	public String registrationPageForVendor(
			HttpServletRequest httpServletRequest) {
		return "vendorRegistrationPage";
	}

	@RequestMapping(value = "/admin/vendorRegistration", method = RequestMethod.POST)
	public String vendorRegistration(HttpServletRequest httpServletRequest,
			ModelMap modelMap, FirmDetails firmDetails) {
		boolean success = true;
		try {
			/*commonService.saveVendor(firmDetails);*/
		} catch (Exception e) {
			e.printStackTrace();
			success = false;
		}
		if (success)
			modelMap.addAttribute("Confirmation",
					"Vendor Registration Successful");
		else
			modelMap.addAttribute("Confirmation", "Vendor Registration Failed");
		return "vendorRegistrationPage";
	}

}
