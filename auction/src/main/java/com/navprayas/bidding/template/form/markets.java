package com.navprayas.bidding.template.form;

public class markets {
	private long id;
	private int version;
	private String forward;
	private String reverse;
	private String closed;
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
	 * @return the forward
	 */
	public String getForward() {
		return forward;
	}
	/**
	 * @param forward the forward to set
	 */
	public void setForward(String forward) {
		this.forward = forward;
	}
	/**
	 * @return the reverse
	 */
	public String getReverse() {
		return reverse;
	}
	/**
	 * @param reverse the reverse to set
	 */
	public void setReverse(String reverse) {
		this.reverse = reverse;
	}
	/**
	 * @return the closed
	 */
	public String getClosed() {
		return closed;
	}
	/**
	 * @param closed the closed to set
	 */
	public void setClosed(String closed) {
		this.closed = closed;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "markets [closed=" + closed + ", forward=" + forward
				+ ", reverse=" + reverse + "]";
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((closed == null) ? 0 : closed.hashCode());
		result = prime * result + ((forward == null) ? 0 : forward.hashCode());
		result = prime * result + ((reverse == null) ? 0 : reverse.hashCode());
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
		markets other = (markets) obj;
		if (closed == null) {
			if (other.closed != null)
				return false;
		} else if (!closed.equals(other.closed))
			return false;
		if (forward == null) {
			if (other.forward != null)
				return false;
		} else if (!forward.equals(other.forward))
			return false;
		if (reverse == null) {
			if (other.reverse != null)
				return false;
		} else if (!reverse.equals(other.reverse))
			return false;
		return true;
	}
	
}
