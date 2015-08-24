package com.navprayas.bidding.bidder.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Iterator;

import org.apache.poi.hssf.usermodel.HSSFSheet;
//POI libraries to read Excel File
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itextpdf.text.BaseColor;
//itext libraries to write PDF file
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

@RequestMapping("/bidder/**")
@Controller
public class ExcelToPdf {  
        public  void excelToPdfwriter() throws IOException, Exception{
                //First we read the Excel file in binary format into FileInputStream
                FileInputStream input_document = new FileInputStream(new File("excel.xls"));
               
                // Read workbook into HSSFWorkbook
                HSSFWorkbook workbook = new HSSFWorkbook(input_document); 
               
                // Read worksheet into HSSFSheet
               HSSFSheet sheet = workbook.getSheetAt(0); 
               
                
                // To iterate over the rows
                 Iterator<Row> rowIterator = sheet.iterator();
                
                 //We will create output PDF document objects at this point
                Document iText_xls_2_pdf = new Document(PageSize.A4, 0, 0, 0, 0);
                PdfWriter.getInstance(iText_xls_2_pdf, new FileOutputStream("Excel2PDF_Output.pdf"));
                iText_xls_2_pdf.open();
                
                //we have two columns in the Excel sheet, so we create a PDF table with two columns
                //Note: There are ways to make this dynamic in nature, if you want to.
                PdfPTable my_table = new PdfPTable(9);
                my_table.setWidthPercentage(100);
                my_table.setSpacingBefore(0f);
                my_table.setSpacingAfter(0f);
                //my_table.setWidths(new int[]{20,30,20,40,50,30,40,30,20});
                
                
                //We will use the object below to dynamically add new data to the table
                PdfPCell table_cell;
                PdfPCell cell0 = new PdfPCell(new Phrase("******* WON BIDS *******"));
                cell0.setColspan(10);
                cell0.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell0.setPadding(5.0f);
                cell0.setBackgroundColor(new BaseColor(140, 221, 8));
                my_table.addCell(cell0);
                
                //Loop through rows.
                while(rowIterator.hasNext()) {
                        Row row1 = rowIterator.next(); 
                        Iterator<Cell> cellIterator = row1.cellIterator();
                                while(cellIterator.hasNext()) {
                                        Cell cell = cellIterator.next(); //Fetch CELL
                                        
                                        switch(cell.getCellType()) { //Identify CELL type
                                                
                                        case Cell.CELL_TYPE_STRING:
                                                //Push the data from Excel to PDF Cell
                                        	     table_cell=new PdfPCell(new Phrase(cell.getStringCellValue()));
                          
                                                 //feel free to move the code below to suit to your needs
                                                 my_table.addCell(table_cell);
                                                 break;
                                        case Cell.CELL_TYPE_NUMERIC:
                                        	
                                        	//Push the data from Excel to PDF Cell
                                            table_cell=new PdfPCell(new Phrase(Double.toString(cell.getNumericCellValue())));
                                            //feel free to move the code below to suit to your needs
                                              my_table.addCell(table_cell);
                                           

                                                break;
                                        }
                                        //next line
                                }
                              
                            
                
                }
                //Finally add the table to PDF document
                iText_xls_2_pdf.add(my_table);                       
                iText_xls_2_pdf.close();                
                //we created our pdf file..
                input_document.close(); //close xls
        }
}
