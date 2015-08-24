package com.navprayas.bidding.utility;

import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.directwebremoting.Browser;
import org.directwebremoting.ScriptBuffer;
import org.directwebremoting.ScriptSession;
import org.directwebremoting.ScriptSessionFilter;
import org.directwebremoting.ServerContextFactory;
import org.directwebremoting.WebContextFactory;
import org.directwebremoting.proxy.ScriptProxy;
import org.directwebremoting.ui.dwr.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.navprayas.bidding.common.bean.Bidder;
import com.navprayas.bidding.common.form.BidItem;
import com.navprayas.bidding.common.service.BidItemsCacheService;
import com.navprayas.bidding.common.service.SessionManager;
import com.navprayas.bidding.utility.comparator.BidderAmountComparator;

public class CometPusher {

	static class AttributeScriptSessionFilter implements ScriptSessionFilter
	{
	    private String attributeValue;
	    private String attributeName;
	    
		public AttributeScriptSessionFilter(String attributeName, String attributeValue)
	    {
	        this.attributeName = attributeName;
	        this.attributeValue = attributeValue;
	    }

	    public boolean match(ScriptSession session)
	    {
	        Object check = session.getAttribute(attributeName);
	        if(check==null) return false;
	        String checkVal = (String)check;
	        boolean checkResult = (checkVal.equals(attributeValue));
	        return checkResult;
	    }
	    
	}	
	private static CometPusher _instance;
	private final static Logger logger = LoggerFactory.getLogger(CometPusher.class);
	
	private final String bidderActivePage = new StringBuilder().append(ServerContextFactory.get().getContextPath()).append("/bidder/active").toString();
	private final String bidderHomePage = new StringBuilder().append(ServerContextFactory.get().getContextPath()).append("/bidder/home").toString();
	private final String bidderMarketListPage = new StringBuilder().append(ServerContextFactory.get().getContextPath()).append("/bidder/marketlist").toString();
	private final String observerActivePage = new StringBuilder().append(ServerContextFactory.get().getContextPath()).append("/observer/active").toString();
	private final String observerHomePage = new StringBuilder().append(ServerContextFactory.get().getContextPath()).append("/observer/home").toString();
	private final String observerMarketListPage = new StringBuilder().append(ServerContextFactory.get().getContextPath()).append("/observer/home").toString();

   	public static synchronized CometPusher getInstance() {
      	if(null == _instance) {
        	_instance = new CometPusher();
      	}
      	return _instance;
   	}
	
	public void pushBidExtendTime(final BidItem bidItem) {
		Browser.withPage(bidderActivePage, new Runnable() {
			public void run() {
				Util.setValue("extn", bidItem.getTimeLeft());
			}
		});

		Browser.withPage(observerActivePage, new Runnable() {			
			public void run(){
				Util.setValue("extn", bidItem.getTimeLeft());
			}
		});
		
		Browser.withPage(bidderHomePage, new Runnable() {			
			public void run() {
				Util.setValue("extn", bidItem.getTimeLeft());
			}
		});
		
		Browser.withPage(bidderMarketListPage, new Runnable() {			
			public void run() {
				Util.setValue("extn", bidItem.getTimeLeft());
			}
		});
		
		Browser.withPage(observerHomePage, new Runnable() {			
			public void run() {
				long ext = bidItem.getBidEndTime().getTime() - System.currentTimeMillis();
				ext = (ext > 0) ? ext/1000 : 0;
				Util.setValue("extn", ext);
			}
		});
		
		Browser.withPage(observerMarketListPage, new Runnable() {			
			public void run(){
				long ext = bidItem.getBidEndTime().getTime() - System.currentTimeMillis();
				ext = (ext > 0) ? ext/1000 : 0;
				Util.setValue("extn", ext);
			}
		});		
	}

