package com.navprayas.bidding.bidder.service;

import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.bidder.dao.IBidderDao;
import com.navprayas.bidding.common.dto.CommonVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.service.IBidItemsCacheService;
import com.navprayas.bidding.engine.common.Bid;
import com.navprayas.bidding.engine.core.BidderFactory;

@Configurable
@Service("bidderService")

public class BidderServiceImpl implements IBidderService{

	private final static Logger logger = LoggerFactory.getLogger(BidderServiceImpl.class);
	
	public static int AUTO_BIDTYPE = 2;
	public static int NORMAL_BIDTYPE = 1;
	
	@Autowired
	@Qualifier("bidderRepository")
	private IBidderDao bidderDao;

	@Autowired
	@Qualifier("bidItemsCacheService")
	private IBidItemsCacheService bidItemsCacheService;
	
	@Transactional
	public BidItem getBidItem (long bidItemId) {
		return bidderDao.getBidItem(bidItemId);
	}
	
	@Transactional
	public List<BidItem> getBidItems(String userName) {
		return bidderDao.getBidItems(userName);
	}
	@Transactional
	public  List<BidItem> getBidItemsForCategoryForMarketListForBidder(CommonVO commonVO)
	{
		return bidderDao.getBidItemsForCategoryForMarketListForBidder(commonVO);
	}
//	@Transactional
//	public  List<BidItem> getBidItemsForCategoryForActiveMarketForBidder(String userName, long auctionId, long seqId)
//	{
//		return bidderDao.getBidItemsForCategoryForActiveMarketForBidder(userName, auctionId, seqId);
//	}
	@Transactional
	public  List<BidItem> getBidItemsForCategoryForClosedMarketForBidder(CommonVO commonVO)
	{
		return bidderDao.getBidItemsForCategoryForClosedMarketForBidder(commonVO);
	}
	
	@Transactional
	public  List<BidItem> getBidItemsForCategoryForMarketListForBidder(long categoryId, CommonVO commonVO)
	{
		return bidderDao.getBidItemsForCategoryForMarketListForBidder(categoryId, commonVO);
	}
	
//	@Transactional
//	public  List<BidItem> getBidItemsForCategoryForActiveMarketForBidder(long categoryId, String userName, long auctionId, long seqId)
//	{
//		return bidderDao.getBidItemsForCategoryForActiveMarketForBidder(categoryId, userName, auctionId, seqId);
//	}
	@Transactional
	public  List<BidItem> getBidItemsForCategoryForClosedMarketForBidder(long categoryId, CommonVO commonVO)
	{
		return bidderDao.getBidItemsForCategoryForClosedMarketForBidder(categoryId, commonVO);
	}
	@Transactional
	public boolean doBid(Integer bidItemId, Integer bidType, Double bidAmount, final String userName, String comments)
	{

		BidItem bidItem = bidItemsCacheService.getBidItem(bidItemId.longValue());
		Bid bid = new Bid (userName, 
				bidItem.getAuctionId(), 
				bidItemId, 
				bidAmount.doubleValue(), 
				bidItem.getCurrency(), 
				bidItem.getStatusCode(), 
				bidType, 
				comments,
				// Bid Type - 2 : Auto Bid, Bid Type - 1 : Normal Bid
				(bidType == AUTO_BIDTYPE) ? bidAmount.doubleValue() : 0.0); //IF Auto Bid set Bid Amount to Max Auto Bid Amount
		bid.setStatus("I");
		//bid.setVersion(bidItem.getVersion());
		logger.debug(bidAmount + " Bid is " + bid);
		try {
			BidderFactory.create().call(bid); 
		}
		catch(Exception e) {
			e.printStackTrace();
			//logger.debug("Error in calling for bid: " + e.getMessage());
			logger.error("Error in calling for bid: " + e.getMessage());
			return false;
		}
		return false;
	}

	@Transactional
	public List<BidItem> deleteAutoBid(String userName, long categoryId, long autoBidId) {
		
		return bidderDao.deleteAutoBid(userName, categoryId, autoBidId);
	}

	@Transactional
	public List<BidItem> saveAutoBid(String userName, long categoryId,
			long bidItemId, float bidAmount, String comments) {
		Long auctionId  = bidItemsCacheService.getAuctionId();
		return bidderDao.saveAutoBid(userName, categoryId, bidItemId, bidAmount, comments, auctionId);
	}
	@Transactional
	public Set<Long> prefferedBidItemsForBidder(String userName) {
		
		return bidderDao.prefferedBidItemsForBidder(userName);
	}
	@Transactional
	public void setPrefferedBidItem(String userName, Long bidItemId) {
		bidderDao.setPrefferedBidItem(userName, bidItemId);
	}
	@Transactional
	public void removePrefferedBidItem(String userName, Long bidItemId) {
		bidderDao.removePrefferedBidItem(userName, bidItemId);
		
	}
	@Transactional
	public List<BidItem> getWonBids(String bidderName)
	{
		return bidderDao.getWonBids(bidderName);
	}
	
	@Transactional
	public Long findBidItemsCountForMarketListForBidder(CommonVO commonVO) {
		return bidderDao.findBidItemsCountForMarketListForBidder(commonVO);
	}

	@Transactional
	public Long findBidItemsCountForMarketListForBidderForCategory(CommonVO commonVO) {
		return bidderDao.findBidItemsCountForMarketListForBidderForCategory(commonVO);
	}
	
	@Transactional
	public Long findBidItemsCountForClosedListForBidder(CommonVO commonVO) {
		return bidderDao.findBidItemsCountForClosedListForBidder(commonVO);
	}

	@Transactional
	public Long findBidItemsCountForClosedListForBidderForCategory(CommonVO commonVO) {
		return bidderDao.findBidItemsCountForClosedListForBidderForCategory(commonVO);
	}
	
}
