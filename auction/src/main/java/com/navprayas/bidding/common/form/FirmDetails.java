package com.navprayas.bidding.common.form;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="FirmDetails")
public class FirmDetails implements Serializable{

	private static final long serialVersionUID = -6009206982668458513L;

	@Id
	@Column(name="FIRMID")
	@GeneratedValue
	private Long firmId;	
	
	@Column(name="FirmName")
	private String firmName;

	@Column(name="ContactPersonName1")
	private String contactPersonName1;

	@Column(name="ContactPersonName2")
	private String contactPersonName2;

	@Column(name="DirectorName")
	private String directorName;

	@Column(name="PhoneNo")
	private String phoneNo;

	@Column(name="MobileNo")
	private String mobileNo;

	@Column(name="ResNo")
	private String resNo;
	
	@Column(name="FaxNo")
	private String faxNo;

	@Column(name="EmailAddress")
	private String emailAddress;

	@Column(name="OfficeAddress")
	private String officeAddress;

	@Column(name="GodownAddress")
	private String godownAddress;

	
	@Column(name="VATTINNo")
	private String vatTINNo;

	@Column(name="CSTTINNo")
	private String cstTINNo;
	
	@Column(name="PANNo")
	private String panNo;

	@Column(name="IncomeTaxRegistrationNo")
	private String incomeTaxRegistrationNo;

	@Column(name="SecurityGrtNo")
	private String securityGrtNo;
	
	@Column(name="SecurityDate")
	private Date securityDate;
	
	@Column(name="SecurityAmount")
	private String securityAmount;
	
	@Column(name="AcountType")
	private String acountType;
	
	@Column(name="AccountNumber")
	private String accountNumber;
	
	
	@Column(name="IFSCCode")
	private String IFSCCode;
	
	@Column(name="BankName")
	private String bankName;
	
	@Column(name="BankAddress")
	private String bankAddress;
	
	@Column(name="SisterFirmNo1")
	private String sisterFirmNo1;
	
	@Column(name="SisterFirmNo2")
	private String sisterFirmNo2;
	
	@Column(name="SisterFirmNo3")
	private String sisterFirmNo3;
	
	@Column(name="ActualUser")
	private boolean actualUser;
	
	@Column(name="ExciseRegistrationNo")
	private String exciseRegistrationNo;
	
	@Column(name="ExciseRange")
	private String exciseRange;
	
	@Column(name="ERangeAddress")
	private String eRangeAddress;
	
	@Column(name="EDivision")
	private String eDivision;
	
	@Column(name="EDivisionAddress")
	private String eDivisionAddress;
	
	@Column(name="ECommissionerate")
	private String eCommissionerate;
	
	@Column(name="EccNo")
	private String eccNo;

	public Long getFirmId() {
		return firmId;
	}

	public void setFirmId(Long firmId) {
		this.firmId = firmId;
	}

	public String getFirmName() {
		return firmName;
	}

	public void setFirmName(String firmName) {
		this.firmName = firmName;
	}

	public String getContactPersonName1() {
		return contactPersonName1;
	}

	public void setContactPersonName1(String contactPersonName1) {
		this.contactPersonName1 = contactPersonName1;
	}

	public String getContactPersonName2() {
		return contactPersonName2;
	}

	public void setContactPersonName2(String contactPersonName2) {
		this.contactPersonName2 = contactPersonName2;
	}

	public String getDirectorName() {
		return directorName;
	}

	public void setDirectorName(String directorName) {
		this.directorName = directorName;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getMobileNo() {
		return mobileNo;
	}

	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}

	public String getResNo() {
		return resNo;
	}

	public void setResNo(String resNo) {
		this.resNo = resNo;
	}

	public String getFaxNo() {
		return faxNo;
	}

