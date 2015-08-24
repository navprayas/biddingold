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
@Table(name = "biditem")
public class BidItemEntity {
	@Transient
	private MultipartFile file;

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}
	@Transient
	Long selectedAuctionId;
	
	
	public Long getSelectedAuctionId() {
		return selectedAuctionId;
	}

	public void setSelectedAuctionId(Long selectedAuctionId) {
		this.selectedAuctionId = selectedAuctionId;
	}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "bidItemId")
	private int bidItemId;
	@Column(name = "auctionId")
	private Long auctionId;
	@Column(name = "name")
	private String name;
	@Column(name = "location")
	private String location;
	@Column(name = "city")
	private String city;
	@Column(name = "zone")
	private String zone;
	@Column(name = "minBidPrice")
	private Double minBidPrice;
	@Column(name = "minBidIncrement")
	private Double minBidIncrement;
	@Column(name = "bidStartTime")
	private Date bidStartTime;
	@Column(name = "bidEndTime")
	private Date bidEndTime;
	@Column(name = "timeExtn")
	private int timeExtn;
	@Column(name = "statusCode")
	private String statusCode;
	@Column(name = "categoryId")
	private int categoryId;
	@Column(name = "marketId")
	private int marketId;
	@Column(name = "currency")
	private String currency;
	@Column(name = "lastUpdateTime")
	private Date lastUpdateTime;
	@Column(name = "createdTime")
	private Date createdTime;
	@Column(name = "autobidid")
	private int autobidid;
	@Column(name = "autobiddername")
	private String autobiddername;
	@Column(name = "Biddername")
	private String Biddername;
	@Column(name = "serialNumber")
	private String serialNumber;
	@Column(name = "currentMarketPrice")
	private Double currentMarketPrice;
	@Column(name = "isProcessed")
	private String isProcessed;
	@Column(name = "initialStartTime")
	private int initialStartTime;
	@Column(name = "document")
	private Long document;
	@Transient
	@Column(name="main1")
	private String main1;
	@Transient
	@Column(name="desc1")
	private String desc1;
	@Transient
	@Column(name="nocolum")
	private String nocolum;

	public int getBidItemId() {
		return bidItemId;
	}

	public void setBidItemId(int bidItemId) {
		this.bidItemId = bidItemId;
	}

	public Long getAuctionId() {
		return auctionId;
	}

	public void setAuctionId(Long auctionId) {
		this.auctionId = auctionId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getZone() {
		return zone;
	}

	public void setZone(String zone) {
		this.zone = zone;
	}

	public Double getMinBidPrice() {
		return minBidPrice;
	}

	public void setMinBidPrice(Double minBidPrice) {
		this.minBidPrice = minBidPrice;
	}

	public Double getMinBidIncrement() {
		return minBidIncrement;
	}

	public void setMinBidIncrement(Double minBidIncrement) {
		this.minBidIncrement = minBidIncrement;
	}

	public Date getBidStartTime() {
		return bidStartTime;
	}

	public void setBidStartTime(Date bidStartTime) {
		this.bidStartTime = bidStartTime;
	}

	public Date getBidEndTime() {
		return bidEndTime;
	}

	public void setBidEndTime(Date bidEndTime) {
		this.bidEndTime = bidEndTime;
	}

	public int getTimeExtn() {
		return timeExtn;
	}

	public void setTimeExtn(int timeExtn) {
		this.timeExtn = timeExtn;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public int getMarketId() {
		return marketId;
	}

	public void setMarketId(int marketId) {
		this.marketId = marketId;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}

	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}

	public Date getCreatedTime() {
		return createdTime;
	}

	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}

	public int getAutobidid() {
		return autobidid;
	}

	public void setAutobidid(int autobidid) {
		this.autobidid = autobidid;
	}

	public String getAutobiddername() {
		return autobiddername;
	}

	public void setAutobiddername(String autobiddername) {
		this.autobiddername = autobiddername;
	}

	public String getBiddername() {
		return Biddername;
	}

	public void setBiddername(String biddername) {
		Biddername = biddername;
	}

	public String getSerialNumber() {
		return serialNumber;
	}

	public void setSerialNumber(String serialNumber) {
		this.serialNumber = serialNumber;
	}

	public Double getCurrentMarketPrice() {
		return currentMarketPrice;
	}

	public void setCurrentMarketPrice(Double currentMarketPrice) {
		this.currentMarketPrice = currentMarketPrice;
	}

	public String getIsProcessed() {
		return isProcessed;
	}

	public void setIsProcessed(String isProcessed) {
		this.isProcessed = isProcessed;
	}

	public int getInitialStartTime() {
		return initialStartTime;
	}

	public void setInitialStartTime(int initialStartTime) {
		this.initialStartTime = initialStartTime;
	}

	public Long getDocument() {
		return document;
	}

	public void setDocument(Long document) {
		this.document = document;
	}

	public String getMain1() {
		return main1;
	}

	public void setMain1(String main1) {
		this.main1 = main1;
	}

	public String getDesc1() {
		return desc1;
	}

	public void setDesc1(String desc1) {
		this.desc1 = desc1;
	}

	public String getNocolum() {
		return nocolum;
	}

	public void setNocolum(String nocolum) {
		this.nocolum = nocolum;
	}
			
}