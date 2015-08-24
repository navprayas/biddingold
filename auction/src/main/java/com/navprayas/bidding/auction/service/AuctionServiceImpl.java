package com.navprayas.bidding.auction.service;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.auction.dao.AuctionDao;
import com.navprayas.bidding.auction.entity.AuctionEntity;

@Service
@Transactional
public class AuctionServiceImpl implements AuctionService
{
	@Autowired
	AuctionDao auctionDao;

	@Override
	public String saveData(AuctionEntity obj) {
		auctionDao.save(obj);
		return "Success";
	}

}
