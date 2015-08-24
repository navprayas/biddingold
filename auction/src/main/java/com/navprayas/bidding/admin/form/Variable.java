package com.navprayas.bidding.admin.form;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="variable")
public class Variable {

	@Id
	@Column(name="ID")
	@GeneratedValue
	private Integer id;
	
	@Column(name="time_extension")
	private Long timeExtension;

	@Column(name="time_differnrce")
	private Integer timeDiffernrce;
	
	@Column(name="active_lots")
	private Integer activeLots;
	
	@Column(name="active")
	private String isActive;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Long getTimeExtension() {
		return timeExtension;
	}

	public void setTimeExtension(Long timeExtension) {
		this.timeExtension = timeExtension;
	}

	public Integer getTimeDiffernrce() {
		return timeDiffernrce;
	}

	public void setTimeDiffernrce(Integer timeDiffernrce) {
		this.timeDiffernrce = timeDiffernrce;
	}

	public Integer getActiveLots() {
		return activeLots;
	}

	public void setActiveLots(Integer activeLots) {
		this.activeLots = activeLots;
	}

	/**
	 * @param isActive the isActive to set
	 */
	public void setIsActive(String isActive) {
		this.isActive = isActive;
	}

	/**
	 * @return the isActive
	 */
	public String getIsActive() {
		return isActive;
	}

}
