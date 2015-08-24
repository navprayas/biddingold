package com.navprayas.bidding.fileupload.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "itemlot")
public class ItemLotEntity {
	@Id
	@Column(name = "lotId")
	private int lotId;
	@Column(name = "bidItemId")
	private int bidItemId;
	@Column(name = "name")
	private String name;
	@Column(name = "lengthRange")
	private String lengthRange;
	@Column(name = "actualLength")
	private String actualLength;
	@Column(name = "quantity")
	private int quantity;
	@Column(name = "unit")
	private String unit;
	@Column(name = "currency")
	private String currency;
	@Column(name = "remark")
	private String remark;
	@Column(name = "zone")
	private String zone;
	@Column(name = "LOTNO")
	private int LOTNO;

	public int getLotId() {
		return lotId;
	}

	public void setLotId(int lotId) {
		this.lotId = lotId;
	}

	public int getBidItemId() {
		return bidItemId;
	}

	public void setBidItemId(int bidItemId) {
		this.bidItemId = bidItemId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLengthRange() {
		return lengthRange;
	}

	public void setLengthRange(String lengthRange) {
		this.lengthRange = lengthRange;
	}

	public String getActualLength() {
		return actualLength;
	}

	public void setActualLength(String actualLength) {
		this.actualLength = actualLength;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getZone() {
		return zone;
	}

	public void setZone(String zone) {
		this.zone = zone;
	}

	public int getLOTNO() {
		return LOTNO;
	}

	public void setLOTNO(int lOTNO) {
		LOTNO = lOTNO;
	}
}
