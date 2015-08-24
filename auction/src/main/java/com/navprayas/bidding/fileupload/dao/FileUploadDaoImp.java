package com.navprayas.bidding.fileupload.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.fileupload.entity.BidItemEntity;
import com.navprayas.bidding.fileupload.entity.ItemLotEntity;
@Repository
@Transactional
public class FileUploadDaoImp implements FileUploadDao{
	
	@Autowired
	SessionFactory sessionFactory;

	public void saveAuctionDataDao(ItemLotEntity itemLotEntity,BidItemEntity bidItemEntity) {
		// TODO Auto-generated method stub
		Integer bidItemEntity1 = (Integer) sessionFactory.getCurrentSession().save(bidItemEntity);
		itemLotEntity.setBidItemId(bidItemEntity1);
		itemLotEntity.setLotId(bidItemEntity1);
		System.out.println(itemLotEntity.getLotId());
		sessionFactory.getCurrentSession().save(itemLotEntity);
	}

	

	

}
