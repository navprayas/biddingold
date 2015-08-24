package com.navprayas.bidding.common.form;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.navprayas.bidding.common.bean.Bidder;
import com.navprayas.bidding.utility.comparator.BidderAmountComparator;

@Entity
@Table(name="BIDITEM")
public class BidItem implements Serializable{

	private static final long serialVersionUID = -6009206982668458513L;

	@Id
	@Column(name="BIDITEMID")
	private Long bidItemId;	
	
	@Column(name="SERIALNUMBER")
	private String serialNo;
	
	@Column(name="NAME")
	private String name = "";

	@Column(name="LOCATION")
	private String location = "";
	
	@Column(name="CITY")
	private String city = "";
	
	@Column(name="ZONE")
	private String zone = "";
	
	@Column(name="MINBIDPRICE")
	private Double minBidPrice;
	
	@Column(name="MINBIDINCREMENT")
	private Double minBidIncrement;
	
	@Column(name="BIDSTARTTIME")
	private Date bidStartTime;
	
	@Transient
	private long seqId;
	
	@Column(name="BIDENDTIME")
	private Date bidEndTime;
	
	@Column(name="INITIALSTARTTIME")
	private Integer initialStartTime;
	
	@Column(name="TIMEEXTN")
	private Integer timeExtAfterBid;
	
	@Column(name="STATUSCODE")
	private String statusCode;
	
	@Column(name="LASTUPDATETIME")
	private Date lastUpDateTime;

	@Column(name="CREATEDTIME")
	private Date createdTime;
	
	@Column(name="CURRENTMARKETPRICE")
	private Double currentMarketPrice;	
	
	@Column(name="CURRENCY")
	private String currency;

	@Column(name="isProcessed")
	private String isProcessed;
	
	@Column(name="BIDDERNAME")
	private String bidderName;

	@Transient
	private String status;

	@Transient
	private long timeLeft;
	
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
		
	/**
	 * @return the isProcessed
	 */
	public String getIsProcessed() {
		return isProcessed;
	}
	/**
	 * @param isProcessed the isProcessed to set
	 */
	public void setIsProcessed(String isProcessed) {
		this.isProcessed = isProcessed;
	}
	@Column(name="AUTOBIDID")	
	private Long AUTOBIDID;

