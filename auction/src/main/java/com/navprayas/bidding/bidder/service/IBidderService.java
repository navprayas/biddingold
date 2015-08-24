package com.navprayas.bidding.bidder.service;

import java.util.List;
import java.util.Set;

import com.navprayas.bidding.common.dto.CommonVO;
import com.navprayas.bidding.common.form.BidItem;

public interface IBidderService {
	
	public BidItem getBidItem(long bidItemId); // query for item details
	
	public List<BidItem> getBidItems(String userName); // query for item details
	
	public Long findBidItemsCountForMarketListForBidder(CommonVO commonVO); //Query for no of items in Bidder market List
	
	//Query for no of items for a particular category of Bidder market List
	public Long findBidItemsCountForMarketListForBidderForCategory(CommonVO commonVO); 		
	
	public  List<BidItem> getBidItemsForCategoryForMarketListForBidder(CommonVO commonVO);
	
	public Long findBidItemsCountForClosedListForBidder(CommonVO commonVO); //Query for no of items in Bidder Closed List
	
	//Query for no of items for a particular category of Bidder Closed List
	public Long findBidItemsCountForClosedListForBidderForCategory(CommonVO commonVO); 
	
	
	public  List<BidItem> getBidItemsForCategoryForClosedMarketForBidder(CommonVO commonVO);
	
	public  List<BidItem> getBidItemsForCategoryForMarketListForBidder(long categoryId, CommonVO commonVO);
	
	//public  List<BidItem> getBidItemsForCategoryForActiveMarketForBidder(long categoryId, String userName);
	
	public  List<BidItem> getBidItemsForCategoryForClosedMarketForBidder(long categoryId, CommonVO commonVO);
	
	public boolean doBid(Integer bidItemId, Integer bidType, Double bidAmount, String userName, String comments);

	public List<BidItem> saveAutoBid(String userName, long categoryId, long bidItemId, float bidAmount, String comments);
	
	public List<BidItem> deleteAutoBid(String userName, long categoryId, long autoBidId);
	
	public Set<Long> prefferedBidItemsForBidder(String userName);
	
	public void setPrefferedBidItem(String userName, Long bidItemId);
	
	public void removePrefferedBidItem(String userName, Long bidItemId);
	
	public List<BidItem> getWonBids(String bidderName);
}
