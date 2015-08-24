package com.navprayas.bidding.common.dto;

public class ObserverVO {
	
	private Long bidItemId;
	
	private Double bidAmount;
	
	private String bidderName;
	
	private String bidStatus;
	
	private String categoryId;
	
	private String pageO;
	
	public String getPageO() {
		return pageO;
	}
	public void setPageO(String page) {
		this.pageO = page;
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
	 * @return the bidItemId
	 */
	public Long getBidItemId() {
		return bidItemId;
	}
	/**
	 * @param bidItemId the bidItemId to set
	 */
	public void setBidItemId(Long bidItemId) {
		this.bidItemId = bidItemId;
	}
	
	
	@Override
	public String toString() {
		return "ObserverVO [bidAmount=" + bidAmount + ", bidItemId="
				+ bidItemId + "]";
	}
	/**
	 * @param categoryId the categoryId to set
	 */
	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	/**
	 * @return the categoryId
	 */
	public String getCategoryId() {
		return categoryId;
	}
	
}
