<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/" var="static_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<%@page import="java.util.Date"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction_Bidder Report</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
<link type="text/css" rel="stylesheet"
	href="${css_url}/dhtmlgoodies_calendar.css?random=20051112"
	media="screen"></link>
<script type="text/javascript"
	src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript">

function onSubmit() {
		//document.dateForm.action="${form_url}";
		return validate();

	}

	function onSubmitExcel() {
		document.dateForm.action = "${excelURL}";
		document.dateForm.submit();

		//return validate();
	}
	var DateDiff = {

		inDays : function(d1, d2) {
			var t2 = d2.getTime();
			var t1 = d1.getTime();

			return parseInt((t2 - t1) / (24 * 3600 * 1000));
		},

		inWeeks : function(d1, d2) {
			var t2 = d2.getTime();
			var t1 = d1.getTime();

			return parseInt((t2 - t1) / (24 * 3600 * 1000 * 7));
		},

		inMonths : function(d1, d2) {
			var d1Y = d1.getFullYear();
			var d2Y = d2.getFullYear();
			var d1M = d1.getMonth();
			var d2M = d2.getMonth();

			return (d2M + 12 * d2Y) - (d1M + 12 * d1Y);
		},

		inYears : function(d1, d2) {
			return d2.getFullYear() - d1.getFullYear();
		}
	};
	function validate() {
		var status = true;
		var fromDate = document.getElementById("dateFrom").value;
		var toDate = document.getElementById("dateTo").value;

		if (fromDate == null || fromDate == '') {
			alert("From Date cannot be empty");
			return false;
		} else if (toDate == null || toDate == '') {
			alert("To Date cannot be empty");
			return false;
		} else {
			//DATE COMPARISON		
			var dt1 = parseInt(fromDate.substring(0, 2), 10);
			var mon1 = parseInt(fromDate.substring(3, 5), 10);
			var yr1 = parseInt(fromDate.substring(6, 10), 10);

			var dt2 = parseInt(toDate.substring(0, 2), 10);
			var mon2 = parseInt(toDate.substring(3, 5), 10);
			var yr2 = parseInt(toDate.substring(6, 10), 10);

			var date1 = new Date(yr1, mon1 - 1, dt1);
			var date2 = new Date(yr2, mon2 - 1, dt2);

			if (date2 < date1) {
				alert("From Date cannot be greater than To Date");
				return false;
			}
			if (DateDiff.inDays(date1, date2) > 30) {
				alert("The date range can not be more than 30 days.");
				return false;
			}
		}
		return status;
	}
</script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" rel="stylesheet"
	href="${css_url}/dhtmlgoodies_calendar.css?random=20051112"
	media="screen"></link>
<script type="text/javascript"
	src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript">
	$(function() {
		// Dialog			
		+$('.desc').dialog({
			autoOpen : false,
			width : 'auto',
		});
		$('.bids').dialog({
			autoOpen : false,
			width : 'auto',
		});
		$('.removediv').dialog({
			autoOpen : false,
			width : 'auto',
		});
		$('.change').dialog({
			autoOpen : false,
			width : 'auto',
			height : 110,
		});

		// Dialog Link

		$('.description').click(function() {

			//$('.desc').dialog('open');
			$('#dialog_' + $(this).attr('id')).dialog('open');
			return false;
		});
		$('.autobid').click(function() {

			$('.bids').dialog('open');
			return false;
		});
		$('.remove').click(function() {

			$('.removediv').dialog('open');
			return false;
		});
		$('.changepass').click(function() {

			$('.change').dialog('open');
			return false;
		});

	});
</script>

</head>

<body>
	<%@ include file="/WEB-INF/jsp/bidder/bidder_report_top.jsp"%>
	<div class="Mian">
		<div id="dhtmltooltip"></div>
		<script type="text/javascript">
			pathToImages = "${static_url}" + pathToImages;
		</script>

		<style>
.tbl-first {
	width: 60%;
	float: left;
}

.tbl-second {
	width: 40%;
	float: left;
}

