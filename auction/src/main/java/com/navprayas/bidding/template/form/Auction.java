package com.navprayas.bidding.template.form;

import java.util.Date;

public class Auction {
	private long id;
	private int version;
	private long auctionId;
	private long bidItemId;
	private long marketId;
	private Date auctionDate;
	private Date startTime;
	private Date endTime;
	private int totalBidItems;
	private int totalSuccessBids;
	private  float totalTradeAmount;
	private String  currency;
	private Date lastUpdateTime;
	private Date createdTime;
	/**
	 * @return the id
	 */
	public long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(long id) {
		this.id = id;
	}
	/**
	 * @return the version
	 */
	public int getVersion() {
		return version;
	}
	/**
	 * @param version the version to set
	 */
	public void setVersion(int version) {
		this.version = version;
	}
	/**
	 * @return the auctionId
	 */
	public long getAuctionId() {
		return auctionId;
	}
	/**
	 * @param auctionId the auctionId to set
	 */
	public void setAuctionId(long auctionId) {
		this.auctionId = auctionId;
	}
	/**
	 * @return the bidItemId
	 */
	public long getBidItemId() {
		return bidItemId;
	}
	/**
	 * @param bidItemId the bidItemId to set
	 */
	public void setBidItemId(long bidItemId) {
		this.bidItemId = bidItemId;
	}
	/**
	 * @return the marketId
	 */
	public long getMarketId() {
		return marketId;
	}
	/**
	 * @param marketId the marketId to set
	 */
	public void setMarketId(long marketId) {
		this.marketId = marketId;
	}
	/**
	 * @return the auctionDate
	 */
	public Date getAuctionDate() {
		return auctionDate;
	}
	/**
	 * @param auctionDate the auctionDate to set
	 */
	public void setAuctionDate(Date auctionDate) {
		this.auctionDate = auctionDate;
	}
	/**
	 * @return the startTime
	 */
	public Date getStartTime() {
		return startTime;
	}
	/**
	 * @param startTime the startTime to set
	 */
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	/**
	 * @return the endTime
	 */
	public Date getEndTime() {
		return endTime;
	}
	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	/**
	 * @return the totalBidItems
	 */
	public int getTotalBidItems() {
		return totalBidItems;
	}
	/**
	 * @param totalBidItems the totalBidItems to set
	 */
	public void setTotalBidItems(int totalBidItems) {
		this.totalBidItems = totalBidItems;
	}
	/**
	 * @return the totalSuccessBids
	 */
	public int getTotalSuccessBids() {
		return totalSuccessBids;
	}
	/**
	 * @param totalSuccessBids the totalSuccessBids to set
	 */
	public void setTotalSuccessBids(int totalSuccessBids) {
		this.totalSuccessBids = totalSuccessBids;
	}
	/**
	 * @return the totalTradeAmount
	 */
	public float getTotalTradeAmount() {
		return totalTradeAmount;
	}
	/**
	 * @param totalTradeAmount the totalTradeAmount to set
	 */
	public void setTotalTradeAmount(float totalTradeAmount) {
		this.totalTradeAmount = totalTradeAmount;
	}
	/**
	 * @return the currency
	 */
	public String getCurrency() {
		return currency;
	}
	/**
	 * @param currency the currency to set
	 */
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	/**
	 * @return the lastUpdateTime
	 */
	public Date getLastUpdateTime() {
		return lastUpdateTime;
	}
	/**
	 * @param lastUpdateTime the lastUpdateTime to set
	 */
	public void setLastUpdateTime(Date lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
	/**
	 * @return the createdTime
	 */
	public Date getCreatedTime() {
		return createdTime;
	}
	/**
	 * @param createdTime the createdTime to set
	 */
	public void setCreatedTime(Date createdTime) {
		this.createdTime = createdTime;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Auction [auctionDate=" + auctionDate + ", auctionId="
				+ auctionId + ", bidItemId=" + bidItemId + ", createdTime="
				+ createdTime + ", currency=" + currency + ", endTime="
				+ endTime + ", lastUpdateTime=" + lastUpdateTime
				+ ", marketId=" + marketId + ", startTime=" + startTime
				+ ", totalBidItems=" + totalBidItems + ", totalSuccessBids="
				+ totalSuccessBids + ", totalTradeAmount=" + totalTradeAmount
				+ "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((auctionDate == null) ? 0 : auctionDate.hashCode());
		result = prime * result + (int) (auctionId ^ (auctionId >>> 32));
		result = prime * result + (int) (bidItemId ^ (bidItemId >>> 32));
		result = prime * result
				+ ((createdTime == null) ? 0 : createdTime.hashCode());
		result = prime * result
				+ ((currency == null) ? 0 : currency.hashCode());
		result = prime * result + ((endTime == null) ? 0 : endTime.hashCode());
		result = prime * result
				+ ((lastUpdateTime == null) ? 0 : lastUpdateTime.hashCode());
		result = prime * result + (int) (marketId ^ (marketId >>> 32));
		result = prime * result
				+ ((startTime == null) ? 0 : startTime.hashCode());
		result = prime * result + totalBidItems;
		result = prime * result + totalSuccessBids;
		result = prime * result + Float.floatToIntBits(totalTradeAmount);
		return result;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Auction other = (Auction) obj;
		if (auctionDate == null) {
			if (other.auctionDate != null)
				return false;
		} else if (!auctionDate.equals(other.auctionDate))
			return false;
		if (auctionId != other.auctionId)
			return false;
		if (bidItemId != other.bidItemId)
			return false;
		if (createdTime == null) {
			if (other.createdTime != null)
				return false;
		} else if (!createdTime.equals(other.createdTime))
			return false;
		if (currency == null) {
			if (other.currency != null)
				return false;
		} else if (!currency.equals(other.currency))
			return false;
		if (endTime == null) {
			if (other.endTime != null)
				return false;
		} else if (!endTime.equals(other.endTime))
			return false;
		if (lastUpdateTime == null) {
			if (other.lastUpdateTime != null)
				return false;
		} else if (!lastUpdateTime.equals(other.lastUpdateTime))
			return false;
		if (marketId != other.marketId)
			return false;
		if (startTime == null) {
			if (other.startTime != null)
				return false;
		} else if (!startTime.equals(other.startTime))
			return false;
		if (totalBidItems != other.totalBidItems)
			return false;
		if (totalSuccessBids != other.totalSuccessBids)
			return false;
		if (Float.floatToIntBits(totalTradeAmount) != Float
				.floatToIntBits(other.totalTradeAmount))
			return false;
		return true;
	}
	
}
	