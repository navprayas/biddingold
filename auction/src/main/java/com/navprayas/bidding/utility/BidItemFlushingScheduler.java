package com.navprayas.bidding.utility;

import java.util.TimerTask;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.navprayas.bidding.common.service.BidItemsCacheService;

public class BidItemFlushingScheduler extends TimerTask{
	
	private final static Logger logger = LoggerFactory.getLogger(BidItemFlushingScheduler.class);
	
	private BidItemsCacheService bidItemsCacheService;
	
	public BidItemFlushingScheduler(BidItemsCacheService bidItemsCacheService)
	{
		this.bidItemsCacheService = bidItemsCacheService;
	}

	@Override
	public void run() {
		//bidItemsCacheService.flushCache();
	}
}
