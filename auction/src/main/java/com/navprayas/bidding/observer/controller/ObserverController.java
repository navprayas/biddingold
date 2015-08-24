package com.navprayas.bidding.observer.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tuckey.web.filters.urlrewrite.utils.StringUtils;

import com.navprayas.bidding.bidder.service.IBidderService;
import com.navprayas.bidding.common.bean.Bidder;
import com.navprayas.bidding.common.dto.CommonVO;
import com.navprayas.bidding.common.dto.NavigationInfo;
import com.navprayas.bidding.common.dto.ObserverVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.common.form.UserActivity;
import com.navprayas.bidding.common.service.IBidItemsCacheService;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.observer.service.IObserverService;
import com.navprayas.bidding.utility.CometPusher;
import com.navprayas.bidding.utility.RedisCacheService;
import com.navprayas.bidding.utility.comparator.BidderAmountComparator;

@RequestMapping("/observer/**")
@Controller
public class ObserverController {

	Logger logger = LoggerFactory.getLogger(ObserverController.class);

	@Autowired
	@Qualifier("observerService")
	private IObserverService observerService;

	@Autowired
	@Qualifier("commonService")
	private ICommonService commonService;

	@Autowired
	@Qualifier("bidItemsCacheService")
	IBidItemsCacheService bidItemsCacheService;

	@Autowired
	@Qualifier("bidderService")
	private IBidderService bidderService;

	@RequestMapping("/showOnlineUser")
	public String showOnlineUser(ModelMap modelMap,
			HttpServletRequest httpServletRequest) {
		String strAuctionId = RedisCacheService.getAuctionId();
		if (strAuctionId == null) {
			return "observer_onlineUser";
		}
		Long auctionId = new Long(strAuctionId);
		List<UserActivity> onlineUserVOList = commonService
				.getOnlineUserList(auctionId);
		modelMap.addAttribute("onlineUserVOList", onlineUserVOList);
		return "observer_onlineUser";
	}

	@RequestMapping("/home")
	public String getBidItems(ModelMap modelMap,
			HttpServletRequest httpServletRequest) {
		logger.info("In getBidItems Method:");
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();
		logger.debug("UserName" + name);

		/*
		 * List<BidItem> bidItemsList = null; bidItemsList =
		 * observerService.getBidItemsForCategoryForMarketListForObserver(name);
		 * logger.debug(" For category: BidItems List::"+bidItemsList);
		 * modelMap.addAttribute("bidItemsList", bidItemsList);
		 * 
		 * List<BidderCategory> bidCategoryList =
		 * commonService.getCategoryList(name);
		 * modelMap.addAttribute("bidderCategoryList", bidCategoryList);
		 * logger.debug(" For category: categoryList List::"+bidCategoryList);
		 */

		modelMap.addAttribute("bidItem", new BidItem());
		// List<BidItem> bidItemsList =
		// bidderService.getBidItemsForCategoryForMarketListForBidder(name);
		getBidItemsForCategoryForMarketListForObserver(0, "1", modelMap,
				httpServletRequest);
		List<BidItem> bidItemsList = (List<BidItem>) (modelMap
				.get("bidItemsList"));

		logger.debug("BidItems List in getBidItems::" + bidItemsList);

		return "observerhome";
	}

