package com.navprayas.bidding.common.form;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="BIDS")
public class Bids {
	
	@Id
	@Column(name="BIDID")
	private Long bidId;
	
	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch=FetchType.EAGER)
    @JoinColumn(name="bidItemId", referencedColumnName = "bidItemId")
	private BidItem bidItem;
	
	@Column(name="AUCTIONID")
	private Long auctionId;
		
	
	@Column(name="BIDDERNAME")
	private String bidderName;
	
	@Column(name="BIDAMOUNT")
	private Double bidAmount;
	
	@Column(name="CURRENCY")
	private String currency;
	
	@Column(name="BIDTIME")
	private Date bidTime;
	
	@Column(name="BIDSTATUS")
	private String bidStatus;
	
	
	@Column(name="COMMENTS")
	private String comments;
	
	@Column(name="BIDTYPE")
	private Character bidType;
	
	transient Double bidAmount2;
	transient Double bidAmount3;
	transient String bidderName2;
	transient String bidderName3;
	
	transient Double salesPrice;
	transient Double totalSalesPrice;

	public Character getBidType() {
		return bidType;
	}

	public void setBidType(Character bidType) {
		this.bidType = bidType;
	}

	/**
	 * @return the salesPrice
	 */
	public Double getSalesPrice() {
		return salesPrice;
	}

	/**
	 * @param salesPrice the salesPrice to set
	 */
	public void setSalesPrice(Double salesPrice) {
		this.salesPrice = salesPrice;
	}
	
	/**
	 * @return the totalSalesPrice
	 */
	public Double getTotalSalesPrice() {
		return totalSalesPrice;
	}

	/**
	 * @param totalSalesPrice the totalSalesPrice to set
	 */
	public void setTotalSalesPrice(Double totalSalesPrice) {
		this.totalSalesPrice = totalSalesPrice;
	}

	/**
	 * @return the bidId
	 */
	public Long getBidId() {
		return bidId;
	}

	/**
	 * @param bidId the bidId to set
	 */
	public void setBidId(Long bidId) {
		this.bidId = bidId;
	}

	/**
	 * @return the bidItemId
	 */
	public BidItem getBidItem() {
		return bidItem;
	}

	/**
	 * @param bidItemId the bidItemId to set
	 */
	public void setBidItem(BidItem bidItem) {
		this.bidItem = bidItem;
	}

	/**
	 * @return the auctionId
	 */
	public Long getAuctionId() {
		return auctionId;
	}

	/**
	 * @param auctionId the auctionId to set
	 */
	public void setAuctionId(Long auctionId) {
		this.auctionId = auctionId;
	}

	/**
	 * @return the bidderName
	 */
	public String getBidderName() {
		return bidderName;
	}

	/**
	 * @param bidderName the bidderName to set
	 */
	public void setBidderName(String bidderName) {
		this.bidderName = bidderName;
	}

	/**
	 * @return the bidAmount
	 */
	public Double getBidAmount() {
		return bidAmount;
	}

	/**
	 * @param bidAmount the bidAmount to set
	 */
	public void setBidAmount(Double bidAmount) {
		this.bidAmount = bidAmount;
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
	 * @return the bidTime
	 */
	public Date getBidTime() {
		return bidTime;
	}

	/**
	 * @param bidTime the bidTime to set
	 */
	public void setBidTime(Date bidTime) {
		this.bidTime = bidTime;
	}

	/**
	 * @return the bidStatus
	 */
	public String getBidStatus() {
		return bidStatus;
	}

	/**
	 * @param bidStatus the bidStatus to set
	 */
	public void setBidStatus(String bidStatus) {
		this.bidStatus = bidStatus;
	}

	 

	/**
	 * @return the comments
	 */
	public String getComments() {
		return comments;
	}

	/**
	 * @param comments the comments to set
	 */
	public void setComments(String comments) {
		this.comments = comments;
	}

	/**
	 * @return the bidAmount2
	 */
	public Double getBidAmount2() {
		return bidAmount2;
	}

	/**
	 * @param bidAmount2 the bidAmount2 to set
	 */
	public void setBidAmount2(Double bidAmount2) {
		this.bidAmount2 = bidAmount2;
	}

	/**
	 * @return the bidAmount3
	 */
	public Double getBidAmount3() {
		return bidAmount3;
	}

	/**
	 * @param bidAmount3 the bidAmount3 to set
	 */
	public void setBidAmount3(Double bidAmount3) {
		this.bidAmount3 = bidAmount3;
	}

	/**
	 * @return the bidderName2
	 */
	public String getBidderName2() {
		return bidderName2;
	}

	/**
	 * @param bidderName2 the bidderName2 to set
	 */
	public void setBidderName2(String bidderName2) {
		this.bidderName2 = bidderName2;
	}

	/**
	 * @return the bidderName3
	 */
	public String getBidderName3() {
		return bidderName3;
	}

	/**
	 * @param bidderName3 the bidderName3 to set
	 */
	public void setBidderName3(String bidderName3) {
		this.bidderName3 = bidderName3;
	}

	@Override
	public String toString() {
		return "Bids [bidId=" + bidId + "]";
	}

	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((bidId == null) ? 0 : bidId.hashCode());
		return result;
	}

	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Bids other = (Bids) obj;
		if (bidId == null) {
			if (other.bidId != null)
				return false;
		} else if (!bidId.equals(other.bidId))
			return false;
		return true;
	}

	
}
