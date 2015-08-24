package com.navprayas.bidding.common.form;

import java.util.Date;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="REGUSER")

public class RegUser {
	
	@Id
	@Column(name="ID")
	@GeneratedValue
	private Long id;
	
	@Column(name="VERSION")
	@GeneratedValue
	private Integer version;
	
	@Column(name="REGUSERID")
	private Long regUserId;
	
    @Column(name="FIRSTNAME")
	private String firstName;
    
    @Column(name="MIDDLENAME")
	private String middleName;
    
    @Column(name="LASTNAME")
	private String lastName;
    
    @Column(name="AGE")
	private Integer age;
    
    @Column(name="GENDER")
	private char gender;
    
    @Column(name="DATEOFBIRTH")
	private Date dateOfBirth;
    
    @Column(name="EMAILID")
	private String  emailId;
    
    @Column(name="COTACTID1")
	private Long contactId1;
    
    @Column(name="CONTACTID2")
	private String contactId2;
    
    @Column(name="ADDRESSID")
	private Long addressId;
    
    @Column(name="ROLE")
	private String role;
    
    @Column(name="RANK")
	private Integer rank;
    
    @Column(name="AUCTIONID")
	private String auctionId;
    
    @Column(name="CREATEDTIME")
	private Date  createdTime;
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
	 * @return the regUserId
	 */
	public Long getRegUserId() {
		return regUserId;
	}
	/**
	 * @param regUserId the regUserId to set
	 */
	public void setRegUserId(Long regUserId) {
		this.regUserId = regUserId;
	}
	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}
	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	/**
	 * @return the middleName
	 */
	public String getMiddleName() {
		return middleName;
	}
	/**
	 * @param middleName the middleName to set
	 */
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	/**
	 * @return the lastName
	 */
	public String getLastName() {
		return lastName;
	}
	/**
	 * @param lastName the lastName to set
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	/**
	 * @return the age
	 */
	public Integer getAge() {
		return age;
	}
	/**
	 * @param age the age to set
	 */
	public void setAge(Integer age) {
		this.age = age;
	}
	/**
	 * @return the gender
	 */
	public char getGender() {
		return gender;
	}
	/**
	 * @param gender the gender to set
	 */
	public void setGender(char gender) {
		this.gender = gender;
	}
	/**
	 * @return the dateOfBirth
	 */
	public Date getDateOfBirth() {
		return dateOfBirth;
	}
	/**
	 * @param dateOfBirth the dateOfBirth to set
	 */
	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}
	/**
	 * @return the emailId
	 */
	public String getEmailId() {
		return emailId;
	}
	/**
	 * @param emailId the emailId to set
	 */
	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}
	/**
	 * @return the contactId1
	 */
	public Long getContactId1() {
		return contactId1;
	}
	/**
	 * @param contactId1 the contactId1 to set
	 */
	public void setContactId1(Long contactId1) {
		this.contactId1 = contactId1;
	}
	/**
	 * @return the contactId2
	 */
	public String getContactId2() {
		return contactId2;
	}
	/**
	 * @param contactId2 the contactId2 to set
	 */
	public void setContactId2(String contactId2) {
		this.contactId2 = contactId2;
	}
	/**
	 * @return the addressId
	 */
	public Long getAddressId() {
		return addressId;
	}
	/**
	 * @param addressId the addressId to set
	 */
	public void setAddressId(Long addressId) {
		this.addressId = addressId;
	}
	/**
	 * @return the role
	 */
	public String getRole() {
		return role;
	}
	/**
	 * @param role the role to set
	 */
	public void setRole(String role) {
		this.role = role;
	}
	/**
	 * @return the rank
	 */
	public Integer getRank() {
		return rank;
	}
	/**
	 * @param rank the rank to set
	 */
	public void setRank(Integer rank) {
		this.rank = rank;
	}
	/**
	 * @return the auctionId
	 */
	public String getAuctionId() {
		return auctionId;
	}
	/**
	 * @param auctionId the auctionId to set
	 */
	public void setAuctionId(String auctionId) {
		this.auctionId = auctionId;
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
	
	
	
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RegUser [regUserId=" + regUserId + "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((regUserId == null) ? 0 : regUserId.hashCode());
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
		RegUser other = (RegUser) obj;
		if (regUserId == null) {
			if (other.regUserId != null)
				return false;
		} else if (!regUserId.equals(other.regUserId))
			return false;
		return true;
	}
	

}