	/*
	 * @RequestMapping(value="/marketlist/{categoryId}", method =
	 * RequestMethod.GET) public String
	 * getBidItemsForCategoryForMarketListForObserver
	 * (@PathVariable("categoryId")Integer categoryId, ModelMap modelMap,
	 * HttpServletRequest httpServletRequest) { logger.info(
	 * "In getBidItemsForCategoryForMarketListForObserver Method For category: "
	 * + categoryId); Authentication auth =
	 * SecurityContextHolder.getContext().getAuthentication(); String name =
	 * auth.getName();
	 * 
	 * logger.debug("UserName For category: " + name);
	 * 
	 * List<BidItem> bidItemsList = null;
	 * 
	 * if(categoryId != 0){ bidItemsList =
	 * observerService.getBidItemsForCategoryForMarketListForObserver
	 * (categoryId, name); }else { bidItemsList =
	 * observerService.getBidItemsForCategoryForMarketListForObserver(name); }
	 * logger.debug(" For category: BidItems List::"+bidItemsList);
	 * modelMap.addAttribute("bidItemsList", bidItemsList); List<BidderCategory>
	 * bidCategoryList = commonService.getCategoryList(name);
	 * modelMap.addAttribute("bidderCategoryList", bidCategoryList);
	 * logger.debug(" For category: categoryList List::"+bidCategoryList);
	 * 
	 * if(categoryId != 0){ for(BidderCategory bidderCategory :
	 * bidCategoryList){ String categoryName =
	 * bidderCategory.getCategory().getCategoryName();
	 * logger.debug("Category Name Added in modelMap::"+categoryName);
	 * modelMap.addAttribute("categoryName", categoryName); break; } }
	 * 
	 * return "observer/observer_marketlist"; }
	 * 
	 * @RequestMapping(value="/active/{categoryId}", method = RequestMethod.GET)
	 * public String
	 * getBidItemsForCategoryForActiveMarketForObserver(@PathVariable
	 * ("categoryId")Integer categoryId, ModelMap modelMap, HttpServletRequest
	 * httpServletRequest) { logger.info(
	 * "In getBidItemsForCategoryForActiveMarketForObserver Method For category: "
	 * + categoryId); Authentication auth =
	 * SecurityContextHolder.getContext().getAuthentication(); String userName =
	 * auth.getName();
	 *//**
	 * TODO: Need to implement Redis Cache function
	 */
	/*
	 * Map<Long, BidItem> bidItemsMap = bidItemsCacheService.getBidItemsMap();
	 * 
	 * Collection c = bidItemsMap.values(); List<BidItem> bidItemList = new
	 * ArrayList<BidItem>(c);
	 * 
	 * 
	 * List<BidItem> bidItemListNew = new ArrayList<BidItem>();
	 * 
	 * logger.debug("bidItemsMap"+bidItemsMap);
	 * 
	 * Set<Long> categoryIdList =
	 * observerService.getBidItemsIDListForActiveMarket(userName);
	 * 
	 * for (Iterator<BidItem> it = bidItemList.iterator(); it.hasNext();) {
	 * 
	 * BidItem bidItem = it.next();
	 * 
	 * boolean flag =
	 * categoryIdList.contains(bidItem.getCategory().getCategoryId()); if(flag){
	 * int index = bidItemList.indexOf(bidItem); if(index != -1){
	 * bidItemListNew.add(bidItem); }
	 * 
	 * } }
	 * 
	 * logger.debug("UserName For category: " + userName);
	 * modelMap.addAttribute("bidItemsList", bidItemListNew);
	 * 
	 * List<BidderCategory> bidCategoryList =
	 * commonService.getCategoryList(userName);
	 * modelMap.addAttribute("bidderCategoryList", bidCategoryList);
	 * logger.debug(" For category: categoryList List::"+bidCategoryList);
	 * 
	 * if(categoryId != 0){ for(BidderCategory bidderCategory :
	 * bidCategoryList){ String categoryName =
	 * bidderCategory.getCategory().getCategoryName();
	 * logger.debug("Category Name Added in modelMap::"+categoryName);
	 * modelMap.addAttribute("categoryName", categoryName); break; } }
	 * 
	 * return "observer/observer_active"; }
	 */

