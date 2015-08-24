package com.navprayas.bidding.observer.service;

import java.util.List;
import java.util.Set;

import com.navprayas.bidding.common.dto.CommonVO;
import com.navprayas.bidding.common.dto.ObserverVO;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.Bids;

public interface IObserverService {
	
	public Set<Long> getBidItemsIDListForActiveMarket(String userName); 
	
	public BidItem getBidItem(long bidItemId); // query for item details
	
	public List<BidItem> getBidItems(String userName); // query for item details
	
    public  List<BidItem> getBidItemsForCategoryForMarketListForObserver(String userName);
	
	public  List<BidItem> getBidItemsForCategoryForActiveMarketForObserver(String userName);
	
	public  List<BidItem> getBidItemsForCategoryForMarketListForObserver(long categoryId, String userName);
	
	public  List<BidItem> getBidItemsForCategoryForActiveMarketForObserver(long categoryId, String userName);
	
	public  List<Bids> getBidItemsForCategoryForClosedMarketForObserver(CommonVO commonVO);
	
	public  List<Bids> getBidItemsForCategoryForClosedMarketForObserver(long categoryId, CommonVO commonVO);
	
	public boolean getH1Approved(ObserverVO observerVO, String userName);
	  
}