	public void setFaxNo(String faxNo) {
		this.faxNo = faxNo;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public String getOfficeAddress() {
		return officeAddress;
	}

	public void setOfficeAddress(String officeAddress) {
		this.officeAddress = officeAddress;
	}

	public String getGodownAddress() {
		return godownAddress;
	}

	public void setGodownAddress(String godownAddress) {
		this.godownAddress = godownAddress;
	}

	public String getVatTINNo() {
		return vatTINNo;
	}

	public void setVatTINNo(String vatTINNo) {
		this.vatTINNo = vatTINNo;
	}

	public String getCstTINNo() {
		return cstTINNo;
	}

	public void setCstTINNo(String cstTINNo) {
		this.cstTINNo = cstTINNo;
	}

	public String getPanNo() {
		return panNo;
	}

	public void setPanNo(String panNo) {
		this.panNo = panNo;
	}

	public String getIncomeTaxRegistrationNo() {
		return incomeTaxRegistrationNo;
	}

	public void setIncomeTaxRegistrationNo(String incomeTaxRegistrationNo) {
		this.incomeTaxRegistrationNo = incomeTaxRegistrationNo;
	}

	public String getSecurityGrtNo() {
		return securityGrtNo;
	}

	public void setSecurityGrtNo(String securityGrtNo) {
		this.securityGrtNo = securityGrtNo;
	}

	public Date getSecurityDate() {
		return securityDate;
	}

	public void setSecurityDate(Date securityDate) {
		this.securityDate = securityDate;
	}

	public String getSecurityAmount() {
		return securityAmount;
	}

	public void setSecurityAmount(String securityAmount) {
		this.securityAmount = securityAmount;
	}

	public String getAcountType() {
		return acountType;
	}

	public void setAcountType(String acountType) {
		this.acountType = acountType;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getIFSCCode() {
		return IFSCCode;
	}

	public void setIFSCCode(String iFSCCode) {
		IFSCCode = iFSCCode;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getBankAddress() {
		return bankAddress;
	}

	public void setBankAddress(String bankAddress) {
		this.bankAddress = bankAddress;
	}

	public String getSisterFirmNo1() {
		return sisterFirmNo1;
	}

	public void setSisterFirmNo1(String sisterFirmNo1) {
		this.sisterFirmNo1 = sisterFirmNo1;
	}

	public String getSisterFirmNo2() {
		return sisterFirmNo2;
	}

	public void setSisterFirmNo2(String sisterFirmNo2) {
		this.sisterFirmNo2 = sisterFirmNo2;
	}

	public String getSisterFirmNo3() {
		return sisterFirmNo3;
	}

	public void setSisterFirmNo3(String sisterFirmNo3) {
		this.sisterFirmNo3 = sisterFirmNo3;
	}

	public boolean isActualUser() {
		return actualUser;
	}

	public void setActualUser(boolean actualUser) {
		this.actualUser = actualUser;
	}

	public String getExciseRegistrationNo() {
		return exciseRegistrationNo;
	}

	public void setExciseRegistrationNo(String exciseRegistrationNo) {
		this.exciseRegistrationNo = exciseRegistrationNo;
	}

	public String getExciseRange() {
		return exciseRange;
	}

	public void setExciseRange(String exciseRange) {
		this.exciseRange = exciseRange;
	}

	public String geteRangeAddress() {
		return eRangeAddress;
	}

	public void seteRangeAddress(String eRangeAddress) {
		this.eRangeAddress = eRangeAddress;
	}

	public String geteDivision() {
		return eDivision;
	}

	public void seteDivision(String eDivision) {
		this.eDivision = eDivision;
	}

	public String geteDivisionAddress() {
		return eDivisionAddress;
	}

	public void seteDivisionAddress(String eDivisionAddress) {
		this.eDivisionAddress = eDivisionAddress;
	}

	public String geteCommissionerate() {
		return eCommissionerate;
	}

	public void seteCommissionerate(String eCommissionerate) {
		this.eCommissionerate = eCommissionerate;
	}

	public String getEccNo() {
		return eccNo;
	}

	public void setEccNo(String eccNo) {
		this.eccNo = eccNo;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("FirmDetails [firmName=");
		builder.append(firmName);
		builder.append(", contactPersonName1=");
		builder.append(contactPersonName1);
		builder.append("]");
		return builder.toString();
	}	
	
	
	
}
