package com.navprayas.bidding.admin.form;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name="reguser")
public class ManageUser {


	@Id
	@Column(name="ID")
	@GeneratedValue
	private Integer id;
	

	@Column(name="REGUSERID")
	private Integer RegUserId;
	
	@Column(name="FIRSTNAME")
	private String FirstName;
	
	@Column(name="MIDDLENAME")
	private String MiddleName;
	
	@Column(name="LASTNAME")
	private String LastName;
	
	@Column(name="ROLE")
	private String Role;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getRegUserId() {
		return RegUserId;
	}

	public void setRegUserId(Integer regUserId) {
		RegUserId = regUserId;
	}

	public String getFirstName() {
		return FirstName;
	}

	public void setFirstName(String firstName) {
		FirstName = firstName;
	}

	public String getMiddleName() {
		return MiddleName;
	}

	public void setMiddleName(String middleName) {
		MiddleName = middleName;
	}

	public String getLastName() {
		return LastName;
	}

	public void setLastName(String lastName) {
		LastName = lastName;
	}

	public String getRole() {
		return Role;
	}

	public void setRole(String role) {
		Role = role;
	}
	
	
	
}
