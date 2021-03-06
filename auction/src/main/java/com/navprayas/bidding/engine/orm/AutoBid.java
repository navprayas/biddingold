package com.navprayas.bidding.engine.orm;

import java.util.Date;

public class AutoBid {
	private Long id;
	private Integer version;
	private Long bidId;
	private Long auctionId;
	private Long bidItemId;
	private Double bidAmount;
	private String currency;
	private Date bidTime;
	private String bidStatus;
	private String bidderName;
	private String comments;
	
	public void setId(Long id) {
		this.id = id;
	}
	public Long getId() {
		return id;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
	public Integer getVersion() {
		return version;
	}
	public void setAuctionId(Long auctionId) {
		this.auctionId = auctionId;
	}
	public Long getAuctionId() {
		return auctionId;
	}
	public void setBidAmount(Double bidAmount) {
		this.bidAmount = bidAmount;
	}
	public Double getBidAmount() {
		return bidAmount;
	}
	public void setBidItemId(Long bidItemId) {
		this.bidItemId = bidItemId;
	}
	public Long getBidItemId() {
		return bidItemId;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getCurrency() {
		return currency;
	}
	public void setBidTime(Date bidTime) {
		this.bidTime = bidTime;
	}
	public Date getBidTime() {
		return bidTime;
	}
	public void setBidStatus(String bidStatus) {
		this.bidStatus = bidStatus;
	}
	public String getBidStatus() {
		return bidStatus;
	}
	public void setBidderName(String bidderName) {
		this.bidderName = bidderName;
	}
	public String getBidderName() {
		return bidderName;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getComments() {
		return comments;
	}
	public void setBidId(Long bidId) {
		this.bidId = bidId;
	}
	public Long getBidId() {
		return bidId;
	}
}
