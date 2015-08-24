package com.navprayas.bidding.common.form;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY, region = "BidSequence" )
@Table(name="bidsequence")
public class BidSequence implements Serializable{
	
	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
    @JoinColumn(name="auctionId", referencedColumnName = "auctionId")
	private Auction auction;
	
	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE}, fetch=FetchType.EAGER)
    @JoinColumn(name="bidItemId", referencedColumnName = "bidItemId")
	private BidItem bidItem;
	
	@Id
	@Column(name="SEQUENCEID")
	@GeneratedValue
	private Long sequenceId;
	
	@Column(name="BIDSPAN")
	private Long bidspan;

	/**
	 * @return the auction
	 */
	public Auction getAuction() {
		return auction;
	}

	/**
	 * @param auction the auction to set
	 */
	public void setAuction(Auction auction) {
		this.auction = auction;
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
	 * @return the sequenceId
	 */
	public Long getSequenceId() {
		return sequenceId;
	}

	/**
	 * @param sequenceId the sequenceId to set
	 */
	public void setSequenceId(Long sequenceId) {
		this.sequenceId = sequenceId;
	}

	/**
	 * @return the bidspan
	 */
	public Long getBidspan() {
		return bidspan;
	}

	/**
	 * @param bidspan the bidspan to set
	 */
	public void setBidspan(Long bidspan) {
		this.bidspan = bidspan;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "BidSequence [auction="
				+ auction.getAuctionId() + ", bidItem=" + ((bidItem != null) ? bidItem.getBidItemId() : "null") + ", sequenceId="
				+ sequenceId + ", bidspan=" + bidspan + "]";
	}
	
}