.tbl-second table {
	margin-top: 10px;
	margin-bottom: 10px;
}
</style>


		<div class="CheckBox=Menu">
			<div class="tbl-first">
				<form style="margin: 0px;" action="bidderReport1" name="dateForm">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="13%" height="29" align="left" valign="middle">Select
								Date From</td>
							<td width="13%" align="left" valign="middle"><input
								type="text" id="dateFrom"
								value="<c:out value='${dateFromStr}' />" readonly
								name="paramDateFrom"
								onclick="displayCalendar(document.dateForm.dateFrom,'dd/mm/yyyy',this)"></td>
							<td width="2%" align="left" valign="middle">To</td>
							<td width="78%" align="left" valign="middle"><input
								type="text" id="dateTo" value="<c:out value='${dateToStr}' />"
								readonly name="paramDateTo"
								onclick="displayCalendar(document.dateForm.dateTo,'dd/mm/yyyy',this)">
									<input type="submit" name="Submit" value="Go"
									onclick="return onSubmit();" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div class="tbl-second">

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="20%"><a href="bidder/downloadExcel"
							class="ui-state-default ui-corner-all">Save As Excel </a></td>
						<td width="20%"><a href="bidder/downloadPdf"
							class="ui-state-default ui-corner-all">Save As PDF </a></td>
						<!-- <td width="30%"><a href="bidder/print"
							class="ui-state-default ui-corner-all">Print</a></td> -->
					</tr>
				</table>
			</div>

		</div>
		
		<div class="CheckBoxMenu">

			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="84%" height="29" align="left" valign="middle"
						class="WonTitle">My Won Bids in the given Date Range</td>
					<td width="16%" align="left" valign="middle">&nbsp;</td>
				</tr>
			</table>
		</div>
		<div class="DetailDiv">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="4%" height="40" align="center" valign="middle"
						bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#"
						onmouseover="ddrivetip('Sr No','', 'auto')"
						;
              onmouseout="hideddrivetip()" class="TitleLink">Sr.
							No</a></td>
					<td width="7%" height="40" align="center" valign="middle"
						bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#"
						onmouseover="ddrivetip('Description','', 'auto')"
						;
onmouseout="hideddrivetip()" class="TitleLink">Description</a></td>
					<td width="7%" align="center" valign="middle" bgcolor="#4f81bc"
						class="DetailBorRightTitle"><a href="#"
						onmouseover="ddrivetip('Lot No','', 'auto')"
						;
onmouseout="hideddrivetip()" class="TitleLink">Lot No.</a></td>

					<td width="11%" align="center" valign="middle" bgcolor="#4f81bc"
						class="DetailBorRightTitle"><a href="#"
						onmouseover="ddrivetip('Category Name','', 'auto')"
						;
onmouseout="hideddrivetip()" class="TitleLink">Category
							Name</a></td>

					<td width="9%" align="center" valign="middle" bgcolor="#4f81bc"
						class="DetailBorRightTitle"><a href="#"
						onmouseover="ddrivetip('Material Name','', 'auto')"
						;
onmouseout="hideddrivetip()" class="TitleLink">Material
							Name</a></td>
					<td width="8%" align="center" valign="middle" bgcolor="#4f81bc"
						class="DetailBorRightTitle"><a href="#"
						onmouseover="ddrivetip('Remark','', 'auto')"
						;
onmouseout="hideddrivetip()" class="TitleLink">Remark</a></td>
					<td width="9%" align="center" valign="middle" bgcolor="#4f81bc"
						class="DetailBorRightTitle"><a href="#"
						onmouseover="ddrivetip('Length Range','', 'auto')"
						;
onmouseout="hideddrivetip()" class="TitleLink">Length Range</a></td>
					<td width="9%" align="center" valign="middle" bgcolor="#4f81bc"
						class="DetailBorRightTitle"><a href="#"
						onmouseover="ddrivetip('Actual Length','', 'auto')"
						;
onmouseout="hideddrivetip()" class="TitleLink">Actual
							Length<br /> (Approx)
					</a></td>
					<td width="6%" align="center" valign="middle" bgcolor="#4f81bc"
						class="DetailBorRightTitle"><a href="#"
						onmouseover="ddrivetip('Quantity','', 'auto')"
						;
