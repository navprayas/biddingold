package com.navprayas.bidding.common.form;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY, region = "BidderCategory" )
@Table(name="BidderCategory")
public class BidderCategory implements Serializable{

	private static final long serialVersionUID = -6312688222365987584L;
	
	@Id
	private BidderCategoryId bidderCategoryId;
	
	public BidderCategoryId getBidderCategoryId() {
		return bidderCategoryId;
	}

	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
	@JoinColumn(name="AUCTIONID", referencedColumnName = "AUCTIONID")
	private Auction auction;
	
	public Auction getAuction() {
		return auction;
	}

	public void setAuction(Auction auction) {
		this.auction = auction;
	}

	@Override
	public String toString() {
		return "BidderCategory [auction="
						+ auction.getAuctionId() + "]";
	}
	
	public Long getCategoryId() {
		return bidderCategoryId.getCategory().getCategoryId();
	}
	
	public String getUserName() {
		return bidderCategoryId.getUser().getUsername();
	}
	
	public void setBidderCategoryId(BidderCategoryId bidderCategoryId) {
		this.bidderCategoryId = bidderCategoryId;
	}

}
