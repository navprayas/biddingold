package com.navprayas.bidding.template.form;

import java.sql.Blob;

public class BidItemExt {
	private long id;
	private int version;
	private long bidItemExtId;
	private long  bidItemId;
	private String productDescription;
	private Blob image;
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
	 * @return the bidItemExtId
	 */
	public long getBidItemExtId() {
		return bidItemExtId;
	}
	/**
	 * @param bidItemExtId the bidItemExtId to set
	 */
	public void setBidItemExtId(long bidItemExtId) {
		this.bidItemExtId = bidItemExtId;
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
		return "BidItemExt [bidItemExtId=" + bidItemExtId + ", bidItemId="
				+ bidItemId + ", image=" + image + ", productDescription="
				+ productDescription + "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (bidItemExtId ^ (bidItemExtId >>> 32));
		result = prime * result + (int) (bidItemId ^ (bidItemId >>> 32));
		result = prime
				* result
				+ ((productDescription == null) ? 0 : productDescription
						.hashCode());
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
		if (bidItemExtId != other.bidItemExtId)
			return false;
		if (bidItemId != other.bidItemId)
			return false;
		if (productDescription == null) {
			if (other.productDescription != null)
				return false;
		} else if (!productDescription.equals(other.productDescription))
			return false;
		return true;
	}
	
}
