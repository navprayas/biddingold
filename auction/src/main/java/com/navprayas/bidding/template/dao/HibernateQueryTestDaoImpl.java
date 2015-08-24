package com.navprayas.bidding.template.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.cfg.AnnotationConfiguration;

import com.navprayas.bidding.common.bean.BiddingHistoryBean;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.BiddingDetailsForm;
import com.navprayas.bidding.common.form.Bids;

public class HibernateQueryTestDaoImpl {

	private static Session session = null;
	static {
		session = new AnnotationConfiguration().configure().buildSessionFactory().openSession();
	}
	
	
	public static List<BiddingHistoryBean>  getBiddingHistoryForObserver(BiddingDetailsForm biddingDetailsForm )
	{
		
		String queryString1 = " FROM Bids AS bids WHERE bids.bidItem.bidItemId = :bidItemId ORDER BY bids.bidTime desc";
		
		Query query = session.createQuery(queryString1);
		
		Long bidItemId = biddingDetailsForm.getBidItemId();
		query.setParameter("bidItemId", bidItemId);
		
		List<Bids> bidsList = query.list();
		
		List<BiddingHistoryBean> biddingHistoryBeanList = new ArrayList<BiddingHistoryBean>();
		for (Bids bids : bidsList) {
			BiddingHistoryBean biddingHistoryBean = new BiddingHistoryBean();
			
			biddingHistoryBean.setBidAmount(bids.getBidAmount());
			biddingHistoryBean.setBidDateAndTime(bids.getBidTime());
			biddingHistoryBean.setBiddingCompany(bids.getBidItem().getBidderName());
			if(bids.getBidType() != null){
				biddingHistoryBean.setBidType(bids.getBidType());
			}
			biddingHistoryBeanList.add(biddingHistoryBean);
		}

		return biddingHistoryBeanList;
	}
	
	public static void main(String args[])
	{
		try{
			
			//This step will read hibernate.cfg.xml and prepare hibernate for use
			//Create new instance of Contact and set 
			//values in it by reading them from form object
			Transaction tx = session.beginTransaction();
			BiddingDetailsForm b = new BiddingDetailsForm();
			b.setBidItemId((long)165);
			getBiddingHistoryForObserver(b);
/*			getBidItems("bidder");
			getBidItemsAll();
			
			//For observer for all categories (in default case)
			getBidItemsForCategoryForMarketList();
			getBidItemsForCategoryForActiveMarket();
			getBidItemsForCategoryForClosedMarket();
			
			//For observer with category id
			getBidItemsForCategoryForMarketList(1);
			getBidItemsForCategoryForActiveMarket(1);
			getBidItemsForCategoryForClosedMarket(1);
			
			//For bidder for all categories (in default case)
			getBidItemsForCategoryForMarketListForBidder("bidder");
			getBidItemsForCategoryForActiveMarketForBidder("bidder");
			getBidItemsForCategoryForClosedMarketForBidder("bidder");
			
			//For bidder with category id
			getBidItemsForCategoryForMarketListForBidder(1, "bidder");
			getBidItemsForCategoryForActiveMarketForBidder(1, "bidder");
			getBidItemsForCategoryForClosedMarketForBidder(1, "bidder");*/	
			
			getBidItemsForCategoryForClosedMarketForObserver(2, "vikas", 194, 0);
			tx.commit();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			// Actual contact insertion will happen at this step
			if(session != null && session.isOpen())
			{
				session.flush();
				session.close();
			}

		}

	}
	