	@RequestMapping(value = "/marketlist")
	public String getBidItemsForCategoryForMarketListForObserver(
			@RequestParam(value = "category", required = false) Integer categoryId,
			@RequestParam(required = false, defaultValue = "1", value = "page") String page,
			ModelMap modelMap, HttpServletRequest httpServletRequest) {
		logger.info("In getBidItemsForCategoryForMarketListForObserver Method For category: "
				+ categoryId);
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();
		if (categoryId == null) {
			categoryId = 0;
		}
		logger.debug("UserName For category: " + name);
		List<BidderCategory> categoryList = commonService.getCategoryList(name);
		modelMap.addAttribute("bidderCategoryList", categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		modelMap.addAttribute("categoryName", categoryId);

		List<BidItem> bidItemsList = null;

		modelMap.addAttribute("refreshTime", -1);
		String endSeq = RedisCacheService.isEndSequence();

		CommonVO commonVO = new CommonVO();

		commonVO.setUserName(name);
		NavigationInfo navigationInfo = new NavigationInfo();

		if (endSeq == null) {
			if (RedisCacheService.getAuctionId() == null) {
				return "observer_marketlist";
			}
			Long auctionId = new Long(RedisCacheService.getAuctionId());

			commonVO.setSequenceId(0L);
			commonVO.setAuctionId(auctionId);
			commonVO.setCategoryId(categoryId);
			logger.debug("Before record count for Biditems:");

			Long count = null;
			if (categoryId != 0) {
				count = bidderService
						.findBidItemsCountForMarketListForBidderForCategory(commonVO);
			} else {
				count = bidderService
						.findBidItemsCountForMarketListForBidder(commonVO);
			}
			navigationInfo.setRowCount(Integer.valueOf(count + ""));

			if (StringUtils.isBlank(page)) {
				navigationInfo.setCurrentPage(1);
			} else {
				navigationInfo.setCurrentPage(Integer.parseInt(page));
			}
			int curPage = (navigationInfo.getCurrentPage() - 1) < 0 ? 0
					: (navigationInfo.getCurrentPage() - 1);
			logger.debug("Before getting data");
			commonVO.setFirstResult(curPage * navigationInfo.getPageSize());
			commonVO.setMaxResult(navigationInfo.getPageSize());

			logger.debug("****** BidItems Count is::" + count + " *******");

			if (categoryId != 0)
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(
								categoryId, commonVO);
			else
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(commonVO);
			if (bidItemsList == null || bidItemsList.size() == 0) {
				return "observer_marketlist";
			}
			Date date = null;
			if (bidItemsCacheService.getAuctionStartTime() == null) {
				date = commonService.getActualAuctionStartTime(auctionId);
			} else {
				date = bidItemsCacheService.getAuctionStartTime();
			}
			if (date == null) {
				return "observer_marketlist";
			}
			Date currDate = new Date();
			long refreshTime = date.getTime() - currDate.getTime();
			refreshTime = (long) (refreshTime / 1000);
			if (refreshTime < 0) {
				return "observer_marketlist";
				// throw new
				// RuntimeException("Refresh time can not be negative");
			}

			if (curPage > 0 && bidItemsList.size() > 0) {
				refreshTime = refreshTime
						+ ((curPage * navigationInfo.getPageSize()))
						* bidItemsList.get(0).getBidSpan();
			}
			modelMap.addAttribute("refreshTime", refreshTime);
			for (BidItem bidItem : bidItemsList) {
				bidItem.setTimeLeft(refreshTime);
				refreshTime += bidItem.getBidSpan();
				if (bidItem.getCurrentMarketPrice() == null) {
					bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice());
					bidItemsList.set(bidItemsList.indexOf(bidItem), bidItem);
				}
			}
		} else if (endSeq.equalsIgnoreCase("false")) {
			long activeBidItemId = RedisCacheService.getActiveBidItemId();
			Map<String, String> activeItemDetails = RedisCacheService
					.getBidItemSequenceDetails(activeBidItemId);
			long auctionId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_AUCTIONID));
			long seqId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_SEQUENCEID));

			commonVO.setSequenceId(seqId);
			commonVO.setAuctionId(auctionId);
			commonVO.setCategoryId(categoryId);

			Long count = null;
			if (categoryId != 0) {
				count = bidderService
						.findBidItemsCountForMarketListForBidderForCategory(commonVO);
			} else {
				count = bidderService
						.findBidItemsCountForMarketListForBidder(commonVO);
			}
			navigationInfo.setRowCount(Integer.valueOf(count + ""));
			logger.debug("****** BidItems Count is::" + count + " *******");

			if (StringUtils.isBlank(page)) {
				navigationInfo.setCurrentPage(1);
			} else {
				navigationInfo.setCurrentPage(Integer.parseInt(page));
			}
			int curPage = (navigationInfo.getCurrentPage() - 1) < 0 ? 0
					: (navigationInfo.getCurrentPage() - 1);
			logger.debug("Before getting data");
			commonVO.setFirstResult(curPage * navigationInfo.getPageSize());
			commonVO.setMaxResult(navigationInfo.getPageSize());

			if (categoryId != 0)
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(
								categoryId, commonVO);
			else
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(commonVO);

			BidItem activeBidItem = bidItemsCacheService
					.getBidItem(RedisCacheService.getActiveBidItemId());

			long refreshTime = activeBidItem.getTimeLeft();
			logger.debug("*****refreshTime::" + refreshTime);
			if (curPage > 0 && bidItemsList.size() > 0) {
				refreshTime = refreshTime
						+ ((curPage * navigationInfo.getPageSize()))
						* bidItemsList.get(0).getBidSpan();
			}
			modelMap.addAttribute("refreshTime", refreshTime);

			for (BidItem bidItem : bidItemsList) {
				bidItem.setTimeLeft(refreshTime);
				logger.debug("bidItem : " + bidItem.getBidItemId() + " "
						+ bidItem.getBidSpan() + " " + refreshTime);
				refreshTime += bidItem.getBidSpan();
				if (bidItem.getCurrentMarketPrice() == null) {
					bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice());
					bidItemsList.set(bidItemsList.indexOf(bidItem), bidItem);
				}
			}
		} else {
			bidItemsList = new ArrayList<BidItem>();
		}
		logger.debug(" For category: BidItems List::" + bidItemsList);
		modelMap.addAttribute("bidItemsList", bidItemsList);

		modelMap.put("navigationInfo", navigationInfo);

		return "observer_marketlist";
	}

	@RequestMapping(value = "/active")
	public String getBidItemsForCategoryForActiveMarketForObserver(
			@RequestParam(value = "category", required = false) Integer categoryId,
			ModelMap modelMap, HttpServletRequest httpServletRequest) {
		logger.info("In getBidItemsForCategoryForActiveMarketForObserver Method For category: "
				+ categoryId);

		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();
		if (categoryId == null) {
			categoryId = 0;
		}
		logger.debug("UserName For category: " + name);

		/*
		 * if(categoryId != 0) //bidItemsList =
		 * bidderService.getBidItemsForCategoryForActiveMarketForBidder
		 * (categoryId, name); //bidItemsList =
		 * RedisCacheService.getBidItems("1"); //hard coded for time being else
		 * bidItemsList =
		 * bidderService.getBidItemsForCategoryForActiveMarketForBidder(name);
		 * //bidItemsList = RedisCacheService.getBidItems("1"); //hard coded for
		 * time being
		 */

		List<BidderCategory> categoryList = commonService.getCategoryList(name);
		modelMap.addAttribute("bidderCategoryList", categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		modelMap.addAttribute("categoryName", categoryId);

		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		BidItem activeBidItem = bidItemsCacheService
				.getBidItem(RedisCacheService.getActiveBidItemId());
		if (activeBidItem != null) {

			if ((categoryId.longValue() == 0)
					|| (categoryId.longValue() == activeBidItem.getCategory()
							.getCategoryId())) {
				logger.debug("Same category Id found " + categoryId);
			} else {
				modelMap.addAttribute("bidItemsList", bidItemsList);
				return "observer_active";
			}

			activeBidItem.setItemLots(commonService.getItemLots(activeBidItem
					.getBidItemId()));
			logger.debug(" For category: BidItems List::" + bidItemsList);

			bidItemsList.add(activeBidItem);

			BidItem tempItem = observerService.getBidItem(activeBidItem
					.getBidItemId());
			if (tempItem != null && activeBidItem != null) {
				activeBidItem.setSerialNo(tempItem.getSerialNo());
			}

			for (BidItem item : bidItemsList) {
				List<Bidder> bidders = item.getCurrentBidderList();
				Collections.sort(bidders, new BidderAmountComparator());
				if (bidders.size() > 0) {
					Bidder bidder = bidders.get(0);
					modelMap.addAttribute("CurrentBidder",
							bidder.getBidderName());
				} else {
					modelMap.addAttribute("CurrentBidder", "");
				}

			}

		}
		modelMap.addAttribute("bidItemsList", bidItemsList);
		// return "bidder/active_bidder";
		return "observer_active";
	}

	@RequestMapping(value = "/closed")
	public String getBidItemsForCategoryForClosedMarketForObserver(
			@RequestParam(required = false, defaultValue = "1", value = "page") String page,
			@RequestParam(value = "category", required = false) Integer categoryId,
			ModelMap modelMap, HttpServletRequest httpServletRequest) {
		logger.info("In getBidItemsForCategoryForClosedMarketForObserver Method For category: "
				+ categoryId);
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();
		if (categoryId == null) {
			categoryId = 0;
		}
		logger.debug("UserName For category: " + name);
		List<Bids> bidsList = null;
		CommonVO commonVO = new CommonVO();

		commonVO.setUserName(name);
		NavigationInfo navigationInfo = new NavigationInfo();
		String endSeq = RedisCacheService.isEndSequence();
		Long auctionId = 0L;
		long seqId = 0L;
		if (endSeq == null) {
			bidsList = new ArrayList<Bids>();
			logger.debug(" For category: BidItems List::" + bidsList);
			modelMap.addAttribute("bidsList", bidsList);
			List<BidderCategory> categoryList = commonService
					.getCategoryList(name);
			modelMap.addAttribute("bidderCategoryList", categoryList);
			logger.debug(" For category: bidderCategoryList List::"
					+ categoryList);
			modelMap.addAttribute("categoryName", categoryId);

			return "observer_closed";
		} else if (endSeq.equalsIgnoreCase("false")) {
			long activeBidItemId = RedisCacheService.getActiveBidItemId();
			Map<String, String> activeItemDetails = RedisCacheService
					.getBidItemSequenceDetails(activeBidItemId);
			auctionId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_AUCTIONID));
			seqId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_SEQUENCEID));
		} else {
			String strAuctionId = RedisCacheService.getAuctionId();
			if (strAuctionId == null) {
				return "observer_closed";
			}
			auctionId = new Long(strAuctionId);
		}

		commonVO.setSequenceId(seqId);
		commonVO.setAuctionId(auctionId);
		commonVO.setCategoryId(categoryId);

		logger.debug("Before record count for Biditems:");
		Long count = null;
		count = seqId - 1;
		if (count < 0) {
			count = bidderService
					.findBidItemsCountForClosedListForBidder(commonVO);
		}
		if (seqId == 0 && count != 0) {
			seqId = count + 1;
			commonVO.setSequenceId(seqId);
		}
		navigationInfo.setRowCount(count.intValue());
		logger.debug("****** BidItems Count is::" + count + " *******");

		if (StringUtils.isBlank(page)) {
			navigationInfo.setCurrentPage(1);
		} else {
			navigationInfo.setCurrentPage(Integer.parseInt(page));
		}

		int curPage = (navigationInfo.getCurrentPage() - 1) < 0 ? 0
				: (navigationInfo.getCurrentPage() - 1);
		logger.debug("Before getting data");
		commonVO.setFirstResult(curPage * navigationInfo.getPageSize());
		commonVO.setMaxResult(navigationInfo.getPageSize());

		if (categoryId != 0) {
			bidsList = observerService
					.getBidItemsForCategoryForClosedMarketForObserver(
							categoryId, commonVO);
		} else
			bidsList = observerService
					.getBidItemsForCategoryForClosedMarketForObserver(commonVO);

		logger.debug(" For category: BidItems List::" + bidsList);
		modelMap.addAttribute("bidsList", bidsList);
		modelMap.put("navigationInfo", navigationInfo);
		List<BidderCategory> categoryList = commonService.getCategoryList(name);
		modelMap.addAttribute("bidderCategoryList", categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		modelMap.addAttribute("categoryName", categoryId);

		return "observer_closed";
	}

	@RequestMapping("/approveH1")
	public String getBidApproved(ObserverVO observerVO, ModelMap modelMap,
			HttpServletRequest httpServletRequest) {
		logger.debug("In getH1Approved Method::");
		String page = observerVO.getPageO();
		logger.debug("Page No:" + page);
		if (observerVO.getCategoryId() == null)
			observerVO.setCategoryId("0");
		Long categoryId = Long.parseLong(observerVO.getCategoryId());
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();

		boolean success = true;
		if (observerVO != null && observerVO.getBidItemId() != null) {
			success = observerService.getH1Approved(observerVO, name);
		}
		logger.debug("UserName For category: " + name);

		List<Bids> bidsList = null;

		CommonVO commonVO = new CommonVO();
		commonVO.setUserName(name);
		Long auctionId = 0L;
		long seqId = 0L;
		String endSeq = RedisCacheService.isEndSequence();
		if (endSeq == null) {
			bidsList = new ArrayList<Bids>();
			modelMap.addAttribute("bidsList", bidsList);
			List<BidderCategory> bidCategoryList = commonService
					.getCategoryList(name);
			modelMap.addAttribute("bidderCategoryList", bidCategoryList);
			logger.debug(" For category: categoryList List::" + bidCategoryList);

			modelMap.addAttribute("categoryName", categoryId);
			return "observer_closed";
		} else if (endSeq.equalsIgnoreCase("false")) {
			long activeBidItemId = RedisCacheService.getActiveBidItemId();
			Map<String, String> activeItemDetails = RedisCacheService
					.getBidItemSequenceDetails(activeBidItemId);
			auctionId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_AUCTIONID));
			seqId = Long.parseLong(activeItemDetails
					.get(RedisConstants.ATTR_SEQUENCEID));

		} else {
			String strAuctionId = RedisCacheService.getAuctionId();
			if (strAuctionId == null) {
				return "observer_closed";
			}
			auctionId = new Long(strAuctionId);

		}
		commonVO.setSequenceId(seqId);
		commonVO.setAuctionId(auctionId);
		commonVO.setCategoryId(categoryId);

		Integer categoryL = categoryId.intValue();
		httpServletRequest.setAttribute("H1Approved", success);
		getBidItemsForCategoryForClosedMarketForObserver(page, categoryL,
				modelMap, httpServletRequest);
		/*
		 * if(categoryId != 0){ bidsList =
		 * observerService.getBidItemsForCategoryForClosedMarketForObserver
		 * (categoryId, commonVO); } else { bidsList =
		 * observerService.getBidItemsForCategoryForClosedMarketForObserver
		 * (commonVO); } modelMap.addAttribute("bidsList", bidsList);
		 * List<BidderCategory> bidCategoryList =
		 * commonService.getCategoryList(name);
		 * modelMap.addAttribute("bidderCategoryList", bidCategoryList);
		 * logger.debug(" For category: categoryList List::"+bidCategoryList);
		 * 
		 * modelMap.addAttribute("categoryName", categoryId);
		 */

		return "observer_closed";

	}

	@RequestMapping(value = "/extension", method = RequestMethod.GET)
	public @ResponseBody
	ResponseEntity<String> doExtendBidding(
			@RequestParam(value = "bidItemId", required = true) Long bidItemId,
			@RequestParam(value = "extendTime", required = true) Integer extendTime) {
		logger.debug("Time extension called for " + bidItemId);
		// Authentication auth =
		// SecurityContextHolder.getContext().getAuthentication();
		// String userName = auth.getName();

		if (bidItemId != null && extendTime != null) {
			BidItem bidItem = RedisCacheService.getBidItem(
					RedisConstants.BIDITEM + bidItemId,
					String.valueOf(bidItemId));
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.SECOND, (int) bidItem.getTimeLeft() + extendTime);
			bidItem.setBidEndTime(cal.getTime());
			cal.add(Calendar.SECOND, -(bidItem.getTimeExtAfterBid() + 10));
			bidItem.setLastUpDateTime(cal.getTime());
			RedisCacheService.setBidEndTime(bidItemId, bidItem.getBidEndTime(),
					RedisConstants.BIDITEM + bidItemId);
			RedisCacheService.setBidItemLastUpdateTime(bidItemId,
					bidItem.getLastUpDateTime(), RedisConstants.BIDITEM
							+ bidItemId);
			CometPusher.getInstance().pushBidExtendTime(bidItem);
		}

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		return new ResponseEntity<String>(headers, HttpStatus.OK);
	}

}
