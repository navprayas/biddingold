package com.navprayas.bidding.common.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.common.bean.Bidder;
import com.navprayas.bidding.common.bean.EmailTemplate;
import com.navprayas.bidding.common.constant.BiddingConstants;
import com.navprayas.bidding.common.email.EmailSender;
import com.navprayas.bidding.common.form.Auction;
import com.navprayas.bidding.common.form.Authorities;
import com.navprayas.bidding.common.form.AutoBids;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.BidderCategory;
import com.navprayas.bidding.common.form.BidderCategoryId;
import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.common.form.FirmDetails;
import com.navprayas.bidding.common.form.ItemLot;
import com.navprayas.bidding.common.form.UserActivity;
import com.navprayas.bidding.common.form.UserDetails;
import com.navprayas.bidding.common.form.Users;
import com.navprayas.bidding.common.util.CommonUtil;
import com.navprayas.bidding.engine.orm.Bid;
import com.navprayas.bidding.utility.RedisCacheService;

@Repository("commonRepository")
public class CommonDaoImpl implements ICommonDao {

	private final static Logger logger = LoggerFactory.getLogger(CommonDaoImpl.class);
	
	@Autowired
	private SessionFactory sessionFactory;

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private EmailSender commonEmailSender;
	
	
	@Transactional
	public List<Category> getCategoryList() {
		Query query = sessionFactory.getCurrentSession().createQuery(" from Category ");
		@SuppressWarnings("unchecked")
		List<Category> categoryList = (List<Category>)query.list();
		RedisCacheService.setCategories(categoryList);
		return categoryList;
	}
	
	public int saveVendor(FirmDetails firmDetails){
		sessionFactory.getCurrentSession().save(firmDetails);
		return firmDetails.getFirmId().intValue();
	}

	public void saveUserActivity(UserActivity userActivity){
		sessionFactory.getCurrentSession().save(userActivity);
	}
	
	public List<UserActivity> getOnlineUserList(Long auctionId){
		Query query = sessionFactory.getCurrentSession().createQuery(" from UserActivity userActivity where userActivity.auctionId = :auctionId and " +
				"userActivity.role = :role");
		query.setParameter("role", BiddingConstants.ROLE_BIDDER);
		query.setParameter("auctionId", auctionId);
		List<UserActivity> userActivityList = (List<UserActivity>)query.list();
	
		return userActivityList;
	}
	public void updateUserActivity(String sessionId,Long auctionId){
		UserActivity userActivity = (UserActivity)sessionFactory.getCurrentSession().get(UserActivity.class, sessionId);
		if(userActivity==null) {
			return;
		}
		if(auctionId == null){
			//userActivity.setLogoutTime(Calendar.getInstance().getTime());
		}else{
			userActivity.setAuctionId(auctionId);
		}
		sessionFactory.getCurrentSession().update(userActivity);
	}
	
