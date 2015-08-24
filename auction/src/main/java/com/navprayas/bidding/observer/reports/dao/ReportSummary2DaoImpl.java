package com.navprayas.bidding.observer.reports.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.common.constant.BiddingConstants;
import com.navprayas.bidding.common.dto.ReportSummary2;
import com.navprayas.bidding.common.dto.ReportVO;
import com.navprayas.bidding.common.form.BidItem;


@Repository("reportRepository2")
public class ReportSummary2DaoImpl implements IReportSummary2Dao{
	
	
	Logger logger = LoggerFactory.getLogger(ReportSummary2DaoImpl.class);
	
	@Autowired
	private SessionFactory sessionFactory;

	public Map<Long,ReportSummary2> getReportSummary2(String userName, ReportVO reportVO) {
		
		Query totalSaleQuery = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg, Auction as auction where bidItem.category.categoryId = bidderCateg.category.categoryId" +
		"  and bidderCateg.username.loginName = :userName AND auction.startTime <= :currentTime and auction.endTime >= :currentTime AND " +
		"auction.auctionId = bidItem.auction.auctionId ORDER BY bidItem.category.categoryId ");
		
		Query actualSoldQuery = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg, Auction as auction where bidItem.category.categoryId = bidderCateg.category.categoryId" +
		"  and bidderCateg.username.loginName = :userName  and bidItem.bidEndTime < :currentTime AND auction.startTime <= :currentTime and auction.endTime >= :currentTime AND " +
		" auction.auctionId = bidItem.auction.auctionId ORDER BY bidItem.category.categoryId ");
		
		Query unsoldBiddedQuery = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg, Auction as auction, Bids as bids where bidItem.category.categoryId = bidderCateg.category.categoryId" +
		"  and bidderCateg.username.loginName = :userName  and bidItem.bidEndTime < :currentTime AND auction.startTime <= :currentTime and auction.endTime >= :currentTime AND " +
		" auction.auctionId = bidItem.auction.auctionId AND bidItem.isProcessed IS NULL AND bids.bidItem.bidItemId = bidItem.bidItemId ORDER BY bidItem.category.categoryId ");
			
	
		Query unsoldUnBiddedQuery = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg, Auction as auction, Bids as bids where bidItem.category.categoryId = bidderCateg.category.categoryId" +
				"  and bidderCateg.username.loginName = :userName  and bidItem.bidEndTime < :currentTime AND auction.startTime <= :currentTime and auction.endTime >= :currentTime AND " +
				" auction.auctionId = bidItem.auction.auctionId AND bidItem.isProcessed IS NULL AND bids.bidItem.bidItemId != bidItem.bidItemId ORDER BY bidItem.category.categoryId ");

				
		totalSaleQuery.setParameter("userName", userName);
		totalSaleQuery.setParameter("currentTime", new Date());
		List<Object[]> objectsList1 = totalSaleQuery.list();
		
		Map<Long,ReportSummary2> reportSummary2Map = new HashMap<Long,ReportSummary2>();
		
		getTotalSalesDataSummary2(objectsList1, reportSummary2Map);
		logger.debug("ReportSummary2 Map for Total Sales::"+reportSummary2Map);
		
		actualSoldQuery.setParameter("userName", userName);
		actualSoldQuery.setParameter("currentTime", new Date());
		
		List<Object[]> objectsList2 = actualSoldQuery.list();
		getActualSalesDataSummary2(objectsList2, reportSummary2Map);
		
		unsoldBiddedQuery.setParameter("userName", userName);
		unsoldBiddedQuery.setParameter("currentTime", new Date());
		List<Object[]> objectsList3 = unsoldBiddedQuery.list();		
		
		getUnsoldBiddedDataSummary2(objectsList3, reportSummary2Map);
		
		unsoldUnBiddedQuery.setParameter("userName", userName);
		unsoldUnBiddedQuery.setParameter("currentTime", new Date());
		List<Object[]> objectsList4 = unsoldUnBiddedQuery.list();
		
		getUnsoldUnBiddedDataSummary2(objectsList4, reportSummary2Map);
		return reportSummary2Map;
	
	}
	private void getUnsoldBiddedDataSummary2(List<Object[]> objectsList, Map<Long, ReportSummary2> reportSummary2Map) {
		int counter = 0;
		
		int totalUnsoldBiddedLot = 0;
		int totalUnsoldBiddedQuantity = 0;
		Long categoryId = null;
		
		
		ReportSummary2 reportSummary2Prev = null;
		for (Object[] objects : objectsList) {
			
			BidItem bidItem = (BidItem)objects[0];
			if(counter == 0){
				
				categoryId = bidItem.getCategory().getCategoryId();
				
				if(reportSummary2Map.containsKey(categoryId)){
					reportSummary2Prev = reportSummary2Map.get(categoryId);
				}else{
					reportSummary2Prev = new ReportSummary2();
				}
				
				
				reportSummary2Prev.setCategoryId(categoryId);
				reportSummary2Prev.setCategoryName(bidItem.getCategory().getCategoryName());
				
				reportSummary2Prev.setTotalUnsoldBiddedLots(++totalUnsoldBiddedLot);
				totalUnsoldBiddedQuantity += bidItem.getTotalQuantity();
				reportSummary2Prev.setTotalUnsoldBiddedQuantity(totalUnsoldBiddedQuantity);
			}
			
			if(counter != 0 && categoryId.equals(bidItem.getCategory().getCategoryId())){
				if(reportSummary2Prev == null){
					if(reportSummary2Map.containsKey(categoryId)){
						reportSummary2Prev = reportSummary2Map.get(categoryId);
					}else{
						reportSummary2Prev = new ReportSummary2();
					}
				}
				reportSummary2Prev.setCategoryId(categoryId);
				reportSummary2Prev.setCategoryName(bidItem.getCategory().getCategoryName());
				
				reportSummary2Prev.setTotalUnsoldBiddedLots(++totalUnsoldBiddedLot);
				totalUnsoldBiddedQuantity += bidItem.getTotalQuantity();
				reportSummary2Prev.setTotalUnsoldBiddedQuantity(totalUnsoldBiddedQuantity);
				
			}else if(!categoryId.equals(bidItem.getCategory().getCategoryId())){
				
				reportSummary2Map.put(categoryId, reportSummary2Prev);
				categoryId = bidItem.getCategory().getCategoryId();
				
				if(reportSummary2Map.containsKey(categoryId)){
					reportSummary2Prev = reportSummary2Map.get(categoryId);
				}else{
					reportSummary2Prev = new ReportSummary2();
				}
				totalUnsoldBiddedLot = 0 ;
				totalUnsoldBiddedQuantity = 0;
				
				reportSummary2Prev.setCategoryId(categoryId);
				reportSummary2Prev.setCategoryName(bidItem.getCategory().getCategoryName());
				
				reportSummary2Prev.setTotalUnsoldBiddedLots(++totalUnsoldBiddedLot);
				totalUnsoldBiddedQuantity += bidItem.getTotalQuantity();
				reportSummary2Prev.setTotalUnsoldBiddedQuantity(totalUnsoldBiddedQuantity);
				
			}
			counter++;
			if(counter == objectsList.size()){
				logger.debug("Objects list max size" + objectsList.size());
				reportSummary2Map.put(categoryId, reportSummary2Prev);				
			}
		
		}
	
	
		
	}
	
	private void getUnsoldUnBiddedDataSummary2(List<Object[]> objectsList, Map<Long, ReportSummary2> reportSummary2Map) {
		int counter = 0;
		
		int totalUnsoldUnBiddedLot = 0;
		int totalUnsoldUnBiddedQuantity = 0;
		Long categoryId = null;
		
		
		ReportSummary2 reportSummary2Prev = null;
		for (Object[] objects : objectsList) {
			
			BidItem bidItem = (BidItem)objects[0];
			if(counter == 0){
				
				categoryId = bidItem.getCategory().getCategoryId();
				
				if(reportSummary2Map.containsKey(categoryId)){
					reportSummary2Prev = reportSummary2Map.get(categoryId);
				}else{
					reportSummary2Prev = new ReportSummary2();
				}
				
				
				reportSummary2Prev.setCategoryId(categoryId);
				reportSummary2Prev.setCategoryName(bidItem.getCategory().getCategoryName());
				
				reportSummary2Prev.setTotalUnsoldUnBiddedLots(++totalUnsoldUnBiddedLot);
				totalUnsoldUnBiddedQuantity += bidItem.getTotalQuantity();
				reportSummary2Prev.setTotalUnsoldUnBiddedQuantity(totalUnsoldUnBiddedQuantity);
			}
			
			if(counter != 0 && categoryId.equals(bidItem.getCategory().getCategoryId())){
				if(reportSummary2Prev == null){
					if(reportSummary2Map.containsKey(categoryId)){
						reportSummary2Prev = reportSummary2Map.get(categoryId);
					}else{
						reportSummary2Prev = new ReportSummary2();
					}
				}
				reportSummary2Prev.setCategoryId(categoryId);
				reportSummary2Prev.setCategoryName(bidItem.getCategory().getCategoryName());
				
				reportSummary2Prev.setTotalUnsoldUnBiddedLots(++totalUnsoldUnBiddedLot);
				totalUnsoldUnBiddedQuantity += bidItem.getTotalQuantity();
				reportSummary2Prev.setTotalUnsoldUnBiddedQuantity(totalUnsoldUnBiddedQuantity);
				
			}else if(!categoryId.equals(bidItem.getCategory().getCategoryId())){
				
				reportSummary2Map.put(categoryId, reportSummary2Prev);
				categoryId = bidItem.getCategory().getCategoryId();
				
				if(reportSummary2Map.containsKey(categoryId)){
					reportSummary2Prev = reportSummary2Map.get(categoryId);
				}else{
					reportSummary2Prev = new ReportSummary2();
				}
				totalUnsoldUnBiddedLot = 0 ;
				totalUnsoldUnBiddedQuantity = 0;
				
				reportSummary2Prev.setCategoryId(categoryId);
				reportSummary2Prev.setCategoryName(bidItem.getCategory().getCategoryName());
				
				reportSummary2Prev.setTotalUnsoldUnBiddedLots(++totalUnsoldUnBiddedLot);
				totalUnsoldUnBiddedQuantity += bidItem.getTotalQuantity();
				reportSummary2Prev.setTotalUnsoldUnBiddedQuantity(totalUnsoldUnBiddedQuantity);
				
			}
			counter++;
			if(counter == objectsList.size()){
				logger.debug("Objects list max size" + objectsList.size());
				reportSummary2Map.put(categoryId, reportSummary2Prev);				
			}
		
		}
	
	
		
	}
	
	private void getTotalSalesDataSummary2(List<Object[]> objectsList,	Map<Long, ReportSummary2> reportSummary2Map) {
		int counter = 0;
		
		int totalLots = 0;
		int totalLotsQuantity = 0;
		Long categoryId = null;
		
		
		ReportSummary2 reportSummary2Prev = new ReportSummary2();
		for (Object[] objects : objectsList) {
			
			BidItem bidItem = (BidItem)objects[0];
			if(counter == 0){
				categoryId = bidItem.getCategory().getCategoryId();
				reportSummary2Prev.setCategoryId(categoryId);
				reportSummary2Prev.setCategoryName(bidItem.getCategory().getCategoryName());
				reportSummary2Prev.setTotalLotsForSale(++totalLots);
				totalLotsQuantity += bidItem.getTotalQuantity();
				reportSummary2Prev.setTotalLotsquantityForSale(totalLotsQuantity);
			}
			
			if(counter != 0 && categoryId.equals(bidItem.getCategory().getCategoryId())){
				
				reportSummary2Prev.setTotalLotsForSale(++totalLots);
				totalLotsQuantity += bidItem.getTotalQuantity();
				reportSummary2Prev.setTotalLotsquantityForSale(totalLotsQuantity);
				
			}else if(!categoryId.equals(bidItem.getCategory().getCategoryId())){
				
				reportSummary2Map.put(categoryId, reportSummary2Prev);
				categoryId = bidItem.getCategory().getCategoryId();
				reportSummary2Prev = new ReportSummary2();
				totalLots = 0 ;
				totalLotsQuantity = 0;
				
				reportSummary2Prev.setCategoryId(categoryId);
				reportSummary2Prev.setCategoryName(bidItem.getCategory().getCategoryName());
				reportSummary2Prev.setTotalLotsForSale(++totalLots);
				totalLotsQuantity += bidItem.getTotalQuantity();
				reportSummary2Prev.setTotalLotsquantityForSale(totalLotsQuantity);
				
			}
			counter++;
			if(counter == objectsList.size()){
				logger.debug("Objects list max size" + objectsList.size());
				reportSummary2Map.put(categoryId, reportSummary2Prev);				
			}
		
		}
	}
	/**
	 * Method to get Actual Sales Data for Summary2
	 * @param objectsList
	 * @param reportSummary2Map
	 */
	private void getActualSalesDataSummary2(List<Object[]> objectsList, Map<Long, ReportSummary2> reportSummary2Map) {
		int counter = 0;
		
		int totalLots = 0;
		int totalLotsQuantity = 0;
		Double totalActualSoldAmount = 0.0;
		
		Long categoryId = null;
		
		
		ReportSummary2 reportSummary2Prev = null;
		
		for (Object[] objects : objectsList) {
			
			BidItem bidItem = (BidItem)objects[0];
			String lotsStatus = bidItem.getIsProcessed();
			if(counter == 0){
				categoryId = bidItem.getCategory().getCategoryId();
				if(reportSummary2Map.containsKey(categoryId)){
					reportSummary2Prev = reportSummary2Map.get(categoryId);
				}else{
					reportSummary2Prev = new ReportSummary2();
				}
				
				if(lotsStatus != null && (lotsStatus.equals(BiddingConstants.H1) || lotsStatus.equals(BiddingConstants.H2) || lotsStatus.equals(BiddingConstants.H3))){
					reportSummary2Prev.setCategoryId(categoryId);
					reportSummary2Prev.setTotalActualSoldLots(++totalLots);
					
					totalLotsQuantity += bidItem.getTotalQuantity();					
					reportSummary2Prev.setTotalActualSoldQunatity(totalLotsQuantity);
					
					totalActualSoldAmount += bidItem.getCurrentMarketPrice();
					reportSummary2Prev.setTotalActualSoldAmount(totalActualSoldAmount);
				}
			}
			if(counter != 0 && categoryId.equals(bidItem.getCategory().getCategoryId())){
				if(reportSummary2Prev == null){
					if(reportSummary2Map.containsKey(categoryId)){
						reportSummary2Prev = reportSummary2Map.get(categoryId);
					}else{
						reportSummary2Prev = new ReportSummary2();
					}					
				}
				if(lotsStatus != null && (lotsStatus.equals(BiddingConstants.H1) || lotsStatus.equals(BiddingConstants.H2) || lotsStatus.equals(BiddingConstants.H3))){	
					reportSummary2Prev.setCategoryId(categoryId);
					reportSummary2Prev.setTotalActualSoldLots(++totalLots);
					
					totalLotsQuantity += bidItem.getTotalQuantity();
					reportSummary2Prev.setTotalActualSoldQunatity(totalLotsQuantity);
					
					totalActualSoldAmount += bidItem.getCurrentMarketPrice();
					reportSummary2Prev.setTotalActualSoldAmount(totalActualSoldAmount);
				}
				
			}else if(!categoryId.equals(bidItem.getCategory().getCategoryId())){

				if(reportSummary2Prev != null && reportSummary2Prev.getCategoryId() != null){
					double actAmt = 0.0 ;
					int actQuan = 0 ;
					if(reportSummary2Prev.getTotalActualSoldAmount() != null && reportSummary2Prev.getTotalActualSoldQunatity() != null){
						actAmt = reportSummary2Prev.getTotalActualSoldAmount();
						actQuan = reportSummary2Prev.getTotalActualSoldQunatity();
						if(actAmt != 0.0 && actQuan != 0){
							Double avg = (Double)actAmt/actQuan;
							reportSummary2Prev.setAvergeAmount(avg);
						}
					}
					reportSummary2Map.put(categoryId, reportSummary2Prev);
					totalLots = 0 ;
					totalLotsQuantity = 0;
					totalActualSoldAmount = 0.0;
				}
				categoryId = bidItem.getCategory().getCategoryId();
				if(reportSummary2Map.containsKey(categoryId)){
					reportSummary2Prev = reportSummary2Map.get(categoryId);
				}else{
					reportSummary2Prev = new ReportSummary2();
				}
				if(lotsStatus != null && (lotsStatus.equals(BiddingConstants.H1) || lotsStatus.equals(BiddingConstants.H2) || lotsStatus.equals(BiddingConstants.H3))){
				
					reportSummary2Prev.setCategoryId(categoryId);
					reportSummary2Prev.setTotalActualSoldLots(++totalLots);
					
					totalLotsQuantity += bidItem.getTotalQuantity();
					reportSummary2Prev.setTotalActualSoldQunatity(totalLotsQuantity);
					
					totalActualSoldAmount += bidItem.getCurrentMarketPrice();
					reportSummary2Prev.setTotalActualSoldAmount(totalActualSoldAmount);
				}
				
			}
			counter++;
			if(counter == objectsList.size()){
				logger.debug("Objects list max size" + objectsList.size());
				if(reportSummary2Prev != null && reportSummary2Prev.getCategoryId() != null){
					
					double actAmt = 0.0 ;
					int actQuan = 0 ;
					if(reportSummary2Prev.getTotalActualSoldAmount() != null && reportSummary2Prev.getTotalActualSoldQunatity() != null){
						actAmt = reportSummary2Prev.getTotalActualSoldAmount();
						actQuan = reportSummary2Prev.getTotalActualSoldQunatity();
						if(actAmt != 0.0 && actQuan != 0){
							Double avg = (Double)actAmt/actQuan;
							reportSummary2Prev.setAvergeAmount(avg);
						}
					}
					
					reportSummary2Map.put(categoryId, reportSummary2Prev);				
				}
			}
		
		}
	}

}