	public void setBidDisplay(final BidItem bidItem, final String currentBidderName) {
		logger.debug("IN COMET PUSHER");
		final long bidItemId = bidItem.getBidItemId();
		final Double currMarketPrice = bidItem.getCurrentMarketPrice();
		final List<Bidder> bidders = bidItem.getCurrentBidderList();
		Collections.sort(bidders, new BidderAmountExtComparator());
		final Set<String> bidderNames = SessionManager.scriptSessionsMap.keySet();
		
		Browser.withPage(bidderActivePage, new Runnable() {

			public void run()
			{
				Util.setValue("Item" + bidItemId, String.valueOf(currMarketPrice));
				long timeLeft = bidItem.getTimeLeft();
				logger.debug("timeLeft: " + timeLeft);
				Util.setValue("extn", bidItem.getTimeLeft());
				Collection<ScriptSession> allScriptSessions = new HashSet<ScriptSession>(); 
				allScriptSessions.addAll(ServerContextFactory.get().getScriptSessionsByPage(bidderActivePage));
				for(ScriptSession scriptSession : allScriptSessions)
				{
					if(scriptSession.isInvalidated()){						    
						ServerContextFactory.get().getAllScriptSessions().remove(scriptSession);
						continue;
					}
					String actualBidderName = (String) scriptSession.getAttribute("userName");
					if(actualBidderName == null) continue;
					logger.debug("Bidders List: " + bidders);
					Bidder thisBidder = new Bidder();
					thisBidder.setBidderName(actualBidderName);
					final int rank = bidders.indexOf(thisBidder);
					logger.debug("rank " + rank);
					if(rank >= 0) thisBidder = bidders.get(rank);
					ScriptSessionFilter filter = new AttributeScriptSessionFilter("userName", actualBidderName);				
					
					Double amountAutoBid = 0.0;
					if(bidItem.getAmountAutoBid() != null)
						amountAutoBid = bidItem.getAmountAutoBid();

					String message = null;
					if(bidItem.isAutoBidFlag() )
					{
						if(actualBidderName.equals(bidItem.getAutoBidderName()))
						{
							message = bidItemId + ":" + (rank+1) + ":2:" + amountAutoBid;
						}
						else
						{
							message = bidItemId + ":" + (rank+1) + ":1:0";
						}
					}
					else
					{
						message = bidItemId + ":" + (rank+1) + ":1:0";
					}
					ScriptBuffer script = new ScriptBuffer();
					script.appendScript("update(").appendData(message).appendScript(");");
					if (filter.match(scriptSession))
				    {					    	
				    	scriptSession.addScript(script);
				    }
				}
			}
		});
		
		Browser.withPage(observerActivePage, new Runnable() {			
			public void run() {
				Util.setValue("Item" + bidItemId, String.valueOf(currMarketPrice));
				Util.setValue("firm" + bidItemId, currentBidderName);
				Util.setValue("extn", bidItem.getTimeLeft());
			}
		});
		
		Browser.withPage(bidderHomePage, new Runnable() {			
			public void run(){
				long ext = bidItem.getBidEndTime().getTime() - System.currentTimeMillis();
				ext = (ext > 0) ? ext/1000 : 0;
				Util.setValue("extn", ext);
			}
		});
		
		Browser.withPage(bidderMarketListPage, new Runnable() {			
			public void run(){
				long ext = bidItem.getBidEndTime().getTime() - System.currentTimeMillis();
				ext = (ext > 0) ? ext/1000 : 0;
				Util.setValue("extn", ext);
			}
		});

		Browser.withPage(observerHomePage, new Runnable() {			
			public void run() {
				long ext = bidItem.getBidEndTime().getTime() - System.currentTimeMillis();
				ext = (ext > 0) ? ext/1000 : 0;
				Util.setValue("extn", ext);
			}
		});
		
		Browser.withPage(observerMarketListPage, new Runnable() {			
			public void run(){
				long ext = bidItem.getBidEndTime().getTime() - System.currentTimeMillis();
				ext = (ext > 0) ? ext/1000 : 0;
				Util.setValue("extn", ext);
			}
		});

	}
	
}


class BidderAmountExtComparator implements Comparator<Bidder>{

	public int compare(Bidder o1, Bidder o2) {
		if(o2.getCurrentBidAmount() != o1.getCurrentBidAmount())
			return (int)(o2.getCurrentBidAmount() - o1.getCurrentBidAmount());
		else if(o1.isAutoBid() != o2.isAutoBid())
		{
			int a = o1.isAutoBid() ? 10 : 0;
			int b = o2.isAutoBid() ? 10 : 0;
			return b - a;
		}
		else
		{
			return (int)(o1.getBiddingTime().getTime() - o2.getBiddingTime().getTime());
		}
	}

}
