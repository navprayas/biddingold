package com.navprayas.bidding.bidder.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.common.dto.CommonVO;
import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.AutoBids;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.BiditemBidder;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.common.form.CloseBids;
import com.navprayas.bidding.common.form.Users;



@Repository("bidderRepository")
public class BidderDaoImpl implements IBidderDao{
	Logger logger = LoggerFactory.getLogger(BidderDaoImpl.class);
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

	public  List<BidItem> getBidItemsForCategoryForMarketListForBidder(CommonVO commonVO) {
		String queryString = "from BidItem as bidItem left outer join bidItem.autoBids as autoBidsList, BidderCategory as bidderCateg, BidSequence bidSeq  " +
			"where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and " +
			" bidderCateg.auction.auctionId = :auctionId and bidderCateg.bidderCategoryId.user.username = :userName " +
			" and bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem.bidItemId ";
		Long sequenceId = commonVO.getSequenceId();
		String userName = commonVO.getUserName();
		if(sequenceId != 0)
			queryString += " and bidSeq.sequenceId > :sequenceId order by bidSeq.sequenceId ";
		else
			queryString += " order by bidSeq.sequenceId ";
		
		Query query = sessionFactory.getCurrentSession().createQuery(queryString).setFirstResult(commonVO.getFirstResult()).setMaxResults(commonVO.getMaxResult());
		query.setParameter("auctionId", commonVO.getAuctionId());
		if(sequenceId != 0)
			query.setParameter("sequenceId", sequenceId);
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();

		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			AutoBids autoBids = (AutoBids)objects[1];
			BidderCategory bidderCategory = (BidderCategory)objects[2];
			BidSequence bidSequence = (BidSequence)objects[3];
			//System.out.print(" objects \n");
			List<AutoBids> autoBidsList = bidItem.getAutoBids();
			for(AutoBids autoBid : autoBidsList)
			{
				if(userName.equals(autoBid.getBidderName()) && autoBid.getBidStatus().equalsIgnoreCase("A"))
				{
					bidItem.setAutoBidFlag(true);
					bidItem.setAmountAutoBid(autoBid.getBidAmount());
					bidItem.setCurrentAutoBidId(autoBid.getAutoBidId());
					break;
				}
			}
			bidItem.setSeqId(bidSequence.getSequenceId());
			bidItem.setBidSpan(bidSequence.getBidspan());
			logger.debug("BidItem::"+bidItem);
			logger.debug("autoBids::"+autoBids);
			logger.debug("BidderCategory::"+bidderCategory);
			
			if(!bidItemsList.contains(bidItem))
				bidItemsList.add(bidItem);
		
		}
		return bidItemsList;		
	}	
	
	public  List<BidItem> getBidItemsForCategoryForActiveMarketForBidder(String userName) {
		 
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and bidItem.bidStartTime < :currentTime and bidItem.bidEndTime > :currentTime and bidderCateg.bidderCategoryId.user.username = :userName ");
		query.setParameter("currentTime", new Date());
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		logger.debug("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			BidderCategory bidderCategory = (BidderCategory)objects[1];
			if(bidItem.getCurrentMarketPrice()==null)
				bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice());
			bidItemsList.add(bidItem);
		
		}
		return bidItemsList;
	}	
	
	public List<BidItem> getBidItemsForCategoryForClosedMarketForBidder(CommonVO commonVO) {
		Long sequenceId = commonVO.getSequenceId();
		String userName = commonVO.getUserName();
		String queryString = " from BidItem as bidItem, BidderCategory as bidderCateg, BidSequence bidSeq  " +
		" where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and " +
		" bidderCateg.auction.auctionId = :auctionId and bidderCateg.bidderCategoryId.user.username = :userName " +
		" and bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem.bidItemId ";
		if(sequenceId != 0)
			queryString += " and bidSeq.sequenceId < :sequenceId order by bidSeq.sequenceId ";
		else
			queryString += " order by bidSeq.sequenceId";
		
		Query query = sessionFactory.getCurrentSession().createQuery(queryString).setFirstResult(commonVO.getFirstResult()).setMaxResults(commonVO.getMaxResult());
		query.setParameter("auctionId", commonVO.getAuctionId());
		if(sequenceId != 0)
			query.setParameter("sequenceId", sequenceId);
		query.setParameter("userName", userName);
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		logger.debug("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			//BidderCategory bidderCategory = (BidderCategory)objects[1];
			BidSequence bidSeq = (BidSequence)objects[2];
			bidItem.setSeqId(bidSeq.getSequenceId());
			String bidderName = bidItem.getBidderName();
			if(bidderName != null && bidderName.equals(userName)){
				bidItem.setStatus("Won");
			}
			bidItemsList.add(bidItem);
		}
		return bidItemsList;
	}	
	
	public  List<BidItem> getBidItemsForCategoryForMarketListForBidder(long categoryId,CommonVO commonVO) {
		String queryString = " from BidItem as bidItem left outer join bidItem.autoBids as autoBidsList, BidderCategory as bidderCateg, BidSequence bidSeq  " +
		" where bidItem.category.categoryId = :categoryId  and bidderCateg.auction.auctionId = :auctionId " +
		" and bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and bidderCateg.bidderCategoryId.user.username = :userName " +
		" and bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem.bidItemId ";
		Long sequenceId = commonVO.getSequenceId();
		String userName = commonVO.getUserName();
		if(sequenceId != 0)
			queryString += " and bidSeq.sequenceId > :sequenceId order by bidSeq.sequenceId ";
		else
			queryString += " order by bidSeq.sequenceId";
		
		Query query = sessionFactory.getCurrentSession().createQuery(queryString).setFirstResult(commonVO.getFirstResult()).setMaxResults(commonVO.getMaxResult());
		query.setParameter("categoryId", categoryId);
		query.setParameter("auctionId", commonVO.getAuctionId());
		if(sequenceId != 0L)
			query.setParameter("sequenceId", sequenceId);
		query.setParameter("userName", userName);
		
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		logger.debug("bidItemList.size()::::"+ objectsList.size());

		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			AutoBids autoBids = (AutoBids)objects[1];
			BidderCategory bidderCategory = (BidderCategory)objects[2];
			BidSequence bidSequence = (BidSequence)objects[3];
			List<AutoBids> autoBidsList = bidItem.getAutoBids();
			for(AutoBids autoBid : autoBidsList)
			{
				if(userName.equals(autoBid.getBidderName()) && autoBid.getBidStatus().equalsIgnoreCase("A"))
				{
					bidItem.setAutoBidFlag(true);
					bidItem.setAmountAutoBid(autoBid.getBidAmount());
					bidItem.setCurrentAutoBidId(autoBid.getAutoBidId());
					break;
				}
						
			}
			logger.debug("BidItem::"+bidItem);
			logger.debug("autoBids::"+autoBids);
			logger.debug("BidderCategory::"+bidderCategory);
			bidItem.setSeqId(bidSequence.getSequenceId());
			bidItem.setBidSpan(bidSequence.getBidspan());
			if(!bidItemsList.contains(bidItem))
				bidItemsList.add(bidItem);
		}
		return bidItemsList;
	}	
	
	public  List<BidItem> getBidItemsForCategoryForActiveMarketForBidder(long categoryId, String userName) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem, BidderCategory as bidderCateg where bidItem.category.categoryId = :categoryId  and bidderCateg.bidderCategoryId.category.categoryId = :categoryId and bidItem.bidStartTime < :currentTime and bidItem.bidEndTime > :currentTime  and bidderCateg.bidderCategoryId.user.username = :userName ");
		query.setParameter("categoryId", categoryId);
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
	public  List<BidItem> getBidItemsForCategoryForClosedMarketForBidder(long categoryId, CommonVO commonVO) {
		
		Long sequenceId = commonVO.getSequenceId();
		Long auctionId = commonVO.getAuctionId();
		String userName = commonVO.getUserName();
		
		String queryString = " from BidItem as bidItem, BidderCategory as bidderCateg, BidSequence bidSeq  " +
		"where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and bidderCateg.bidderCategoryId.user.username = :userName " +
		" and bidItem.category.categoryId = :categoryId  and  bidderCateg.auction.auctionId = :auctionId and " +
		" bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem.bidItemId ";
		if(sequenceId != 0L)
			queryString += " and bidSeq.sequenceId < :sequenceId order by bidSeq.sequenceId ";
		else
			queryString += " order by bidSeq.sequenceId";

		Query query = sessionFactory.getCurrentSession().createQuery(queryString).setFirstResult(commonVO.getFirstResult()).setMaxResults(commonVO.getMaxResult());
		
		//query.setParameter("bidStartTime", new Date());
		query.setParameter("categoryId", categoryId);
		query.setParameter("auctionId", auctionId);
		if(sequenceId != 0L)
			query.setParameter("sequenceId", sequenceId);
		query.setParameter("userName", userName);
		
		List<Object[]> objectsList = query.list();
		List<BidItem> bidItemsList = new ArrayList<BidItem>();
		logger.debug("bidItemList.size()::::"+ objectsList.size());
		for (Object[] objects : objectsList) {
			BidItem bidItem = (BidItem)objects[0];
			//BidderCategory bidderCategory = (BidderCategory)objects[1];
			BidSequence bidSeq = (BidSequence)objects[2];
			bidItem.setSeqId(bidSeq.getSequenceId());
			String bidderName = bidItem.getBidderName();
			if(bidderName != null && bidderName.equals(userName)){
				bidItem.setStatus("Won");
			}
			bidItemsList.add(bidItem);
		
		}
		return bidItemsList;
	}

	public List<BidItem> saveAutoBid(String userName, long categoryId, long bidItemId,
			double bidAmount, String comments, Long auctionId) {
		logger.debug("userName " + userName + " categoryId " + categoryId + " bidItemId " + bidItemId + " bidAmount " + bidAmount);
		BidItem bidItem = getBidItem(bidItemId);
		AutoBids autoBid = initializeAutoBid(userName, bidItem, bidAmount,
				comments, auctionId);
		
		List<AutoBids> autoBids = bidItem.getAutoBids();
		if(autoBids != null)
			for(AutoBids autoBidItem : autoBids)
			{
				if(autoBidItem.getBidderName().equalsIgnoreCase(userName))
				{
					autoBidItem.setBidStatus("I");
					sessionFactory.getCurrentSession().saveOrUpdate(autoBidItem);
				}
			}
		
		sessionFactory.getCurrentSession().save(autoBid);
		//sessionFactory.getCurrentSession().flush();
		
		bidItem.setCurrentAutoBidId(autoBid.getAutoBidId());
		
		sessionFactory.getCurrentSession().saveOrUpdate(bidItem);
		sessionFactory.getCurrentSession().flush();
		
		List<BidItem> listBidItems = new ArrayList<BidItem>();
		return listBidItems;
	}

	private AutoBids initializeAutoBid(String userName, BidItem bidItem,
			double bidAmount, String comments, Long auctionId) {
		AutoBids autoBid = new AutoBids();
		//autoBid.setAutoBidId((System.currentTimeMillis())%1000000);
		autoBid.setBidItemId(bidItem);
		autoBid.setBidTime(new Date());
		autoBid.setCurrency("INR");
		autoBid.setBidAmount(bidAmount);
		autoBid.setBidderName(userName);
		autoBid.setBidStatus("A");
		autoBid.setComments(comments);
		Auction auction = (Auction)sessionFactory.getCurrentSession().get(Auction.class, auctionId);
		autoBid.setAuction(auction);
		bidItem.setAmountAutoBid(bidAmount);
		bidItem.setAutoBidFlag(true);
		return autoBid;
	}

	public List<BidItem> deleteAutoBid(String userName, long categoryId, long autoBidId) {

		AutoBids autobid = (AutoBids)sessionFactory.getCurrentSession().get(AutoBids.class, autoBidId);
		if(autobid!=null)
		{
			autobid.setBidStatus("I");
			sessionFactory.getCurrentSession().saveOrUpdate(autobid);
			sessionFactory.getCurrentSession().flush();
		}
		
		List<BidItem> listBidItems = new ArrayList<BidItem>();
		return listBidItems;
	}

	private Bids initializeBids(Double bidAmount, String userName,
			BidItem bidItemOrig, String comments) {
		Bids bid = new Bids();
		bid.setBidAmount(bidAmount.doubleValue());
		bid.setBidderName(userName);
		bid.setBidItem(bidItemOrig);
		bid.setBidTime(new Date());
		bid.setComments(comments);
		//bid.setBidId((long)(System.currentTimeMillis()%1000000));
		return bid;
	}
	
	public void saveAutoBidOrBidsAfterDoBid(String userName, long bidItemId,
			double bidAmount, String comments, int bidType)
	{
		Session session = sessionFactory.openSession();
		session.getTransaction().begin();
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.bidItemId=:bidItemId");
		query.setParameter("bidItemId", bidItemId);
		BidItem bidItem = (BidItem)query.uniqueResult();

		session.flush();
		logger.debug("In saveAutoBidOrBidsAfterDoBid Method in DAO::"+bidItem);
		if(bidType == 1)
		{
			Bids bid = initializeBids(bidAmount, userName, bidItem, comments);
			session.save(bid);
		}
		else
		{
			List<AutoBids> autoBids = bidItem.getAutoBids();
			if(autoBids != null)
				for(AutoBids autoBidItem : autoBids)
				{
					if(autoBidItem.getBidderName().equals(userName))
					{
						autoBidItem.setBidStatus("I");
						session.saveOrUpdate(autoBidItem);
					}
				}			
			AutoBids autoBid = initializeAutoBid(userName, bidItem, bidAmount, comments, bidItem.getAuctionId());
			session.save(autoBid);			
		}
		session.flush();
		session.getTransaction().commit();
		session.close();
	}
	
	public AutoBids getAutoBid(long autoBidId)
	{
		Query query = sessionFactory.getCurrentSession().createQuery("From AutoBids autoBids where autoBids.autoBidId = :autoBidId ");
		query.setParameter("autoBidId", autoBidId);
		AutoBids autoBids = (AutoBids)query.uniqueResult();
		return autoBids;
	}

	public Set<Long> prefferedBidItemsForBidder(String userName) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BiditemBidder as bidItemBidder where bidItemBidder.user.username = :userName ");
		query.setParameter("userName", userName);
		List<BiditemBidder> bidItemBidderList = query.list();
		
		Set<Long> bidItemSet = new HashSet<Long>();
		for(BiditemBidder bidItemBidder : bidItemBidderList)
		{
			if(bidItemBidder.getBiditem() != null)
			bidItemSet.add(bidItemBidder.getBiditem().getBidItemId());
		}
		return bidItemSet;
	}

	public void setPrefferedBidItem(String userName, Long bidItemId) {
		logger.debug("In setPrefferedBidItem Method in DAO:: " + userName + " " + bidItemId);
		BidItem bidItem = getBidItem(bidItemId);
		Users user = getLoginDetail(userName);
		BiditemBidder bidItemBidder = new BiditemBidder();
		bidItemBidder.setBiditem(bidItem);
		bidItemBidder.setUsername(user);
		sessionFactory.getCurrentSession().save(bidItemBidder);
		logger.debug("In setPrefferedBidItem Method in DAO:: " + userName + " " + bidItemId);
	}

	private Users getLoginDetail(String userName) {
		logger.debug("In getLoginDetail Method in DAO:: " + userName);
		Query query = sessionFactory.getCurrentSession().createQuery(" from Users as users where users.username=:userName");
		query.setParameter("userName", userName);
		Users loginDetail = (Users)query.uniqueResult();
		logger.debug("In getLoginDetail Method in DAO::"+loginDetail);
		return loginDetail;
	}

	public void removePrefferedBidItem(String userName, Long bidItemId) {
		logger.debug("In removePrefferedBidItem Method in DAO:: " + userName + " " + bidItemId);
		Query query = sessionFactory.getCurrentSession().createQuery(" from BiditemBidder b where b.biditem.bidItemId = :bidItemId and b.bidderCategoryId.user.username=:userName ");
		query.setParameter("userName", userName);
		query.setParameter("bidItemId", bidItemId);
		BiditemBidder bidItemBidder = (BiditemBidder)query.uniqueResult();
		logger.debug("In removePrefferedBidItem Method in DAO:: " + bidItemBidder);
		sessionFactory.getCurrentSession().delete(bidItemBidder);
		
	}
	public List<BidItem> getWonBids(String bidderName)
	{
		Query query = sessionFactory.getCurrentSession().createQuery("From CloseBids closeBids where closeBids.bidderName= :bidderName ");
		query.setParameter("bidderName", bidderName);
		List<CloseBids> closebidList = query.list();
		
		List<BidItem> listBidItems = new ArrayList<BidItem>();
		for (CloseBids closebid : closebidList) {
			BidItem bidItem = closebid.getBidItem();
			listBidItems.add(bidItem);
		}
		return listBidItems ;
	}
	public Long findBidItemsCountForMarketListForBidder(CommonVO commonVO) {
		
		Long sequenceId = commonVO.getSequenceId();
		Long auctionId = commonVO.getAuctionId();
		String userName = commonVO.getUserName();
		
		String queryString = "select count(*) from BidItem as bidItem left outer join bidItem.autoBids as autoBidsList, BidderCategory as bidderCateg, BidSequence bidSeq  " +
				"where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and " +
				" bidderCateg.auction.auctionId = :auctionId and bidderCateg.bidderCategoryId.user.username = :userName " +
				" and bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem.bidItemId ";
			if(sequenceId != 0)
				queryString += " and bidSeq.sequenceId > :sequenceId order by bidSeq.sequenceId ";
			else
				queryString += " order by bidSeq.sequenceId ";
			Query query = sessionFactory.getCurrentSession().createQuery(queryString);
			query.setParameter("auctionId", auctionId);
			query.setParameter("userName", userName);
			if(sequenceId != 0){
				query.setParameter("sequenceId", sequenceId);
			}	
			
			Long count = (Long) query.uniqueResult();
			
		return count;
	}
	public Long findBidItemsCountForMarketListForBidderForCategory(CommonVO commonVO) {
		
		String queryString = "select count(*) from BidItem as bidItem left outer join bidItem.autoBids as autoBidsList, BidderCategory as bidderCateg, BidSequence bidSeq  " +
				" where bidItem.category.categoryId = :categoryId and  bidderCateg.auction.auctionId = :auctionId " +
				" and bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and bidderCateg.bidderCategoryId.user.username = :userName " +
				" and bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem.bidItemId ";
				Long sequenceId = commonVO.getSequenceId();
				String userName = commonVO.getUserName();
				if(sequenceId != 0)
					queryString += " and bidSeq.sequenceId > :sequenceId order by bidSeq.sequenceId ";
				else
					queryString += " order by bidSeq.sequenceId";
				
				Query query = sessionFactory.getCurrentSession().createQuery(queryString);
				query.setParameter("categoryId", commonVO.getCategoryId());
				query.setParameter("auctionId", commonVO.getAuctionId());
				if(sequenceId != 0L)
					query.setParameter("sequenceId", sequenceId);
				query.setParameter("userName", userName);
				
				Long count = null;
				Object object = query.uniqueResult();
				logger.debug("count::::"+ object);
				
				if (object != null) {
					count = (Long)object;
				}
				
				return count;
	}
	
	
	public Long findBidItemsCountForClosedListForBidder(CommonVO commonVO) {
		
		Long sequenceId = commonVO.getSequenceId();
		Long auctionId = commonVO.getAuctionId();
		String userName = commonVO.getUserName();		
		
		String queryString = "select count(*) from BidItem as bidItem, BidderCategory as bidderCateg, BidSequence bidSeq  " +
				" where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and " +
				" bidderCateg.auction.auctionId = :auctionId and bidderCateg.bidderCategoryId.user.username = :userName " +
				" and bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem.bidItemId ";
				if(sequenceId != 0)
					queryString += " and bidSeq.sequenceId < :sequenceId order by bidSeq.sequenceId ";
				else
					queryString += " order by bidSeq.sequenceId";
				
				Query query = sessionFactory.getCurrentSession().createQuery(queryString);
				query.setParameter("auctionId", auctionId);
				if(sequenceId != 0)
					query.setParameter("sequenceId", sequenceId);
				query.setParameter("userName", userName);
			
			Long count = (Long) query.uniqueResult();
			
		return count;
	}
	public Long findBidItemsCountForClosedListForBidderForCategory(CommonVO commonVO) {
		
		Long sequenceId = commonVO.getSequenceId();
		Long auctionId = commonVO.getAuctionId();
		String userName = commonVO.getUserName();	
		
		String queryString = "select count(*) from BidItem as bidItem, BidderCategory as bidderCateg, BidSequence bidSeq  " +
				"where bidItem.category.categoryId = bidderCateg.bidderCategoryId.category.categoryId and " +
				" bidderCateg.auction.auctionId = :auctionId and bidderCateg.bidderCategoryId.user.username = :userName " +
				" and bidItem.category.categoryId = :categoryId  and " +
				" bidSeq.auction.auctionId = :auctionId and bidSeq.bidItem.bidItemId = bidItem.bidItemId ";
				if(sequenceId != 0L)
					queryString += " and bidSeq.sequenceId < :sequenceId order by bidSeq.sequenceId ";
				else
					queryString += " order by bidSeq.sequenceId";

				Query query = sessionFactory.getCurrentSession().createQuery(queryString);
				
				//query.setParameter("bidStartTime", new Date());
				query.setParameter("categoryId", commonVO.getCategoryId());
				query.setParameter("auctionId", auctionId);
				if(sequenceId != 0L)
					query.setParameter("sequenceId", sequenceId);
				query.setParameter("userName", userName);
				
				Long count = null;
				Object object = query.uniqueResult();
				logger.debug("count::::"+ object);
				
				if (object != null) {
					count = (Long)object;
				}
				
				return count;
	}
	
}



