package com.navprayas.bidding.common.service;

import java.util.Map;

import java.util.Date;

import com.navprayas.bidding.common.form.BidItem;

public interface IBidItemsCacheService {
	public BidItem getBidItem(Long bidItemId);
	public void setBidItem(BidItem bidItem);
	public Map<Long, BidItem> getBidItemsMap();
	public void flushCache();
	public Date getAuctionStartTime();
	public long getAuctionId();
}
