package com.navprayas.bidding.observer.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.common.bean.EmailTemplate;
import com.navprayas.bidding.common.constant.BiddingConstants;
import com.navprayas.bidding.common.dto.CommonVO;
import com.navprayas.bidding.common.dto.ObserverVO;
import com.navprayas.bidding.common.email.EmailSender;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.common.form.CloseBids;
import com.navprayas.bidding.common.form.Users;

@Repository("observerRepository")
public class ObserverDaoImpl implements IObserverDao{

	Logger logger = LoggerFactory.getLogger(ObserverDaoImpl.class);
	
	@Autowired
	private SessionFactory sessionFactory;
	
	@Autowired
	private EmailSender observerEmailSender;
	
	public BidItem getBidItem(long bidItemId) {
		logger.debug("In getBidItemById Method in DAO::");
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem where bidItem.bidItemId=:bidItemId");
		query.setParameter("bidItemId", bidItemId);
		BidItem bidItem = (BidItem)query.uniqueResult();
		logger.debug("In getBidItemById Method in DAO::"+bidItem);
		return bidItem;
	}

	public List<BidItem> getBidItems(String userName) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidderCateg.bidderCategoryId.user.username = :userName ");
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		logger.debug("bidItemList.size()::::"+ objectsList.size());
			for (Object[] objects : objectsList) {
				BidItem bidItem = (BidItem)objects[0];
				BidderCategory bidderCategory = (BidderCategory)objects[1];
				bidItemsList.add(bidItem);
				
				System.out.print(" objects ");		
				logger.debug("BidItem::"+bidItem);
				logger.debug("BidderCategory::"+bidderCategory);
			
			}
		return bidItemsList;
	
	}

	public List<BidItem> getBidItemsForCategoryForActiveMarketForObserver(
			String userName) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and bidItem.bidStartTime < :bidStartTime and bidItem.bidEndTime > :currentTime  and bidderCateg.bidderCategoryId.user.username = :userName ");
		query.setParameter("bidStartTime", new Date());
		query.setParameter("currentTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		logger.debug("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			bidItemsList.add(bidItem);
		
		}
		return bidItemsList;
	}

	public List<BidItem> getBidItemsForCategoryForActiveMarketForObserver(
			long categoryId, String userName) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = :categoryId  and bidderCateg.bidderCategoryId.category.categoryId = :categoryId and bidItem.bidStartTime < :bidStartTime and bidItem.bidEndTime > :currentTime  and bidderCateg.bidderCategoryId.user.username = :userName ");
		query.setParameter("categoryId", categoryId);
		query.setParameter("bidStartTime", new Date());
		query.setParameter("currentTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		logger.debug("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			bidItemsList.add(bidItem);
		
		}
		logger.debug("bidItemList.size() after::::"+ objectsList.size());
		return bidItemsList;
	}

	public List<Bids> getBidItemsForCategoryForClosedMarketForObserver(CommonVO commonVO)  {
		
		Long sequenceId = commonVO.getSequenceId();
		String userName = commonVO.getUserName();
		
		int firstResult = commonVO.getFirstResult();
		int lastResult = commonVO.getFirstResult() + commonVO.getMaxResult();
		
		if(lastResult >= sequenceId) {
			lastResult = sequenceId.intValue() - 1;
		}
		
		String queryString = " SELECT bids1.bidId, bids1.bidItem, bids1.bidderName, bids1.currency, " +
		  " bids1.bidTime, bids1.bidStatus, bids1.comments, MAX(bids1.bidAmount),bidSeq.sequenceId, bidItem1.bidItemId FROM Bids AS bids1 right outer join bids1.bidItem  AS bidItem1, BidderCategory AS "+ 
		  " bidderCategory , BidSequence bidSeq WHERE bidderCategory.bidderCategoryId.user.username = :userName AND bidItem1.category.categoryId = bidderCategory.bidderCategoryId.category.categoryId AND " +
		  " bidderCategory.auction.auctionId = :auctionId and bidSeq.auction.auctionId = :auctionId " +
		  " and bidSeq.bidItem.bidItemId = bidItem1.bidItemId ";		 
		
		queryString += " and ( bidSeq.sequenceId between :firstResult and :lastResult )";
		
		queryString += " GROUP BY bids1.bidderName,bids1.bidItem.bidItemId, bidItem1.bidItemId ORDER BY bidSeq.sequenceId , bids1.bidItem.bidItemId, MAX(bids1.bidAmount) DESC ";
		
		Query query = sessionFactory.getCurrentSession().createQuery(queryString);
		query.setParameter("auctionId", commonVO.getAuctionId());
		
		query.setParameter("firstResult", new Long(firstResult + 1));
		query.setParameter("lastResult", new Long(lastResult));
		
		query.setParameter("userName", userName);
		
		List<Object[]> objectsList = query.list();
		return getBidsListForClosedMarket(objectsList);
	}

	
	public List<Bids> getBidItemsForCategoryForClosedMarketForObserver(long categoryId, CommonVO commonVO) {
		
		Long sequenceId = commonVO.getSequenceId();
		String userName = commonVO.getUserName();
		
		if (sequenceId == null || sequenceId <= 0) {
			return new ArrayList<Bids>();
		}
		
		int firstResult = commonVO.getFirstResult();
		int lastResult = commonVO.getFirstResult() + commonVO.getMaxResult();
		
		if(lastResult >= sequenceId) {
			lastResult = sequenceId.intValue() - 1;
		}		
		
		String queryString = " SELECT bids1.bidId, bids1.bidItem, bids1.bidderName, bids1.currency, " +
		  " bids1.bidTime, bids1.bidStatus, bids1.comments, MAX(bids1.bidAmount),bidSeq.sequenceId, bidItem1.bidItemId FROM Bids AS bids1 right outer join " +
		  "bids1.bidItem  AS bidItem1, BidderCategory AS bidderCategory , BidSequence bidSeq WHERE bidderCategory.bidderCategoryId.user.username = :userName AND " +
		  "bidItem1.category.categoryId = bidderCategory.bidderCategoryId.category.categoryId AND " +
		  " bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem1.bidItemId " +
		  " and  bidderCategory.auction.auctionId = :auctionId " +
		  " and bidderCategory.bidderCategoryId.category.categoryId = :categoryId ";
		
		queryString += " and ( bidSeq.sequenceId between :firstResult and :lastResult )";
		
		queryString += " GROUP BY bids1.bidderName,bids1.bidItem.bidItemId, bidItem1.bidItemId ORDER BY bidSeq.sequenceId , bids1.bidItem.bidItemId, MAX(bids1.bidAmount) DESC ";
		
		Query query = sessionFactory.getCurrentSession().createQuery(queryString);
				
		query.setParameter("categoryId", categoryId);
		query.setParameter("auctionId", commonVO.getAuctionId());
		
		query.setParameter("firstResult", new Long(firstResult + 1));
		query.setParameter("lastResult", new Long(lastResult));
		
		query.setParameter("userName", userName);
		
		List<Object[]> objectsList = query.list();
		return getBidsListForClosedMarket(objectsList);
	}

	public List<BidItem> getBidItemsForCategoryForMarketListForObserver(
			String userName) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and bidItem.bidStartTime > :bidStartTime and bidderCateg.bidderCategoryId.user.username = :userName ");
		query.setParameter("bidStartTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		logger.debug("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];			
			bidItemsList.add(bidItem);
		
		}
		return bidItemsList;
	}

	public List<BidItem> getBidItemsForCategoryForMarketListForObserver(
			long categoryId, String userName) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = :categoryId  and bidderCateg.bidderCategoryId.category.categoryId = :categoryId  and bidItem.bidStartTime > :bidStartTime and bidderCateg.bidderCategoryId.user.username = :userName ");
		query.setParameter("categoryId", categoryId);
		query.setParameter("bidStartTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		logger.debug("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			bidItemsList.add(bidItem);
		
		}
		return bidItemsList;
	}

	public Set<Long> getBidItemsIDListForActiveMarket(String userName) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and bidItem.bidStartTime < :bidStartTime and bidItem.bidEndTime > :currentTime  and bidderCateg.bidderCategoryId.user.username = :userName ");
		query.setParameter("bidStartTime", new Date());
		query.setParameter("currentTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		Set<Long> categoryIDList = new HashSet<Long>();
		logger.debug("categoryList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem  = (BidItem)objects[0];
			Category category = bidItem.getCategory();			
			categoryIDList.add(category.getCategoryId());
		
		}
		logger.debug("categoryIDList ::"+categoryIDList);
		return categoryIDList;
	}

	public boolean getH1Approved(ObserverVO observerVO, String userName) {
		
		boolean success = true;
		BidItem bidItem = getBidItem(observerVO.getBidItemId());
		bidItem.setIsProcessed(observerVO.getBidStatus());
		bidItem.setBidderName(observerVO.getBidderName());
		
		if(!BiddingConstants.REJECTED.equals(observerVO.getBidStatus())){
			CloseBids closeBids = new CloseBids();
			
			closeBids.setBidStatus(observerVO.getBidStatus());
			closeBids.setBidAmount(observerVO.getBidAmount());
			
			closeBids.setBidItem(bidItem);
			closeBids.setObserverName(userName);
			closeBids.setBidderName(observerVO.getBidderName());		
			//closeBids.setCloseBidId((System.currentTimeMillis())%1000000);
			try{
				sessionFactory.getCurrentSession().save(closeBids);
				sessionFactory.getCurrentSession().flush();				
				sessionFactory.getCurrentSession().saveOrUpdate(bidItem);
				
				logger.debug("Sending mail to Approved bidder.");
				sendMailToApprovedBidder(observerVO, userName);
			}catch(Exception ex){
				logger.debug("Exception in getH1Approved Method::"+ex.getMessage());
				success = false;
			}
			
		}else if(BiddingConstants.REJECTED.equals(observerVO.getBidStatus())){
			sessionFactory.getCurrentSession().saveOrUpdate(bidItem);
		}
		return success;
	}

	private void sendMailToApprovedBidder(ObserverVO observerVO, String userName) {		
		try {
			EmailTemplate emailTemplate = new EmailTemplate();
			emailTemplate.setBidAmount(observerVO.getBidAmount()+"");
			Criteria criteria = sessionFactory.getCurrentSession().createCriteria(Users.class);
			criteria.add(Restrictions.eq("username", observerVO.getBidderName()));
			Users user = (Users)criteria.uniqueResult();
			emailTemplate.setTo(user.getEmail());
			emailTemplate.setFirstName(user.getUserDetails().getFirstName());
			if(user.getUserDetails().getLastName()!=null)
				emailTemplate.setLastName(user.getUserDetails().getLastName());
			else 
				emailTemplate.setLastName("");
			emailTemplate.setCc("helpdesk@navprayas.com");
			BidItem bidItem = (BidItem)sessionFactory.getCurrentSession().get(BidItem.class, observerVO.getBidItemId());
			emailTemplate.setSubject("Bid Winning Confirmation:: " + bidItem.getSerialNo());
			emailTemplate.setBidSerialNumber(bidItem.getSerialNo() + "");
			logger.debug("Email Template created :: " + emailTemplate);
			observerEmailSender.sendEmail(emailTemplate);
		} catch (Exception e) {
			logger.error("Email not sent ", e);
		}
		
		
	}

	private List<Bids> getBidsListForClosedMarket(List<Object[]> objectsList) {
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		List<Bids> bidsListO = new ArrayList<Bids>();
		List<Bids> bidsList = new ArrayList<Bids>();
		
		for (Object[] objects : objectsList) {
			
			Bids bids = new Bids();
			bids.setBidId(objects[0]== null ? null: ((Long)objects[0]).longValue());
			bids.setBidItem((BidItem)objects[1]);
			bids.setBidItem((BidItem)objects[1]);
			if(objects[1]==null) {
				bids.setBidItem((BidItem)getBidItem(((Long)objects[9]).longValue()));
			}
			bids.setBidderName((objects[2])==null?null:((String)(objects[2])).trim());
			bids.setCurrency((objects[3])==null?null:((String)(objects[3])).trim());
			bids.setBidTime((Date)objects[4]);
			bids.setBidStatus((objects[5])==null?null:((String)(objects[5])).trim());
			bids.setComments((objects[6])==null?null:((String)(objects[6])).trim());;
			bids.setBidAmount(objects[7]== null ? null: ((Double)objects[7]).doubleValue());
			
			BidItem bidItem = bids.getBidItem();
			bidItem.setSeqId(objects[8]== null ? null: ((Long)objects[8]).longValue());
			bids.setBidItem(bidItem);
			
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
			logger.debug("Bids::"+bids);	
		}
		logger.debug("Size of Bids List::"+bidsList.size());
		return bidsList;
	}

	
}