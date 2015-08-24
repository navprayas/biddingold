package com.navprayas.bidding.auction.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.auction.entity.AuctionEntity;

@Repository
@Transactional
public class AuctionDaoImpl implements AuctionDao {

	@Autowired
	SessionFactory sessionFactory;
	
	
	@Override
	public void save(AuctionEntity ob) {
		sessionFactory.getCurrentSession().save(ob);
		
	}

}
