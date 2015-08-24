package com.navprayas.bidding.common.form;

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
@Table(name="CLOSEDBIDS")

public class CloseBids {
	
	@Id
	@Column(name="CLOSEDBIDID")
	@GeneratedValue
	private Long closeBidId;
		
	@Column(name="BIDAMOUNT")
	private  Double bidAmount;
	
	@Column(name="BIDSTATUS")
	private String bidStatus;
	
	@Column(name="BIDDERNAME")
	private String bidderName;
	
	@Column(name="OBSERVERNAME")
	private String observerName;
	
	@Column(name="BIDUPLOADDATE")
	private Date bidUpLoadTime;
	
	
	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
    @JoinColumn(name="auctionId", referencedColumnName = "auctionId")
	private Auction auction;
	
	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
    @JoinColumn(name="bidItemId", referencedColumnName = "bidItemId")
	private BidItem bidItem ;
	
	/**
	 * @return the closeBidId
	 */
	public Long getCloseBidId() {
		return closeBidId;
	}

	/**
	 * @param closeBidId the closeBidId to set
	 */
	public void setCloseBidId(Long closeBidId) {
		this.closeBidId = closeBidId;
	}

	/**
	 * @return the bidItem
	 */
	public BidItem getBidItem() {
		return bidItem;
	}

	/**
	 * @param bidItem the bidItem to set
	 */
	public void setBidItem(BidItem bidItem) {
		this.bidItem = bidItem;
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
	 * @return the observerName
	 */
	public String getObserverName() {
		return observerName;
	}

	/**
	 * @param observerName the observerName to set
	 */
	public void setObserverName(String observerName) {
		this.observerName = observerName;
	}

	/**
	 * @return the bidUpLoadTime
	 */
	public Date getBidUpLoadTime() {
		return bidUpLoadTime;
	}

	/**
	 * @param bidUpLoadTime the bidUpLoadTime to set
	 */
	public void setBidUpLoadTime(Date bidUpLoadTime) {
		this.bidUpLoadTime = bidUpLoadTime;
	}

	

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CloseBids [closeBidId=" + closeBidId + "]";
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((closeBidId == null) ? 0 : closeBidId.hashCode());
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
		CloseBids other = (CloseBids) obj;
		if (closeBidId == null) {
			if (other.closeBidId != null)
				return false;
		} else if (!closeBidId.equals(other.closeBidId))
			return false;
		return true;
	}
	
	
	
	


}
