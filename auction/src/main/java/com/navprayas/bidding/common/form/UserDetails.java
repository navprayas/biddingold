package com.navprayas.bidding.common.form;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Cache(usage = CacheConcurrencyStrategy.READ_WRITE, region = "UserDetails" )
@Table(name="UserDetails")
public class UserDetails {

	@Id
	@Column(name="userDetailsId")
	@GeneratedValue
	private Long userDetailsId;
	
	@OneToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
    @JoinColumn(name="userId", referencedColumnName = "userId")
	private Users user; 
	
	@Column(name="firstName")
	private String firstName; 
	@Column(name="middleName")
	private String middleName; 
	@Column(name="lastName")
	private String lastName; 
	@Column(name="age")
	private String age; 
	@Column(name="gender")
	private String gender; 
	//@Column(name="dateofbirth")
	//private Date dateofbirth;
	
	public Long getUserDetailsId() {
		return userDetailsId;
	}
	public void setUserDetailsId(Long userDetailsId) {
		this.userDetailsId = userDetailsId;
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
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	/*public Date getDateofbirth() {
		return dateofbirth;
	}
	public void setDateofbirth(Date dateofbirth) {
		this.dateofbirth = dateofbirth;
	}*/
	public Users getUser() {
		return user;
	}
	public void setUser(Users user) {
		this.user = user;
	} 
	
	//private String primaryContactId; 
	//private String secondContactId; 
	//private String addressId; 
	
}
