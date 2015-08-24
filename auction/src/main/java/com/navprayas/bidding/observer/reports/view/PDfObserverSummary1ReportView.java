package com.navprayas.bidding.observer.reports.view;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.write.Label;

import org.springframework.web.servlet.view.document.AbstractPdfView;

import com.lowagie.text.Cell;
import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.navprayas.bidding.common.form.Bids;
import com.navprayas.bidding.common.form.ItemLot;

public class PDfObserverSummary1ReportView extends AbstractPdfView {

	/**
	 * This method is used to generate PDF Sheet for Basic Employer
	 */
	private static final String pdfName = "ObserverSummary1Report.pdf";

	@Override
	protected void buildPdfDocument(Map<String, Object> model,
			Document document, PdfWriter writer, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		List<Bids> bidsList = (List<Bids>) model.get("list");
		File file = new File(pdfName);
		FileOutputStream fileout = new FileOutputStream(file);
		PdfWriter.getInstance(document, fileout);

		document.open();

		Chunk chunk = new Chunk("Observer Summary Report");
		Font font = new Font(Font.TIMES_ROMAN);

		font.setStyle(Font.UNDERLINE);
		font.setStyle(Font.ITALIC);
		font.setSize(9);
		chunk.setFont(font);
		document.add(chunk);
		Paragraph paragraph = new Paragraph();
		paragraph.add("Summary Report");
		paragraph.setAlignment(Element.ALIGN_CENTER);
		document.add(paragraph);
		document.add(new Chunk(" "));
		PdfPTable table = new PdfPTable(19); // 19 columns.
		table.setTotalWidth(350);
		table.setWidthPercentage(100);
		int []a={3,3,3,3,6,3,4,3,3,3,3,3,3,3,3,3,3,3,3};
		table.setWidths(a);
		table.addCell(getCell("Sr. No.", Element.ALIGN_CENTER));
		table.addCell(getCell("Description", Element.ALIGN_CENTER));
		table.addCell(getCell("Lot No", Element.ALIGN_CENTER));
		table.addCell(getCell("Category", Element.ALIGN_CENTER));
		table.addCell(getCell("Market Name", Element.ALIGN_CENTER));
		table.addCell(getCell("Remark", Element.ALIGN_CENTER));
		table.addCell(getCell("Length Range", Element.ALIGN_CENTER));
		table.addCell(getCell("Actual Length(Approx)", Element.ALIGN_CENTER));
		table.addCell(getCell("Quantity", Element.ALIGN_CENTER));
		table.addCell(getCell("Zone", Element.ALIGN_CENTER));
		table.addCell(getCell("H1 Company Name", Element.ALIGN_CENTER));
		table.addCell(getCell("H1 Bid Price", Element.ALIGN_CENTER));
		table.addCell(getCell("H2 Company Name", Element.ALIGN_CENTER));
		table.addCell(getCell("H2 Bid Price", Element.ALIGN_CENTER));
		table.addCell(getCell("H3 Company Name", Element.ALIGN_CENTER));
		table.addCell(getCell("H3 Bid Price", Element.ALIGN_CENTER));
		table.addCell(getCell("Lot's Status", Element.ALIGN_CENTER));
		table.addCell(getCell("Sales Price", Element.ALIGN_CENTER));
		table.addCell(getCell("Total Sales(Qty X SalesPrice)",
				Element.ALIGN_CENTER));

		// columns value from list collections
		int serNo = 1;

		for (Bids bids : bidsList) {
			// create the row data
			table.addCell(getCell(String.valueOf(serNo), Element.ALIGN_CENTER));
			table.addCell(getCell("Desc", Element.ALIGN_CENTER));
			table.addCell(getCell(bids.getBidItem().getBidItemId().toString()
					+ "", Element.ALIGN_CENTER));
			table.addCell(getCell(bids.getBidItem().getCategory()
					.getCategoryName().toString(), Element.ALIGN_CENTER));
			table.addCell(getCell(bids.getBidItem().getName(),
					Element.ALIGN_CENTER));
			if (bids.getBidItem().getItemLots().size() == 1) {
				for (ItemLot itemLots : bids.getBidItem().getItemLots()) {
					table.addCell(getCell(itemLots.getRemark().toString(),
							Element.ALIGN_CENTER));
					table.addCell(getCell(itemLots.getLengthRange() + "",
							Element.ALIGN_CENTER));
					table.addCell(getCell(itemLots.getActualLengh() + "",
							Element.ALIGN_CENTER));
				}
			} else if (bids.getBidItem().getItemLots().size() > 1) {

				table.addCell(getCell("", Element.ALIGN_CENTER));
				table.addCell(getCell("", Element.ALIGN_CENTER));
				table.addCell(getCell("", Element.ALIGN_CENTER));
			}
			table.addCell(getCell(bids.getBidItem().getTotalQuantity() + " "
					+ bids.getBidItem().getUnit(), Element.ALIGN_CENTER));

			table.addCell(getCell(bids.getBidItem().getZone(),
					Element.ALIGN_CENTER));
			table.addCell(getCell(bids.getBidderName(), Element.ALIGN_CENTER));
			table.addCell(getCell(bids.getBidAmount() + "",
					Element.ALIGN_CENTER));
			table.addCell(getCell(bids.getBidderName2(), Element.ALIGN_CENTER));
			if (bids.getBidAmount2() != null) {
				table.addCell(getCell(bids.getBidAmount2() + "",
						Element.ALIGN_CENTER));
			} else {
				table.addCell(getCell("", Element.ALIGN_CENTER));
			}

			table.addCell(getCell(bids.getBidderName3(), Element.ALIGN_CENTER));
			if (bids.getBidAmount3() != null) {
				table.addCell(getCell(bids.getBidAmount3().toString(),
						Element.ALIGN_CENTER));
			} else {
				table.addCell(getCell("", Element.ALIGN_CENTER));
			}

			table.addCell(getCell(bids.getBidItem().getIsProcessed(),
					Element.ALIGN_CENTER));
			if (bids.getSalesPrice() != null) {
				table.addCell(getCell(bids.getSalesPrice() + "",
						Element.ALIGN_CENTER));
			} else {
				table.addCell(getCell("", Element.ALIGN_CENTER));
			}
			if (bids.getTotalSalesPrice() != null) {
				table.addCell(getCell(bids.getTotalSalesPrice() + "",
						Element.ALIGN_CENTER));
			} else {
				table.addCell(getCell("", Element.ALIGN_CENTER));
			}
			if (bids.getBidItem().getItemLots().size() > 1) {

				for (ItemLot itemLots : bids.getBidItem().getItemLots()) {

					table.addCell(getCell(itemLots.getLotId() + "",
							Element.ALIGN_CENTER));
					table.addCell(getCell(bids.getBidItem().getCategory()
							.getCategoryName(), Element.ALIGN_CENTER));
					table.addCell(getCell(itemLots.getName(),
							Element.ALIGN_CENTER));
					table.addCell(getCell(itemLots.getRemark(),
							Element.ALIGN_CENTER));
					table.addCell(getCell(itemLots.getLengthRange(),
							Element.ALIGN_CENTER));
					table.addCell(getCell(itemLots.getActualLengh(),
							Element.ALIGN_CENTER));
					table.addCell(getCell(itemLots.getQuantity() + " "
							+ itemLots.getUnit(), Element.ALIGN_CENTER));

				}
			}

			serNo++;
		}

		document.add(table);
	}

	private PdfPCell getCell(String content, int alignment) {
		// PdfPCell cell = new PdfPCell(new Phrase(content));
		if (content == null || content.equalsIgnoreCase("null")) {
			content = "";
		}
		Font font = new Font();
		font.setSize(8);
		Chunk chunk = new Chunk(content);
		chunk.setFont(font);
		PdfPCell cell = new PdfPCell(new Paragraph(chunk));
		cell.setVerticalAlignment(alignment);
		return cell;
	}
}
