package com.navprayas.bidding.biddinghistory.bidder.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.navprayas.bidding.bidder.controller.BidderController;
import com.navprayas.bidding.bidder.service.IBidderService;
import com.navprayas.bidding.biddinghistory.bidder.sevice.IBidderHistoryService;
import com.navprayas.bidding.common.bean.BiddingHistoryBean;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BiddingDetailsForm;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.utility.RedisCacheService;

@RequestMapping("/bidderHistory/**")
@Controller

public class BidderHistoryController {
	
private final static Logger logger = LoggerFactory.getLogger(BidderHistoryController.class);
	
	@Autowired
	@Qualifier("bidderHistoryService")
	private IBidderHistoryService bidderHistoryService;
	
	@Autowired
	@Qualifier("commonService")
	private ICommonService commonService;	
	
	@RequestMapping("/marketList")
	public String getBiddingHistoryForMarketlist(Integer bidItemId,String bidItem, String quantity, 
			String seqId, ModelMap modelMap, HttpServletRequest httpServletRequest) {
		
		logger.info("In getBiddingHistoryForMarketlist Method:");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userName = auth.getName();
		
		BiddingDetailsForm biddingDetailsForm = new BiddingDetailsForm();
		if(bidItemId != null){
			biddingDetailsForm.setBidItemId(bidItemId.longValue());
		}
		biddingDetailsForm.setUserName(userName);	
		
		
		List<BiddingHistoryBean> biddingHistoryBean = bidderHistoryService.getBiddingHistoryForMarketlist(biddingDetailsForm);
		modelMap.addAttribute("BiddingHistoryBean", biddingHistoryBean);
		modelMap.addAttribute("bidItem", bidItem);
		modelMap.addAttribute("quantity", quantity);
		modelMap.addAttribute("seqId", seqId);
		return "bidder_history_detail";
	}

	@RequestMapping("/biddingHistoryObserver")
	public String getBiddingHistoryForObserver(Integer bidItemId,String bidItem, String quantity, 
			String seqId, ModelMap modelMap, HttpServletRequest httpServletRequest) {
		
		logger.info("In getBiddingHistoryForMarketlist Method:");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userName = auth.getName();
		
		BiddingDetailsForm biddingDetailsForm = new BiddingDetailsForm();
		if(bidItemId != null){
			biddingDetailsForm.setBidItemId(bidItemId.longValue());
		}
		biddingDetailsForm.setUserName(userName);	
		
		
		List<BiddingHistoryBean> biddingHistoryBean = bidderHistoryService.getBiddingHistoryForObserver(biddingDetailsForm);
		modelMap.addAttribute("BiddingHistoryBean", biddingHistoryBean);
		modelMap.addAttribute("bidItem", bidItem);
		modelMap.addAttribute("quantity", quantity);
		modelMap.addAttribute("seqId", seqId);
		return "observer_history_detail";
	}


}
