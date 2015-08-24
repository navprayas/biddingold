package com.navprayas.bidding.biddinghistory.bidder.dao;

import java.util.List;

import com.navprayas.bidding.common.bean.BiddingHistoryBean;

import com.navprayas.bidding.common.form.BiddingDetailsForm;

public interface IBidderHistoryDao {
	
public List<BiddingHistoryBean>  getBiddingHistoryForMarketlist(BiddingDetailsForm biddingDetailsForm );

public List<BiddingHistoryBean>  getBiddingHistoryForObserver(BiddingDetailsForm biddingDetailsForm );
	

}
