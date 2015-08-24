package com.navprayas.bidding.observer.reports.dao;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TimeZone;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.common.constant.BiddingConstants;
import com.navprayas.bidding.common.dto.ReportVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.common.form.CloseBids;
import com.navprayas.bidding.common.form.LotsStatus;
import com.navprayas.bidding.utility.RedisCacheService;


@Repository("reportRepository")
public class ReportDaoImpl implements IReportDao{
	
	Logger logger = LoggerFactory.getLogger(ReportDaoImpl.class);
	@Autowired
	private SessionFactory sessionFactory;
	
	public BidItem getBidItem(long bidItemId) {
		logger.debug("In getBidItemById Method in DAO::");
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem where bidItem.bidItemId=:bidItemId");
		query.setParameter("bidItemId", bidItemId);
		BidItem bidItem = (BidItem)query.uniqueResult();
		logger.debug("In getBidItemById Method in DAO::"+bidItem);
		return bidItem;
	}
	
	public List<Bids> getReportSummary1(String userName, ReportVO reportVO) {
		logger.debug("In getReportSummary1 Method in Report DAO::");
		
		Query query = sessionFactory.getCurrentSession().createQuery("SELECT bids1.bidId, bids1.bidItem, bids1.bidderName, bids1.currency, " +
		    " bids1.bidTime, bids1.bidStatus, bids1.comments, MAX(bids1.bidAmount) , bidItem1.bidItemId FROM Bids AS bids1 right outer join bids1.bidItem AS bidItem1, BidderCategory AS "+ 
			" bidderCategory WHERE bidderCategory.bidderCategoryId.user.username = :userName AND bidItem1.category.categoryId = bidderCategory.bidderCategoryId.category.categoryId " +
			" AND bidItem1.bidEndTime > :bidtime1 and bidItem1.bidEndTime <= :bidtime2 GROUP BY bids1.bidderName," +
			"bids1.bidItem.bidItemId, bidItem1.bidItemId ORDER BY bids1.bidItem.bidItemId,MAX(bids1.bidAmount) DESC");

	    Date bidtime1 = getReportStartTime(reportVO);
		Date bidtime2 = getReportEndTime(reportVO);
				
		query.setParameter("userName", userName);
		query.setParameter("bidtime2", bidtime2);
		query.setParameter("bidtime1", bidtime1);
		
		List<Object[]> objectsList = query.list();
		
		List<Bids> bidsList = new ArrayList<Bids>();
		processSummary1ReportList(objectsList, bidsList);
		getBidsSalesPrice(bidsList);
		
		logger.debug("Size of Bids List::"+bidsList.size());
		return bidsList;
	}
	private Date getReportStartTime(ReportVO reportVO) {
		
		String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
	    sdf.setTimeZone(TimeZone.getDefault());
		
	    Date bidtime1 = null;
		String bidTimeStr1 = null;
		
		if(reportVO == null){
			logger.debug("Report VO is null");
		    Calendar cal = Calendar.getInstance(TimeZone.getDefault());	    
		    cal.set(Calendar.HOUR_OF_DAY, 0);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			 
			bidTimeStr1 = sdf.format(cal.getTime());
			
		} else {
			logger.debug("Report VO ::"+reportVO);
			bidTimeStr1 = sdf.format(reportVO.getDateFrom());
		}
		
		try{				
			bidtime1 = sdf.parse(bidTimeStr1);
			
		}catch (Exception e) {
			logger.debug("Exception while parsing date::");
		}
		logger.debug("Date1::"+bidtime1);
		return bidtime1;
	}

	private Date getReportEndTime(ReportVO reportVO) {
		
		String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
	    sdf.setTimeZone(TimeZone.getDefault());
		    
	    Date bidtime2 = null;
		String bidTimeStr2 = null;
		
		if(reportVO == null){
			logger.debug("Report VO is null");
		    Calendar cal = Calendar.getInstance(TimeZone.getDefault());
			
			cal.set(Calendar.HOUR_OF_DAY, 23);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 59);
			bidTimeStr2 = sdf.format(cal.getTime());	
			
		} else {
			logger.debug("Report VO ::"+reportVO);
			bidTimeStr2 = sdf.format(reportVO.getDateTo());	
		}
		
