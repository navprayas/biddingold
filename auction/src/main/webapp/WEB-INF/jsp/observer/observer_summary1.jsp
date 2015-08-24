<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<spring:url value="/static/" var="static_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<spring:url value="/report/observerSummary2" var="report_summary2_url" />
<spring:url value="/report/observerSummary1" var="report_summary1_url" />
<spring:url value="/report/observerBidderWise"
	var="report_bidderwise_url" />
<spring:url value="/report/observerSummary1/Search/page" var="form_url" />
<spring:url value="/report/observerSummary1/Search/Category"
	var="categoryUrl" />
<spring:url value="/report/observerSummary1/find/excel" var="excelURL" />
<spring:url value="/report/observerSummary1/LotsStatus/List"
	var="lots_url" />
<spring:url value="/report/observerSummary1/find/pdf" var="pdfURL" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<script language="JavaScript">
	function onSubmit() {
		document.dateForm.action = "${form_url}";
		return validate();
	}

	function onSubmitExcel() {
		document.dateForm.action = "${excelURL}";
		document.dateForm.submit();

		//return validate();
	}

	function onSubmitPDF() {
		document.dateForm.action = "${pdfURL}";

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
	function getResultForCategory(categoryId) {
		document.dateForm.categoryId.value = categoryId;
		document.dateForm.action = "${categoryUrl}";
		document.dateForm.submit();
	}

	function getResultForLotStatus(lotsStat) {
		alert(lotsStat);
		document.dateForm.lotsStatus.value = lotsStat;
		var index = document.getElementById("category").selectedIndex;
		var itemName = document.getElementById("category").options[index].value;
		document.dateForm.categoryId.value = itemName;

		document.dateForm.action = "${lots_url}";
		document.dateForm.submit();
		/* if(validate()){
			 alert("After Validation");
			 document.dateForm.submit();
		 }*/

		return false;
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
<link type="text/css" href="${css_url}/custom.css" rel="stylesheet" />
<%-- <script type="text/javascript" src="${js_url}/tooltip.js"></script> --%>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript">
	$(function() {
		/* // Dialog			

		$('.desc').dialog({
			autoOpen : false,
			width : 'auto',
		});
		$('.partici').dialog({
			autoOpen : false,
			width : 'auto',
		});
		$('.bidhistory').dialog({
			autoOpen : false,
			width : 'auto',
			height : 310,
		});
		$('.biddetail').dialog({
			autoOpen : false,
			width : 'auto',
		});
		$('.textension').dialog({
			autoOpen : false,
			width : 'auto',
			height : 310,
		});
		$('.change').dialog({
			autoOpen : false,
			width : 'auto',
			height : 110,
		});

		$('.description').click(function() {

			//$('.desc').dialog('open');
			$('#dialog_' + $(this).attr('id')).dialog('open');
			return false;
		});

		$('.partcipents').click(function() {

			$('.partici').dialog('open');
			return false;
		});
		$('.history').click(function() {

			$('.bidhistory').dialog('open');
			return false;
		});
		$('.detail').click(function() {

			$('.biddetail').dialog('open');
			return false;
		});
		$('.time').click(function() {

			$('.textension').dialog('open');
			return false;
		});
		$('.changepass').click(function() {

			$('.change').dialog('open');
			return false;
		});

	}); */
</script>
<script type="text/javascript">
	/* $(function() {
		$(".desc").dialog({
			bgiframe : false,
			modal : true,

		});

		$(".partici").dialog({
			bgiframe : false,
			modal : true,

		});
		$(".bidhistory").dialog({
			bgiframe : false,
			modal : true,

		});

		$(".biddetail").dialog({
			bgiframe : false,
			modal : true,

		});
		$(".textension").dialog({
			bgiframe : false,
			modal : true,

		});
		$(".change").dialog({
			bgiframe : false,
			modal : true,

		});

	}); */
</script>

</head>

<body>
	<%-- <%@ include file="/WEB-INF/jsp/observer/observer_report_top.jsp"%> --%>
	<div class="container">
		<!-- <div id="dhtmltooltip"></div> -->
		<script type="text/javascript">
			pathToImages = "${static_url}" + pathToImages;
		</script>
		<!--observer_top.html-->
		<!--observer_top.html Ends-->
		<form action="${form_url}" method="post" modelAttribute="reportVO"
			name="dateForm">
			<div class="mark-check1 mktlst">

				<%-- <div class="col-xs-12 col-sm-6">
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a
							aria-controls="home" role="tab" data-toggle="tab"
							href="${report_summary1_url}"
							>Summary</a></li>
					</ul>
				</div> --%>

				<!-- <div class="col-xs-12 col-sm-6">
					<ul class="list-inline pull-right">
						<li><a href="#" onclick="javascript:onSubmitExcel();">Export
								to Excel</a></li>
						<li><a href="#" onclick="javascript:onSubmitPDF();">download
								PDF</a></li>
						<li><a href="#print">Print</a></li>
					</ul>
				</div>

 -->
			</div>
			<div class="table-responsive user-map nofound itemlist">
				<!--<table class="table table-bordered table-striped text-center"> -->
				<%-- <tr>
							<td>Select Date From <input type="text" id="dateFrom"
								value='${dateFromStr}' name="paramDateFrom"
								onclick="displayCalendar(document.dateForm.dateFrom,'dd/mm/yyyy',this)" />

								To <input type="text" id="dateTo" name="paramDateTo"
								onclick="displayCalendar(document.dateForm.dateTo,'dd/mm/yyyy',this)"
								value="${dateToStr}" /> <input type="hidden" name="categoryId" />
								<input type="hidden" name="lotsStatus" value="" /> <input
								type="submit" name="Submit" value="Go"
								onclick="return onSubmit();" /></td>



							<td align="right"><a href="#"
								onclick="javascript:onSubmitExcel();">Export to Excel</a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="#" onclick="javascript:onSubmitPDF();">download PDF</a></td>
						</tr> --%>
				<!-- </table>-->
			</div>
	</div>
	</div>
	<div class="table-responsiveuser-map nofound itemlist">
		<table class="table table-bordered table-striped text-center">

			<tr>
				<td colspan="10">Select Date From <input type="text"
					id="dateFrom" value='${dateFromStr}' name="paramDateFrom"
					onclick="displayCalendar(document.dateForm.dateFrom,'dd/mm/yyyy',this)" />

					To <input type="text" id="dateTo" name="paramDateTo"
					onclick="displayCalendar(document.dateForm.dateTo,'dd/mm/yyyy',this)"
					value="${dateToStr}" /> <input type="hidden" name="categoryId" />
					<input type="hidden" name="lotsStatus" value="" /> <input
					type="submit" name="Submit" value="Go" onclick="return onSubmit();" /></td>



				<td colspan="9" align="right"><a href="#"
					onclick="javascript:onSubmitExcel();">Export to Excel</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#" onclick="javascript:onSubmitPDF();">download PDF</a></td>
			</tr>


			<tr>
				<td><a href="#">Sr. No.</a></td>
				<td><a href="#">Lot. No</a></td>
				<td><a href="#">Description</a></td>
				<td><select name="category" id="category"
					onChange="getResultForCategory(this.value)">
						<option value="0">All</option>
						<c:forEach var="bidderCategory" items="${bidderCategoryList}">
							<c:if
								test="${bidderCategory.bidderCategoryId.category.categoryId==categoryName}">
								<option
									value="${bidderCategory.bidderCategoryId.category.categoryId}"
									selected="selected">
									<c:out
										value="${bidderCategory.bidderCategoryId.category.categoryName}" />
								</option>
							</c:if>
							<c:if
								test="${bidderCategory.bidderCategoryId.category.categoryId!=categoryName}">
								<option
									value="${bidderCategory.bidderCategoryId.category.categoryId}">
									<c:out
										value="${bidderCategory.bidderCategoryId.category.categoryName}" />
								</option>
							</c:if>
						</c:forEach>
				</select></td>
				<td><a href="#">Material Name</a></td>
				<td><a href="#">Remark</a></td>
				<td><a href="#">Length Range</a></td>
				<td><a href="#">Actual Length<br /> (Approx)
				</a></td>
				<td><a href="#">Quantity</a></td>
				<td><a href="#">Zone</a></td>
				<td colspan="2">
					<table>
						<tr>
							<td colspan="2"><a href="#">H1</a></td>
						</tr>

						<tr>
							<td>Company Name</td>
							<td>Bid Price</td>
						</tr>
					</table>
				</td>
				<td colspan="2">
					<table>
						<tr>
							<td colspan="2"><a href="#">H2</a></td>
						</tr>
						<tr>
							<td><a href="#">Company Name</a></td>
							<td><a href="#">Bid Price</a></td>
						</tr>
					</table>
				</td>
				<td colspan="2"><a href="#">H3</a>
					<table>
						<tr>
							<td>Company Name</td>
							<td>Bid Price</td>
						</tr>
					</table></td>
				<td><a href="#">Lot's Status</a>
					<table>
						<tr>
							<td><select name="bidsStatus" id="bidsStatus"
								onchange="getResultForLotStatus(this.value)">
									<option value="0">All</option>
									<c:forEach var="bidsStatus" items="${bidsStatusSet}">
										<option value="${bidsStatus}">
											<%-- <c:if test="${bidsStatus==bidsStat}">
										<option value="${bidsStatus}" selected="selected"> --%>
											<c:out value="${bidsStatus}" />
										</option>
										<%-- </c:if> --%>
										<%-- <c:if test="${bidsStatus!=bidsStat}">
										<option value="${bidsStatus}">
											<c:out value="${bidsStatus}" />
										</option>
									</c:if> --%>
									</c:forEach>
							</select></td>
						</tr>
					</table></td>
				<td><a href="#">Sales Price</a></td>
				<td><a href="#">Total Sales (Qty X SalesPrice)</a></td>
			</tr>

			 <%-- <tr>
				<!-- <td colspan="10">&nbsp;</td>
				<td>Company Name</td>
				<td>Bid Price</td>
				<td>Company Name</td>
				<td>Bid Price</td>
				<td>Company Name</td>
				<td>Bid Price</td> -->
				<td><select name="bidsStatus" id="bidsStatus"
					onchange="getResultForLotStatus(this.value)">
						<option value="0">All</option>
						<c:forEach var="bidsStatus" items="${bidsStatusSet}">
							<option value="${bidsStatus}">
								<c:if test="${bidsStatus==bidsStat}">
										<option value="${bidsStatus}" selected="selected">
								<c:out value="${bidsStatus}" />
							</option>
							</c:if>
							<c:if test="${bidsStatus!=bidsStat}">
										<option value="${bidsStatus}">
											<c:out value="${bidsStatus}" />
										</option>
									</c:if>
						</c:forEach>
				</select></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr> --%> 
			<c:forEach items="${BidsList}" var="bids" varStatus="status">
				<tr class="table">
					<td>${bids.bidItem.serialNo}.</td>
					<c:forEach items="${bids.bidItem.itemLots}" var="itemLotUnique"
						varStatus="status2">
						<c:if test="${status2.index+1 == 1}">
							<td>${itemLotUnique.lotNo}</td>
						</c:if>
					</c:forEach>

					<td>

						<div class="modal fade" id="dialog_desc${status.index+1}"
							tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title" id="myModalLabel">Description</h4>
									</div>
									<div class="modal-body">




										<div id="dialog_desc${status.index+1}"
											title="Item Description" class="table-responsive user-map">

											<table class="table table-bordered table-striped text-center">
												<tr>
													<td align="left" valign="top"><form name="form1"
															method="post" action="" style="margin: 0px;">
															<table>
																<tr>
																	<td>Sr. No.</td>
																	<td>Category</td>
																	<td>Lot No.</td>
																	<td>Material Name</td>
																	<td>Remark</td>
																	<td>Length Range</td>
																	<td>Actual Length <br> (Approx) </td>
																	<td>Qty</td>
																	<td>Zone</td>
																</tr>
																<tr>
																	<td>${bids.bidItem.serialNo}.</td>
																	<td>${bids.bidItem.category.categoryName}</td>
																	<c:forEach items="${bids.bidItem.itemLots}"
																		var="itemLotUnique" varStatus="status2">
																		<c:if test="${status2.index+1 == 1}">
																			<td>${itemLotUnique.lotNo}</td>
																		</c:if>
																	</c:forEach>

																	<td>${bids.bidItem.name}</td>
																	<c:if test="${fn:length(bids.bidItem.itemLots) == 1}">
																		<c:forEach items="${bids.bidItem.itemLots}"
																			var="itemLotUnique" varStatus="status2">
																			<td>${itemLotUnique.remark}</td>
																			<td>${itemLotUnique.lengthRange}</td>
																			<td>${itemLotUnique.actualLengh}</td>
																		</c:forEach>
																	</c:if>
																	<c:if test="${fn:length(bids.bidItem.itemLots) > 1}">
																		<td>&nbsp;</td>
																		<td>&nbsp;</td>
																		<td>&nbsp;</td>
																	</c:if>

																	<td>${bids.bidItem.totalQuantity}
																		${bids.bidItem.unit}</td>
																	<c:if test="${fn:length(bids.bidItem.itemLots) == 1}">
																		<c:forEach items="${bids.bidItem.itemLots}"
																			var="itemLotUnique" varStatus="status2">
																			<td>${bids.bidItem.zone}</td>
																		</c:forEach>
																	</c:if>
																	<c:if test="${fn:length(bids.bidItem.itemLots) > 1}">
																		<td>&nbsp;</td>
																	</c:if>
																</tr>

																<c:if test="${fn:length(bids.bidItem.itemLots) > 1}">
																	<c:forEach items="${bids.bidItem.itemLots}"
																		var="itemLot" varStatus="status1">
																		<tr>
																			<td>${status1.index+1}.</td>
																			<td>${bids.bidItem.category.categoryName}</td>
																			<td>${itemLot.lotNo}</td>
																			<td>${itemLot.name}</td>

																			<td>${itemLot.remark}</td>
																			<td>${itemLot.lengthRange}</td>
																			<td>${itemLot.actualLengh}</td>
																			<td>${itemLot.quantity}${itemLot.unit}</td>
																			<td>${itemLot.zone}</td>
																		</tr>
																	</c:forEach>
																</c:if>

															</table>
														</form></td>
												</tr>
											</table>
										</div>


									</div>
								</div>
							</div>
						</div> <input type="submit" name="button7" id="desc${status.index+1}"
						value="Desc" data-toggle="modal"
						data-target="#dialog_desc${status.index+1}" />
					</td>
					<td align="center" valign="middle">${bids.bidItem.category.categoryName}</td>
					<td align="center" valign="middle"><a href="#"
						class="LinkSelected">${bids.bidItem.name}</a></td>
					<c:if test="${fn:length(bids.bidItem.itemLots) == 1}">
						<c:forEach items="${bids.bidItem.itemLots}" var="itemLotUnique"
							varStatus="status2">

							<td align="center" valign="middle">${itemLotUnique.remark}</td>
							<td align="center" valign="middle">${itemLotUnique.lengthRange}</td>
							<td>${itemLotUnique.actualLengh}</td>
						</c:forEach>
					</c:if>

					<c:if test="${fn:length(bids.bidItem.itemLots) > 1}">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</c:if>


					<td>${bids.bidItem.totalQuantity}${bids.bidItem.unit}</td>
					<c:if test="${fn:length(bids.bidItem.itemLots) == 1}">
						<c:forEach items="${bids.bidItem.itemLots}" var="itemLotUnique"
							varStatus="status2">
							<td>${bids.bidItem.zone}</td>
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(bids.bidItem.itemLots) > 1}">
						<td>&nbsp;</td>
					</c:if>
					<td>${bids.bidderName}</td>
					<td>${bids.bidAmount}</td>
					<td>${bids.bidderName2}</td>
					<td>${bids.bidAmount2}</td>
					<td>${bids.bidderName3}</td>
					<td>${bids.bidAmount3}</td>
					<td>${bids.bidItem.isProcessed}</td>
					<td><c:if test="${not empty bids.salesPrice}">  
        		${bids.bidItem.currency} ${bids.salesPrice} 
        	</c:if></td>
					<td><c:if test="${not empty bids.totalSalesPrice}"> 
        		${bids.bidItem.currency} ${bids.totalSalesPrice}
        	</c:if></span></td>
				</tr>

			</c:forEach>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td><strong>Total</strong></td>
				<td>${reportsTotal.totalQuantity}${bids.bidItem.unit}</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>INR ${reportsTotal.totalBidAmount1}</td>
				<td>&nbsp;</td>
				<td>INR ${reportsTotal.totalBidAmount2}</td>
				<td>&nbsp;</td>
				<td>INR ${reportsTotal.totalBidAmount3}</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>INR ${reportsTotal.finalTotalSalesPrice}</td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td><strong>&nbsp;</strong></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

		</table>
	</div>
	</form>
	<br />
	<br />
	<!-- <div class="Spacer"></div> -->
	</div>
</body>
</html>
