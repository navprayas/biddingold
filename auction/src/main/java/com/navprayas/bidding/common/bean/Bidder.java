package com.navprayas.bidding.common.bean;

import java.util.Date;

public class Bidder {

	private String bidderName;
	
	private double currentBidAmount;
	
	private boolean isAutoBid;
	
	private Date biddingTime = new Date(); 
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Bidder [bidderName=" + bidderName + ", currentBidAmount="
				+ currentBidAmount + ", isAutoBid=" + isAutoBid
				+ ", autoBidMaxAnount=" + autoBidMaxAnount + "]";
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
	 * @return the currentBidAmount
	 */
	public double getCurrentBidAmount() {
		return currentBidAmount;
	}

	/**
	 * @param currentBidAmount the currentBidAmount to set
	 */
	public void setCurrentBidAmount(double currentBidAmount) {
		this.currentBidAmount = currentBidAmount;
	}

	/**
	 * @return the isAutoBid
	 */
	public boolean isAutoBid() {
		return isAutoBid;
	}

	/**
	 * @param isAutoBid the isAutoBid to set
	 */
	public void setAutoBid(boolean isAutoBid) {
		this.isAutoBid = isAutoBid;
	}

	/**
	 * @return the autoBidMaxAnount
	 */
	public Double getAutoBidMaxAnount() {
		return autoBidMaxAnount;
	}

	/**
	 * @param autoBidMaxAnount the autoBidMaxAnount to set
	 */
	public void setAutoBidMaxAnount(Double autoBidMaxAnount) {
		this.autoBidMaxAnount = autoBidMaxAnount;
	}

	private Double autoBidMaxAnount;

	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((bidderName == null) ? 0 : bidderName.hashCode());
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
		Bidder other = (Bidder) obj;
		if (bidderName == null) {
			if (other.bidderName != null)
				return false;
		} else if (!bidderName.equals(other.bidderName))
			return false;
		return true;
	}

	/**
	 * @param biddingTime the biddingTime to set
	 */
	public void setBiddingTime(Date biddingTime) {
		this.biddingTime = biddingTime;
	}

	/**
	 * @return the biddingTime
	 */
	public Date getBiddingTime() {
		return biddingTime;
	}
	
}
