package com.navprayas.bidding.fileupload.service;


import java.io.IOException;




import com.navprayas.bidding.fileupload.entity.BidItemEntity;
import com.navprayas.bidding.fileupload.entity.ItemLotEntity;


public interface FileUploadService {

	public String saveAuctionData(BidItemEntity bidItemEntity, Long selectedAuctionId) throws IOException ;
}
