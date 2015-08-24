package com.navprayas.bidding.common.form;


import java.sql.Blob;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name="BIDITEMEXT")

public class BidItemExt {
	
	@Id
	@Column(name="ID")
	@GeneratedValue
	private Long id;
	
	@Column(name="VERSION")
	@GeneratedValue
	private Integer version;
	
	@Column(name="BIDITEMEXTID")
	private Long bidItemExtId;
	
	@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
    @JoinColumn(name="biditemid")
	private BidItem  bidItem;
	
	@Column(name="PRODUCTDESCRIPTION")
	private String productDescription;
	
	@Column(name="IMAGE")
	private Blob image;
	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * @return the version
	 */
	public Integer getVersion() {
		return version;
	}
	/**
	 * @param version the version to set
	 */
	public void setVersion(Integer version) {
		this.version = version;
	}
	/**
	 * @return the bidItemExtId
	 */
	public Long getBidItemExtId() {
		return bidItemExtId;
	}
	/**
	 * @param bidItemExtId the bidItemExtId to set
	 */
	public void setBidItemExtId(Long bidItemExtId) {
		this.bidItemExtId = bidItemExtId;
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
	 * @return the productDescription
	 */
	public String getProductDescription() {
		return productDescription;
	}
	/**
	 * @param productDescription the productDescription to set
	 */
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	/**
	 * @return the image
	 */
	public Blob getImage() {
		return image;
	}
	/**
	 * @param image the image to set
	 */
	public void setImage(Blob image) {
		this.image = image;
	}
	
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "BidItemExt [bidItemExtId=" + bidItemExtId + "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((bidItemExtId == null) ? 0 : bidItemExtId.hashCode());
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
		BidItemExt other = (BidItemExt) obj;
		if (bidItemExtId == null) {
			if (other.bidItemExtId != null)
				return false;
		} else if (!bidItemExtId.equals(other.bidItemExtId))
			return false;
		return true;
	}
	
	
}
