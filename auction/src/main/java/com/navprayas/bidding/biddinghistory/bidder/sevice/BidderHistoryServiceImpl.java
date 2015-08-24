package com.navprayas.bidding.biddinghistory.bidder.sevice;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;



import com.navprayas.bidding.biddinghistory.bidder.dao.IBidderHistoryDao;
import com.navprayas.bidding.common.bean.BiddingHistoryBean;
import com.navprayas.bidding.common.form.BiddingDetailsForm;
import com.navprayas.bidding.common.service.IBidItemsCacheService;

@Configurable
@Service("bidderHistoryService")

public class BidderHistoryServiceImpl implements IBidderHistoryService {
	
private final static Logger logger = LoggerFactory.getLogger(BidderHistoryServiceImpl.class);
	
	@Autowired
	@Qualifier("bidderHistoryRepository")
	private IBidderHistoryDao bidderHistoryDao;

	@Transactional
	public List<BiddingHistoryBean> getBiddingHistoryForMarketlist(BiddingDetailsForm biddingDetailsForm )
	{
		return bidderHistoryDao.getBiddingHistoryForMarketlist(biddingDetailsForm);
	}
	@Transactional
	public List<BiddingHistoryBean>  getBiddingHistoryForObserver(BiddingDetailsForm biddingDetailsForm )
	{
		return bidderHistoryDao.getBiddingHistoryForObserver(biddingDetailsForm);
	
	}
	
	
	

}
