package com.navprayas.bidding.observer.reports.view;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.format.Colour;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.springframework.web.servlet.view.document.AbstractJExcelView;

import com.navprayas.bidding.common.dto.ReportSummary2;
import com.navprayas.bidding.common.dto.TotalReportSummary2;

public class ExeclObserverSummary2ReportView extends AbstractJExcelView {
	
	/**
	 * This method is used to generate Excel Sheet for Observer Summary2
	 */
	private static final String excelName = "ObserverSummary2Report.xls";
	   
	@Override
	protected void buildExcelDocument(Map<String, Object> model,WritableWorkbook workbook, HttpServletRequest request,
			   HttpServletResponse response) throws Exception {
		
		 List<ReportSummary2> reportSummary2List = (List<ReportSummary2>) model.get("list1");
		 List<TotalReportSummary2> totalReportSummary2List = (List<TotalReportSummary2>) model.get("list2");
		 
		 response.setHeader("Content-Disposition", "attachment; filename="+excelName);
		   
		   WritableSheet sheet = workbook.createSheet("Observer Summary2 Report", 0);
		   WritableFont wf = new WritableFont(WritableFont.ARIAL, 10,WritableFont.BOLD);
		   WritableCellFormat hdrFmt = new WritableCellFormat(wf);
		   hdrFmt.setBackground(Colour.LIGHT_ORANGE);
	  
	   	   int colNum = 0;
	   	sheet.addCell(new Label(colNum++, 0, "Sr. No.",hdrFmt));	      
	   	sheet.addCell(new Label(colNum++, 0, "Category Name",hdrFmt));	          
        sheet.addCell(new Label(colNum++, 0, "TotalLots For Sales ",hdrFmt));
        sheet.addCell(new Label(colNum++, 0, "TotalQuantity For Sales ",hdrFmt));
        sheet.addCell(new Label(colNum++, 0, "ActualLots Sold ",hdrFmt));
        sheet.addCell(new Label(colNum++, 0, "ActualQuantity Sold ",hdrFmt)); 
        sheet.addCell(new Label(colNum++, 0, "ActualAmount Sold",hdrFmt));
        sheet.addCell(new Label(colNum++, 0, "Average Amount",hdrFmt));
        sheet.addCell(new Label(colNum++, 0, "UnsoldLots(Bidded)",hdrFmt));
        sheet.addCell(new Label(colNum++, 0, "Unsold Quantity(Bidded)",hdrFmt));
        sheet.addCell(new Label(colNum++, 0, "UnSold Lots(Non-Bidded)",hdrFmt));
        sheet.addCell(new Label(colNum++, 0, "UnSold Qunatity(Non-Bidded)",hdrFmt));
        
        
        //Setting Column Width
        for(int x=0; x<colNum; x++){               
            sheet.setColumnView(x, 15);
        }        
        
        int rowNum = 1;
        int serNo = 1;
        
        for (ReportSummary2 reportSummary2 : reportSummary2List) {
            //create the row data
			   
	        colNum = 0;
	        sheet.addCell(new Label(colNum++, rowNum, serNo+""));	
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getCategoryName()));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getTotalLotsForSale()+""));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getTotalLotsquantityForSale()+""));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getTotalActualSoldLots()+""));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getTotalActualSoldQunatity()+""));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getTotalActualSoldAmount()+""));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getAvergeAmount()+""));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getTotalUnsoldBiddedLots()+""));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getTotalUnsoldBiddedQuantity()+""));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getTotalUnsoldUnBiddedLots()+""));
	        sheet.addCell(new Label(colNum++, rowNum, reportSummary2.getTotalUnsoldUnBiddedQuantity()+""));
	        serNo++;
	        rowNum++;
        	
        }
        for (TotalReportSummary2 totalReportSummary2 : totalReportSummary2List) {
            //create the row data
			   
	        colNum = 0;
	        sheet.addCell(new Label(colNum++, rowNum, ""));	
	        sheet.addCell(new Label(colNum++, rowNum, "Total"));
	        sheet.addCell(new Label(colNum++, rowNum, totalReportSummary2.getGrandTotalLotsForSale()+""));
	        sheet.addCell(new Label(colNum++, rowNum, totalReportSummary2.getGrandTotalLotsquantityForSale()+""));
	        sheet.addCell(new Label(colNum++, rowNum, totalReportSummary2.getGrandTotalActualSoldLots()+""));
	        sheet.addCell(new Label(colNum++, rowNum, totalReportSummary2.getGrandTotalActualSoldQunatity()+""));
	        sheet.addCell(new Label(colNum++, rowNum, totalReportSummary2.getGrandTotalActualSoldAmount()+""));
	        sheet.addCell(new Label(colNum++, rowNum, totalReportSummary2.getAvergeTotalAmount()+""));
	        sheet.addCell(new Label(colNum++, rowNum, ""));
	        sheet.addCell(new Label(colNum++, rowNum, ""));
	        sheet.addCell(new Label(colNum++, rowNum, totalReportSummary2.getGrandTUnsoldUnBiddedLots()+""));
	        sheet.addCell(new Label(colNum++, rowNum, totalReportSummary2.getGrandTotalUnsoldUnBiddedQuantity()+""));
	       
	        rowNum++;
	        
	     }
	}
}
