package com.navprayas.bidding.biddinghistory.bidder.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.navprayas.bidding.common.bean.BiddingHistoryBean;
import com.navprayas.bidding.common.form.BiddingDetailsForm;
import com.navprayas.bidding.common.form.Bids;


@Repository("bidderHistoryRepository")
public class BidderHistoryDaoImpl implements IBidderHistoryDao  {
	
	Logger logger = LoggerFactory.getLogger(BidderHistoryDaoImpl.class);
	@Autowired
	private SessionFactory sessionFactory;
	
	public List<BiddingHistoryBean> getBiddingHistoryForMarketlist(BiddingDetailsForm biddingDetailsForm )
	{
		logger.debug("In getBiddingHistoryForMarketlist Method in DAO::");
		
		String queryString1 = " FROM Bids AS bids WHERE bids.bidderName = :userName AND bids.bidItem.bidItemId = :bidItemId ";
		
		Query query = sessionFactory.getCurrentSession().createQuery(queryString1);
		
		Long bidItemId = biddingDetailsForm.getBidItemId();
		String userName = biddingDetailsForm.getUserName();
		query.setParameter("userName", userName);
		query.setParameter("bidItemId", bidItemId);
		
		List<Bids> bidsList = query.list();
		
		List<BiddingHistoryBean> biddingHistoryBeanList = new ArrayList<BiddingHistoryBean>();
		logger.debug("BiddingHistoryBean size()::::"+ bidsList.size());
		for (Bids bids : bidsList) {
			BiddingHistoryBean biddingHistoryBean = new BiddingHistoryBean();
			
			biddingHistoryBean.setBidAmount(bids.getBidAmount());
			biddingHistoryBean.setBidDateAndTime(bids.getBidTime());
			biddingHistoryBean.setBiddingCompany(userName);
			biddingHistoryBean.setComment(bids.getComments());
			//biddingHistoryBean.setRank(bids.get);
			if(bids.getBidType() != null){
				char bidType = bids.getBidType();
				if(bidType == '1'){
					biddingHistoryBean.setBidType('N');
				}else if(bidType == '2'){
					biddingHistoryBean.setBidType('A');
				}else{
					biddingHistoryBean.setBidType(bidType);
				}
			}
			biddingHistoryBeanList.add(biddingHistoryBean);
		}

		return biddingHistoryBeanList;
		
	}
	
	public List<BiddingHistoryBean>  getBiddingHistoryForObserver(BiddingDetailsForm biddingDetailsForm )
	{
		logger.debug("In getBiddingHistoryForObserver Method in DAO::");
		
		String queryString1 = " FROM Bids AS bids WHERE bids.bidItem.bidItemId = :bidItemId ORDER BY bids.bidTime desc";
		
		Query query = sessionFactory.getCurrentSession().createQuery(queryString1);
		
		Long bidItemId = biddingDetailsForm.getBidItemId();
		query.setParameter("bidItemId", bidItemId);
		
		List<Bids> bidsList = query.list();
		
		List<BiddingHistoryBean> biddingHistoryBeanList = new ArrayList<BiddingHistoryBean>();
		logger.debug("BiddingHistoryBean size()::::"+ bidsList.size());
		for (Bids bids : bidsList) {
			BiddingHistoryBean biddingHistoryBean = new BiddingHistoryBean();
			
			biddingHistoryBean.setBidAmount(bids.getBidAmount());
			biddingHistoryBean.setBidDateAndTime(bids.getBidTime());
			biddingHistoryBean.setBiddingCompany(bids.getBidderName());
			biddingHistoryBean.setLocation(bids.getBidItem().getLocation());
			biddingHistoryBean.setComment(bids.getComments());
			if(bids.getBidType() != null){
				char bidType = bids.getBidType();
				if(bidType == '1'){
					biddingHistoryBean.setBidType('N');
				}else if(bidType == '2'){
					biddingHistoryBean.setBidType('A');
				}else{
					biddingHistoryBean.setBidType(bidType);
				}
			}
			biddingHistoryBeanList.add(biddingHistoryBean);
		}

		return biddingHistoryBeanList;
	}
	
}