	public static List<Bids> getBidItemsForCategoryForClosedMarketForObserver(
			long categoryId, String userName, long auctionId, long sequenceId) {
		String queryString = " SELECT bids1.bidId, bids1.bidItem, bids1.bidderName, bids1.currency, " +
		  " bids1.bidTime, bids1.bidStatus, bids1.comments, MAX(bids1.bidAmount),bidSeq.sequenceId, bidItem1.bidItemId FROM Bids AS bids1 right outer join bids1.bidItem  AS bidItem1, BidderCategory AS "+ 
		  " bidderCategory , BidSequence bidSeq WHERE bidderCategory.username.loginName = :userName AND bidItem1.category.categoryId = bidderCategory.category.categoryId AND " +
		  " bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem1.bidItemId " +
		  " and bidderCategory.category.categoryId = :categoryId ";
		 
		
		if(sequenceId != 0){
			queryString += " and bidSeq.sequenceId < :sequenceId ";
		}	
		
			queryString += " GROUP BY bids1.bidderName,bids1.bidItem.bidItemId ORDER BY bidSeq.sequenceId , bids1.bidItem.bidItemId, MAX(bids1.bidAmount) DESC ";
		
		Query query = session.createQuery(queryString);
		
		
		query.setParameter("categoryId", categoryId);
		query.setParameter("auctionId", auctionId);
		if(sequenceId != 0L)
			query.setParameter("sequenceId", sequenceId);
		query.setParameter("userName", userName);
		
		List<Object[]> objectsList = query.list();
		
		return getBidsListForClosedMarket(objectsList);
	}
	
	
	public static BidItem getBidItem(long bidItemId) {
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.bidItemId=:bidItemId");
		query.setParameter("bidItemId", bidItemId);
		BidItem bidItem = (BidItem)query.uniqueResult();
		return bidItem;
	}	
	private static List<Bids> getBidsListForClosedMarket(List<Object[]> objectsList) {
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		List<Bids> bidsListO = new ArrayList<Bids>();
		List<Bids> bidsList = new ArrayList<Bids>();
		
		for (Object[] objects : objectsList) {
			
			Bids bids = new Bids();
			bids.setBidId(objects[0]== null ? null: ((Long)objects[0]).longValue());
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
				if(j == 0){
					bidPrevObj.setBidAmount2(bids.getBidAmount());
					bidPrevObj.setBidderName2(bids.getBidderName());
				}else if( j == 1 ){
					bidPrevObj.setBidAmount3(bids.getBidAmount());
					bidPrevObj.setBidderName3(bids.getBidderName());
				}
				j++;
			}else if(!bidItemID.equals(bids.getBidItem().getBidItemId())) {
				
				bidsList.add(bidPrevObj);
				j = 0;
				bidItemID = bids.getBidItem().getBidItemId();
				bidPrevObj = bids;	
				
			}
			i++;
			if(recordCounter == objectsList.size()){
				bidsList.add(bidPrevObj);				
			}
		}
		return bidsList;
	}
	
	
	public static List<BidItem> getBidItems(String userName) {
		 
		Query query = session.createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidderCateg.username.loginName = :userName ");
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		System.out.println("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			
			System.out.print(" objects ");
			
			System.out.println("BidItem::"+bidItem);
			System.out.println("BidderCategory::"+bidderCategory);
		
		}
		return bidItemsList;
	}
	
	public static List<BidItem> getBidItemsAll() {
		 
		Query query = session.createQuery(" from BidItem as bidItem");
		List<BidItem> bidItemsList = query.list();
		System.out.println("bidItemList.size()::::"+ bidItemsList.size());
		for (BidItem bidItem : bidItemsList) {			
			System.out.println("BidItem::"+bidItem);
		}
		return bidItemsList;
	}
