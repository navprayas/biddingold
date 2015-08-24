package com.navprayas.bidding.common.dto;

public class ReportSummary2 {

	private Long categoryId;
	private String categoryName;
	
	private Integer totalLotsForSale;
	private Integer totalLotsquantityForSale;
	
	private Integer totalActualSoldLots;
	private Integer totalActualSoldQunatity;
	private Double totalActualSoldAmount;
	
	private Double avergeAmount;
	
	private Integer totalUnsoldBiddedLots;
	private Integer totalUnsoldBiddedQuantity;
	
	private Integer totalUnsoldUnBiddedLots;
	private Integer totalUnsoldUnBiddedQuantity;
	
	/**
	 * @return the categoryId
	 */
	public Long getCategoryId() {
		return categoryId;
	}
	/**
	 * @return the categoryName
	 */
	public String getCategoryName() {
		return categoryName;
	}
	/**
	 * @param categoryName the categoryName to set
	 */
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	/**
	 * @return the totalLotsForSale
	 */
	public Integer getTotalLotsForSale() {
		return totalLotsForSale;
	}
	/**
	 * @return the totalActualSoldLots
	 */
	public Integer getTotalActualSoldLots() {
		return totalActualSoldLots;
	}
	/**
	 * @return the totalActualSoldQunatity
	 */
	public Integer getTotalActualSoldQunatity() {
		return totalActualSoldQunatity;
	}
	/**
	 * @return the totalActualSoldAmount
	 */
	public Double getTotalActualSoldAmount() {
		return totalActualSoldAmount;
	}
	/**
	 * @return the avergeAmount
	 */
	public Double getAvergeAmount() {
		return avergeAmount;
	}
	/**
	 * @return the totalUnsoldBiddedLots
	 */
	public Integer getTotalUnsoldBiddedLots() {
		return totalUnsoldBiddedLots;
	}
	/**
	 * @return the totalUnsoldBiddedQuantity
	 */
	public Integer getTotalUnsoldBiddedQuantity() {
		return totalUnsoldBiddedQuantity;
	}
	/**
	 * @return the totalUnsoldUnBiddedLots
	 */
	public Integer getTotalUnsoldUnBiddedLots() {
		return totalUnsoldUnBiddedLots;
	}
	/**
	 * @return the totalUnsoldUnBiddedQuantity
	 */
	public Integer getTotalUnsoldUnBiddedQuantity() {
		return totalUnsoldUnBiddedQuantity;
	}
	/**
	 * @param totalActualSoldLots the totalActualSoldLots to set
	 */
	public void setTotalActualSoldLots(Integer totalActualSoldLots) {
		this.totalActualSoldLots = totalActualSoldLots;
	}
	/**
	 * @param totalActualSoldQunatity the totalActualSoldQunatity to set
	 */
	public void setTotalActualSoldQunatity(Integer totalActualSoldQunatity) {
		this.totalActualSoldQunatity = totalActualSoldQunatity;
	}
	/**
	 * @param totalActualSoldAmount the totalActualSoldAmount to set
	 */
	public void setTotalActualSoldAmount(Double totalActualSoldAmount) {
		this.totalActualSoldAmount = totalActualSoldAmount;
	}
	/**
	 * @param avergeAmount the avergeAmount to set
	 */
	public void setAvergeAmount(Double avergeAmount) {
		this.avergeAmount = avergeAmount;
	}
	/**
	 * @param totalUnsoldBiddedLots the totalUnsoldBiddedLots to set
	 */
	public void setTotalUnsoldBiddedLots(Integer totalUnsoldBiddedLots) {
		this.totalUnsoldBiddedLots = totalUnsoldBiddedLots;
	}
	/**
	 * @param totalUnsoldBiddedQuantity the totalUnsoldBiddedQuantity to set
	 */
	public void setTotalUnsoldBiddedQuantity(Integer totalUnsoldBiddedQuantity) {
		this.totalUnsoldBiddedQuantity = totalUnsoldBiddedQuantity;
	}
	/**
	 * @param totalUnsoldUnBiddedLots the totalUnsoldUnBiddedLots to set
	 */
	public void setTotalUnsoldUnBiddedLots(Integer totalUnsoldUnBiddedLots) {
		this.totalUnsoldUnBiddedLots = totalUnsoldUnBiddedLots;
	}
	/**
	 * @param totalUnsoldUnBiddedQuantity the totalUnsoldUnBiddedQuantity to set
	 */
	public void setTotalUnsoldUnBiddedQuantity(Integer totalUnsoldUnBiddedQuantity) {
		this.totalUnsoldUnBiddedQuantity = totalUnsoldUnBiddedQuantity;
	}
	/**
	 * @return the totalLotsquantityForSale
	 */
	public Integer getTotalLotsquantityForSale() {
		return totalLotsquantityForSale;
	}
	/**
	 * @param categoryId the categoryId to set
	 */
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	
	public String toString() {
		return "ReportSummary2 [categoryId=" + categoryId
				+ ", totalLotsForSale=" + totalLotsForSale
				+ ", totalLotsquantityForSale=" + totalLotsquantityForSale
				+ "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((categoryId == null) ? 0 : categoryId.hashCode());
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
		ReportSummary2 other = (ReportSummary2) obj;
		if (categoryId == null) {
			if (other.categoryId != null)
				return false;
		} else if (!categoryId.equals(other.categoryId))
			return false;
		return true;
	}
	/**
	 * @param totalLotsForSale the totalLotsForSale to set
	 */
	public void setTotalLotsForSale(Integer totalLotsForSale) {
		this.totalLotsForSale = totalLotsForSale;
	}
	/**
	 * @param totalLotsquantityForSale the totalLotsquantityForSale to set
	 */
	public void setTotalLotsquantityForSale(Integer totalLotsquantityForSale) {
		this.totalLotsquantityForSale = totalLotsquantityForSale;
	}
	
}
