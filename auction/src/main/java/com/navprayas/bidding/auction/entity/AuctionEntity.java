package com.navprayas.bidding.auction.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="newauction")
public class AuctionEntity
{
	@Transient
	String createdTimeFormat;
	
	@Transient
	String lastUpdateTimeFormat;
	
	@Transient
	String auctionStartTimeFormat;
	
	@Transient
	String auctionEndTimeFormat;



	
	
	public String getCreatedTimeFormat() {
		return createdTimeFormat;
	}

	public void setCreatedTimeFormat(String createdTimeFormat) {
		this.createdTimeFormat = createdTimeFormat;
	}

	public String getLastUpdateTimeFormat() {
		return lastUpdateTimeFormat;
	}

	public void setLastUpdateTimeFormat(String lastUpdateTimeFormat) {
		this.lastUpdateTimeFormat = lastUpdateTimeFormat;
	}

	public String getAuctionStartTimeFormat() {
		return auctionStartTimeFormat;
	}

	public void setAuctionStartTimeFormat(String auctionStartTimeFormat) {
		this.auctionStartTimeFormat = auctionStartTimeFormat;
	}

	public String getAuctionEndTimeFormat() {
		return auctionEndTimeFormat;
	}

	public void setAuctionEndTimeFormat(String auctionEndTimeFormat) {
		this.auctionEndTimeFormat = auctionEndTimeFormat;
	}

	
@Id
@GeneratedValue(strategy=GenerationType.AUTO)
@Column(name="id")
private int id;

@Column(name="auctionName")	
private String auctionName;

@Column(name="isApproved")
private int isApproved;

@Column(name="createdTime")
private Date createdTime;

@Column(name="lastUpdateTime")
private Date lastUpdateTime;

@Column(name="auctionStartTime")
private Date auctionStartTime;

@Column(name="auctionEndTime")
private Date auctionEndTime;

public int getId() {
	return id;
}

public void setId(int id) {
	this.id = id;
}

public String getAuctionName() {
	return auctionName;
}

public void setAuctionName(String auctionName) {
	this.auctionName = auctionName;
}


public int getIsApproved() {
	return isApproved;
}

public void setIsApproved(int isApproved) {
	this.isApproved = isApproved;
}

public Date getCreatedTime() {
	return createdTime;
}

public void setCreatedTime(Date createdTime) {
	this.createdTime = createdTime;
}

public Date getLastUpdateTime() {
	return lastUpdateTime;
}

public void setLastUpdateTime(Date lastUpdateTime) {
	this.lastUpdateTime = lastUpdateTime;
}

public Date getAuctionStartTime() {
	return auctionStartTime;
}

public void setAuctionStartTime(Date auctionStartTime) {
	this.auctionStartTime = auctionStartTime;
}

public Date getAuctionEndTime() {
	return auctionEndTime;
}

public void setAuctionEndTime(Date auctionEndTime) {
	this.auctionEndTime = auctionEndTime;
}
}

