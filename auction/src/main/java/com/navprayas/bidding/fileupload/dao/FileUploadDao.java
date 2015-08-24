package com.navprayas.bidding.fileupload.dao;

import com.navprayas.bidding.fileupload.entity.BidItemEntity;
import com.navprayas.bidding.fileupload.entity.ItemLotEntity;

public interface FileUploadDao {

	public void saveAuctionDataDao(ItemLotEntity itemLotEntity,BidItemEntity bidItemEntity);
}
