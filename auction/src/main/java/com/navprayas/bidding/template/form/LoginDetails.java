package com.navprayas.bidding.template.form;

public class LoginDetails {
	private long id;
	private int version;
	private long loginId;
	private long regUserId;
	private String loginName;
	private String password;
	private String passwordQuestion;
	private String  passwordAnswer;
	private String emailId;
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
	 * @return the loginId
	 */
	public long getLoginId() {
		return loginId;
	}
	/**
	 * @param loginId the loginId to set
	 */
	public void setLoginId(long loginId) {
		this.loginId = loginId;
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
	 * @return the loginName
	 */
	public String getLoginName() {
		return loginName;
	}
	/**
	 * @param loginName the loginName to set
	 */
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	/**
	 * @return the passwordQuestion
	 */
	public String getPasswordQuestion() {
		return passwordQuestion;
	}
	/**
	 * @param passwordQuestion the passwordQuestion to set
	 */
	public void setPasswordQuestion(String passwordQuestion) {
		this.passwordQuestion = passwordQuestion;
	}
	/**
	 * @return the passwordAnswer
	 */
	public String getPasswordAnswer() {
		return passwordAnswer;
	}
	/**
	 * @param passwordAnswer the passwordAnswer to set
	 */
	public void setPasswordAnswer(String passwordAnswer) {
		this.passwordAnswer = passwordAnswer;
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
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "LoginDetails [emailId=" + emailId + ", loginId=" + loginId
				+ ", loginName=" + loginName + ", password=" + password
				+ ", passwordAnswer=" + passwordAnswer + ", passwordQuestion="
				+ passwordQuestion + ", regUserId=" + regUserId + "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((emailId == null) ? 0 : emailId.hashCode());
		result = prime * result + (int) (loginId ^ (loginId >>> 32));
		result = prime * result
				+ ((loginName == null) ? 0 : loginName.hashCode());
		result = prime * result
				+ ((password == null) ? 0 : password.hashCode());
		result = prime * result
				+ ((passwordAnswer == null) ? 0 : passwordAnswer.hashCode());
		result = prime
				* result
				+ ((passwordQuestion == null) ? 0 : passwordQuestion.hashCode());
		result = prime * result + (int) (regUserId ^ (regUserId >>> 32));
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
		LoginDetails other = (LoginDetails) obj;
		if (emailId == null) {
			if (other.emailId != null)
				return false;
		} else if (!emailId.equals(other.emailId))
			return false;
		if (loginId != other.loginId)
			return false;
		if (loginName == null) {
			if (other.loginName != null)
				return false;
		} else if (!loginName.equals(other.loginName))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (passwordAnswer == null) {
			if (other.passwordAnswer != null)
				return false;
		} else if (!passwordAnswer.equals(other.passwordAnswer))
			return false;
		if (passwordQuestion == null) {
			if (other.passwordQuestion != null)
				return false;
		} else if (!passwordQuestion.equals(other.passwordQuestion))
			return false;
		if (regUserId != other.regUserId)
			return false;
		return true;
	}
	

}
