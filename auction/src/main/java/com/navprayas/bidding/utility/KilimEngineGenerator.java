package com.navprayas.bidding.utility;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.InitializingBean;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.navprayas.bidding.engine.core.Auctioneer;
import com.navprayas.bidding.engine.core.AuctioneerFactory;
import com.navprayas.bidding.engine.core.BidPublisher;

public class KilimEngineGenerator implements InitializingBean {

	private final static Logger logger = LoggerFactory.getLogger(KilimEngineGenerator.class);
	private static Auctioneer auctioneer;
	
	SessionFactory sessionFactory;
	
	public KilimEngineGenerator(SessionFactory sessionFactory)
	{
		this.sessionFactory = sessionFactory;
	}
	
	public void init() {
        logger.debug("Starting Kilim Engine");
        RedisCacheService.flushDB();
        auctioneer = AuctioneerFactory.create();
        try { 
         	auctioneer.registerSessionFactory(sessionFactory); 
        	auctioneer.startAuction();
        } 
        catch(Exception e) { logger.error("ERROR In Starting Bidding Engine!!!" + e.getMessage());
        	logger.error("Stopping the auction");
        	System.exit(1);
        }
      
        BidPublisher.getInstance().addObserver(BidObserver.getInstance());
	}

	public void afterPropertiesSet() throws Exception {
		logger.debug("After setting properties related to Kilim Engine");		
	}
	
	public void destroy()
	{
		logger.debug("Destroying Kilim Engine");
		auctioneer.stopAuction();
	}
	
	public static Auctioneer getAuctioneer() {
		return auctioneer;
	}
}