/*	
	public static List<BidItem> getBidItemsForCategory(long categoryId) {
		 
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.category.categoryId = :categoryId ");
		query.setParameter("categoryId", categoryId);
		List<BidItem> bidItemsList = query.list();
		System.out.println("bidItemList.size()::::"+ bidItemsList.size());
		for (BidItem bidItem : bidItemsList) {			
			System.out.println("BidItem::"+bidItem);
		}
		return bidItemsList;
	}
	*/
	public static List<BidItem> getBidItemsForCategoryForMarketList() {
		 
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.bidStartTime > :bidStartTime");
		query.setParameter("bidStartTime", new Date());
		List<BidItem> bidItemsList = query.list();
		System.out.println("bidItemList.size()::::"+ bidItemsList.size());
		for (BidItem bidItem : bidItemsList) {			
			System.out.println("BidItem::"+bidItem);
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForActiveMarket() {
		 
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.bidStartTime < :bidStartTime and bidItem.bidEndTime is null ");
		query.setParameter("bidStartTime", new Date());
		List<BidItem> bidItemsList = query.list();
		System.out.println("bidItemList.size()::::"+ bidItemsList.size());
		for (BidItem bidItem : bidItemsList) {			
			System.out.println("BidItem::"+bidItem);
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForClosedMarket() {
		 
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.bidEndTime is not null ");
		List<BidItem> bidItemsList = query.list();
		System.out.println("bidItemList.size()::::"+ bidItemsList.size());
		for (BidItem bidItem : bidItemsList) {			
			System.out.println("BidItem::"+bidItem);
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForMarketList(long categoryId) {
		 
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.category.categoryId = :categoryId and bidItem.bidStartTime > :bidStartTime");
		query.setParameter("categoryId", categoryId);
		query.setParameter("bidStartTime", new Date());
		List<BidItem> bidItemsList = query.list();
		System.out.println("bidItemList.size()::::"+ bidItemsList.size());
		for (BidItem bidItem : bidItemsList) {			
			System.out.println("BidItem::"+bidItem);
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForActiveMarket(long categoryId) {
		 
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.category.categoryId = :categoryId and bidItem.bidStartTime < :bidStartTime and bidItem.bidEndTime is null ");
		query.setParameter("categoryId", categoryId);
		query.setParameter("bidStartTime", new Date());
		List<BidItem> bidItemsList = query.list();
		System.out.println("bidItemList.size()::::"+ bidItemsList.size());
		for (BidItem bidItem : bidItemsList) {			
			System.out.println("BidItem::"+bidItem);
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForClosedMarket(long categoryId) {
		 
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.category.categoryId = :categoryId and bidItem.bidEndTime is not null ");
		query.setParameter("categoryId", categoryId);
		List<BidItem> bidItemsList = query.list();
		System.out.println("bidItemList.size()::::"+ bidItemsList.size());
		for (BidItem bidItem : bidItemsList) {			
			System.out.println("BidItem::"+bidItem);
		}
		return bidItemsList;
	}
	
	public static List<BidItem> getBidItemsForCategoryForMarketListForBidder(String userName) {
		 
		Query query = session.createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.bidStartTime > :bidStartTime and bidderCateg.username.loginName = :userName ");
		query.setParameter("bidStartTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		System.out.println("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			
			System.out.print(" objects ");
			
			System.out.println("BidItem::"+bidItem);
			System.out.println("BidderCategory::"+bidderCategory);
		
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForActiveMarketForBidder(String userName) {
		 
		Query query = session.createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.bidStartTime < :bidStartTime and bidItem.bidEndTime is null  and bidderCateg.username.loginName = :userName ");
		query.setParameter("bidStartTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		System.out.println("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			
			System.out.print(" objects ");
			
			System.out.println("BidItem::"+bidItem);
			System.out.println("BidderCategory::"+bidderCategory);
		
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForClosedMarketForBidder(String userName) {
		 
		Query query = session.createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.bidEndTime is not null and bidderCateg.username.loginName = :userName ");
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		System.out.println("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			
			System.out.print(" objects ");
			
			System.out.println("BidItem::"+bidItem);
			System.out.println("BidderCategory::"+bidderCategory);
		
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForMarketListForBidder(long categoryId, String userName) {
		 
		Query query = session.createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = :categoryId and bidItem.bidStartTime > :bidStartTime and bidderCateg.username.loginName = :userName ");
		query.setParameter("categoryId", categoryId);
		query.setParameter("bidStartTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		System.out.println("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			
			System.out.print(" objects ");
			
			System.out.println("BidItem::"+bidItem);
			System.out.println("BidderCategory::"+bidderCategory);
		
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForActiveMarketForBidder(long categoryId, String userName) {
		 
		Query query = session.createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = :categoryId and bidItem.bidStartTime < :bidStartTime and bidItem.bidEndTime is null  and bidderCateg.username.loginName = :userName ");
		query.setParameter("categoryId", categoryId);
		query.setParameter("bidStartTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		System.out.println("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			
			System.out.print(" objects ");
			
			System.out.println("BidItem::"+bidItem);
			System.out.println("BidderCategory::"+bidderCategory);
		
		}
		return bidItemsList;
	}	
	
	public static List<BidItem> getBidItemsForCategoryForClosedMarketForBidder(long categoryId, String userName) {
		 
		Query query = session.createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = :categoryId and bidItem.bidEndTime is not null and bidderCateg.username.loginName = :userName ");
		query.setParameter("categoryId", categoryId);
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		System.out.println("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			
			System.out.print(" objects ");
			
			System.out.println("BidItem::"+bidItem);
			System.out.println("BidderCategory::"+bidderCategory);
		
		}
		return bidItemsList;
	}
}
