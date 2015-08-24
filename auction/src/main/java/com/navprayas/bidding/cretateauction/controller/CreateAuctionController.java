package com.navprayas.bidding.cretateauction.controller;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.navprayas.bidding.cretateauction.entity.CreateAuctionEntity;
import com.navprayas.bidding.cretateauction.service.CreateAuctionService;

@Controller
public class CreateAuctionController {
	@Autowired
	CreateAuctionService auctionService;
	@RequestMapping(value = "/admin/CreateAuction")
	public String createAuction(HttpServletRequest httpServletRequest, ModelMap modelMap) {
		
		List<CreateAuctionEntity> auctionList=auctionService.getAllAuctionList();
		modelMap.addAttribute("auctionlist", auctionList);
		
		return "createauction";
	}
	@RequestMapping(value = "/admin/createAuction", method = RequestMethod.POST)
	public String createAuction(@ModelAttribute("firmDetails") CreateAuctionEntity auction,ModelMap modelMap) throws ParseException
	{	String message = "Submitted Successfully";
		try{
		auctionService.saveData(auction);
		List<CreateAuctionEntity> auctionList=auctionService.getAllAuctionList();
		modelMap.addAttribute("auctionlist", auctionList);
		}
		catch(Exception e){
		e.printStackTrace();	
		message="Not Submitted";
		}
		modelMap.addAttribute("messages", message);
		return "createauction";
	}
	@RequestMapping(value = "/admin/editauction", method = RequestMethod.GET)
	public String modifyAuction(@RequestParam Integer auctionId,ModelMap modelMap) throws ParseException
	{	
		
		
		modelMap.addAttribute("auctionDetails", auctionService.getAuctionDetails(auctionId));
		List<CreateAuctionEntity> auctionList=auctionService.getAllAuctionList();
		modelMap.addAttribute("auctionlist", auctionList);
		return "createauction";
	}
	
	
}
