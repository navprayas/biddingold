package com.navprayas.bidding.common.form;

import java.sql.Blob;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="AUTOBIDS")
public class AutoBids {

	@Id		
	@Column(name="AUTOBIDID")
	@GeneratedValue
	private Long autoBidId;
	
	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
	@JoinColumn(name="AUCTIONID", referencedColumnName = "AUCTIONID")
	private Auction auction;
	
	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
    @JoinColumn(name="bidItemId", referencedColumnName = "bidItemId")
	private BidItem bidItemId;
	

	@Column(name="BIDAMOUNT")
	private Double bidAmount;
	
	@Column(name="CURRENCY")
	private String currency;
	
	@Column(name="BIDTIME")
	private Date bidTime;
	

	@Column(name="BIDSTATUS")
	private String bidStatus;
	

	@Column(name="BIDDERNAME")
	private String bidderName;
	
	@Column(name="COMMENTS")
	private String comments;
	
	/**
	 * @return the autoBidId
	 */
	public Long getAutoBidId() {
		return autoBidId;
	}


	/**
	 * @param autoBidId the autoBidId to set
	 */
	public void setAutoBidId(Long autoBidId) {
		this.autoBidId = autoBidId;
	}


	/**
	 * @return the auction
	 */
	public Auction getAuction() {
		return auction;
	}


	/**
	 * @param auctionId the auction to set
	 */
	public void setAuction(Auction auction) {
		this.auction = auction;
	}


	/**
	 * @return the lotId
	 */
	public BidItem getBidItemId() {
		return bidItemId;
	}


	/**
	 * @param lotId the lotId to set
	 */
	public void setBidItemId(BidItem bidItemId) {
		this.bidItemId = bidItemId;
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


	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "AutoBids [autoBidId=" + autoBidId + "]";
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((auction.getAuctionId() == null) ? 0 : auction.getAuctionId().intValue());
		result = prime * result
				+ ((autoBidId == null) ? 0 : autoBidId.hashCode());		
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
		AutoBids other = (AutoBids) obj;
		if (auction.getAuctionId() == null) {
			if (other.auction.getAuctionId() != null)
				return false;
		} else if (!auction.getAuctionId().equals(other.auction.getAuctionId()))
			return false;
		if (autoBidId == null) {
			if (other.autoBidId != null)
				return false;
		} else if (!autoBidId.equals(other.autoBidId))
			return false;
		return true;
	}


	
}
