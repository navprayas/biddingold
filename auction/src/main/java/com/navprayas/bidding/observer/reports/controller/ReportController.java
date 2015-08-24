package com.navprayas.bidding.observer.reports.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import org.springframework.web.servlet.ModelAndView;

import com.navprayas.bidding.common.dto.ReportSummary2;
import com.navprayas.bidding.common.dto.ReportVO;
import com.navprayas.bidding.common.dto.TotalReportSummary2;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.common.form.ReportsTotal;
import com.navprayas.bidding.common.service.ICommonService;
import com.navprayas.bidding.observer.reports.service.IReportService;
import com.navprayas.bidding.observer.reports.service.IReportSummary2Service;


@RequestMapping("/report/**")
@Controller
public class ReportController {
	private final static Logger logger = LoggerFactory.getLogger(ReportController.class);
	private static final String DATE_FORMAT = "dd/MM/yyyy";
	
	@Autowired
	@Qualifier("reportService")
	private IReportService reportService;
	
	
	@Autowired
	@Qualifier("reportService2")
	private IReportSummary2Service  reportSummary2Service;
	
	@Autowired
	@Qualifier("commonService")
	private ICommonService commonService;
	
	@RequestMapping("/observerSummary1")
	public String getObserverReportSummary1(ModelMap modelMap, HttpServletRequest httpServletRequest) {
		
		logger.debug("In getObserverReportSummary1 Method::");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userName = auth.getName();
		
		List<Bids> bidsList = reportService.getReportSummary1(userName, null);
		List<BidderCategory> bidCategoryList = commonService.getCategoryList(userName);
		Set<String> bidsStatusSet  = reportService.getLotsList(userName);
		
		ReportsTotal reportsTotal = getReportsTotal(bidsList);
		
		Date d1 = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		String date = sdf.format(d1);	
		
		modelMap.addAttribute("dateFromStr", date);
		modelMap.addAttribute("dateToStr", date);
		
		modelMap.addAttribute("BidsList",bidsList);
		modelMap.addAttribute("bidderCategoryList", bidCategoryList);
		modelMap.addAttribute("reportsTotal",reportsTotal);
		modelMap.addAttribute("bidsStatusSet",bidsStatusSet);
		modelMap.addAttribute("bidsStat",0);
		return "observersummary1";
	}
	
	@RequestMapping(value = "/observerSummary1/Search/page")
	public String findobserverSummary1ReportList(ReportVO reportVO, ModelMap modelMap) {
		
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String name = auth.getName();
		List<Bids> bidsList = null;
		if(reportVO.getParamDateFrom() == null || reportVO.getParamDateTo() == null){
			bidsList = reportService.getReportSummary1(name, null);
		}else{
			bidsList = reportService.getReportSummary1(name, reportVO);
		}
		List<BidderCategory> bidCategoryList = commonService.getCategoryList(name);
		ReportsTotal reportsTotal = getReportsTotal(bidsList);
		Set<String> bidsStatusSet  = reportService.getLotsList(name);
		modelMap.addAttribute("BidsList",bidsList);
		
		if(reportVO.getParamDateFrom() == null || reportVO.getParamDateTo() == null){
			Date d1 = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
			String date = sdf.format(d1);	
			modelMap.addAttribute("dateFromStr", date);
			modelMap.addAttribute("dateToStr", date);
		}else {
			Date dateFrom = reportVO.getDateFrom();
			Date dateTo = reportVO.getDateTo();
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
			String dateFromStr = sdf.format(dateFrom);
			String dateToStr = sdf.format(dateTo);
			modelMap.addAttribute("dateFromStr", dateFromStr);
			modelMap.addAttribute("dateToStr", dateToStr);
		}
		
		
		
		modelMap.addAttribute("bidderCategoryList", bidCategoryList);
		modelMap.addAttribute("reportsTotal",reportsTotal);
		
		modelMap.addAttribute("bidsStatusSet",bidsStatusSet);
		modelMap.addAttribute("bidsStat",0);
		
		return "observersummary1";
	}
	
	@RequestMapping(value = "observerSummary1/find/excel")
    public ModelAndView getObserverSummary1ReportExcel(ReportVO reportVO,ModelMap modelMap) {             

             logger.debug("Inside getObserverSummary1ReportExcel Method::"); 
             
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
     		String name = auth.getName();
     		
     		List<Bids> bidsList = reportService.getReportSummary1(name, reportVO);     		

            return new ModelAndView("ExcelObserverReportSummary1","list",bidsList);

    }
	
	@RequestMapping(value="/observerSummary1/Search/Category")
	public String getBidsForCategoryObserverReportSummary1(ReportVO reportVO,ModelMap modelMap, HttpServletRequest httpServletRequest) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String name = auth.getName();
		long categoryId = reportVO.getCategoryId();
		if(reportVO.getCategoryId() == null){
			categoryId = 0;
		}
		logger.debug("UserName For category: " + name);
		
		List<Bids> bidsList = null;
		if(categoryId != 0)
			bidsList = reportService.getBidsForCategoryObserverReportSummary1(reportVO, name);
		else
			bidsList = reportService.getReportSummary1(name, reportVO);
		
