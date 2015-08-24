package com.navprayas.bidding.common.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class ReportVO {

	private static final String DATE_FORMAT = "dd/MM/yyyy";
	private static final String DATE_FORMAT_TO = "dd/MM/yyyy HH:mm:ss";
	private SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
	private SimpleDateFormat sdfTo = new SimpleDateFormat(DATE_FORMAT_TO);
	
    private String paramDateFrom;
	
	private String paramDateTo;
	
	private Date dateFrom;
	
	private Date dateTo;
	
	private Long categoryId;

	private String lotsStatus;
	
	/**
	 * @return the lotsStatus
	 */
	public String getLotsStatus() {
		return lotsStatus;
	}

	/**
	 * @param lotsStatus the lotsStatus to set
	 */
	public void setLotsStatus(String lotsStatus) {
		this.lotsStatus = lotsStatus;
	}

	/**
	 * @return the categoryId
	 */
	public Long getCategoryId() {
		return categoryId;
	}

	/**
	 * @param categoryId the categoryId to set
	 */
	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}

	/**
	 * @return the dateFrom
	 */
	public Date getDateFrom() {
		try {
			
			dateFrom = sdf.parse(paramDateFrom);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dateFrom;
	}

	/**
	 * @param dateFrom the dateFrom to set
	 */
	public void setDateFrom(Date dateFrom) {
		try {
			this.dateFrom = sdf.parse(paramDateFrom);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//this.dateFrom = dateFrom;
	}

	/**
	 * @return the dateTo
	 */
	public Date getDateTo() {
		try {
			paramDateTo = paramDateTo + " 23:59:59";
			dateTo = sdfTo.parse(paramDateTo);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dateTo;
	}

	/**
	 * @param dateTo the dateTo to set
	 */
	public void setDateTo(Date dateTo) {
		try {
			this.dateTo = sdf.parse(paramDateTo);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//this.dateTo = dateTo;
	}

	/**
	 * @param paramDateFrom the paramDateFrom to set
	 */
	public void setParamDateFrom(String paramDateFrom) {
		this.paramDateFrom = paramDateFrom;
	}

	/**
	 * @return the paramDateFrom
	 */
	public String getParamDateFrom() {
		return paramDateFrom;
	}

	/**
	 * @param paramDateTo the paramDateTo to set
	 */
	public void setParamDateTo(String paramDateTo) {
		this.paramDateTo = paramDateTo;
	}

	/**
	 * @return the paramDateTo
	 */
	public String getParamDateTo() {
		return paramDateTo;
	}
	
	
	
}
