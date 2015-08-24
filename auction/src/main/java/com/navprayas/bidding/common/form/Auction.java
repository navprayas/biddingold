package com.navprayas.bidding.common.form;



import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;


@Entity
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY, region = "Auction" )
@Table(name="AUCTION")
public class Auction implements Serializable{

	@Id
	@Column(name="AUCTIONID")
	private Long auctionId;

	@Column(name="LASTUPDATETIME")
	private Date lastUpdateTime;	

	@Column(name="CREATEDTIME")
	private Date createdTime;
	
	@Column(name="AUCTIONSTARTTIME")
	private Date auctionStartTime;
	
	@Column(name="AUCTIONENDTIME")
	private Date auctionEndTime;
	
	@Column(name="STATUS")
	private String status;
	
	@Column(name="NAME")
	private String name;
	
	@Column(name="ISAPPROVED")
	private String isApproved;

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


	


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getIsApproved() {
		return isApproved;
	}


	public void setIsApproved(String isApproved) {
		this.isApproved = isApproved;
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Auction [auctionId=" + auctionId + "]";
	}


	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((auctionId == null) ? 0 : auctionId.hashCode());
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
		if (auctionId == null) {
			if (other.auctionId != null)
				return false;
		} else if (!auctionId.equals(other.auctionId))
			return false;
		return true;
	}


	public Date getAuctionStartTime() {
		return auctionStartTime;
	}


	public void setAuctionStartTime(Date auctionStartTime) {
		this.auctionStartTime = auctionStartTime;
	}


	public Date getAuctionEndTime() {
		return auctionEndTime;
	}


	public void setAuctionEndTime(Date auctionEndTime) {
		this.auctionEndTime = auctionEndTime;
	}


}
	