		List<BidderCategory> bidCategoryList = commonService.getCategoryList(name);
		Set<String> bidsStatusSet  = reportService.getLotsList(name);
		ReportsTotal reportsTotal = getReportsTotal(bidsList);
		
		Date dateFrom = reportVO.getDateFrom();
		Date dateTo = reportVO.getDateTo();
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		String dateFromStr = sdf.format(dateFrom);
		String dateToStr = sdf.format(dateTo);
		
		modelMap.addAttribute("dateFromStr", dateFromStr);
		modelMap.addAttribute("dateToStr", dateToStr);
		
		modelMap.addAttribute("BidsList",bidsList);
		modelMap.addAttribute("bidderCategoryList", bidCategoryList);
		modelMap.addAttribute("reportsTotal",reportsTotal);
		
		modelMap.addAttribute("bidsStatusSet",bidsStatusSet);
		modelMap.addAttribute("bidsStat",0);
		modelMap.addAttribute("categoryName",categoryId);

		return "observersummary1";
	}
	
	@RequestMapping("/observerSummary1/LotsStatus/List")
	public String getLotsStatusSearchListObserverReportSummary1(ReportVO reportVO, ModelMap modelMap, HttpServletRequest httpServletRequest) {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userName = auth.getName();
		String lotsStatus = reportVO.getLotsStatus();
		if(lotsStatus == null){
			lotsStatus = "0";
		}
		long categoryId = 0;
		if(reportVO.getCategoryId() != null){
			categoryId = reportVO.getCategoryId();
		}
		logger.debug("UserName For category: " + userName);
		List<Bids> bidsList = null;
		
		if(reportVO.getLotsStatus() != null && !reportVO.getLotsStatus().equals("0"))
			bidsList = reportService.getBidsForLotsObserverReportSummary1(reportVO, userName);
		else
			bidsList = reportService.getReportSummary1(userName, reportVO);
		
		List<BidderCategory> bidCategoryList = commonService.getCategoryList(userName);
		Set<String> bidsStatusSet  = reportService.getLotsList(userName);
		ReportsTotal reportsTotal = getReportsTotal(bidsList);
		
		Date dateFrom = reportVO.getDateFrom();
		Date dateTo = reportVO.getDateTo();
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		String dateFromStr = sdf.format(dateFrom);
		String dateToStr = sdf.format(dateTo);
		
		modelMap.addAttribute("dateFromStr", dateFromStr);
		modelMap.addAttribute("dateToStr", dateToStr);
		
		modelMap.addAttribute("BidsList",bidsList);
		modelMap.addAttribute("bidderCategoryList", bidCategoryList);
		modelMap.addAttribute("reportsTotal",reportsTotal);

		modelMap.addAttribute("bidsStatusSet",bidsStatusSet);
		modelMap.addAttribute("bidsStat",lotsStatus);
		modelMap.addAttribute("categoryName",categoryId);
		return "observersummary1";
	}

	
	
	

	private ReportsTotal getReportsTotal(List<Bids> bidsList) {
		int totalQuantity = 0;
		Double totalBidAmount1 = 0.0;
		Double totalBidAmount2 = 0.0;
		Double totalBidAmount3 = 0.0;
		Double finalTotalSalesPrice = 0.0;
		for(Bids bids : bidsList){
			totalQuantity += bids.getBidItem().getTotalQuantity() == null ? 0.0 : bids.getBidItem().getTotalQuantity();
			totalBidAmount1 += bids.getBidAmount() == null ? 0.0 : bids.getBidAmount();
			totalBidAmount2 += bids.getBidAmount2() == null ? 0.0 : bids.getBidAmount2();
			totalBidAmount3 += bids.getBidAmount3() == null ? 0.0 : bids.getBidAmount3();
			finalTotalSalesPrice += bids.getTotalSalesPrice() == null ? 0.0 : bids.getTotalSalesPrice();
		}
		
		ReportsTotal reportsTotal = new ReportsTotal();
		reportsTotal.setTotalQuantity(totalQuantity);
		reportsTotal.setTotalBidAmount1(totalBidAmount1);
		reportsTotal.setTotalBidAmount2(totalBidAmount2);
		reportsTotal.setTotalBidAmount3(totalBidAmount3);
		reportsTotal.setFinalTotalSalesPrice(finalTotalSalesPrice);
		return reportsTotal;
	}
	
	
	
	
	@RequestMapping("/observerBidderWise")
	public String getObserverBidderwiseSummary(ModelMap modelMap, HttpServletRequest httpServletRequest) {
		logger.debug("In getObserverBidderwiseSummary Method::");
		return "observer/observer_bidder_wise_popup";
	}
	
	@RequestMapping("/observerSummary2")
	public String getObserverReportSummary2(ModelMap modelMap, HttpServletRequest httpServletRequest) {
		
		logger.debug("In getObserverReportSummary2 Method::");
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String userName = auth.getName();
		
		Date d1 = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
		String date = sdf.format(d1);	
		
		modelMap.addAttribute("dateFromStr", date);
		modelMap.addAttribute("dateToStr", date);
		
		Map<Long,ReportSummary2> reportSummary2Map = reportSummary2Service.getReportSummary2(userName, null);
		Collection<ReportSummary2> reportSummary2Col = reportSummary2Map.values();
		
		List<ReportSummary2> reportSummary2List = new ArrayList<ReportSummary2>(reportSummary2Col);		
		modelMap.addAttribute("reportSummary2List",reportSummary2List);
		
		TotalReportSummary2 totalReportSummary2 = getReportsSummary2Total(reportSummary2List);
		modelMap.addAttribute("totalReportSummary2",totalReportSummary2);
		
		return "observer/observer_summary2";
	}
	
	
	
	private TotalReportSummary2 getReportsSummary2Total(List<ReportSummary2> reportSummary2List) {
		
		int  grandTotalLotsForSale = 0;
		int  grandTotalLotsquantityForSale = 0;
		
		int  grandTotalActualSoldLots = 0;
		int  grandTotalActualSoldQunatity = 0;
		Double  grandTotalActualSoldAmount = 0.0;
		
		Double  avergeTotalAmount = 0.0;
		int  grandTUnsoldUnBiddedLots  = 0;
		int  grandTotalUnsoldUnBiddedQuantity  = 0;

		for(ReportSummary2 reportSummary2 : reportSummary2List){
			
			grandTotalLotsForSale += reportSummary2.getTotalLotsForSale() == null ? 0 : reportSummary2.getTotalLotsForSale();
			grandTotalLotsquantityForSale += reportSummary2.getTotalLotsquantityForSale() == null ? 0 : reportSummary2.getTotalLotsquantityForSale();
			
			grandTotalActualSoldLots += reportSummary2.getTotalActualSoldLots() == null ? 0 : reportSummary2.getTotalActualSoldLots();
			grandTotalActualSoldQunatity += reportSummary2.getTotalActualSoldQunatity() == null ? 0 : reportSummary2.getTotalActualSoldQunatity();
			grandTotalActualSoldAmount += reportSummary2.getTotalActualSoldAmount() == null ? 0.0 : reportSummary2.getTotalActualSoldAmount();
			
			avergeTotalAmount += reportSummary2.getAvergeAmount() == null ? 0.0 : reportSummary2.getAvergeAmount();
			grandTUnsoldUnBiddedLots += reportSummary2.getTotalUnsoldBiddedLots() == null ? 0 : reportSummary2.getTotalUnsoldBiddedLots();
			grandTotalUnsoldUnBiddedQuantity += reportSummary2.getTotalUnsoldBiddedQuantity() == null ? 0 : reportSummary2.getTotalUnsoldBiddedQuantity();
			
		}
		
		TotalReportSummary2 totalReportSummary2 = new TotalReportSummary2();
		
		totalReportSummary2.setGrandTotalLotsForSale(grandTotalLotsForSale);
		totalReportSummary2.setGrandTotalLotsquantityForSale(grandTotalLotsquantityForSale);
		
		totalReportSummary2.setGrandTotalActualSoldAmount(grandTotalActualSoldAmount);
		totalReportSummary2.setGrandTotalActualSoldLots(grandTotalActualSoldLots);
		totalReportSummary2.setGrandTotalActualSoldQunatity(grandTotalActualSoldQunatity);
		
		totalReportSummary2.setAvergeTotalAmount(avergeTotalAmount);
		totalReportSummary2.setGrandTotalUnsoldUnBiddedQuantity(grandTotalUnsoldUnBiddedQuantity);
		totalReportSummary2.setGrandTUnsoldUnBiddedLots(grandTUnsoldUnBiddedLots);
		
		return totalReportSummary2;
	}
	
	
	@RequestMapping(value = "observerSummary2/find/excel")
    public ModelAndView getObserverSummary2ReportExcel(ReportVO reportVO,ModelMap modelMap) {             

             logger.debug("Inside getObserverSummary2ReportExcel Method::"); 
             
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
     		String userName = auth.getName();
     		
     		Map<Long,ReportSummary2> reportSummary2Map = reportSummary2Service.getReportSummary2(userName, reportVO);
    		Collection<ReportSummary2> reportSummary2Col = reportSummary2Map.values();
    		List<ReportSummary2> reportSummary2List = new ArrayList<ReportSummary2>(reportSummary2Col);
    	    		

            return new ModelAndView("ExcelObserverReportSummary2","list1",reportSummary2List);

    }
	
	// Code added By Ashish
	@RequestMapping(value = "observerSummary1/find/pdf")
    public ModelAndView getObserverSummary1ReportPDF(ReportVO reportVO,ModelMap modelMap) {             

             logger.debug("Inside getObserverSummary1ReportExcel Method::"); 
             
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
     		String name = auth.getName();
     		
     		List<Bids> bidsList = reportService.getReportSummary1(name, reportVO);     		

            return new ModelAndView("PDfObserverSummary1ReportView","list",bidsList);

    }
	
	
}