		try{
			bidtime2 = sdf.parse(bidTimeStr2);
			
		}catch (Exception e) {
			logger.debug("Exception while parsing date::");
		}
		logger.debug("Date2::"+ bidtime2);
		return bidtime2;
	}

	private void getBidsSalesPrice(List<Bids> bidsList) {
		for(Bids bid : bidsList){
			String lotsStatus = bid.getBidItem().getIsProcessed();
			if(lotsStatus != null )
			{
				Integer totalQuantity = bid.getBidItem().getTotalQuantity();
				if(BiddingConstants.H1.equalsIgnoreCase(lotsStatus)){
					bid.setSalesPrice(bid.getBidAmount());
					
					if(totalQuantity != null && bid.getBidAmount() != null){
						Double totalSalesPrice = totalQuantity*bid.getBidAmount();
						bid.setTotalSalesPrice(totalSalesPrice);
					}
				}else if(BiddingConstants.H2.equalsIgnoreCase(lotsStatus)){
					bid.setSalesPrice(bid.getBidAmount2());
					
					if(totalQuantity != null && bid.getBidAmount2() != null){
						Double totalSalesPrice = totalQuantity*bid.getBidAmount2();
						bid.setTotalSalesPrice(totalSalesPrice);
					}
					
				}else if(BiddingConstants.H3.equalsIgnoreCase(lotsStatus)){
					bid.setSalesPrice(bid.getBidAmount3());
					
					if(totalQuantity != null && bid.getBidAmount3() != null){
						Double totalSalesPrice = totalQuantity*bid.getBidAmount3();
						bid.setTotalSalesPrice(totalSalesPrice);
					}
				}else if(BiddingConstants.REJECTED.equalsIgnoreCase(lotsStatus) || BiddingConstants.HOLD.equalsIgnoreCase(lotsStatus)){
					bid.setSalesPrice(bid.getBidAmount());
				}
			}
		}
	}
	
	public List<Bids> getBidsForCategoryObserverReportSummary1(ReportVO reportVO, String userName){
		logger.debug("In getReportSummary1 Method in Report DAO::");
				
		Query query = sessionFactory.getCurrentSession().createQuery("SELECT bids1.bidId, bids1.bidItem, bids1.bidderName, bids1.currency, " +
			    " bids1.bidTime, bids1.bidStatus, bids1.comments, MAX(bids1.bidAmount) , bidItem1.bidItemId FROM Bids AS bids1 right outer join bids1.bidItem AS bidItem1, BidderCategory AS "+ 
				" bidderCategory WHERE bidderCategory.bidderCategoryId.user.username = :userName AND bidItem1.category.categoryId = bidderCategory.bidderCategoryId.category.categoryId " +
				" AND bidderCategory.bidderCategoryId.category.categoryId = :categoryId AND bidItem1.bidEndTime > :bidtime1 and bidItem1.bidEndTime <= :bidtime2 GROUP BY bids1.bidderName," +
				"bids1.bidItem.bidItemId, bidItem1.bidItemId ORDER BY bids1.bidItem.bidItemId,MAX(bids1.bidAmount) DESC");
				
		String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	    SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
	    sdf.setTimeZone(TimeZone.getDefault());
		
	    Date bidtime1 = getReportStartTime(reportVO);
		Date bidtime2 = getReportEndTime(reportVO);
	    
	    query.setParameter("userName", userName);
		query.setParameter("bidtime2", bidtime2);
		query.setParameter("bidtime1", bidtime1);
		query.setParameter("categoryId", reportVO.getCategoryId());
		
		List<Object[]> objectsList = query.list();
		
		List<Bids> bidsList = new ArrayList<Bids>();
		
		processSummary1ReportList(objectsList, bidsList);
		getBidsSalesPrice(bidsList);
		logger.debug("Size of Bids List::"+bidsList.size());
		return bidsList;
	}

	private void processSummary1ReportList(List<Object[]> objectsList,List<Bids> bidsList) {
		List<Bids> bidsListO = new ArrayList<Bids>();
		Long activeId = RedisCacheService.getActiveBidItemId();
		for (Object[] objects : objectsList) {
			
			Bids bids = new Bids();
			bids.setBidId(objects[0]== null ? null: ((Long)objects[0]).longValue());
			bids.setBidItem((BidItem)objects[1]);
			if(objects[1]==null) {
				bids.setBidItem((BidItem)getBidItem(((Long)objects[8]).longValue()));
			}
			if(bids.getBidItem() != null && activeId !=null && bids.getBidItem().getBidItemId().equals(activeId)) continue;
			bids.setBidderName((objects[2])==null?null:((String)(objects[2])).trim());
			bids.setCurrency((objects[3])==null?null:((String)(objects[3])).trim());
			bids.setBidTime((Date)objects[4]);
			bids.setBidStatus((objects[5])==null?null:((String)(objects[5])).trim());
			bids.setComments((objects[6])==null?null:((String)(objects[6])).trim());;
			bids.setBidAmount(objects[7]== null ? null: ((Double)objects[7]).doubleValue());
			
			bidsListO.add(bids);
		}
		
		Long bidItemID = null;
		int i = 0;
		int j = 0 ;
		Bids bidPrevObj = null;
		int recordCounter = 0;
		for (Bids bids : bidsListO) {
			recordCounter ++;
			
			if(i == 0){
				bidItemID = bids.getBidItem().getBidItemId();
				bidPrevObj = bids;				
			}
			
			if( i != 0 && bidItemID.equals(bids.getBidItem().getBidItemId())){
				logger.debug("Bid Item Id equal::" + bidItemID);
				if(j == 0){
					bidPrevObj.setBidAmount2(bids.getBidAmount());
					bidPrevObj.setBidderName2(bids.getBidderName());
				}else if( j == 1 ){
					bidPrevObj.setBidAmount3(bids.getBidAmount());
					bidPrevObj.setBidderName3(bids.getBidderName());
				}
				j++;
			}else if(!bidItemID.equals(bids.getBidItem().getBidItemId())) {
				
				logger.debug("Bid Item Id  not equal::" + bidItemID);
				bidsList.add(bidPrevObj);
				j = 0;
				bidItemID = bids.getBidItem().getBidItemId();
				bidPrevObj = bids;	
				
			}
			i++;
			if(recordCounter == objectsList.size()){
				logger.debug("Bid list max size" + bidItemID);
				bidsList.add(bidPrevObj);				
			}
			logger.debug("Bids::"+bids);		
		}
	}
	public List<BidItem> getBidsForLotsObserverReportSummary1(long lotid,String userName) {
		// TODO Auto-generated method stub
		return null;
	}
	public Set<String> getLotsList(String userName) {		
		Query query = sessionFactory.getCurrentSession().createQuery("from LotsStatus ");
		List<LotsStatus> lotsStatusList = query.list();
		Set<String> bidsStatusSet = new HashSet<String>();
		for (LotsStatus lotsStatus: lotsStatusList) {
			String bidStatus = lotsStatus.getLotStatus()+"";
			bidsStatusSet.add(bidStatus);
		}
		return bidsStatusSet;
	}
	public List<Bids> getBidsForLotsObserverReportSummary1(ReportVO reportVO,String userName) {
		logger.debug("In getBidsForLotsObserverReportSummary1 Method in Report DAO::");
		
		String queryStr = "SELECT bids1.bidId, bids1.bidItem, bids1.bidderName, bids1.currency, " +
			    " bids1.bidTime, bids1.bidStatus, bids1.comments, MAX(bids1.bidAmount) FROM Bids AS bids1 , BidItem  AS bidItem1, BidderCategory AS "+ 
				" bidderCategory WHERE bidderCategory.bidderCategoryId.user.username = :userName AND bidItem1.category.categoryId = bidderCategory.bidderCategoryId.category.categoryId " +
				"AND bidItem1.bidItemId = bids1.bidItem.bidItemId AND bids1.bidTime > :bidtime1 and bids1.bidTime < :bidtime2 ";		
		
		String lotsStatus = reportVO.getLotsStatus();
		if(reportVO != null && lotsStatus != null && !"".equals(lotsStatus)){
			queryStr = queryStr + " and bidItem1.isProcessed = :lotsStatus ";
		}
		
		queryStr = queryStr +	"GROUP BY bids1.bidderName, bids1.bidItem.bidItemId ORDER BY bids1.bidItem.bidItemId,MAX(bids1.bidAmount) DESC";
		
		Query query = sessionFactory.getCurrentSession().createQuery(queryStr);

		Date bidtime1 = getReportStartTime(reportVO);
		Date bidtime2 = getReportEndTime(reportVO);
		
		
		query.setParameter("userName", userName);
		query.setParameter("bidtime2", bidtime2);
		query.setParameter("bidtime1", bidtime1);
		if(reportVO != null && lotsStatus != null && !"".equals(lotsStatus) && !"0".equals(lotsStatus)){
			query.setParameter("lotsStatus", lotsStatus);
		}
		
		List<Object[]> objectsList = query.list();
		List<Bids> bidsList = new ArrayList<Bids>();
		
		processSummary1ReportList(objectsList, bidsList);
		
		/*
		logger.debug("Going to process Bid List for Lots Status:");
		List<Bids> finalLotsBidList = new ArrayList<Bids>();
		
		if(reportVO != null && lotsStatus != null && !"".equals(lotsStatus)){				
			for(Bids bid: bidsList){
				String isProcessed = bid.getBidItem().getIsProcessed();
				if(isProcessed != null && lotsStatus.equals(isProcessed)){
					finalLotsBidList.add(bid);
				}
			}
			getBidsSalesPrice(finalLotsBidList);
			return finalLotsBidList;
		}*/
		getBidsSalesPrice(bidsList);
		logger.debug("Size of Bids List::"+bidsList.size());
		return bidsList;
	}
	
	
	
}
