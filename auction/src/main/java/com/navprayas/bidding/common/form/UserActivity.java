package com.navprayas.bidding.common.form;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="UserActivity")
public class UserActivity implements Serializable{

	private static final long serialVersionUID = -6009206982668458513L;

	@Id
	@Column(name="sessionId")
	private String sessionId;	
	
	@Column(name="auctionId")
	private Long auctionId;

	@Column(name="userId")
	private Long userId;
	
	@Column(name="loginTime")
	private Date loginTime;
		
	@Column(name="message")
	private String message;
	
	@Column(name="role")
	private String role;

	public Long getAuctionId() {
		return auctionId;
	}

	public void setAuctionId(Long auctionId) {
		this.auctionId = auctionId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Date getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}
	
}
