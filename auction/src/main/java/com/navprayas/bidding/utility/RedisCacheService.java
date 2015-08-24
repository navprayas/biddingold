package com.navprayas.bidding.utility;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.navprayas.bidding.common.bean.Bidder;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.form.BidSequence;
import com.navprayas.bidding.common.form.Category;
import com.navprayas.bidding.engine.redis.Redis;
import com.navprayas.bidding.engine.redis.RedisConstants;
import com.navprayas.bidding.engine.redis.RedisImpl;
import redis.clients.jedis.Jedis;

public class RedisCacheService {
	
	private static final Logger logger = LoggerFactory.getLogger(RedisCacheService.class);
	private static Redis redis = RedisImpl.getInstance();
	public static SimpleDateFormat sdf = new SimpleDateFormat(RedisConstants.DATESTRING);
	
	/*public static Jedis jedis;
	static {
		try {
			jedis = redis.connect();
		}
		catch(Exception e) {
			logger.error("FAILED TO GET REDIS CONNECTION!!!!");
		}
	}*/
	
	public static void flushDB() {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			jedis.flushAll();
			jedis.bgrewriteaof();
		}
		catch(Exception e) {
			logger.error("FAILED TO FLUSH DB!!!");
		}	
		redis.close(jedis);
	}
	
	public static void setBidItemList(List<BidItem> bidItems) {
		for(BidItem item : bidItems) {
			setBidItem(RedisConstants.BIDITEM + item.getBidItemId() , item);
		}
	}
	
	public static void setBidItem(String key, BidItem bidItem) {
		Jedis jedis = null;
		try {
			 jedis = redis.connect();
			 /*if(jedis.sismember(RedisConstants.BIDITEMS, String.valueOf(bidItem.getBidItemId()))) {
				 redis.close(jedis);
				 return;
			 }*/
			 jedis.sadd(RedisConstants.BIDITEMS, String.valueOf(bidItem.getBidItemId()));
			 jedis.hsetnx(key, RedisConstants.ATTR_BIDITEMID, String.valueOf(bidItem.getBidItemId()));
			 jedis.hsetnx(key, RedisConstants.ATTR_NAME, (bidItem.getName() == null) ? "" : bidItem.getName());
			 jedis.hsetnx(key, RedisConstants.ATTR_LOCATION, (bidItem.getLocation() == null) ? "" : bidItem.getLocation()); 
			 jedis.hsetnx(key, RedisConstants.ATTR_CITY, (bidItem.getCity() == null) ? "" : bidItem.getCity()); 
			 jedis.hsetnx(key, RedisConstants.ATTR_ZONE, (bidItem.getZone() == null) ? "" : bidItem.getZone()); 
			 //jedis.hsetnx(key, RedisConstants.ATTR_VERSION, String.valueOf(bidItem.getVersion()));
			 jedis.hsetnx(key, RedisConstants.ATTR_MINBIDPRICE, (bidItem.getMinBidPrice() == null) ? "0" : String.valueOf(bidItem.getMinBidPrice()));
			 jedis.hsetnx(key, RedisConstants.ATTR_MINBIDINCREMENT, (bidItem.getMinBidIncrement() == null) ? "0" : String.valueOf(bidItem.getMinBidIncrement()));
			 jedis.hsetnx(key, RedisConstants.ATTR_BIDSTARTTIME, sdf.format(bidItem.getBidStartTime()));
			 jedis.hsetnx(key, RedisConstants.ATTR_BIDENDTIME, (bidItem.getBidEndTime() != null) ? sdf.format(bidItem.getBidEndTime()) : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_INITIALSTARTTIME, String.valueOf(bidItem.getInitialStartTime()));
			 jedis.hsetnx(key, RedisConstants.ATTR_TIMEEXTAFTERBID, (bidItem.getTimeExtAfterBid() == null) ? "0" : String.valueOf(bidItem.getTimeExtAfterBid()));
			 jedis.hsetnx(key, RedisConstants.ATTR_STATUSCODE, (bidItem.getStatusCode() != null) ? bidItem.getStatusCode() : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_LASTUPDATETIME, (bidItem.getLastUpDateTime() != null ) ? sdf.format(bidItem.getLastUpDateTime()) : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_CREATEDTIME, (bidItem.getCreatedTime() != null) ? sdf.format(bidItem.getCreatedTime()) : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_CURRENTMARKETPRICE, (bidItem.getCurrentMarketPrice() != null) ? String.valueOf(bidItem.getCurrentMarketPrice()) : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_ISAUTOBID, String.valueOf(bidItem.isAutoBidFlag()));
			 jedis.hsetnx(key, RedisConstants.ATTR_AUTOBIDID, (bidItem.getAUTOBIDID() != null) ? String.valueOf(bidItem.getAUTOBIDID()) : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_AUTOBIDAMOUNT, (bidItem.getAmountAutoBid() != null) ? String.valueOf(bidItem.getAmountAutoBid()) : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_CURRENCY, (bidItem.getCurrency() != null) ? bidItem.getCurrency() : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_CATEGORYID, String.valueOf((bidItem.getCategory() != null)? bidItem.getCategory().getCategoryId() : ""));
			 jedis.hsetnx(key, RedisConstants.ATTR_AUCTIONID, String.valueOf(bidItem.getAuctionId()));
			 jedis.hsetnx(key, RedisConstants.ATTR_AUTOBIDDERNAME, (bidItem.getAutoBidderName() != null) ? bidItem.getAutoBidderName() : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_CURRENTAUTOBIDID, (bidItem.getCurrentAutoBidId() != null) ? String.valueOf(bidItem.getCurrentAutoBidId()) : "");
			 jedis.hsetnx(key, RedisConstants.ATTR_BIDSPAN, String.valueOf(bidItem.getBidSpan()));
			 jedis.hsetnx(key, RedisConstants.ATTR_BIDSEQUENCEID, String.valueOf(bidItem.getSeqId()));
			 
			 setBidders(bidItem);
			 setCategory(bidItem.getBidItemId(), bidItem.getCategory());
		}
		catch(Exception e) {
			logger.error("FAILED TO CACHE RedisConstants.BIDITEM: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);
	}

	public static BidItem getBidItem(String key, String bidItemId) {
		Jedis jedis = null;
		BidItem bidItem = new BidItem();
		String s = null;
		try {
			jedis = redis.connect();
			if(!bidItemExists(bidItemId)) {
				redis.close(jedis);
				return null;
			}
			s = jedis.hget(key, RedisConstants.ATTR_BIDITEMID);
			bidItem.setBidItemId(( s == null || s.equals("null") || s.length() == 0) ? 0L : Long.parseLong(s));
			s = jedis.hget(key, RedisConstants.ATTR_NAME);
			bidItem.setName(s);
			s = jedis.hget(key, RedisConstants.ATTR_LOCATION);
			bidItem.setLocation(s);
			s = jedis.hget(key, RedisConstants.ATTR_CITY);
			bidItem.setCity(s);
			s = jedis.hget(key, RedisConstants.ATTR_ZONE);
			bidItem.setZone(s);
			//s = jedis.hget(key, RedisConstants.ATTR_VERSION);
			//bidItem.setVersion(( s == null || s.equals("null") || s.length() == 0) ? 0 : Integer.parseInt(s));
			s = jedis.hget(key, RedisConstants.ATTR_MINBIDPRICE);
			bidItem.setMinBidPrice(( s == null || s.equals("null") || s.length() == 0) ? 0.0 : Double.parseDouble(s));
			s = jedis.hget(key, RedisConstants.ATTR_MINBIDINCREMENT);
			bidItem.setMinBidIncrement(( s == null || s.equals("null") || s.length() == 0) ? 0.0 : Double.parseDouble(s));
			s = jedis.hget(key, RedisConstants.ATTR_BIDSTARTTIME);
			bidItem.setBidStartTime(( s == null || s.length() == 0 ) ? null : sdf.parse(s) );
			s = jedis.hget(key, RedisConstants.ATTR_BIDENDTIME);
			bidItem.setBidEndTime(( s == null || s.equals("null") || s.length() == 0 ) ? null : sdf.parse(s) );
			s = jedis.hget(key, RedisConstants.ATTR_INITIALSTARTTIME);
			bidItem.setInitialStartTime(( s == null || s.equals("null") || s.length() == 0) ? 0 : Integer.parseInt(s));
			s = jedis.hget(key, RedisConstants.ATTR_TIMEEXTAFTERBID);
			bidItem.setTimeExtAfterBid(( s == null || s.equals("null") || s.length() == 0) ? 0 : Integer.parseInt(s));
			s = jedis.hget(key, RedisConstants.ATTR_STATUSCODE);
			bidItem.setStatusCode(s);
			s = jedis.hget(key, RedisConstants.ATTR_WINNERID);
			s = jedis.hget(key, RedisConstants.ATTR_LASTUPDATETIME);
			bidItem.setLastUpDateTime(( s == null || s.equals("null") || s.length() == 0 ) ? null : sdf.parse(s) );
			s = jedis.hget(key, RedisConstants.ATTR_CREATEDTIME);
			bidItem.setCreatedTime(( s == null || s.equals("null") || s.length() == 0 ) ? null : sdf.parse(s) );
			s = jedis.hget(key, RedisConstants.ATTR_CURRENTMARKETPRICE);
			bidItem.setCurrentMarketPrice(( s == null || s.equals("null") || s.length() == 0) ? 0.0 : Double.parseDouble(s));
			s = jedis.hget(key, RedisConstants.ATTR_ISAUTOBID);
			bidItem.setAutoBidFlag(( s == null || s.equals("null") || s.length() == 0) ? false : true);
			s = jedis.hget(key, RedisConstants.ATTR_AUTOBIDID);
			bidItem.setAUTOBIDID(( s == null || s.equals("null") || s.length() == 0) ? 0L : Long.parseLong(s));
			s = jedis.hget(key, RedisConstants.ATTR_AUTOBIDAMOUNT);
			bidItem.setAmountAutoBid(( s == null || s.equals("null") || s.length() == 0) ? 0.0 : Double.parseDouble(s));
			s = jedis.hget(key, RedisConstants.ATTR_CURRENCY);
			bidItem.setCurrency(s);
			s = jedis.hget(key, RedisConstants.ATTR_CATEGORYID);
			bidItem.setCategory(( s != null) ? getCategory(s) : null );
			s = jedis.hget(key, RedisConstants.ATTR_AUCTIONID);
			bidItem.setAuctionId(( s == null || s.equals("null") || s.length() == 0) ? 0L : Long.parseLong(s));
			s = jedis.hget(key, RedisConstants.ATTR_AUTOBIDDERNAME);
			bidItem.setAutoBidderName(s);
			s = jedis.hget(key, RedisConstants.ATTR_CURRENTAUTOBIDID);
			bidItem.setCurrentAutoBidId(( s == null || s.equals("null") || s.length() == 0) ? 0L : Long.parseLong(s));
			s = jedis.hget(key, RedisConstants.ATTR_BIDSPAN);
			bidItem.setBidSpan(( s == null || s.equals("null") || s.length() == 0) ? 0L : Long.parseLong(s));
			s = jedis.hget(key, RedisConstants.ATTR_BIDSEQUENCEID);
			bidItem.setSeqId(( s == null || s.equals("null") || s.length() == 0) ? 0L : Long.parseLong(s));
			
			getBidders(bidItem);

		} catch (Exception e) {
			logger.error("FAILED TO GET BIDITEM FROM CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);		
		return bidItem;
	}
	
	public static boolean setBidEndTime(long bidItemId, Date bidEndTime, String key) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			 if(!jedis.sismember(RedisConstants.BIDITEMS, String.valueOf(bidItemId))) {
				 redis.close(jedis);
				 return false;
			 }
			 jedis.hset(key, RedisConstants.ATTR_BIDENDTIME, sdf.format(bidEndTime));
		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM END TIME: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);	
		return true;
	}

	public static Date getBidEndTime(long bidItemId, String key) {
		Jedis jedis = null;
		Date bidEndTime = null;
		try {
			jedis = redis.connect();
			String endTime = jedis.hget(key, RedisConstants.ATTR_BIDENDTIME);
			bidEndTime = (endTime == null || endTime.length() == 0 || endTime.equals("null")) ? null : sdf.parse(endTime);
		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM END TIME: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);	
		return bidEndTime;
	}

	public static boolean setBidItemLastUpdateTime(long bidItemId, Date lastUpdateTime, String key) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			 if(!jedis.sismember(RedisConstants.BIDITEMS, String.valueOf(bidItemId))) {
				 redis.close(jedis);
				 return false;
			 }
			 jedis.hset(key, RedisConstants.ATTR_LASTUPDATETIME, sdf.format(lastUpdateTime));
		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM LAST UPDATE TIME: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);	
		return true;
	}

	public static Date getBidItemLastUpdateTime(long bidItemId, String key) {
		Jedis jedis = null;
		Date bidEndTime = null;
		try {
			jedis = redis.connect();
			String endTime = jedis.hget(key, RedisConstants.ATTR_LASTUPDATETIME);
			bidEndTime = (endTime == null || endTime.length() == 0 || endTime.equals("null")) ? null : sdf.parse(endTime);
		} catch (Exception e) {
			logger.error("FAILED TO SET BIDITEM LAST UPDATE TIME: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);	
		return bidEndTime;
	}
	
	public static void getBidders(BidItem bidItem) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			
			Set<String> bidders = jedis.smembers(RedisConstants.BIDDERS + bidItem.getBidItemId());
			for(String bidder : bidders) {
				bidItem.addBidder(getBidder(bidItem.getBidItemId(), bidder));
			}
		} catch (Exception e) {
			logger.error("FAILED TO ADD BIDDER FOR BIDITEM: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);			
	}

	public static void setBidders(BidItem bidItem) {
		List<Bidder> bidders = bidItem.getCurrentBidderList();
		if(bidders == null || bidders.isEmpty())
			return;
		for(Bidder b : bidders) {
			setBidder(bidItem.getBidItemId(), b.getBidderName(), b.isAutoBid(), b.getCurrentBidAmount());
		}	
	}
	
	public static void setBidder(long bidItemId, String bidderName, boolean isAutoBid, double bidAmount) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();
			String key = RedisConstants.BIDDER + bidItemId + "::";
			jedis.sadd(RedisConstants.BIDDERS + bidItemId, bidderName);
			jedis.hsetnx(key + bidderName, "bidderName", bidderName);
			jedis.hsetnx(key + bidderName, "autoBid", String.valueOf(isAutoBid));
			jedis.hsetnx(key + bidderName, "bidAmount", String.valueOf(bidAmount));
		} catch (Exception e) {
			logger.error("FAILED TO STORE BIDDER FOR BIDITEM: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);			
	}
	
	public static Bidder getBidder(long bidItemId, String bidderName) {
		Jedis jedis = null;
		Bidder bidder = null;
		try {
			jedis = redis.connect();
			String key = RedisConstants.BIDDER + bidItemId + "::";
			/*if(!jedis.sismember(RedisConstants.BIDDERS + bidItemId, bidderName)) {
				redis.close(jedis);
				return null;
			}*/
			bidder = new Bidder();
			bidder.setBidderName(jedis.hget(key + bidderName, "bidderName"));
			bidder.setAutoBid(Boolean.parseBoolean((jedis.hget(key + bidderName, "autoBid"))));
			bidder.setCurrentBidAmount(
					(jedis.hget(key + bidderName, "bidAmount") == null) ? 0.0 : Double.parseDouble(jedis.hget(key + bidderName, "bidAmount")));
		} catch (Exception e) {
			logger.error("FAILED TO GET BIDDER: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);		
		return bidder;
	}
	
	public static List<BidItem> getBidItems(String categoryId) {
		Jedis jedis = null;
		List<BidItem> bidItems = null;
		try {
			 jedis = redis.connect();
			 Set<String> bidItemIds = jedis.smembers(RedisConstants.CATEGORY + categoryId);
			 bidItems = new ArrayList<BidItem>();
			 for(String bidItemId : bidItemIds) {
				 bidItems.add(getBidItem(RedisConstants.BIDITEM + bidItemId, bidItemId));
			 }
		}
		catch(Exception e) {
			logger.error("FAILED TO SET BIDITEM TO CATEGORY: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);			
		return bidItems;
	}
	
	public static List<BidItem> getBidItems() {
		Jedis jedis = null;
		List<BidItem> bidItems = new ArrayList<BidItem>();
		try {
			jedis = redis.connect();
			Set<String> bidItemIds = jedis.smembers(RedisConstants.BIDITEMS);
			for(String bidItemId : bidItemIds) {
				bidItems.add(getBidItem(RedisConstants.BIDITEM + bidItemId, bidItemId));
			}
		
		} catch (Exception e) {
			logger.error("FAILED TO GET BIDITEMS: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);	
		return bidItems;
	}
	
	public static boolean bidItemExists(String bidItemId) {
		Jedis jedis = null;
		try {
			 jedis = redis.connect();		
			 return jedis.sismember(RedisConstants.BIDITEMS, bidItemId);
		}
		catch(Exception e) {
			logger.error("FAILED TO CHECK BIDITEM IN CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);
		return false;
	}

	public static void setCategory(long bidItemId, Category category) {
		if (category == null) return;
		Jedis jedis = null;
		try {
			 jedis = redis.connect();
			 jedis.sadd(RedisConstants.CATEGORIES + category.getCategoryId(), String.valueOf(bidItemId));
		}
		catch(Exception e) {
			logger.error("FAILED TO SET BIDITEM TO CATEGORY: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);	
	}

	public static Category getCategory(String categoryId) {
		Jedis jedis = null;
		Category category = null;
		try {
			 jedis = redis.connect();	
			 category = new Category();
			 category.setCategoryName(jedis.hget(RedisConstants.CATEGORY + categoryId, RedisConstants.ATTR_CATEGORY_NAME));
			 category.setCategoryId(Long.valueOf(jedis.hget(RedisConstants.CATEGORY + categoryId, RedisConstants.ATTR_CATEGORY_ID)));
		}
		catch(Exception e) {
			logger.error("FAILED TO GET CATEGOY FROM CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);		
		return category;		
	}
	
	public static void setCategories(List<Category> categoryies) {
		Jedis jedis = null;
		try {
			 jedis = redis.connect();		
			 for(Category c : categoryies) {
				 jedis.sadd(RedisConstants.CATEGORIES, String.valueOf(c.getCategoryId()));
				 jedis.hset(RedisConstants.CATEGORY + c.getCategoryId(), RedisConstants.ATTR_CATEGORY_NAME, c.getCategoryName());
				 jedis.hset(RedisConstants.CATEGORY + c.getCategoryId(), RedisConstants.ATTR_CATEGORY_ID, String.valueOf(c.getCategoryId()));
			 }
		}
		catch(Exception e) {
			logger.error("FAILED TO SET CATEGORIES LIST IN CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);
	}
	
	public static List<Category> getCategories() {
		Jedis jedis = null;
		List<Category> categoryList = new ArrayList<Category>();
		try {
			 jedis = redis.connect();	
			 Set<String> categories = jedis.smembers(RedisConstants.CATEGORIES);
			 Category category = null;
			 for(String c : categories) {
				 category = new Category();
				 category.setCategoryName(jedis.hget(RedisConstants.CATEGORY + c, RedisConstants.ATTR_CATEGORY_NAME));
				 category.setCategoryId(Long.valueOf(jedis.hget(RedisConstants.CATEGORY + c, RedisConstants.ATTR_CATEGORY_ID)));
				 categoryList.add(category);
			 }
		}
		catch(Exception e) {
			logger.error("FAILED TO GET CATEGORIES LIST FROM CACHE: " + e.getMessage());
			e.printStackTrace();
		}
		redis.close(jedis);		
		return categoryList;
	}

	
	public static void setBidderCategories(List<Category> categories) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();	
			for(Category c : categories) {
				jedis.sadd(RedisConstants.BID_CATEGORY + c.getCategoryId(), c.getCategoryName());
			}
		}
		catch(Exception e) {
			logger.error("FAILED TO SET BIDCATEOGIRES IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);	
	}

	public static void setBidIdKey(long maxBidId) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();	
			jedis.set("::BIDID::", String.valueOf(maxBidId));
		}
		catch(Exception e) {
			logger.error("FAILED TO SET BIDCATEOGIRES IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);		
	}

	public static void setAutoBidIdKey(long maxAutoBidId) {
		Jedis jedis = null;
		try {
			jedis = redis.connect();	
			jedis.set("::AUTOBIDID::", String.valueOf(maxAutoBidId));
		}
		catch(Exception e) {
			logger.error("FAILED TO SET BIDCATEOGIRES IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);			
	}

	public static long getBidItemSpan(long bidItemId) {
		Jedis jedis = null;
		long bidSpan = 0;
		try {
			 jedis = redis.connect();
			 bidSpan = Long.parseLong(jedis.hget(RedisConstants.BIDSEQUENCE + bidItemId, RedisConstants.ATTR_BIDSPAN));
		}
		catch(Exception e) {
			logger.error("FAILED TO GET BIDITEM SPAN FROM CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);		
		return bidSpan;		
	}
	
	public static void setBidSequenceList(List<BidSequence> bidSequenceList) {
		Jedis jedis = null;
		try {
			 jedis = redis.connect();
			 for(BidSequence s : bidSequenceList) {
				 jedis.zadd(RedisConstants.BIDITEMID_SEQUENCE, s.getSequenceId(), String.valueOf(s.getBidItem().getBidItemId()));
				 jedis.set(RedisConstants.AUCTIONID, String.valueOf(s.getAuction().getAuctionId()));
				 jedis.hset(RedisConstants.BIDSEQUENCE + s.getBidItem().getBidItemId(), RedisConstants.ATTR_BIDITEMID, String.valueOf(s.getBidItem().getBidItemId()));
				 jedis.hset(RedisConstants.BIDSEQUENCE + s.getBidItem().getBidItemId(), RedisConstants.ATTR_SEQUENCEID, String.valueOf(s.getSequenceId()));
				 jedis.hset(RedisConstants.BIDSEQUENCE + s.getBidItem().getBidItemId(), RedisConstants.ATTR_AUCTIONID, String.valueOf(s.getAuction().getAuctionId()));
				 jedis.hset(RedisConstants.BIDSEQUENCE + s.getBidItem().getBidItemId(), RedisConstants.ATTR_BIDSPAN, String.valueOf(s.getBidspan()));
			 }
			 
			 Set<String> bidItemList = jedis.zrangeByScore(RedisConstants.BIDITEMID_SEQUENCE, 0, jedis.zcard(RedisConstants.BIDITEMID_SEQUENCE));
			
			 for(String bidItemId : bidItemList) {
				 jedis.lpush(RedisConstants.BIDITEMSEQUENCEIDS, bidItemId);
			 }
		}
		catch(Exception e) {
			logger.error("FAILED TO SET BIDSEQUENCE IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);	
	}
	
	
	// Get SEQUENCE ID, BIDITEM ID, BIDSPAN, AUCTION ID. Pass BIDITEM ID
	public static Map<String, String> getBidItemSequenceDetails(long bidItemId) {
		Jedis jedis = null;
		Map<String, String> sequenceDetails = null;
		try {
			 jedis = redis.connect();
			 sequenceDetails = jedis.hgetAll(RedisConstants.BIDSEQUENCE + bidItemId);
		}
		catch(Exception e) {
			logger.error("FAILED TO GET BIDSEQUENCE DETAILS FROM CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);		
		return sequenceDetails;
	}
	
	public static void setActiveBidItemId() {
		Jedis jedis = null;
		try {
			 jedis = redis.connect();
			 String bidItemId = jedis.rpop(RedisConstants.BIDITEMSEQUENCEIDS);
			 jedis.set(RedisConstants.ACTIVE_BIDITEMID, (bidItemId == null) ? "0" : bidItemId );
		}
		catch(Exception e) {
			logger.error("FAILED TO SET BIDSEQUENCE IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);			
	}
	
	public static long getActiveBidItemId() {
		Jedis jedis = null;
		long bidItemId = 0L;
		try {
			 jedis = redis.connect();
			 String id = jedis.get(RedisConstants.ACTIVE_BIDITEMID);
			 bidItemId = (id == null) ? 0 : Long.parseLong(id);
		}
		catch(Exception e) {
			logger.error("FAILED TO SET BIDSEQUENCE IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);	
		return bidItemId;
	}

	public static String isEndSequence() {
		Jedis jedis = null;
		String endSequence = null;
		try {
			 jedis = redis.connect();
			 endSequence = jedis.get(RedisConstants.ACTIVE_BIDITEMID);
			 if(endSequence == null) return null;
			 if(endSequence.equals("0")) return "TRUE";
		}
		catch(Exception e) {
			logger.error("FAILED TO GET ENDSEQUNCE IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);
		return "FALSE";
	}
	
	public static void setAuctionId(String auctionId) {
		Jedis jedis = null;
		try {
			 jedis = redis.connect();
			 jedis.set(RedisConstants.AUCTIONID, auctionId);
			 System.out.println(jedis.get(RedisConstants.AUCTIONID));
			 
		}
		catch(Exception e) {
			logger.error("FAILED TO GET ENDSEQUNCE IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);
	}
	
	public static String getAuctionId() {
		Jedis jedis = null;
		String auctionId = null;
		try {
			 jedis = redis.connect();
			 auctionId = jedis.get(RedisConstants.AUCTIONID);
		}
		catch(Exception e) {
			logger.error("FAILED TO GET ENDSEQUNCE IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);		
		return auctionId;
	}

	public static void setExpiredBidItem(long bidItemId) {
		Jedis jedis = null;
		try {
			 jedis = redis.connect();
			 jedis.sadd(RedisConstants.EXPIRED_BIDITEMS, String.valueOf(bidItemId));
			 jedis.hset(RedisConstants.BIDITEM + bidItemId, RedisConstants.ATTR_STATUSCODE, "CLOSED");
			 jedis.hset(RedisConstants.BIDITEM + bidItemId, RedisConstants.ATTR_BIDENDTIME, sdf.format(new Date()));
		}
		catch(Exception e) {
			logger.error("FAILED TO GET ENDSEQUNCE IN CACHE: " + e.getMessage());
			e.printStackTrace();			
		}
		redis.close(jedis);		
	}

}
