package com.navprayas.bidding.template.form;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="BIDITEM")
public class BidItem {
	@Id
	@Column(name="ID")
	@GeneratedValue
	private long id;
	
	@Column(name="VERSION")
	private int version;
	
	@Column(name="LOCATION")
	private String location;
	
	@Column(name="CITY")
	private String city;
	
	@Column(name="MINBIDVALUE")
	private double minBidValue;
	
	@Column(name="MINBIDINCREMENT")
	private double minBidIncrement;
	
	@Column(name="STATUSCODE")
	private String status;
	
	@Column(name="MARKETID")
	private long marketId;
	
	@Column(name="CURRENCY")
	private String currency;
	
	@Column(name="BIDSTARTTIME")
	private Date bidStartTime;
	
	@Column(name="BIDENDTIME")
	private Date bidEndTime;
	
	@Column(name="CURRENTBIDVALUE")
	private double currentBidValue;
	
	@Column(name="CURRENTBIDDER")
	private String currentBidder;


	/**
	 * @return the location
	 */
	public String getLocation() {
		return location;
	}
	/**
	 * @param location the location to set
	 */
	public void setLocation(String location) {
		this.location = location;
	}
	/**
	 * @return the city
	 */
	public String getCity() {
		return city;
	}
	/**
	 * @param city the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}

	/**
	 * @return the minBidValue
	 */
	public double getMinBidValue() {
		return minBidValue;
	}
	/**
	 * @param minBidValue the minBidValue to set
	 */
	public void setMinBidValue(double minBidValue) {
		this.minBidValue = minBidValue;
	}
	/**
	 * @return the minBidIncrement
	 */
	public double getMinBidIncrement() {
		return minBidIncrement;
	}
	/**
	 * @param minBidIncrement the minBidIncrement to set
	 */
	public void setMinBidIncrement(double minBidIncrement) {
		this.minBidIncrement = minBidIncrement;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
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
	 * @return the bidStartTime
	 */
	public Date getBidStartTime() {
		return bidStartTime;
	}
	/**
	 * @param bidStartTime the bidStartTime to set
	 */
	public void setBidStartTime(Date bidStartTime) {
		this.bidStartTime = bidStartTime;
	}
	/**
	 * @return the bidEndTime
	 */
	public Date getBidEndTime() {
		return bidEndTime;
	}
	/**
	 * @param bidEndTime the bidEndTime to set
	 */
	public void setBidEndTime(Date bidEndTime) {
		this.bidEndTime = bidEndTime;
	}

	/**
	 * @return the currentBidValue
	 */
	public double getCurrentBidValue() {
		return currentBidValue;
	}
	/**
	 * @param currentBidValue the currentBidValue to set
	 */
	public void setCurrentBidValue(double currentBidValue) {
		this.currentBidValue = currentBidValue;
	}
	/**
	 * @return the currentBidder
	 */
	public String getCurrentBidder() {
		return currentBidder;
	}
	/**
	 * @param currentBidder the currentBidder to set
	 */
	public void setCurrentBidder(String currentBidder) {
		this.currentBidder = currentBidder;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "BidItem [bidEndTime=" + bidEndTime + ", bidStartTime="
				+ bidStartTime + ", city=" + city + ", currency=" + currency
				+ ", currentBidValue=" + currentBidValue + ", currentBidder="
				+ currentBidder + ", location=" + location + ", marketId=" + marketId
				+ ", minBidIncrement="	+ minBidIncrement + ", minBidValue=" + minBidValue
				+ ", status=" + status + "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((bidEndTime == null) ? 0 : bidEndTime.hashCode());
		result = prime * result
				+ ((bidStartTime == null) ? 0 : bidStartTime.hashCode());
		result = prime * result + ((city == null) ? 0 : city.hashCode());
		result = prime * result
				+ ((currency == null) ? 0 : currency.hashCode());
		long temp;
		temp = Double.doubleToLongBits(currentBidValue);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result
				+ ((currentBidder == null) ? 0 : currentBidder.hashCode());
		result = prime * result + (int) (marketId ^ (marketId >>> 32));
		temp = Double.doubleToLongBits(minBidIncrement);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		temp = Double.doubleToLongBits(minBidValue);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((status == null) ? 0 : status.hashCode());
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
		BidItem other = (BidItem) obj;
		if (bidEndTime == null) {
			if (other.bidEndTime != null)
				return false;
		} else if (!bidEndTime.equals(other.bidEndTime))
			return false;
		if (bidStartTime == null) {
			if (other.bidStartTime != null)
				return false;
		} else if (!bidStartTime.equals(other.bidStartTime))
			return false;
		if (city == null) {
			if (other.city != null)
				return false;
		} else if (!city.equals(other.city))
			return false;
		if (currency == null) {
			if (other.currency != null)
				return false;
		} else if (!currency.equals(other.currency))
			return false;
		if (Double.doubleToLongBits(currentBidValue) != Double
				.doubleToLongBits(other.currentBidValue))
			return false;
		if (currentBidder == null) {
			if (other.currentBidder != null)
				return false;
		} else if (!currentBidder.equals(other.currentBidder))
			return false;
		if (location == null) {
			if (other.location != null)
				return false;
		} else if (!location.equals(other.location))
			return false;
		if (marketId != other.marketId)
			return false;
		if (Double.doubleToLongBits(minBidIncrement) != Double
				.doubleToLongBits(other.minBidIncrement))
			return false;
		if (Double.doubleToLongBits(minBidValue) != Double
				.doubleToLongBits(other.minBidValue))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		return true;
	}
	
	
	
	
}
	