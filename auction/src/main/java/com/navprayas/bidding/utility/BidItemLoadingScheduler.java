package com.navprayas.bidding.utility;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.navprayas.bidding.common.service.BidItemsCacheService;

public class BidItemLoadingScheduler implements Runnable{

	private final static Logger logger = LoggerFactory.getLogger(BidItemLoadingScheduler.class);
	
	private BidItemsCacheService bidItemsCacheService;
	
	public BidItemLoadingScheduler(BidItemsCacheService bidItemsCacheService)
	{
		this.bidItemsCacheService = bidItemsCacheService;
	}

	public void run() {
		// TODO Auto-generated method stub
		try
		{			
			bidItemsCacheService.initCache();
		}
		catch(Exception e)
		{
			logger.error(e.getMessage(), e);
			e.printStackTrace();
		}
	}
	
	public void initCache() {
		// TODO Auto-generated method stub
		try
		{			
			bidItemsCacheService.initCache();
		}
		catch(Exception e)
		{
			logger.error(e.getMessage(), e);
			e.printStackTrace();
		}		
	}

}
