package com.navprayas.bidding.bidder.controller;

import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.navprayas.bidding.common.form.BidItem;

@RequestMapping("/bidder/**")
@Controller
public class WriteExcelFile {

	public void writeWonListToExcelFile(String excel, List<BidItem> wonlist)
			throws Exception {
		Workbook workbook = null;

		if (excel.endsWith("xlsx")) {
			workbook = new XSSFWorkbook();
		} else if (excel.endsWith("xls")) {
			workbook = new HSSFWorkbook();
		} else {
			throw new Exception("Invalid file name, should be xls or xlsx");
		}

		Sheet sheet = workbook.createSheet("wonlist");
		
				/*// create row (3rd row)
		        Row r = sheet.createRow(11);
		        // add value to 3rd cell
		        r.createCell(11).setCellValue("*******WON BIDS*******");
		        // merge cells
		        sheet.addMergedRegion(// first row (0-based), last row (0-based), first column (0-based), last column (0-based)
		            new CellRangeAddress(2, 2, 2, 4));
		        // go to 4th row
		        r = sheet.createRow(12);
		        // add values to cells
		        r.createCell(12).setCellValue(" ");
		        r.createCell(13).setCellValue(" ");
		        r.createCell(14).setCellValue(" ");
		        r.createCell(15).setCellValue(" ");
		        r.createCell(16).setCellValue(" ");*/
		    
		
		Iterator<BidItem> iterator = wonlist.iterator();
		
		Row row1 = sheet.createRow(0);
		Cell c0 = row1.createCell(0);
		c0.setCellValue("Sr. No.");

		Cell c1 = row1.createCell(1);
		c1.setCellValue("Description");

		Cell c2 = row1.createCell(2);
		c2.setCellValue("Lot No");

		Cell c3 = row1.createCell(3);
		c3.setCellValue("Category Name");

		Cell c4 = row1.createCell(4);
		c4.setCellValue("Material Name");

		Cell c5 = row1.createCell(5);
		c5.setCellValue("Remark");

		Cell c6 = row1.createCell(6);
		c6.setCellValue("Length Range");

		Cell c7 = row1.createCell(7);
		c7.setCellValue("Actual Length(Approx)");

		Cell c8 = row1.createCell(8);
		c8.setCellValue("Quantity");

		int rowIndex = 1;
		int serNo = 1;
		while (iterator.hasNext()) {
			BidItem biditem = iterator.next();
			Row row = sheet.createRow(rowIndex++);

			Cell cell0 = row.createCell(0);
			cell0.setCellValue(serNo++);

			Cell cell1 = row.createCell(1);
			cell1.setCellValue("Desc");

			Cell cell2 = row.createCell(2);
			cell2.setCellValue(biditem.getItemLots().get(0).getLotId());

			Cell cell3 = row.createCell(3);
			cell3.setCellValue(biditem.getCategory().getCategoryName());

			Cell cell4 = row.createCell(4);
			cell4.setCellValue(biditem.getItemLots().get(0).getName());

			Cell cell5 = row.createCell(5);
			cell5.setCellValue(biditem.getItemLots().get(0).getRemark());

			Cell cell6 = row.createCell(6);
			cell6.setCellValue(biditem.getItemLots().get(0).getLengthRange());

			Cell cell7 = row.createCell(7);
			cell7.setCellValue(biditem.getItemLots().get(0).getActualLengh());

			Cell cell8 = row.createCell(8);
			cell8.setCellValue(biditem.getItemLots().get(0).getQuantity()
					 + biditem.getItemLots().get(0).getUnit());


		}
		
		for (int i = 0; i < 10; i++) {
			sheet.autoSizeColumn(i);
		}

		// CODE TO WRITE EXCEL FILE

		FileOutputStream fos = new FileOutputStream("excel.xls");
		workbook.write(fos);
		fos.close();
		System.out.println(excel + " written successfully");

	}

}
