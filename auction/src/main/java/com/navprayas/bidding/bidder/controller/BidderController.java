package com.navprayas.bidding.bidder.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.navprayas.bidding.common.dto.ReportVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.service.IBidItemsCacheService;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.utility.RedisCacheService;

@RequestMapping("/bidder/**")
@Controller
public class BidderController {

	private final static Logger logger = LoggerFactory
			.getLogger(BidderController.class);
	private static final String DATE_FORMAT = "dd/MM/yyyy";
	@Autowired
	@Qualifier("bidderService")
	private IBidderService bidderService;

	@Autowired
	@Qualifier("commonService")
	private ICommonService commonService;

	@Autowired
	@Qualifier("bidItemsCacheService")
	private IBidItemsCacheService bidItemsCacheService;

	@RequestMapping(value={"/home","/"},method=RequestMethod.GET)
	public String getBidItems(ModelMap modelMap,
			HttpServletRequest httpServletRequest) {
		logger.info("In getBidItems Method:");
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();
		modelMap.addAttribute("bidItem", new BidItem());
		getBidItemsForCategoryForMarketListForBidder(0, "1", modelMap,
				httpServletRequest);
		// List<BidItem> bidItemsList =
		// (List<BidItem>)(modelMap.get("bidItemsList"));
		// return "bidder/bidder_marketlist";
		return "bidder_marketlist";
	}
	@RequestMapping(value = "/marketlist")
	public String getBidItemsForCategoryForMarketListForBidder(
			@RequestParam(value = "category", required = false) Integer categoryId,
			@RequestParam(required = false, defaultValue = "1", value = "page") String page,
			ModelMap modelMap, HttpServletRequest httpServletRequest) {
		System.out.println("categoryId" + categoryId);
		logger.info("In getBidItemsForCategoryForMarketListForBidder Method For category: "
				+ categoryId);
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();
		if (categoryId == null) {
			categoryId = 0;
		}
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
			logger.debug("In end sequence is null");
			String strAuctionId = RedisCacheService.getAuctionId();
			if (strAuctionId == null) {
				return "bidder_marketlist";
			}
			Long auctionId = new Long(strAuctionId);

			commonVO.setSequenceId(0L);
			commonVO.setAuctionId(auctionId);
			commonVO.setCategoryId(categoryId);

			commonService.updateUserActivity(httpServletRequest.getSession()
					.getId(), auctionId);

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
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(
								categoryId, commonVO);
			} else {
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(commonVO);
			}

			if (bidItemsList == null || bidItemsList.size() == 0) {
				return "bidder_marketlist";
			}

			logger.debug("***************BidItems List Size::"
					+ bidItemsList.size());

