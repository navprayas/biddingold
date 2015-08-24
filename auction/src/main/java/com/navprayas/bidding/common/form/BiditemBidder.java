package com.navprayas.bidding.common.form;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name="BIDITEM_BIDDER")
public class BiditemBidder implements Serializable{
	
	private static final long serialVersionUID = 4698549352288008561L;

		@Id
		@Column(name="ID")
		@GeneratedValue
		private Long id;
		
		@Column(name="VERSION")
		@GeneratedValue
		private Integer version;
				
		@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
	    @JoinColumn(name="bidItemId", referencedColumnName = "bidItemId")
		private BidItem biditem;

		
		@ManyToOne( cascade = {CascadeType.PERSIST, CascadeType.MERGE} )
	    @JoinColumn(name="userId", referencedColumnName = "userId" )	
		private Users user;


		/**
		 * @return the id
		 */
		public Long getId() {
			return id;
		}

		/**
		 * @param id the id to set
		 */
		public void setId(Long id) {
			this.id = id;
		}

		/**
		 * @return the version
		 */
		public Integer getVersion() {
			return version;
		}

		/**
		 * @param version the version to set
		 */
		public void setVersion(Integer version) {
			this.version = version;
		}

		/**
		 * @return the user
		 */
		public Users getUser() {
			return user;
		}

		/**
		 * @param user the user to set
		 */
		public void setUsername(Users user) {
			this.user = user;
		}

		/* (non-Javadoc)
		 * @see java.lang.Object#toString()
		 */
		@Override
		public String toString() {
			return "Biditem_Bidder [Id=" + id + "]";
		}

		/**
		 * @param biditem the biditem to set
		 */
		public void setBiditem(BidItem biditem) {
			this.biditem = biditem;
		}

		/**
		 * @return the biditem
		 */
		public BidItem getBiditem() {
			return biditem;
		}
		
}