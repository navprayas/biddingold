package com.navprayas.bidding.template.form;

import java.util.Date;

public class RegUser {
	private long id;
	private int version;
	private long regUserId;
	private String firstName;
	private String middleName;
	private String lastName;
	private int age;
	private char gender;
	private Date dateOfBirth;
	private String  emailId;
	private long contactId1;
	private String contactId2;
	private long addressId;
	private String role;
	private int rank;
	private String auctionId;
	private Date  createdTime;
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
	 * @return the regUserId
	 */
	public long getRegUserId() {
		return regUserId;
	}
	/**
	 * @param regUserId the regUserId to set
	 */
	public void setRegUserId(long regUserId) {
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
	public int getAge() {
		return age;
	}
	/**
	 * @param age the age to set
	 */
	public void setAge(int age) {
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
	public long getContactId1() {
		return contactId1;
	}
	/**
	 * @param contactId1 the contactId1 to set
	 */
	public void setContactId1(long contactId1) {
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
	public long getAddressId() {
		return addressId;
	}
	/**
	 * @param addressId the addressId to set
	 */
	public void setAddressId(long addressId) {
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
	public int getRank() {
		return rank;
	}
	/**
	 * @param rank the rank to set
	 */
	public void setRank(int rank) {
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
		return "RegUser [addressId=" + addressId + ", age=" + age
				+ ", auctionId=" + auctionId + ", contactId1=" + contactId1
				+ ", contactId2=" + contactId2 + ", createdTime=" + createdTime
				+ ", dateOfBirth=" + dateOfBirth + ", emailId=" + emailId
				+ ", firstName=" + firstName + ", gender=" + gender
				+ ", lastName=" + lastName + ", middleName=" + middleName
				+ ", rank=" + rank + ", regUserId=" + regUserId + ", role="
				+ role + "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (addressId ^ (addressId >>> 32));
		result = prime * result + age;
		result = prime * result
				+ ((auctionId == null) ? 0 : auctionId.hashCode());
		result = prime * result + (int) (contactId1 ^ (contactId1 >>> 32));
		result = prime * result
				+ ((contactId2 == null) ? 0 : contactId2.hashCode());
		result = prime * result
				+ ((createdTime == null) ? 0 : createdTime.hashCode());
		result = prime * result
				+ ((dateOfBirth == null) ? 0 : dateOfBirth.hashCode());
		result = prime * result + ((emailId == null) ? 0 : emailId.hashCode());
		result = prime * result
				+ ((firstName == null) ? 0 : firstName.hashCode());
		result = prime * result + gender;
		result = prime * result
				+ ((lastName == null) ? 0 : lastName.hashCode());
		result = prime * result
				+ ((middleName == null) ? 0 : middleName.hashCode());
		result = prime * result + rank;
		result = prime * result + (int) (regUserId ^ (regUserId >>> 32));
		result = prime * result + ((role == null) ? 0 : role.hashCode());
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
		if (addressId != other.addressId)
			return false;
		if (age != other.age)
			return false;
		if (auctionId == null) {
			if (other.auctionId != null)
				return false;
		} else if (!auctionId.equals(other.auctionId))
			return false;
		if (contactId1 != other.contactId1)
			return false;
		if (contactId2 == null) {
			if (other.contactId2 != null)
				return false;
		} else if (!contactId2.equals(other.contactId2))
			return false;
		if (createdTime == null) {
			if (other.createdTime != null)
				return false;
		} else if (!createdTime.equals(other.createdTime))
			return false;
		if (dateOfBirth == null) {
			if (other.dateOfBirth != null)
				return false;
		} else if (!dateOfBirth.equals(other.dateOfBirth))
			return false;
		if (emailId == null) {
			if (other.emailId != null)
				return false;
		} else if (!emailId.equals(other.emailId))
			return false;
		if (firstName == null) {
			if (other.firstName != null)
				return false;
		} else if (!firstName.equals(other.firstName))
			return false;
		if (gender != other.gender)
			return false;
		if (lastName == null) {
			if (other.lastName != null)
				return false;
		} else if (!lastName.equals(other.lastName))
			return false;
		if (middleName == null) {
			if (other.middleName != null)
				return false;
		} else if (!middleName.equals(other.middleName))
			return false;
		if (rank != other.rank)
			return false;
		if (regUserId != other.regUserId)
			return false;
		if (role == null) {
			if (other.role != null)
				return false;
		} else if (!role.equals(other.role))
			return false;
		return true;
	}
	

}