	public List<BidderCategory> getCategoryList(String userName, long auctionId) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidderCategory bidCat where bidCat.bidderCategoryId.user.username = :userName and bidCat.auction.auctionId = :auctionId");
		query.setParameter("userName", userName);
		query.setParameter("auctionId", auctionId);
		@SuppressWarnings("unchecked")
		List<BidderCategory> bidderCategoryList = (List<BidderCategory>)query.list();			
		return bidderCategoryList;
	}

	public List<BidItem> getAllComingActiveBids() {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		Query query = session.createQuery(" from BidItem as bidItem where (bidItem.bidStartTime <= :bidStartTime or bidItem.bidStartTime <= :bidComingTime) and bidItem.bidEndTime > :currentTime ");
		
		Date tempDate = new Date();
		logger.debug("currentTime " + tempDate);
		long time = tempDate.getTime();
		time = time + 15*60*1000;
		tempDate.setTime(time);
		logger.debug("currentTime + 15 mins " + tempDate);
		query.setParameter("bidStartTime", new Date());
		query.setParameter("bidComingTime", tempDate);
		query.setParameter("currentTime", new Date());
		@SuppressWarnings("unchecked")
		List<BidItem> bidItems = (List<BidItem>)query.list();
		logger.debug("Values for active " + bidItems);
		
		for(BidItem bidItem : bidItems)
		{
			query = session.createQuery(" from AutoBids autoBids where autoBids.bidItemId.bidItemId = :bidItemId ");
			query.setParameter("bidItemId", bidItem.getBidItemId());
			//query.setParameter("status", "A");
			@SuppressWarnings("unchecked")
			List<AutoBids> autoBids = (List<AutoBids>)query.list();
			if(autoBids!=null && autoBids.size() > 1)
			{
				Collections.sort(autoBids, new Comparator<AutoBids>() {

					public int compare(AutoBids o1, AutoBids o2) {
						if(o2.getBidAmount() != o1.getBidAmount())
							return (int)(o2.getBidAmount() - o1.getBidAmount());
						else
							return (int)(o1.getBidTime().getTime() - o2.getBidTime().getTime());
					}
				});
				//logger.debug("AutoBid in If " + autoBids);
				bidItem.setAutoBidFlag(true);
				
				bidItem.setAmountAutoBid(autoBids.get(0).getBidAmount());
				bidItem.setCurrentAutoBidId(autoBids.get(0).getAutoBidId());
				bidItem.setAutoBidderName(autoBids.get(0).getBidderName());
				Bidder bidderTemp = new Bidder();
				bidderTemp.setBidderName(autoBids.get(0).getBidderName());
				bidderTemp.setAutoBid(true);
				bidderTemp.setAutoBidMaxAnount(autoBids.get(0).getBidAmount());
				if(autoBids.get(1).getBidAmount() == autoBids.get(0).getBidAmount() || 
						(autoBids.get(1).getBidAmount() + bidItem.getMinBidIncrement()) >= autoBids.get(0).getBidAmount())
				{
					bidItem.setCurrentMarketPrice(autoBids.get(0).getBidAmount());
					bidderTemp.setCurrentBidAmount(autoBids.get(0).getBidAmount());
				}
				else
				{
					bidItem.setCurrentMarketPrice(autoBids.get(1).getBidAmount() + bidItem.getMinBidIncrement());
					bidderTemp.setCurrentBidAmount(autoBids.get(1).getBidAmount() + bidItem.getMinBidIncrement());
				}
				bidItem.addBidder(bidderTemp);
				
				for(int i = 1; i < autoBids.size() ; i++)
				{
					bidderTemp = new Bidder();
					bidderTemp.setBidderName(autoBids.get(i).getBidderName());
					bidderTemp.setAutoBid(true);
					bidderTemp.setCurrentBidAmount(autoBids.get(i).getBidAmount());
					bidItem.addBidder(bidderTemp);
				}
			}
			else if(autoBids!=null && autoBids.size() == 1)
			{
				//logger.debug("AutoBid in else " + autoBids);
				bidItem.setAutoBidFlag(true);
				bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice());
				bidItem.setAmountAutoBid(autoBids.get(0).getBidAmount());
				bidItem.setCurrentAutoBidId(autoBids.get(0).getAutoBidId());
				bidItem.setAutoBidderName(autoBids.get(0).getBidderName());
				Bidder bidderTemp = new Bidder();
				bidderTemp.setBidderName(autoBids.get(0).getBidderName());
				bidderTemp.setAutoBid(true);
				bidderTemp.setAutoBidMaxAnount(autoBids.get(0).getBidAmount());
				bidderTemp.setCurrentBidAmount(bidItem.getMinBidPrice());
				bidItem.addBidder(bidderTemp);				
			}
			else {
				if(bidItem.getCurrentMarketPrice() == 0) bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice());
			}
		}
		session.getTransaction().commit();
		session.close();
		return bidItems;
	}

	public void flushAllActiveBidItems(Collection<BidItem> bidItems) {
		Session session = sessionFactory.openSession();
		session.beginTransaction();
		for(BidItem bidItem : bidItems)
		{
			session.merge(bidItem);
		}
		session.flush();
		session.getTransaction().commit();
		session.close();
	}

	@Transactional
	public BidItem getBidItem(long bidItemId) {
		logger.debug("In getBidItemById Method in DAO::" + bidItemId);
		////logger.debug("In getBidItemById Method in DAO::" + bidItemId);
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidItem as bidItem where bidItem.bidItemId=:bidItemId");
		query.setParameter("bidItemId", bidItemId);
		BidItem bidItem = (BidItem)query.uniqueResult();
		logger.debug("In getBidItemById Method in DAO::"+bidItem);

			query = sessionFactory.getCurrentSession().createQuery(" from AutoBids autoBids where autoBids.bidItemId.bidItemId = :bidItemId and autoBids.bidStatus = :status ");
			query.setParameter("bidItemId", bidItem.getBidItemId());
			query.setParameter("status", "A");
			@SuppressWarnings("unchecked")
			List<AutoBids> autoBids = (List<AutoBids>)query.list();
			if(autoBids!=null && autoBids.size() > 1)
			{
				Collections.sort(autoBids, new Comparator<AutoBids>() {

					public int compare(AutoBids o1, AutoBids o2) {
						if(o2.getBidAmount() != o1.getBidAmount())
							return (int)(o2.getBidAmount() - o1.getBidAmount());
						else
							return (int)(o1.getBidTime().getTime() - o2.getBidTime().getTime());
					}
				});
				//logger.debug("AutoBid in If " + autoBids);
				bidItem.setAutoBidFlag(true);
				
				bidItem.setAmountAutoBid(autoBids.get(0).getBidAmount());
				bidItem.setCurrentAutoBidId(autoBids.get(0).getAutoBidId());
				bidItem.setAutoBidderName(autoBids.get(0).getBidderName());
				Bidder bidderTemp = new Bidder();
				bidderTemp.setBidderName(autoBids.get(0).getBidderName());
				bidderTemp.setAutoBid(true);
				bidderTemp.setAutoBidMaxAnount(autoBids.get(0).getBidAmount());
				
				if(autoBids.get(1).getBidAmount().doubleValue() == autoBids.get(0).getBidAmount().doubleValue())
				{
					bidItem.setCurrentMarketPrice(autoBids.get(0).getBidAmount());
					bidderTemp.setCurrentBidAmount(autoBids.get(0).getBidAmount());
				}
				else
				{
					bidItem.setCurrentMarketPrice(autoBids.get(1).getBidAmount() + bidItem.getMinBidIncrement());
					bidderTemp.setCurrentBidAmount(autoBids.get(1).getBidAmount() + bidItem.getMinBidIncrement());
				}
				bidItem.addBidder(bidderTemp);
				
				for(int i = 1; i < autoBids.size() ; i++)
				{
					bidderTemp = new Bidder();
					bidderTemp.setBidderName(autoBids.get(i).getBidderName());
					bidderTemp.setAutoBid(true);
					bidderTemp.setCurrentBidAmount(autoBids.get(i).getBidAmount());
					bidItem.addBidder(bidderTemp);
				}
			}
			else if(autoBids!=null && autoBids.size() == 1)
			{
				//logger.debug("AutoBid in else " + autoBids);
				bidItem.setAutoBidFlag(true);
				bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice() + bidItem.getMinBidIncrement());
				bidItem.setAmountAutoBid(autoBids.get(0).getBidAmount());
				bidItem.setCurrentAutoBidId(autoBids.get(0).getAutoBidId());
				bidItem.setAutoBidderName(autoBids.get(0).getBidderName());
				Bidder bidderTemp = new Bidder();
				bidderTemp.setBidderName(autoBids.get(0).getBidderName());
				bidderTemp.setAutoBid(true);
				bidderTemp.setAutoBidMaxAnount(autoBids.get(0).getBidAmount());
				bidderTemp.setCurrentBidAmount(bidItem.getMinBidPrice() + bidItem.getMinBidIncrement());
				bidItem.addBidder(bidderTemp);				
			}
			else {
				if(bidItem.getCurrentMarketPrice() == null || bidItem.getCurrentMarketPrice() == 0) bidItem.setCurrentMarketPrice(bidItem.getMinBidPrice());
			}		
			try {
				saveAutoBidResultToBids(bidItem);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		return bidItem;
	}

	private void saveAutoBidResultToBids(BidItem bidItem) {
		if (bidItem.getCurrentBidderList() != null && bidItem.getCurrentBidderList().size() > 0) {
			Bid bid = new Bid();
			bid.setBidItemId(bidItem.getBidItemId());
			bid.setAuctionId(bidItem.getAuctionId());
			bid.setBidAmount(bidItem.getCurrentMarketPrice());
			bid.setComments("Auto Bid First Winner");
			bid.setBidType(2);
			bid.setBidTime(new Date());
			bid.setBidderName(bidItem.getCurrentBidderList().get(0).getBidderName());
			bid.setStatus("SUCCESS");
			bid.setCurrency("INR");
			sessionFactory.getCurrentSession().save(bid);
		}
		
	}

	@Transactional
	public long getMaxBidId() {
		Query query = sessionFactory.getCurrentSession().createQuery(" select max(bidId) from Bids bid ");
		List list = query.list();
		return (list.get(0) == null) ? 1000 : (Long)list.get(0);
	}

	@Transactional
	public long getMaxAutoBidId() {
		Query query = sessionFactory.getCurrentSession().createQuery(" select max(autoBidId) from AutoBids bid ");
		List list = query.list();
		return (list.get(0) == null) ? 1000 : (Long)list.get(0);

	}
	
	@Transactional
	public List<BidSequence> getCurrentBidSequence(long auctionId) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from BidSequence as bidSeq where bidSeq.auction.auctionId = :auctionId  ");
		query.setParameter("auctionId", auctionId);
		List<BidSequence> bidSeqList = query.list();
		logger.debug("bidSeqList " + bidSeqList);
		return bidSeqList;
	}
	
	@Transactional
	public Date getActualAuctionStartTime(long auctionId) {
		Query query = sessionFactory.getCurrentSession().createQuery(" select auction.auctionStartTime from Auction as auction where auction.auctionId = :auctionId");
		query.setParameter("auctionId", auctionId);
		Object obj = query.uniqueResult();
		Date startTime = null;
		if(obj != null)
			startTime = (Date)query.uniqueResult();
		return startTime;
	}
	
	@Transactional
	public void setActualAuctionStartTime(long auctionId, Date actualAuctionStartTime) {
		Query query = sessionFactory.getCurrentSession().createQuery(" Update Auction as auction set auction.status = 'Running', auction.auctionStartTime = :actualAuctionStartTime, auction.lastUpdateTime = :lastUpdateTime where auction.auctionId = :auctionId ");
		query.setParameter("actualAuctionStartTime", actualAuctionStartTime);
		query.setParameter("auctionId", auctionId);
		query.setParameter("lastUpdateTime", new Date());
		query.executeUpdate();
	}	

	@Transactional
	public void setAuctionEndTime(long auctionId, Date auctionEndTime) {
		Query query = sessionFactory.getCurrentSession().createQuery(" Update Auction as auction set auction.auctionEndTime = :auctionEndTime, auction.status = 'End', auction.lastUpdateTime = :lastUpdateTime where auction.auctionId = :auctionId ");
		query.setParameter("auctionEndTime", auctionEndTime);
		query.setParameter("auctionId", auctionId);
		query.setParameter("lastUpdateTime", new Date());
		query.executeUpdate();		
	}

	@Transactional
	public void updateBidItem(BidItem bidItem) {
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(" from BidItem as bidItem where bidItem.bidItemId=:bidItemId");
		query.setParameter("bidItemId", bidItem.getBidItemId());
		BidItem dbBidItem = (BidItem)query.uniqueResult();
		dbBidItem.setBidStartTime(bidItem.getBidStartTime());
		dbBidItem.setBidEndTime(bidItem.getBidEndTime());
		dbBidItem.setLastUpDateTime(bidItem.getLastUpDateTime());
		dbBidItem.setCurrentMarketPrice(bidItem.getCurrentMarketPrice());
		dbBidItem.setStatusCode("END");
		
	}
	
	public List<ItemLot> getItemLots(long bidItemId)
	{
		Query query = sessionFactory.getCurrentSession().createQuery(" from ItemLot as itemLot where itemLot.bidItemId = :bidItemId");
		query.setParameter("bidItemId", bidItemId);
		List<ItemLot> itemLotsList = query.list();
		logger.debug("ItemLotList " + itemLotsList);
		return itemLotsList;
	}
	/*
	public Long getAuctionIdIfAny() {
		Query query = sessionFactory.getCurrentSession().createQuery(" select auction.auctionId from Auction as auction where " +
				"(auction.auctionEndTime is null ) and isApproved = '1' order by auction.auctionId DESC ");
		//query.setParameter("currentTime", new Date());
		List<Object> ids = query.list();
		//Object object = query.uniqueResult();
		Object object = null;
		if(ids.size() > 0) {
			object = ids.get(0);
		}
		logger.debug("auctionId::::"+ object);
		Long auctionId = null;
		if (object != null) {
			auctionId = (Long)object;
		}
		return auctionId;
	}
	*/
	public boolean isValidAuction(Long auctionId) {
		Query query = sessionFactory.getCurrentSession().createQuery(" from Auction as auction where auction.auctionId = :auctionId ");
		query.setLong("auctionId", auctionId);	
		Auction auction =(Auction) query.uniqueResult();
		return auction.getStatus().equals("Start") && "1".equalsIgnoreCase(auction.getIsApproved());
	}
	
	public Long getTimeExtension()
	{
		Query query = sessionFactory.getCurrentSession().createQuery(" select variable.timeExtension from Variable as variable where variable.isActive = 'Y' ");
		Object object = query.uniqueResult();
		logger.debug("timeExtension::::"+ object);
		Long timeExtension = null;
		if (object != null) {
			timeExtension = (Long)object;
		}
		return timeExtension;
	}
	
	@Transactional
	public void cleanAuction() {
		Query query = sessionFactory.getCurrentSession().createQuery(" DELETE FROM AutoBids as a WHERE a.bidTime > :thatDate ");
		query.setString("thatDate","2011-04-29");
        int rowCount = query.executeUpdate();
        //logger.debug("autobid Rows affected: " + rowCount);
        
        Query query1 = sessionFactory.getCurrentSession().createQuery(" UPDATE BidItem " +
        		" SET bidStartTime = NULL, bidEndTime = NULL, lastUpDateTime = NULL, statusCode = 'START', " +
        		" AUTOBIDID= NULL, autoBidderName = NULL ");
        rowCount = query1.executeUpdate();
        //logger.debug("biditem Rows affected: " + rowCount);
	}
	
	@Transactional
	public void closeAuction(Long auctionId) {
		Query query = sessionFactory.getCurrentSession().createQuery(" update Auction as auction set auction.auctionEndTime = :auctionEndTime, " +
				"auction.lastUpdateTime = :lastUpdateTime, auction.status = 'Closed'  where auctionId = :auctionId ");
		query.setDate("auctionEndTime", new Date());
		query.setDate("lastUpdateTime", new Date());
		query.setLong("auctionId", auctionId);	
		query.executeUpdate();
	}

	public void insertAuctionDetail() {
		Query query = sessionFactory.getCurrentSession().getNamedQuery("updateAuction");
		query.executeUpdate();	
		
		query = sessionFactory.getCurrentSession().getNamedQuery("insertAuction");
		query.executeUpdate();

		query = sessionFactory.getCurrentSession().getNamedQuery("insertBidItem1");
		query.executeUpdate();
		
		query = sessionFactory.getCurrentSession().getNamedQuery("insertBidItem2");
		query.executeUpdate();

		query = sessionFactory.getCurrentSession().getNamedQuery("insertBidSeq1");
		query.executeUpdate();		
		
		query = sessionFactory.getCurrentSession().getNamedQuery("insertBidSeq2");
		query.executeUpdate();

		query = sessionFactory.getCurrentSession().getNamedQuery("insertItemLot1");
		query.executeUpdate();
		
		query = sessionFactory.getCurrentSession().getNamedQuery("insertItemLot2");
		query.executeUpdate();
	}

	//***********************Password Change**********************/
	public String ChangePassword (String LoggerName,String Oldpass,String Newpass)
	{
		//logger.debug("Name-->"+ LoggerName);
		Query query = sessionFactory.getCurrentSession().createQuery("From Users usr where usr.username= :LoggerName");
		query.setString("LoggerName",LoggerName);
		Users user = (Users)query.uniqueResult();
		user.setActive(1); // To activate the user after first time login and password change
		String Pas = user.getPassword();
		Oldpass = passwordEncoder.encodePassword(Oldpass,null);
		//logger.debug("Query is This"+query);
	    if (Pas.equals(Oldpass)){
			updateUserPassword(LoggerName, Newpass);
		} else {
			return "error";
	    }
		
		return "Sucess";
	}
	//***********************Password Change**********************/

	public void updateUserPassword(String LoggerName, String Newpass) {
		Query UpdQuery = sessionFactory.getCurrentSession().createQuery("update Users set password= :Newpass where username= :LoggerName ");
		UpdQuery.setString("LoggerName",LoggerName);
		String encPassword = passwordEncoder.encodePassword(Newpass, null);
		UpdQuery.setString("Newpass",encPassword);
		int rowCount = UpdQuery.executeUpdate();
	}

	public String checkUserExistsAndSendPasswordMail(String userName, String secretAnswer){
		logger.debug("Name-->"+ userName);
		Query query = sessionFactory.getCurrentSession().createQuery("From Users usr where usr.username= :LoggerName and usr.passwordAnswer = :passwordAnswer");
		query.setString("LoggerName",userName);
		query.setString("passwordAnswer",secretAnswer);
		Users user = (Users)query.uniqueResult();
		if(user != null){
			String newPassword = CommonUtil.randomString(8);
			boolean success = sendPasswordToUser(user, newPassword, true);
			if (success)
				return "Success";
			return "error";
		}else{
			return "error";
		}
	}
	
	public boolean checkIfUserExists(String userName){
		boolean status = false;
		Users user = getUserForUsername(userName);
		if(user != null){
			status = true;
		}
		return status;
	}

	public Users getUserForUsername(String userName) {
		logger.debug("Name--"+ userName);
		Query query = sessionFactory.getCurrentSession().createQuery("From Users usr where usr.username= :LoggerName");
		query.setString("LoggerName",userName);
		
		Users user = (Users)query.uniqueResult();
		return user;
	}
	
	private boolean sendPasswordToUser(Users user, String newPassword, boolean updatePassReq) {		
		
		EmailTemplate emailTemplate = new EmailTemplate();
		emailTemplate.setTo(user.getEmail());
		emailTemplate.setFirstName(user.getUserDetails().getFirstName());
		emailTemplate.setLastName(user.getUserDetails().getLastName());
		emailTemplate.setPassword(newPassword);
		
		emailTemplate.setCc("ashish_katiyar16@rediffmail.com");			
		emailTemplate.setSubject("New Password to access Auction Application");			
		
		logger.debug("Email Template created :: " + emailTemplate);
		emailTemplate.setUserName(user.getUsername());
		
		boolean emailSent = commonEmailSender.sendEmail(emailTemplate);
		
		if (emailSent & updatePassReq) {
			updateUserPassword(user.getUsername(), newPassword);
		}
		
		return emailSent;
	}


	public String saveUser(Users users, Authorities authorities, UserDetails userDetails){
		
		if(checkIfUserExists(users.getUsername())) {
			return "failure";
		}
		sessionFactory.getCurrentSession().save(users);
		String plainPassword = users.getPassword();
		String encPassword = passwordEncoder.encodePassword(users.getPassword(), null);   
		users.setPassword(encPassword);   
		users.setUserDetails(userDetails);
		sessionFactory.getCurrentSession().save(users);		
		sessionFactory.getCurrentSession().save(authorities);
		
		userDetails.setUser(users);
		sessionFactory.getCurrentSession().save(userDetails);
		
		sendPasswordToUser(users, plainPassword, false);
		return "success";
		
	}
	
	public List<Auction> getAuctionListForAction() {
		Query query = sessionFactory.getCurrentSession().createQuery("From Auction auction where auction.status != 'Closed' and auction.status != 'Terminated' order by auction.auctionStartTime desc");
		return (List<Auction>)query.list();
	}

	public List<Users> getActiveBidders() {
		Query query = sessionFactory.getCurrentSession().createQuery("From Users users order by users.username ");
		return (List<Users>)query.list();
	}
	
	public void setUserAuctionMap(Long selectedAuctionId, String selectedCategoryIdList, String selectedUserIdList) {
		List<String> categoryIds = new ArrayList<String>();
		List<String> userIds = new ArrayList<String>();
		StringTokenizer st = new StringTokenizer(selectedCategoryIdList, "$");
		while (st.hasMoreTokens()) {
			categoryIds.add(st.nextToken());
		} 
		st = new StringTokenizer(selectedUserIdList, "$");
		while (st.hasMoreTokens()) {
			userIds.add(st.nextToken());
		} 
		for(String userId : userIds) {
			for(String categoryId : categoryIds) {
				BidderCategory bidderCategory = new BidderCategory();
				BidderCategoryId bidderCategoryId = new BidderCategoryId();
				org.hibernate.classic.Session currentSession = sessionFactory.getCurrentSession();
				bidderCategoryId.setCategory((Category)currentSession.load(Category.class, new Long(categoryId)));
				bidderCategoryId.setUser((Users)currentSession.load(Users.class, new Long(userId)));
				bidderCategory.setBidderCategoryId(bidderCategoryId);
				bidderCategory.setAuction((Auction)currentSession.load(Auction.class, selectedAuctionId));
				try {
					currentSession.save(bidderCategory);
					currentSession.flush();
				} catch(Exception e) {
					e.printStackTrace();
					logger.error("Duplicate entry issue");
				}
				
			}
		}
	}
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	public static void main(String[] args) {
		String selectedCategoryIdList = "1$2";
		String selectedUserIdList = "3$4";
		List<String> categoryIds = new ArrayList<String>();
		List<String> userIds = new ArrayList<String>();
		
		StringTokenizer st = new StringTokenizer(selectedCategoryIdList, "$");
	     
	}
	
}
