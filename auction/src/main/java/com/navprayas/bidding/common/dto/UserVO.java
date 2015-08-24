package com.navprayas.bidding.common.dto;

public class UserVO {

	private Long userId;
	private String username;
	private String email;
	private String firstName; 
	private String middleName; 
	private String lastName;
	private String name;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getMiddleName() {
		return middleName;
	}
	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getName() {
		StringBuilder str = new StringBuilder(firstName);
		if(middleName != null) {
			str.append(" ").append(middleName);
		}
		if(lastName != null) {
			str.append(" ").append(lastName);
		}
		setName(str.toString());
		return this.name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}	
}
