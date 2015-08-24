 package com.navprayas.bidding.common.form;

public class BiddingDetailsForm {
	
	private String userName ;
	
	private Long auctionId;
	
	private Long bidItemId;

	public Long getAuctionId() {
		return auctionId;
	}

	public Long getBidItemId() {
		return bidItemId;
	}

	public void setBidItemId(Long bidItemId) {
		this.bidItemId = bidItemId;
	}

	public void setAuctionId(Long auctionId) {
		this.auctionId = auctionId;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	

}
