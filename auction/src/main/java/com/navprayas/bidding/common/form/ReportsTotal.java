package com.navprayas.bidding.common.form;

public class ReportsTotal {

	private Integer totalQuantity;
	private Double totalBidAmount1;
	private Double totalBidAmount2;
	private Double totalBidAmount3;
	private Double finalTotalSalesPrice;
	/**
	 * @return the finalTotalSalesPrice
	 */
	public Double getFinalTotalSalesPrice() {
		return finalTotalSalesPrice;
	}
	/**
	 * @param finalTotalSalesPrice the finalTotalSalesPrice to set
	 */
	public void setFinalTotalSalesPrice(Double finalTotalSalesPrice) {
		this.finalTotalSalesPrice = finalTotalSalesPrice;
	}
	/**
	 * @return the totalQuantity
	 */
	public Integer getTotalQuantity() {
		return totalQuantity;
	}
	/**
	 * @return the totalBidAmount1
	 */
	public Double getTotalBidAmount1() {
		return totalBidAmount1;
	}
	/**
	 * @return the totalBidAmount2
	 */
	public Double getTotalBidAmount2() {
		return totalBidAmount2;
	}
	/**
	 * @return the totalBidAmount3
	 */
	public Double getTotalBidAmount3() {
		return totalBidAmount3;
	}
	/**
	 * @param totalQuantity the totalQuantity to set
	 */
	public void setTotalQuantity(Integer totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
	/**
	 * @param totalBidAmount1 the totalBidAmount1 to set
	 */
	public void setTotalBidAmount1(Double totalBidAmount1) {
		this.totalBidAmount1 = totalBidAmount1;
	}
	/**
	 * @param totalBidAmount2 the totalBidAmount2 to set
	 */
	public void setTotalBidAmount2(Double totalBidAmount2) {
		this.totalBidAmount2 = totalBidAmount2;
	}
	/**
	 * @param totalBidAmount3 the totalBidAmount3 to set
	 */
	public void setTotalBidAmount3(Double totalBidAmount3) {
		this.totalBidAmount3 = totalBidAmount3;
	}
	
}