onmouseout="hideddrivetip()" class="TitleLink">Quantity</a></td>
				</tr>
				
				
				<c:forEach items="${wonList}" var="bidItem" varStatus="status">
				<tr class="table">
						<td height="40" align="center" valign="middle"
							class="DetailBorRight">${status.index+1}</td>

												<td align="center" valign="middle" class="DetailBorRight">


							<div id="dialog_desc${status.index+1}" class="desc"
								title="Item Description" style="display: none;">
								<table width="700" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="left" valign="top"><form name="form1"
												method="post" action="" style="margin: 0px;">
												<table width="700" border="0" cellspacing="0"
													cellpadding="0">
													<tr></tr>
													<tr>
														<td width="49" height="30" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Sr.
															No.</td>
														<td width="92" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Category</td>
														<td width="56" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Lot
															No.</td>
														<td width="131" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Materials
															Name</td>
														<td width="64" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Remark</td>
														<td width="96" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Length
															Range</td>
														<td width="125" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Actual
															Length <br> (Approx) 
														</td>
														<td width="87" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Qty</td>
													</tr>


													<tr>
														<td height="30" align="center" valign="middle"
															bgcolor="#f7c794" style="border-right: 1px solid #fff;">${status.index+1}.
														</td>
														<td align="center" valign="middle" bgcolor="#f7c794"
															style="border-right: 1px solid #fff;">${bidItem.category.categoryName}</td>
														<td align="center" valign="middle" bgcolor="#f7c794"
															style="border-right: 1px solid #fff;">${bidItem.bidItemId}</td>
														<td align="center" valign="middle" bgcolor="#f7c794"
															style="border-right: 1px solid #fff;">${bidItem.name}</td>
														<c:if test="${fn:length(bidItem.itemLots) == 1}">
															<c:forEach items="${bidItem.itemLots}"
																var="itemLotUnique" varStatus="status2">
																<td align="center" valign="middle" bgcolor="#f7c794"
																	style="border-right: 1px solid #fff;">${itemLotUnique.remark}</td>
																<td align="center" valign="middle" bgcolor="#f7c794"
																	style="border-right: 1px solid #fff;">${itemLotUnique.lengthRange}</td>
																<td align="center" valign="middle" bgcolor="#f7c794"
																	style="border-right: 1px solid #fff;">${itemLotUnique.actualLengh}</td>
															</c:forEach>
														</c:if>
														<c:if test="${fn:length(bidItem.itemLots) > 1}">
															<td align="center" valign="middle" bgcolor="#f7c794"
																style="border-right: 1px solid #fff;">&nbsp;</td>
															<td align="center" valign="middle" bgcolor="#f7c794"
																style="border-right: 1px solid #fff;">&nbsp;</td>
															<td align="center" valign="middle" bgcolor="#f7c794"
																style="border-right: 1px solid #fff;">&nbsp;</td>
														</c:if>
														<td align="center" valign="middle" bgcolor="#f7c794"
															style="border-right: 1px solid #fff;">${bidItem.totalQuantity}
															${bidItem.unit}</td>
													</tr>


													<c:if test="${fn:length(bidItem.itemLots) > 1}">
														<c:forEach items="${bidItem.itemLots}" var="itemLot"
															varStatus="status1">
															<tr>
																<td height="30" align="center" valign="middle"
																	bgcolor="#f0f3ea" style="border-right: 1px solid #fff;">${status1.index+1}
																</td>
																<td align="center" valign="middle" bgcolor="#f0f3ea"
																	style="border-right: 1px solid #fff;">${bidItem.category.categoryName}</td>
																<td align="center" valign="middle" bgcolor="#f0f3ea"
																	style="border-right: 1px solid #fff;">${itemLot.lotId}</td>
																<td align="center" valign="middle" bgcolor="#f0f3ea"
																	style="border-right: 1px solid #fff;">${itemLot.name}</td>
																<td align="center" valign="middle" bgcolor="#f0f3ea"
																	style="border-right: 1px solid #fff;">${itemLot.remark}</td>
																<td align="center" valign="middle" bgcolor="#f0f3ea"
																	style="border-right: 1px solid #fff;">${itemLot.lengthRange}</td>
																<td align="center" valign="middle" bgcolor="#f0f3ea"
																	style="border-right: 1px solid #fff;">${itemLot.actualLengh}</td>
																<td align="center" valign="middle" bgcolor="#f0f3ea"
																	style="border-right: 1px solid #fff;">${itemLot.quantity}
																	${itemLot.unit}</td>
															</tr>
														</c:forEach>
													</c:if>
												</table>
											</form></td>
									</tr>
								</table>
							</div> <input type="submit" name="button3" id="desc${status.index+1}"
							value="Desc" class="description ui-state-default ui-corner-all" />
						
						</td>	
						
						
						<td align="center" valign="middle" class="DetailBorRight">${bidItem.bidItemId}</td>
						<td align="center" valign="middle" class="DetailBorRight">${bidItem.category.categoryName}</td>
						<td align="center" valign="middle" class="DetailBorRight"><a
							href="#services" class="LinkSelected">${bidItem.name}</a></td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight">${bidItem.totalQuantity}
							${bidItem.unit}</td>
					</tr>
									
						</c:forEach>
		
		
		</table>
		
		</div>
		<div class="GreenSpacer"></div>



	</div>
	


	<div class="AutoBidBlue"></div>
	<div class="Footer">© Copyright 2011 Navprayas</div>
	<div class="clr"></div>
</body>
</html>