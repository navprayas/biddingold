package com.navprayas.bidding.fileupload.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.navprayas.bidding.cretateauction.dao.CreateAuctionDao;
import com.navprayas.bidding.cretateauction.entity.CreateAuctionEntity;
import com.navprayas.bidding.fileupload.dao.FileUploadDao;
import com.navprayas.bidding.fileupload.entity.BidItemEntity;
import com.navprayas.bidding.fileupload.entity.ItemLotEntity;

@Service
@Transactional
public class FileUploadServiceImp implements FileUploadService {

	@Autowired
	FileUploadDao fileUploadDao;
	@Autowired
	private CreateAuctionDao createAuctionDao;

	@Override
	public String saveAuctionData(BidItemEntity bidItemEntity1,
			Long selectedAuctionId) throws IOException {
		// TODO Auto-generated method stub

		FileInputStream inputStream = (FileInputStream) (bidItemEntity1
				.getFile().getInputStream());
		POIFSFileSystem fs = new POIFSFileSystem(inputStream);
		HSSFWorkbook wb = new HSSFWorkbook(fs);
		HSSFSheet sheet = wb.getSheetAt(0);
		Row row;
		for (int i = 1; i <= sheet.getLastRowNum(); i++) {
			row = sheet.getRow(i);
			ItemLotEntity itemLotEntity = new ItemLotEntity();
			BidItemEntity bidItemEntity = new BidItemEntity();

			// Biditem table data
			// bidItemEntity.setAuctionId(selectedAuctionId);
			bidItemEntity.setName(row.getCell(4).getStringCellValue());
			bidItemEntity.setLocation(row.getCell(15).getStringCellValue());
			bidItemEntity.setCity(row.getCell(16).getStringCellValue());
			// .setZone(row.getCell(9).getStringCellValue());
			bidItemEntity.setMinBidPrice(row.getCell(11).getNumericCellValue());
			bidItemEntity.setMinBidIncrement(row.getCell(12)
					.getNumericCellValue());
			bidItemEntity.setBidStartTime(null);
			bidItemEntity.setBidEndTime(null);
			bidItemEntity.setTimeExtn((int) row.getCell(13)
					.getNumericCellValue());
			bidItemEntity.setStatusCode("Start");
			bidItemEntity.setCategoryId(2);
			bidItemEntity.setMarketId(1);
			bidItemEntity.setCurrency(row.getCell(14).getStringCellValue());
			bidItemEntity
					.setLastUpdateTime(new Timestamp(new Date().getTime()));
			bidItemEntity.setCreatedTime(new Timestamp(new Date().getTime()));
			bidItemEntity.setAutobidid(0);
			bidItemEntity.setAutobiddername(null);
			bidItemEntity.setBiddername(null);
			bidItemEntity.setSerialNumber(Double.toString(row.getCell(0)
					.getNumericCellValue()));
			bidItemEntity.setCurrentMarketPrice(row.getCell(10)
					.getNumericCellValue());
			bidItemEntity.setIsProcessed(null);
			bidItemEntity.setInitialStartTime(3);
			bidItemEntity.setDocument(null);
			// bidItemEntity.setMain1(row.getCell(1).getStringCellValue());
			// bidItemEntity.setDesc1(row.getCell(2).getStringCellValue());
			bidItemEntity.setNocolum(row.getCell(6).getStringCellValue());

			// Itemlot table data
			itemLotEntity.setName(row.getCell(4).getStringCellValue());
			itemLotEntity.setLotId(bidItemEntity.getBidItemId());
			itemLotEntity.setBidItemId(bidItemEntity.getBidItemId());
			itemLotEntity.setLengthRange(row.getCell(7).getStringCellValue());
			itemLotEntity.setActualLength(null);
			itemLotEntity.setQuantity((int) row.getCell(8)
					.getNumericCellValue());
			itemLotEntity.setUnit(null);
			itemLotEntity.setCurrency(row.getCell(14).getStringCellValue());
			itemLotEntity.setRemark(row.getCell(5).getStringCellValue());
			itemLotEntity.setZone(row.getCell(9).getStringCellValue());
			itemLotEntity.setLOTNO((int) row.getCell(3).getNumericCellValue());
			// New Auctio is created here then bid item uploaded
			// This code added by Ashish started here
			CreateAuctionEntity createAuction = new CreateAuctionEntity();
			createAuction.setName(sheet.getSheetName());
			createAuction.setIsApproved("0");
			createAuction.setStatus("Start");
			createAuction.setCreatedTime(new Timestamp(new Date().getTime()));
			String auctionId = createAuctionDao.save(createAuction);
			if (auctionId != null) {
				bidItemEntity.setAuctionId(Long.parseLong(auctionId));
				// This code added by Ashish Ended here
				fileUploadDao.saveAuctionDataDao(itemLotEntity, bidItemEntity);
			}
		}

		return null;
	}
}
