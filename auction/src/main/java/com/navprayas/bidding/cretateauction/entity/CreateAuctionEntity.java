package com.navprayas.bidding.cretateauction.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="auction")
public class CreateAuctionEntity {
	@Transient
	String createdTimeFormat;
	

	public String getCreatedTimeFormat() {
		return createdTimeFormat;
	}

	public void setCreatedTimeFormat(String createdTimeFormat) {
		this.createdTimeFormat = createdTimeFormat;
	}

	

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "auctionId")
	private int auctionId;

	public int getAuctionId() {
		return auctionId;
	}

	public void setAuctionId(int auctionId) {
		this.auctionId = auctionId;
	}

	@Column(name = "status")
	private String status;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "isApproved")
	private String isApproved;

	public String getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(String isApproved) {
		this.isApproved = isApproved;
	}

	@Column(name = "name")
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "createdTime")
	private Date createdTime;

	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

}