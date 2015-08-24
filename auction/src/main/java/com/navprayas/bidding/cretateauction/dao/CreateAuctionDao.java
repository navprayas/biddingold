package com.navprayas.bidding.cretateauction.dao;

import java.util.List;

import com.navprayas.bidding.cretateauction.entity.CreateAuctionEntity;


public interface CreateAuctionDao {
 public String save(CreateAuctionEntity auctionEntity);
 public List<CreateAuctionEntity> getAllAuctionList();
public CreateAuctionEntity getAuction(Integer auctionId);
}
