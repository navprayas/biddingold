package com.navprayas.bidding.common.service;

import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.PostConstruct;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import redis.clients.jedis.Jedis;

import com.navprayas.bidding.common.dao.ICommonDao;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.engine.common.BidItemUpdate;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.utility.BidItemScheduler;
import com.navprayas.bidding.utility.ObjectRegistry;
import com.navprayas.bidding.utility.RedisCacheService;

@Service("bidItemsCacheService")
public class BidItemsCacheService implements IBidItemsCacheService{
	
	@Autowired
	@Qualifier("commonRepository")
	private ICommonDao commonDao;
	
	private volatile boolean mapUpdated = false;
	
	private final static Logger logger = LoggerFactory.getLogger(BidItemsCacheService.class);
			
	private final Map<Long, BidItem> bidItemsMap = Collections.synchronizedMap(new HashMap<Long, BidItem>());
	
	BidItemScheduler scheduler = null;
	
	public Date auctionStartTime;
	public long auctionId;
	
	boolean startFlag = true;
	
	@PostConstruct
	public void init(){
		//initCache();
		ObjectRegistry.getInstance().putObject(BidItemsCacheService.class.getName(), this);
	}
	@Transactional
	public void initCache()
	{
		logger.debug("Initializing cache " + new Date());
		
		startFlag = true;
		Date startTime = null;
		if(auctionStartTime != null) {
			startTime = auctionStartTime;
		}
		else {
			startTime = commonDao.getActualAuctionStartTime(auctionId);
		}
		 
		List<BidSequence> bidSequenceList = commonDao.getCurrentBidSequence(auctionId);
		logger.debug("bidSequenceList " + bidSequenceList);
		try
		{
			RedisCacheService.flushDB();
			RedisCacheService.setBidSequenceList(bidSequenceList);
			if(bidSequenceList != null && bidSequenceList.size() > 0)
			{
				List<Category> categories = commonDao.getCategoryList();
				
				RedisCacheService.setCategories(categories);
				RedisCacheService.setBidIdKey(commonDao.getMaxBidId());
				RedisCacheService.setAutoBidIdKey(commonDao.getMaxAutoBidId());

				scheduler = new BidItemScheduler();
				scheduler.setCacheService(this);
				scheduler.start(startTime);
			}
		}
		catch(Exception e)
		{
			logger.error("Cache service failed " + e.getMessage());
			e.printStackTrace();
		}
	}

	public long setNextBidItem() {
		String endSequence = RedisCacheService.isEndSequence();
		if(endSequence != null && endSequence.equals("TRUE")) {
			logger.debug("In End of Sequence");
			commonDao.setAuctionEndTime(auctionId, new Date());
			cleanBidItem(RedisCacheService.getActiveBidItemId());
			//scheduler.stop();
			return 0L;
		}
		else if(startFlag) {
			startFlag = false;
			logger.debug("In Start of Sequence");
			RedisCacheService.setActiveBidItemId();
			BidItem bidItem = getBidItem(RedisCacheService.getActiveBidItemId());
			logger.debug("BidItem from Redis : " + bidItem);
			return bidItem.getBidSpan();
		} 
		else {
			logger.debug("In Next of Sequence");
			long activeBidItemId = RedisCacheService.getActiveBidItemId();
			BidItem bidItem = RedisCacheService.getBidItem(RedisConstants.BIDITEM + activeBidItemId, String.valueOf(activeBidItemId));
			logger.debug("BidItem from Redis : " + bidItem);
			if(bidItem == null) return 0;
						
			if(bidItem.getTimeLeft() > 0) {
				logger.debug("Extended Time: " + bidItem.getTimeLeft());
				return bidItem.getTimeLeft();		
			}
			else {
				RedisCacheService.setActiveBidItemId();
				cleanBidItem(activeBidItemId);
				bidItem = getBidItem(RedisCacheService.getActiveBidItemId());
				if(bidItem == null) return 0;
				return bidItem.getBidSpan();
			}
		}
	}

	public void initializeBidItem(BidItem bidItem) {
		Calendar cal = Calendar.getInstance() ;
		bidItem.setLastUpDateTime(cal.getTime());
		bidItem.setBidStartTime(cal.getTime());
		//long bidSpan = RedisCacheService.getBidItemSpan(bidItem.getBidItemId());
		Map bidItemDetails = RedisCacheService.getBidItemSequenceDetails(bidItem.getBidItemId());
		long bidSpan = Long.parseLong((String)bidItemDetails.get(RedisConstants.ATTR_BIDSPAN));
		long seqId = Long.parseLong((String)bidItemDetails.get(RedisConstants.ATTR_SEQUENCEID));
		cal.add(Calendar.SECOND, (int)bidSpan);
		bidItem.setBidEndTime(cal.getTime());
		bidItem.setStatusCode("ACTIVE");
		bidItem.setBidSpan(bidSpan);
		bidItem.setSeqId(seqId);
	}

	public void setBidItem(BidItem bidItem)
	{
		RedisCacheService.setBidItem(RedisConstants.BIDITEM + bidItem.getBidItemId(), bidItem);
		logger.debug("DAO Set BidItem : " + bidItem);
		logger.debug("REDIS Set BidItem : " + RedisCacheService.getBidItem(RedisConstants.BIDITEM + bidItem.getBidItemId(), String.valueOf(bidItem.getBidItemId())));
	}

	@Transactional
	public BidItem getBidItem(Long bidItemId)
	{
		BidItem bidItem = RedisCacheService.getBidItem(RedisConstants.BIDITEM + bidItemId, String.valueOf(bidItemId));
		if(bidItem == null && bidItemId != 0) {
			bidItem = commonDao.getBidItem(bidItemId);
			initializeBidItem(bidItem);
			setBidItem(bidItem); //Save to cache
		}
		return bidItem;
	}
	
	private void cleanBidItem(long bidItemId) {
		RedisCacheService.setExpiredBidItem(bidItemId);
		commonDao.updateBidItem(RedisCacheService.getBidItem(RedisConstants.BIDITEM + bidItemId, bidItemId + ""));
	}
	
	public boolean setBidEndTime(long bidItemId, Date bidEndTime) {
		return RedisCacheService.setBidEndTime(bidItemId, bidEndTime, RedisConstants.BIDITEM + bidItemId);
	}
	/**
	 * @return the bidItemsMap
	 */
	public Map<Long, BidItem> getBidItemsMap() {
		return bidItemsMap;
	}
	
	@Transactional
	public void flushCache()
	{
		logger.debug("Flushing cache " + new Date());
		if(mapUpdated)
			commonDao.flushAllActiveBidItems(bidItemsMap.values());
		mapUpdated = false;
	}

	public void setAuctionStartTime(Date d) {
		auctionStartTime = d;
	}
	
	public Date getAuctionStartTime() {
		return auctionStartTime;
	}
	
	public void setAuctionId(long id) {
		auctionId = id;
	}
	
	public long getAuctionId() {
		return auctionId;
	}
}