			Date date = null;
			if (bidItemsCacheService.getAuctionStartTime() == null) {
				date = commonService.getActualAuctionStartTime(auctionId);
			} else {
				date = bidItemsCacheService.getAuctionStartTime();
			}
			if (date == null) {
				return "bidder_marketlist";
			}
			Date currDate = new Date();
			long refreshTime = date.getTime() - currDate.getTime();
			refreshTime = (long) (refreshTime / 1000);
			logger.debug("*****refreshTime::" + refreshTime);
			if (refreshTime <= 0) {
				return "bidder_marketlist";
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
				logger.debug("bidItem : " + bidItem.getBidItemId() + " "
						+ bidItem.getBidSpan() + " " + refreshTime);
				bidItem.setTimeLeft(refreshTime);
				refreshTime += bidItem.getBidSpan();
				if (bidItem.getCurrentMarketPrice() == null) {
					bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice());
					bidItemsList.set(bidItemsList.indexOf(bidItem), bidItem);
				}
			}
		} else if (endSeq.equalsIgnoreCase("false")) {
			logger.debug("In is end sequence is false");
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
			logger.debug("Before record count for Biditems:");
			Long count = 0L;
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

			if (categoryId != 0) {
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(
								categoryId, commonVO);
			} else {
				bidItemsList = bidderService
						.getBidItemsForCategoryForMarketListForBidder(commonVO);
			}
			if (bidItemsList != null) {
				logger.debug("***************BidItems List Size::"
						+ bidItemsList.size());
			}
			BidItem activeBidItem = bidItemsCacheService
					.getBidItem(RedisCacheService.getActiveBidItemId());
			modelMap.addAttribute("refreshTime", activeBidItem.getTimeLeft());

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
			logger.debug("In end sequence is true");
			bidItemsList = new ArrayList<BidItem>();
		}
		logger.debug(" For category: BidItems List::" + bidItemsList);
		modelMap.addAttribute("bidItemsList", bidItemsList);
		Set<Long> biditemBidderSet = prefferedBidItemsForBidder(name);
		Map<Long, Integer> bidItemPrefferMap = new HashMap<Long, Integer>();
		for (Long bidId : biditemBidderSet)
			bidItemPrefferMap.put(bidId, 1);

		logger.debug("bidItemPrefferMap: " + bidItemPrefferMap);
		modelMap.addAttribute("bidItemPrefferMap", bidItemPrefferMap);

		modelMap.addAttribute("navigationInfo", navigationInfo);

		return "bidder_marketlist";
	}

	@RequestMapping(value = "/active", method = RequestMethod.GET)
	public String getBidItemsForCategoryForActiveMarketForBidder(
			@RequestParam(value = "category", required = false) Integer categoryId,
			ModelMap modelMap, HttpServletRequest httpServletRequest) {
		logger.info("In getBidItemsForCategoryForMarketListForBidder Method For category: "
				+ categoryId);

		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();
		logger.debug("UserName For category: " + name);
		if (categoryId == null) {
			categoryId = 0;
		}
		List<BidderCategory> categoryList = commonService.getCategoryList(name);
		modelMap.addAttribute("bidderCategoryList", categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		modelMap.addAttribute("categoryName", categoryId);
		List<BidItem> bidItemsList = new ArrayList<BidItem>();

		String endSeq = RedisCacheService.isEndSequence();
		if (endSeq != null && endSeq.equalsIgnoreCase("false")) {
			BidItem activeBidItem = bidItemsCacheService
					.getBidItem(RedisCacheService.getActiveBidItemId());

			if (activeBidItem != null) {
				Long activeBidItemCategoryid = activeBidItem.getCategory()
						.getCategoryId();
				if (categoryId.longValue() == 0) {
					if (!checkBidderAllowedforThisCategory(categoryList,
							activeBidItemCategoryid)) {

						modelMap.addAttribute("bidItemsList", bidItemsList);
						return "bidder_active";
					}
				} else if ((categoryId.longValue() == 0)
						|| (categoryId.longValue() == activeBidItem
								.getCategory().getCategoryId())) {
					logger.debug("Same category Id found " + categoryId);
				} else {
					modelMap.addAttribute("bidItemsList", bidItemsList);
					return "bidder_active";
				}
				activeBidItem.setItemLots(commonService
						.getItemLots(activeBidItem.getBidItemId()));
				logger.debug(" For category: BidItems List::" + bidItemsList);

				if (activeBidItem.getCurrentMarketPrice() == null)
					activeBidItem.setCurrentMarketPrice(activeBidItem
							.getMinBidPrice());
				bidItemsList.add(activeBidItem);

				BidItem tempItem = bidderService.getBidItem(activeBidItem
						.getBidItemId());
				if (tempItem != null && activeBidItem != null) {
					activeBidItem.setSerialNo(tempItem.getSerialNo());
				}

				Map<Long, String> bidItemWithRanks = new HashMap<Long, String>();
				Map<Long, String> bidItemWithAutoBidFlag = new HashMap<Long, String>();

				for (BidItem item : bidItemsList) {
					Bidder tempBidder = new Bidder();
					tempBidder.setBidderName(name);
					List<Bidder> bidders = item.getCurrentBidderList();
					int rank = bidders.indexOf(tempBidder) + 1;
					bidItemWithRanks.put(item.getBidItemId(), rank + "");
					if (item.isAutoBidFlag() && rank > 0
							&& bidders.get(rank - 1).isAutoBid()) {
						bidItemWithAutoBidFlag.put(item.getBidItemId(), "2");
					} else {
						bidItemWithAutoBidFlag.put(item.getBidItemId(), "1");
					}
				}
				modelMap.addAttribute("bidItemWithRanks", bidItemWithRanks);
				modelMap.addAttribute("bidItemWithAutoBidFlag",
						bidItemWithAutoBidFlag);
				Set<Long> biditemBidderSet = prefferedBidItemsForBidder(name);
				Map<Long, Integer> bidItemPrefferMap = new HashMap<Long, Integer>();
				for (Long bidId : biditemBidderSet)
					bidItemPrefferMap.put(bidId, 1);

				logger.debug("bidItemPrefferMap: " + bidItemPrefferMap);
				modelMap.addAttribute("bidItemPrefferMap", bidItemPrefferMap);
			}
		}
		modelMap.addAttribute("bidItemsList", bidItemsList);
		return "bidder_active";
	}

	private boolean checkBidderAllowedforThisCategory(
			List<BidderCategory> categoryList, Long activeBidItemCategoryid) {
		boolean check = false;
		for (BidderCategory cat : categoryList) {
			if (activeBidItemCategoryid.equals(cat.getCategoryId()))
				check = true;
		}
		return check;
	}

	@RequestMapping(value = "/closed")
	public String getBidItemsForCategoryForClosedMarketForBidder(
			@RequestParam(required = false, value = "category") Integer categoryId,
			@RequestParam(required = false, defaultValue = "1", value = "page") String page,
			ModelMap modelMap, HttpServletRequest httpServletRequest) {
		logger.info("In getBidItemsForCategoryForClosedMarketForBidder Method For category: "
				+ categoryId);
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();
		if (categoryId == null) {
			categoryId = 0;
		}
		List<BidderCategory> categoryList = commonService.getCategoryList(name);
		modelMap.addAttribute("bidderCategoryList", categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		modelMap.addAttribute("categoryName", categoryId);

		logger.debug("UserName For category: " + name);
		List<BidItem> bidItemsList = null;

		String endSeq = RedisCacheService.isEndSequence();

		CommonVO commonVO = new CommonVO();
		commonVO.setUserName(name);
		commonVO.setCategoryId(categoryId);

		NavigationInfo navigationInfo = new NavigationInfo();

		if (endSeq == null) {
			bidItemsList = new ArrayList<BidItem>();
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

			logger.debug("Before record count for Biditems in Closed Market List:");
			Long count = null;
			if (categoryId != 0) {
				count = bidderService
						.findBidItemsCountForClosedListForBidderForCategory(commonVO);
			} else {
				count = bidderService
						.findBidItemsCountForClosedListForBidder(commonVO);
			}

			navigationInfo.setRowCount(Integer.valueOf(count + ""));
			logger.debug("****** BidItems Count in Closed Market List is::"
					+ count + " *******");

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
						.getBidItemsForCategoryForClosedMarketForBidder(
								categoryId, commonVO);
			else
				bidItemsList = bidderService
						.getBidItemsForCategoryForClosedMarketForBidder(commonVO);
		} else {
			String strAuctionId = RedisCacheService.getAuctionId();
			if (strAuctionId == null) {
				return "bidder_closed";
			}
			Long auctionId = new Long(strAuctionId);

			commonVO.setSequenceId(0L);
			commonVO.setAuctionId(auctionId);

			logger.debug("Before record count for Biditems in Closed Market List:");
			Long count = null;
			if (categoryId != 0) {
				count = bidderService
						.findBidItemsCountForClosedListForBidderForCategory(commonVO);
			} else {
				count = bidderService
						.findBidItemsCountForClosedListForBidder(commonVO);
			}

			navigationInfo.setRowCount(Integer.valueOf(count + ""));
			logger.debug("****** BidItems Count in Closed Market List is::"
					+ count + " *******");

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
						.getBidItemsForCategoryForClosedMarketForBidder(
								categoryId, commonVO);
			else
				bidItemsList = bidderService
						.getBidItemsForCategoryForClosedMarketForBidder(commonVO);
		}

		logger.debug(" For category: BidItems List::" + bidItemsList);
		modelMap.addAttribute("bidItemsList", bidItemsList);

		Set<Long> biditemBidderSet = prefferedBidItemsForBidder(name);
		Map<Long, Integer> bidItemPrefferMap = new HashMap<Long, Integer>();
		for (Long bidId : biditemBidderSet)
			bidItemPrefferMap.put(bidId, 1);

		logger.debug("bidItemPrefferMap: " + bidItemPrefferMap);
		modelMap.addAttribute("bidItemPrefferMap", bidItemPrefferMap);
		modelMap.addAttribute("navigationInfo", navigationInfo);

		return "bidder_closed";
	}

	@RequestMapping(value = "/bid", method = RequestMethod.GET)
	public @ResponseBody
	String doBid(
			@RequestParam(value = "bidItemId", required = true) Long bidItemId,
			@RequestParam(value = "bidType", required = true) Integer bidType,
			@RequestParam(value = "bidAmount", required = true) Double bidAmount,
			@RequestParam(value = "comments", required = true) String comments,
			ModelMap modelMap)

	{
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String userName = auth.getName();
		boolean returnVal = bidderService.doBid(bidItemId.intValue(), bidType,
				new Double(bidAmount), userName, comments);

		if (bidType == 2) {
			BidItem bidItem = bidItemsCacheService.getBidItem(bidItemId);

			Map<Long, String> bidItemWithRanks = new HashMap<Long, String>();
			Map<Long, String> bidItemWithAutoBidFlag = new HashMap<Long, String>();
			Bidder tempBidder = new Bidder();
			tempBidder.setBidderName(userName);
			List<Bidder> bidders = bidItem.getCurrentBidderList();
			int rank = bidders.indexOf(tempBidder) + 1;
			bidItemWithRanks.put(bidItem.getBidItemId(), rank + "");
			if (bidItem.isAutoBidFlag() && rank > 0
					&& bidders.get(rank - 1).isAutoBid()) {
				bidItemWithAutoBidFlag.put(bidItem.getBidItemId(), "2");
			} else {
				bidItemWithAutoBidFlag.put(bidItem.getBidItemId(), "1");
			}
			modelMap.addAttribute("bidItemWithRanks", bidItemWithRanks);
			modelMap.addAttribute("bidItemWithAutoBidFlag",
					bidItemWithAutoBidFlag);
			return "bidder/bidder_active";
		}

		logger.debug("In doBid Method returnVal: " + returnVal);
		HashMap<String, String> h = new HashMap<String, String>();
		h.put("returnVal", "" + returnVal);
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		return "Hello World";
	}

	@RequestMapping(value = "/marketlist/saveautobid", method = RequestMethod.POST)
	public String saveAutoBid(
			@RequestParam(value = "bidItemId", required = true) Long bidItemId,
			@RequestParam(value = "autoBidAmount", required = true) float bidAmount,
			@RequestParam(value = "categoryId", required = true) Long categoryId,
			ModelMap modelMap) {
		logger.debug("In saveautobid Method bidItemId: " + bidItemId);
		logger.debug("In saveautobid Method bidAmount: " + bidAmount);
		logger.debug("In saveautobid Method categoryId: " + categoryId);
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String userName = auth.getName();
		List<BidItem> bidItemsList = null;

		bidItemsList = bidderService.saveAutoBid(userName, categoryId,
				bidItemId, bidAmount, "No Comments");
		logger.debug(" For category: BidItems List::" + bidItemsList);
		modelMap.addAttribute("bidItemsList", bidItemsList);
		List<BidderCategory> categoryList = commonService
				.getCategoryList(userName);
		modelMap.addAttribute("bidderCategoryList", categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		return "redirect:/bidder/home";

	}

	@RequestMapping(value = "/marketlist/deleteautobid", method = RequestMethod.POST)
	public String deleteAutoBid(
			@RequestParam(value = "autoBidId", required = true) Long autoBidId,
			@RequestParam(value = "categoryId", required = true) Long categoryId,
			ModelMap modelMap) {
		logger.debug("In deleteautobid Method autoBidId: " + autoBidId);
		logger.debug("In deleteautobid Method categoryId: " + categoryId);
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String userName = auth.getName();
		List<BidItem> bidItemsList = null;

		bidItemsList = bidderService.deleteAutoBid(userName, categoryId,
				autoBidId);

		logger.debug(" For category: BidItems List::" + bidItemsList);
		modelMap.addAttribute("bidItemsList", bidItemsList);
		List<BidderCategory> categoryList = commonService
				.getCategoryList(userName);
		modelMap.addAttribute("bidderCategoryList", categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);
		return "redirect:/bidder/home";
	}

	public Set<Long> prefferedBidItemsForBidder(String userName) {
		logger.debug("Username for prefferedBidItemsForBidder " + userName);
		return bidderService.prefferedBidItemsForBidder(userName);
	}

	@RequestMapping(value = "/setPreffered", method = RequestMethod.GET)
	public @ResponseBody
	ResponseEntity<String> setPrefferedBidItem(
			@RequestParam(value = "bidItemId", required = true) Long bidItemId) {
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String userName = auth.getName();
		logger.debug("Username/bidItemId for setPrefferedBidItem " + userName
				+ " " + bidItemId);
		bidderService.setPrefferedBidItem(userName, bidItemId);
		return new ResponseEntity<String>("setPreffered", HttpStatus.OK);
	}

	@RequestMapping(value = "/removePreffered", method = RequestMethod.GET)
	public @ResponseBody
	ResponseEntity<String> removePrefferedBidItem(
			@RequestParam(value = "bidItemId", required = true) Long bidItemId) {
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String userName = auth.getName();
		logger.debug("Username/bidItemId for removePrefferedBidItem "
				+ userName + " " + bidItemId);
		bidderService.removePrefferedBidItem(userName, bidItemId);
		return new ResponseEntity<String>("removePreffered", HttpStatus.OK);
	}

	// DEEPAK SINHA
	// MAPPING FOR ALL WON BIDS
	@RequestMapping("/bidderReport")
	public String getwonLists(ModelMap modelMap,
			HttpServletRequest httpServletRequest) throws Exception {

		logger.info("In getwonLists Method:");
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();
		logger.debug("UserName" + name);
		modelMap.addAttribute("listBidItems", new BidItem());
		List<BidItem> wonList = bidderService.getWonBids(name);
		logger.debug("closedbids List::" + wonList);
		modelMap.addAttribute("wonList", wonList);
		List<BidderCategory> categoryList = commonService.getCategoryList(name);
		modelMap.addAttribute("bidderCategoryList", categoryList);
		logger.debug(" For category: bidderCategoryList List::" + categoryList);

		// WRITE EXCEL FILE
		WriteExcelFile writeExcelFile = new WriteExcelFile();
		writeExcelFile.writeWonListToExcelFile("excel.xls", wonList);

		// WRITE PDF FILE
		ExcelToPdf excelToPdf = new ExcelToPdf();
		excelToPdf.excelToPdfwriter();
		return "bidder_report";
	}

	// DEEPAK SINHA
	// MAPPING FOR DATE WISE WON BIDS
	@RequestMapping("/bidderReport1")
	public String getwonList(ModelMap modelMap, ReportVO reportVO,
			HttpServletRequest httpServletRequest) throws Exception {

		logger.info("In getwonList Method:");
		Authentication auth = SecurityContextHolder.getContext()
				.getAuthentication();
		String name = auth.getName();

		Date dateFrom = reportVO.getDateFrom();
		Date dateTo = reportVO.getDateTo();
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		String dateFromStr = sdf.format(dateFrom);
		String dateToStr = sdf.format(dateTo);

		modelMap.addAttribute("dateFromStr", dateFromStr);
		modelMap.addAttribute("dateToStr", dateToStr);

		logger.debug("UserName" + name);
		modelMap.addAttribute("listBidItems", new BidItem());

		List<BidItem> wonList = bidderService.getWonBids(name);
		Iterator<BidItem> itr = wonList.iterator();
		List<BidItem> list = new ArrayList<BidItem>();

		while (itr.hasNext()) {
			BidItem biditem = (BidItem) itr.next();
			Long bidItemId = biditem.getBidItemId();
			// modelMap.addAttribute("listBidItems", new BidItem());
			BidItem bd = bidderService.getBidItem(bidItemId);
			Date bidEndTime = bd.getBidEndTime();

			System.out.println(bd.getBidEndTime());
			System.out.println(dateTo + "\n" + dateFrom);

			if (bidEndTime.after(dateFrom) && bidEndTime.before(dateTo))

			{
				logger.debug("closedbids List::" + bd);
				list.add(biditem);
				// list.add(bd);

				System.out.println("controller working in  if");
			}

			System.out.println("controller working..");

		}
		modelMap.addAttribute("wonList", list);

		// WRITE EXCEL FILE
		WriteExcelFile writeExcelFile = new WriteExcelFile();
		writeExcelFile.writeWonListToExcelFile("excel.xls", list);

		// WRITE PDF FILE
		ExcelToPdf excelToPdf = new ExcelToPdf();
		excelToPdf.excelToPdfwriter();

		List<BidderCategory> categoryList = commonService.getCategoryList(name);
		modelMap.addAttribute("bidderCategoryList", categoryList);
		return "bidder_date_report";

	}

	// DEEPAK SINHA
	// MAPPING FOR DOWNLOAD PDF FILE
	@RequestMapping(value = "/downloadPdf", method = RequestMethod.GET)
	public String downloadPdf(ModelMap model, HttpServletResponse res)
			throws IOException {

		res.setHeader("content-disposition", "attachment;filename="
				+ "Excel2PDF_Output" + ".pdf");
		res.setContentType("application/pdf");
		FileInputStream fin;

		fin = new FileInputStream("Excel2PDF_Output.pdf");

		byte b[] = new byte[fin.available()];
		fin.read(b);
		ServletOutputStream out = res.getOutputStream();
		out.write(b);
		out.close();
		fin.close();
		return null;
	}

	// DEEPAK SINHA
	// MAPPING FOR DOWNLOAD EXCEL FILE
	@RequestMapping(value = "/downloadExcel", method = RequestMethod.GET)
	public String loadData(ModelMap model, HttpServletResponse res)
			throws IOException {

		res.setHeader("content-disposition", "attachment;filename=" + "excel"
				+ ".xls");
		res.setContentType("application/msexcel");
		FileInputStream fin;

		fin = new FileInputStream("/excel.xls");

		byte b[] = new byte[fin.available()];
		fin.read(b);
		ServletOutputStream out = res.getOutputStream();
		out.write(b);
		out.close();
		fin.close();
		return null;
	}
}