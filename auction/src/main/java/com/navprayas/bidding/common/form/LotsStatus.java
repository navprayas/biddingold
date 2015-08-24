package com.navprayas.bidding.common.form;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity
@Cache(usage = CacheConcurrencyStrategy.READ_ONLY, region = "LotsStatus" )
@Table(name="LOTS_STATUS")
public class LotsStatus {
	
	@Id	
	@Column(name="LOT_STATUS_ID")
	private Long lotStatusId;
	
	@Column(name="LOTS_STATUS")
	private String lotStatus;
	
	@Column(name="LOTS_STATUS_DESC")
	private String lotStatusDesc;

	public Long getLotStatusId() {
		return lotStatusId;
	}

	public void setLotStatusId(Long lotStatusId) {
		this.lotStatusId = lotStatusId;
	}

	public String getLotStatus() {
		return lotStatus;
	}

	public void setLotStatus(String lotStatus) {
		this.lotStatus = lotStatus;
	}

	public String getLotStatusDesc() {
		return lotStatusDesc;
	}

	public void setLotStatusDesc(String lotStatusDesc) {
		this.lotStatusDesc = lotStatusDesc;
	}
	
}	