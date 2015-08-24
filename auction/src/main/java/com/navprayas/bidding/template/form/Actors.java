package com.navprayas.bidding.template.form;

public class Actors {
	private long id;
	private int version;
	private long ActorId;
	private String FirstName;
	private String LastName;
	private String ContactDetails;
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
	 * @return the actorId
	 */
	public long getActorId() {
		return ActorId;
	}
	/**
	 * @param actorId the actorId to set
	 */
	public void setActorId(long actorId) {
		ActorId = actorId;
	}
	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return FirstName;
	}
	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		FirstName = firstName;
	}
	/**
	 * @return the lastName
	 */
	public String getLastName() {
		return LastName;
	}
	/**
	 * @param lastName the lastName to set
	 */
	public void setLastName(String lastName) {
		LastName = lastName;
	}
	/**
	 * @return the contactDetails
	 */
	public String getContactDetails() {
		return ContactDetails;
	}
	/**
	 * @param contactDetails the contactDetails to set
	 */
	public void setContactDetails(String contactDetails) {
		ContactDetails = contactDetails;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Actors [ActorId=" + ActorId + ", ContactDetails="
				+ ContactDetails + ", FirstName=" + FirstName + ", LastName="
				+ LastName + "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (ActorId ^ (ActorId >>> 32));
		result = prime * result
				+ ((ContactDetails == null) ? 0 : ContactDetails.hashCode());
		result = prime * result
				+ ((FirstName == null) ? 0 : FirstName.hashCode());
		result = prime * result
				+ ((LastName == null) ? 0 : LastName.hashCode());
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
		Actors other = (Actors) obj;
		if (ActorId != other.ActorId)
			return false;
		if (ContactDetails == null) {
			if (other.ContactDetails != null)
				return false;
		} else if (!ContactDetails.equals(other.ContactDetails))
			return false;
		if (FirstName == null) {
			if (other.FirstName != null)
				return false;
		} else if (!FirstName.equals(other.FirstName))
			return false;
		if (LastName == null) {
			if (other.LastName != null)
				return false;
		} else if (!LastName.equals(other.LastName))
			return false;
		return true;
	}
	
}
	