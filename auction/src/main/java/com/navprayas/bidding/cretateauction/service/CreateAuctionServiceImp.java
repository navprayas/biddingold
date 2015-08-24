package com.navprayas.bidding.cretateauction.service;

import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.cretateauction.dao.CreateAuctionDao;
import com.navprayas.bidding.cretateauction.entity.CreateAuctionEntity;

@Repository
@Transactional
public class CreateAuctionServiceImp implements CreateAuctionService {
	@Autowired
	CreateAuctionDao auctionDao;

	@Override
	public String saveData(CreateAuctionEntity auctionEntity)
			throws ParseException {
		// TODO Auto-generated method stub
		String createdTimeFormat = auctionEntity.getCreatedTimeFormat();
		/*
		 * SimpleDateFormat sd = new SimpleDateFormat("yyyy/MM/dd"); Date
		 * createdTime = null; createdTime = sd.parse(createdTimeFormat);
		 * auctionEntity.setCreatedTime(createdTime);
		 */
		// added by Ashish katiyar started here
		/*
		 * Date date=new Date(createdTimeFormat); Timestamp time=new
		 * Timestamp(date.getTime());
		 * System.out.println("Current date time"+time);
		 */
		auctionEntity.setCreatedTime(new Timestamp(new Date().getTime()));
		// added by Ashish katiyar started here
		auctionDao.save(auctionEntity);
		return "createauction/CreateAuction";
	}

	@Override
	public List<CreateAuctionEntity> getAllAuctionList() {
		
		return auctionDao.getAllAuctionList();
	}

	@Override
	public CreateAuctionEntity getAuctionDetails(Integer auctionId){
		// TODO Auto-generated method stub
		/*DateFormat sd = new SimpleDateFormat("yyyy/MM/dd");
		CreateAuctionEntity auctionEntity=auctionDao.getAuction(auctionId);
		try{
			auctionEntity.setCreatedTime(sd.parse(auctionEntity.getCreatedTime().toString()));
		}catch(Exception e){
			e.printStackTrace();
		}*/
		
		
		
		return auctionDao.getAuction(auctionId);
		
	}
  
}
