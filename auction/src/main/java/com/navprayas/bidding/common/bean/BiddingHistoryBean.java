package com.navprayas.bidding.common.bean;

import java.util.Date;

public class BiddingHistoryBean {
	
	private String biddingCompany;
	private String location;
	private Date bidDateAndTime;
	private Double bidAmount;
	private String rank;
	private Character bidType;
	private String comment;
	
	
	
	
	private Long bidItemId;
	
	public Long getBidItemId() {
		return bidItemId;
	}
	public void setBidItemId(Long bidItemId) {
		this.bidItemId = bidItemId;
	}
	public String getBiddingCompany() {
		return biddingCompany;
	}
	public void setBiddingCompany(String biddingCompany) {
		this.biddingCompany = biddingCompany;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getBidDateAndTime() {
		return bidDateAndTime;
	}
	public void setBidDateAndTime(Date bidDateAndTime) {
		this.bidDateAndTime = bidDateAndTime;
	}
	public Double getBidAmount() {
		return bidAmount;
	}
	public void setBidAmount(Double bidAmount) {
		this.bidAmount = bidAmount;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public Character getBidType() {
		return bidType;
	}
	public void setBidType(Character bidType) {
		this.bidType = bidType;
	}
	
	
	

}
