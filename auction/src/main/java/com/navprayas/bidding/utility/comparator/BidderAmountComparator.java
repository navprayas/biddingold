package com.navprayas.bidding.utility.comparator;

import java.util.Comparator;

import com.navprayas.bidding.common.bean.Bidder;

public class BidderAmountComparator implements Comparator<Bidder>{

	public int compare(Bidder o1, Bidder o2) {
		if(o2.getCurrentBidAmount() != o1.getCurrentBidAmount())
			return (int)(o2.getCurrentBidAmount() - o1.getCurrentBidAmount());
		else
			return (int)(o1.getBiddingTime().getTime() - o2.getBiddingTime().getTime());
	}

}
