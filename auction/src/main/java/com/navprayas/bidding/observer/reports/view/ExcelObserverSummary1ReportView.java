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

import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.common.form.ItemLot;

public class ExcelObserverSummary1ReportView extends AbstractJExcelView{

	/**
	 * This method is used to generate Excel Sheet for Basic Employer
	 */
	private static final String excelName = "ObserverSummary1Report.xls";
	   
	@Override
	protected void buildExcelDocument(Map<String, Object> model,WritableWorkbook workbook, HttpServletRequest request,
			   HttpServletResponse response) throws Exception {
		
			   List<Bids> bidsList = (List<Bids>) model.get("list");	
			  
			   
			   response.setHeader("Content-Disposition", "attachment; filename="+excelName);
			  
			   WritableSheet sheet = workbook.createSheet("Observer Summary1 Report", 0);
			   
			   WritableFont wf = new WritableFont(WritableFont.ARIAL, 10,WritableFont.BOLD);
			   WritableCellFormat hdrFmt = new WritableCellFormat(wf);
			   hdrFmt.setBackground(Colour.LIGHT_ORANGE);
		  
		   	   int colNum = 0;
	           sheet.addCell(new Label(colNum++, 0, "Sr. No.",hdrFmt));	          
	           sheet.addCell(new Label(colNum++, 0, "Description ",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Lot No ",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Category ",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Market Name ",hdrFmt)); 
	           sheet.addCell(new Label(colNum++, 0, "Remark",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Length Range",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Actual Length(Approx)",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Quantity",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Zone",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "H1 Company Name",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "H1 Bid Price",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "H2 Company Name",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "H2 Bid Price",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "H3 Company Name",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "H3 Bid Price",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Lot's Status", hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Sales Price ",hdrFmt));
	           sheet.addCell(new Label(colNum++, 0, "Total Sales(Qty X SalesPrice)",hdrFmt));
	           
	          
	         //Setting Column Width
	           for(int x=0; x<colNum; x++){               
	               sheet.setColumnView(x, 15);
	           }        
	           
	           int rowNum = 1;
	           int serNo = 1;
		   for (Bids bids : bidsList) {
			//create the row data
			   
		        colNum = 0;
		        sheet.addCell(new Label(colNum++, rowNum, serNo+""));				   		
			    sheet.addCell(new Label(colNum++, rowNum,"Desc"));
			    sheet.addCell(new Label(colNum++, rowNum, bids.getBidItem().getBidItemId()+""));
		        sheet.addCell(new Label(colNum++, rowNum, bids.getBidItem().getCategory().getCategoryName()));
		        sheet.addCell(new Label(colNum++, rowNum, bids.getBidItem().getName()));
		        if(bids.getBidItem().getItemLots().size()==1)
		        {
		            for(ItemLot itemLots : bids.getBidItem().getItemLots())
		             {
				        sheet.addCell(new Label(colNum++, rowNum,itemLots.getRemark()));
				        sheet.addCell(new Label(colNum++, rowNum,itemLots.getLengthRange()+""));
				        sheet.addCell(new Label(colNum++, rowNum,itemLots.getActualLengh()+""));
		             }
		        } else if(bids.getBidItem().getItemLots().size()>1)
		        {
		        	
		        	sheet.addCell(new Label(colNum++, rowNum,""));
			        sheet.addCell(new Label(colNum++, rowNum,""));
			        sheet.addCell(new Label(colNum++, rowNum,""));
		        }
		        sheet.addCell(new Label(colNum++, rowNum, bids.getBidItem().getTotalQuantity()+" "+bids.getBidItem().getUnit()));		       
		
		        sheet.addCell(new Label(colNum++, rowNum, bids.getBidItem().getZone()));
		        sheet.addCell(new Label(colNum++, rowNum, bids.getBidderName()));			        
		        sheet.addCell(new Label(colNum++, rowNum, bids.getBidAmount()+""));
		        sheet.addCell(new Label(colNum++, rowNum, bids.getBidderName2()));
		        if(bids.getBidAmount2() != null){
		        	sheet.addCell(new Label(colNum++, rowNum, bids.getBidAmount2()+""));
		        }else{
		        	sheet.addCell(new Label(colNum++, rowNum,""));
		        }		        
		        
		        sheet.addCell(new Label(colNum++, rowNum, bids.getBidderName3()));
		        if(bids.getBidAmount3() != null){
		        	sheet.addCell(new Label(colNum++, rowNum, bids.getBidAmount3()+""));
		        }else{
		        	sheet.addCell(new Label(colNum++, rowNum,""));
		        }
		        
		        sheet.addCell(new Label(colNum++, rowNum, bids.getBidItem().getIsProcessed()));
		        if(bids.getSalesPrice() != null){
		        	sheet.addCell(new Label(colNum++, rowNum, bids.getSalesPrice()+""));
		        } else {
		        	sheet.addCell(new Label(colNum++, rowNum, ""));
		        }
		        if(bids.getTotalSalesPrice() != null){
		        	sheet.addCell(new Label(colNum++, rowNum, bids.getTotalSalesPrice()+""));
		        }else {
		        	sheet.addCell(new Label(colNum++, rowNum, ""));
		        }
		        if(bids.getBidItem().getItemLots().size()>1)
		        {	        	
		        		        	
		        	for(ItemLot itemLots : bids.getBidItem().getItemLots())
		            {
		        		rowNum++;
		        		colNum = 2;	
		        	 	sheet.addCell(new Label(colNum++, rowNum, itemLots.getLotId()+""));		
		        	    sheet.addCell(new Label(colNum++, rowNum, bids.getBidItem().getCategory().getCategoryName()));
				        sheet.addCell(new Label(colNum++, rowNum, itemLots.getName()));
				        sheet.addCell(new Label(colNum++, rowNum,itemLots.getRemark()));
				        sheet.addCell(new Label(colNum++, rowNum,itemLots.getLengthRange()));
				        sheet.addCell(new Label(colNum++, rowNum,itemLots.getActualLengh()));
				        sheet.addCell(new Label(colNum++, rowNum, itemLots.getQuantity()+" "+itemLots.getUnit()));
		        	
		          }
		        }
		        
		        rowNum++;  
		        serNo++;
	           }

	}

	

}