	/**
	 * @return the aUTOBIDID
	 */
	public Long getAUTOBIDID() {
		return AUTOBIDID;
	}
	/**
	 * @param aUTOBIDID the aUTOBIDID to set
	 */
	public void setAUTOBIDID(Long aUTOBIDID) {
		AUTOBIDID = aUTOBIDID;
	}

	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch=FetchType.EAGER )
    @JoinColumn(name="categoryid", referencedColumnName = "categoryid")
	private Category category;
	
	@Column(name="AUCTIONID")
	private Long auctionId;
	
	@OneToMany( cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch=FetchType.EAGER)
    @JoinColumn(name="bidItemId", referencedColumnName = "bidItemId")
	private List<ItemLot> itemLots = new ArrayList<ItemLot>();

	@OneToMany( cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name="bidItemId", referencedColumnName = "bidItemId")
	private List<AutoBids> autoBids = new ArrayList<AutoBids>();  

	@Column(name="autoBidderName")
	private String autoBidderName;
	
	@Column(name="autoBidId")
	private Long currentAutoBidId;
	
	@Transient
	private String unit;
	
	@Transient
	private boolean autoBidFlag;
	
	@Transient
	private Double amountAutoBid;
	
	@Transient
	private Integer totalQuantity;
	
	@Transient
	private List<Bidder> currentBiddersList = Collections.synchronizedList(new ArrayList<Bidder>());

	@Transient
	private long bidSpan;

	public long getBidSpan() {
		return bidSpan;
	}
	public void setBidSpan(long bidSpan) {
		this.bidSpan = bidSpan;
	}
	public List<Bidder> getCurrentBidderList()
	{
		Collections.sort(currentBiddersList, new BidderAmountComparator());
		return currentBiddersList;
	}
	
	public void addBidder(Bidder bidder)
	{
		if(currentBiddersList.contains(bidder))
		{
			//logger.debug("Already Present: " + bidder);
			currentBiddersList.set(currentBiddersList.indexOf(bidder), bidder);
		}
		else
		{
			//logger.debug("Adding new: " + bidder);
			currentBiddersList.add(bidder);
		}
	}
	public void setTotalQuantity(Integer quantity)
	{
		int total = 0;
		for(ItemLot itemLot : itemLots)
		{
			total += itemLot.getQuantity();
		}
		totalQuantity = total;
	}
	public Integer getTotalQuantity()
	{
		int total = 0;
		for(ItemLot itemLot : itemLots)
		{
			total += itemLot.getQuantity();
		}
		totalQuantity = total;
		return totalQuantity;
		
	}
	
	public String getUnit()
	{
		for(ItemLot itemLot : itemLots)
		{
			unit = itemLot.getUnit();
			break;
		}
		return unit;
	}
	
	public void setUnit(String unit1)
	{
		for(ItemLot itemLot : itemLots)
		{
			unit = itemLot.getUnit();
			break;
		}
	}	
	
	public List<ItemLot> getItemLots() {
		return itemLots;
	}


	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public void setItemLots(List<ItemLot> itemLots) {
		this.itemLots = itemLots;
	}
	
	public String getBidderName() {
		return bidderName;
	}
	public void setBidderName(String bidderName) {
		this.bidderName = bidderName;
	}

	public Long getAuctionId() {
		return auctionId;
	}


	public void setAuctionId(Long auctionId) {
		this.auctionId = auctionId;
	}	
	public Long getBidItemId() {
		return bidItemId;
	}

	public void setBidItemId(Long bidItemId) {
		this.bidItemId = bidItemId;
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

	public Integer getInitialStartTime() {
		return initialStartTime;
	}


	public void setInitialStartTime(Integer initialStartTime) {
		this.initialStartTime = initialStartTime;
	}


	public Integer getTimeExtAfterBid() {
		return timeExtAfterBid;
	}


	public void setTimeExtAfterBid(Integer timeExtAfterBid) {
		this.timeExtAfterBid = timeExtAfterBid;
	}


	public String getStatusCode() {
		return statusCode;
	}


	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

	public Date getLastUpDateTime() {
		return lastUpDateTime;
	}


	public void setLastUpDateTime(Date lastUpDateTime) {
		this.lastUpDateTime = lastUpDateTime;
	}

	public Category getCategory() {
		return category;
	}


	public void setCategory(Category category) {
		this.category = category;
	}

	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((bidItemId == null) ? 0 : bidItemId.hashCode());
		return result;
	}


	@Override
	public String toString() {
		return "BidItem [bidItemId=" + bidItemId + "]";
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BidItem other = (BidItem) obj;
		if (bidItemId == null) {
			if (other.bidItemId != null)
				return false;
		} else if (!bidItemId.equals(other.bidItemId))
			return false;
		return true;
	}
	/**
	 * @param autoBids the autoBids to set
	 */
	public void setAutoBids(List<AutoBids> autoBids) {
		this.autoBids = autoBids;
	}
	/**
	 * @return the autoBids
	 */
	public List<AutoBids> getAutoBids() {
		return autoBids;
	}
	public void setAutoBidFlag(boolean autoBidFlag) {
		this.autoBidFlag = autoBidFlag;
	}
	public boolean isAutoBidFlag() {
		return autoBidFlag;
	}
	public void setAmountAutoBid(Double f) {
		this.amountAutoBid = f;
	}
	public Double getAmountAutoBid() {
		return amountAutoBid;
	}
	public void setCurrentAutoBidId(Long currentAutoBidId) {
		this.currentAutoBidId = currentAutoBidId;
	}
	public Long getCurrentAutoBidId() {
		return currentAutoBidId;
	}
	public void setCurrentMarketPrice(Double currentMarketPrice) {
		this.currentMarketPrice = currentMarketPrice;
	}
	public Double getCurrentMarketPrice() {
		return currentMarketPrice;
	}

	public void setTimeLeft(long timeLeft) {
		this.timeLeft = timeLeft;
	}
	
	public long getTimeLeft() {
		if(bidEndTime == null) return timeLeft;
		long bEndTime = TimeUnit.MILLISECONDS.toSeconds(bidEndTime.getTime());
		long lUpdateTime = TimeUnit.MILLISECONDS.toSeconds(lastUpDateTime.getTime());
		long currTime = TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis());
		if(lUpdateTime > bEndTime - timeExtAfterBid) {
			return currTime - lUpdateTime + timeExtAfterBid;
		}
		return ( bEndTime - currTime > 0) ?  bEndTime - currTime : 0;
	}
	
	public void setAutoBidderName(String autoBidderName) {
		this.autoBidderName = autoBidderName;
	}
	public String getAutoBidderName() {
		return autoBidderName;
	}

	/**
	 * @param seqId the seqId to set
	 */
	public void setSeqId(long seqId) {
		this.seqId = seqId;
	}
	/**
	 * @return the seqId
	 */
	public long getSeqId() {
		return seqId;
	}
	
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	public Date getCreatedTime() {
		return createdTime;
	}

	

}
	