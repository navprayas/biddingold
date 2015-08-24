package com.navprayas.bidding.fileupload.entity;


import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;



@Entity
@Table(name="auction")
public class FileUploadEntity {

	@Transient
    private MultipartFile file;

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	
	@Transient
	String createdTimeFormat;
	
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

	@Transient
	String lastUpdateTimeFormat;
	
	@Transient
	String auctionStartTimeFormat;
	
	@Transient
	String auctionEndTimeFormat;
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="auctionId")
	private int auctionId;
	

	
	public int getAuctionId() {
		return auctionId;
	}

	public void setAuctionId(int auctionId) {
		this.auctionId = auctionId;
	}
	@Column (name="status")
	private String status;

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	@Column(name="isApproved")
	private String isApproved;

	public String getIsApproved() {
		return isApproved;
	}

	public void setIsApproved(String isApproved) {
		this.isApproved = isApproved;
	}
	@Column(name="name")
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
 
	@Column(name="createdTime")
	private Date createdTime;

	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	
	@Column(name="lastupDateTime")
	private Date lastupDateTime=null;

	public Date getLastupDateTime() {
		return lastupDateTime;
	}

	public void setLastupDateTime(Date lastupDateTime) {
		this.lastupDateTime = lastupDateTime;
	}
	
	@Column(name="auctionStartTime")
	private Date auctionStartTime=null;

	public Date getAuctionStartTime() {
		return auctionStartTime;
	}

	public void setAuctionStartTime(Date auctionStartTime) {
		this.auctionStartTime = auctionStartTime;
	}
	
	@Column(name="auctionEndTime")
	private Date auctionEndTime=null;

	public Date getAuctionEndTime() {
		return auctionEndTime;
	}

	public void setAuctionEndTime(Date auctionEndTime) {
		this.auctionEndTime = auctionEndTime;
	}
}
