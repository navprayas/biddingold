<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">
<script src="${js_url}jquery-1.10.2.min.js"></script>
<!-- Custom styles for this template -->
<link href="${css_url}/custom.css" rel="stylesheet">

<%@page import="java.util.Date"%>
<script type="text/javascript">
	function getResultForCategory(categoryId) {
		var location1 = "${bidder_report_url}/report/" + categoryId;
		window.location.href = location1;
	}
</script>
<script type="text/javascript">
	function dialogOpen(id) {
		$("div#"+id).dialog ({
			  show : "slide",
			  hide : "puff"
			});

	}

	$(function() {
		// Dialog			

		 $('.desc').dialog({
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
<script type="text/javascript">
	$(function() {
		$(".desc").dialog({
			bgiframe : false,
			modal : true,

		});

		$(".bids").dialog({
			bgiframe : false,
			modal : true,

		});

		$(".removediv").dialog({
			bgiframe : false,
			modal : true,
		});
		$(".change").dialog({
			bgiframe : false,
			modal : true,

		});
	});
</script>




<!-- { middle } -->
<section class="main">
	<div class="container">
		<div class="table-container">
			<div class="top-line">
				<div class="col-xs-12 col-sm-6">
					<ul class="nav nav-tabs" role="tablist">
						<!-- <li role="presentation" class="active"><a
							aria-controls="home" role="tab" data-toggle="tab" href="#summary">Summary
								1</a></li>
						<li><a aria-controls="home" role="tab" data-toggle="tab"
							href="#bidder">Bidder Wise</a></li> -->
					</ul>
				</div>
				<div class="col-xs-12 col-sm-6">
					<ul class="list-inline pull-right">
						<li><a href="#excel"></a></li>
						<li><a href="#pdf"></a></li>
						<li><a href="#print"></a></li>
					</ul>
				</div>
				<div class="clearfix"></div>
			</div>
			<!-- { tab-Effects } -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="summary">
					<!-- <div class="mark-check1">
						<div class="col-sx-12 col-sm-12 select-date">
							<form role="form">
								<div class="col-xs-12 col-sm-4 col-md-3 col-lg-2 tetrt">
									Select Date:&nbsp; <span>Form</span>
								</div>
								<div class="col-xs-12 col-sm-3 col-md-3 col-lg-2">
									<input type="date" placeholder="Date" id="inputdate31"
										class="form-control">
								</div>
								<div class="col-xs-12 col-sm-1 tetrt">To</div>
								<div class="col-xs-12 col-sm-3 col-md-3 col-lg-2">
									<input type="date" placeholder="Date" id="inputdate41"
										class="form-control">
								</div>
								<div class="col-xs-12 col-sm-1 col-md-2 col-lg-2">
									<input type="button" class="btn btn-primary" Value="Go">
								</div>
							</form>
						</div>
					</div> -->
					<div class="table-responsive user-map">
						<table class="table table-bordered table-striped text-center">
							<tr>
								<th>Sr. No.</th>
								<th>Description</th>
								<th>Category</th>
								<th>Lot. No.</th>
								<th>Material Name</th>
								<th>Remark</th>
								<th>Length Range</th>
								<th>Actual Length</th>
								<th>Quantity</th>

								<c:forEach items="${wonList}" var="bidItem" varStatus="status">

									<tr>
										<td>${status.index+1}</td>
										<td>



											<div id="dialog_desc${status.index+1}" style="display: none;">
												<table>
													<tr>
														<td><form name="form1" method="post" action=""
																style="margin: 0px;">
																<table>
																	<tr></tr>
																	<tr>
																		<td>Sr. No.</td>
																		<td>Category</td>
																		<td>Lot No.</td>
																		<td>Materials Name</td>
																		<td>Remark</td>
																		<td>Length Range</td>
																		<td>Actual Length <br> (Approx)
																		</td>
																		<td>Qty</td>
																	</tr>
																	<tr>
																		<td>${status.index+1}.</td>
																		<td>${bidItem.category.categoryName}</td>
																		<td>${bidItem.bidItemId}</td>
																		<td>${bidItem.name}</td>
																		<c:if test="${fn:length(bidItem.itemLots) == 1}">
																			<c:forEach items="${bidItem.itemLots}"
																				var="itemLotUnique" varStatus="status2">
																				<td>${itemLotUnique.remark}</td>
																				<td>${itemLotUnique.lengthRange}</td>
																				<td>${itemLotUnique.actualLengh}</td>
																			</c:forEach>
																		</c:if>
																		<c:if test="${fn:length(bidItem.itemLots) > 1}">
																			<td>&nbsp;</td>
																			<td>&nbsp;</td>
																			<td>&nbsp;</td>
																		</c:if>
																		<td>${bidItem.totalQuantity}${bidItem.unit}</td>
																	</tr>


																	<c:if test="${fn:length(bidItem.itemLots) > 1}">
																		<c:forEach items="${bidItem.itemLots}" var="itemLot"
																			varStatus="status1">
																			<tr>
																				<td>${status1.index+1}</td>
																				<td>${bidItem.category.categoryName}</td>
																				<td>${itemLot.lotId}</td>
																				<td>${itemLot.name}</td>
																				<td>${itemLot.remark}</td>
																				<td>${itemLot.lengthRange}</td>
																				<td>${itemLot.actualLengh}</td>
																				<td>${itemLot.quantity}${itemLot.unit}</td>
																			</tr>
																		</c:forEach>
																	</c:if>
																</table>
															</form></td>
													</tr>
												</table>
											</div> <input type="submit" name="button3"
											id="desc${status.index+1}" value="Desc"
											onclick="dialogOpen(this.id);" />









										</td>


										<td>${bidItem.category.categoryName}</td>
										<td>${bidItem.bidItemId}</td>
										<td>${bidItem.name}</td>
										<c:if test="${fn:length(bidItem.itemLots) == 1}">
											<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
												varStatus="status2">
												<td>${itemLotUnique.remark}</td>
												<td>${itemLotUnique.lengthRange}</td>
												<td>${itemLotUnique.actualLengh}</td>

											</c:forEach>
										</c:if>

										<c:if test="${fn:length(bidItem.itemLots) > 1}">
										</c:if>

										<td>${bidItem.totalQuantity}${bidItem.unit}</td>
								</c:forEach>
						</table>
					</div>
				</div>
				<div role="tabpanel" class="tab-pane" id="bidder">
					<div class="mark-check1">
						<div class="col-sx-12 col-sm-12 select-date">
							<form role="form">
								<div class="col-xs-12 col-sm-4 col-md-3 col-lg-2 tetrt">
									Select Date:&nbsp; <span>Form</span>
								</div>
								<div class="col-xs-12 col-sm-3 col-md-3 col-lg-2">
									<input type="date" placeholder="Date" id="inputdate31"
										class="form-control">
								</div>
								<div class="col-xs-12 col-sm-1 tetrt">To</div>
								<div class="col-xs-12 col-sm-3 col-md-3 col-lg-2">
									<input type="date" placeholder="Date" id="inputdate41"
										class="form-control">
								</div>
								<div class="col-xs-12 col-sm-1 col-md-2 col-lg-2">
									<input type="button" class="btn btn-primary" Value="Go">
								</div>
							</form>
						</div>
					</div>
					<!-- <div class="table-responsive user-map">
						<table class="table table-bordered table-striped text-center">
							<tr>
								<th>Sr. No.</th>
								<th>Lot. No.</th>
								<th>Description</th>
								<th><select>
										<option>All</option>
										<option>1</option>
										<option>2</option>
								</select></th>
								<th>Material Name</th>
								<th>Remark</th>
								<th>Length Range</th>
								<th>Actual Range (Approx)</th>
								<th>Quantity</th>
								<th>Zone</th>
								<th>Company Name</th>
								<th>Bid Price</th>
								<th>Lot's Status<br> <select>
										<option>All</option>
										<option>1</option>
										<option>2</option>
								</select>
								</th>
								<th>Sales Price</th>
								<th>Total Sales (Qty X Sales Price)</th>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td>Total</td>
								<td>0</td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td>&#x20b9; 0.0</td>
							</tr>
						</table>
					</div> -->
				</div>
			</div>
		</div>
	</div>
	<!-- /container -->
</section>

 --%>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<%@page import="java.util.Date"%><html
	xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>


<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
<%-- <script type="text/javascript" src="${js_url}/tooltip.js"></script> --%>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript">
	function getResultForCategory(categoryId) {
		var location1 = "${bidder_report_url}/report/" + categoryId;
		window.location.href = location1;
	}
</script>
<script type="text/javascript">
	$(function() {
		// Dialog			

		$('.desc').dialog({
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
<script type="text/javascript">
	$(function() {
		$(".desc").dialog({
			bgiframe : false,
			modal : true,

		});

		$(".bids").dialog({
			bgiframe : false,
			modal : true,

		});

		$(".removediv").dialog({
			bgiframe : false,
			modal : true,
		});
		$(".change").dialog({
			bgiframe : false,
			modal : true,

		});
	});
</script>



<style type="text/css">
<!--
.td1 {
	background-color: #e9edf3;
	color: #ff0000;
}

.td3 {
	background-color: #d0d7e7;
	color: #ff0000;
}
-->
</style>
</head>

<body>
	<div class="container">
		<!-- <div class="mark-check1">
			<table class="table table-bordered table-striped text-center">
				<tr>
					<td></td>
					<td>&nbsp;</td>
				</tr>
			</table>
		</div> -->
		<div class="table-responsive user-map hktk">
			<table class="table table-bordered table-striped text-center">
				<tr>
					<td ><a href="#"
						>Sr. No</a></td>
					<td ><a href="#"
						>Description</a></td>
					<td ><a href="#"
						>Lot No.</a></td>

					<td ><a href="#"
						>Category
							Name</a></td>

					<td ><a href="#"
						>Material
							Name</a></td>
					<td ><a href="#"
						>Remark</a></td>
					<td ><a href="#"
						>Length Range</a></td>
					<td ><a href="#"
						>Actual
							Length<br /> (Approx)
					</a></td>
					<td ><a href="#"
						>Quantity</a></td>
				</tr>
				<c:forEach items="${wonList}" var="bidItem" varStatus="status">
					<tr class="table">
						<td height="40" align="center" valign="middle"
							class="DetailBorRight">${status.index+1}</td>
						<td align="center" valign="middle" class="DetailBorRight">

							<div class="modal fade" id="dialog_desc${status.index+1}"
								tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="dialog_desc${status.index+1}">Auto
												Bid</h4>
										</div>
										<div class="modal-body">



											<div id="dialog_desc${status.index+1}" class="desc"
												title="Item Description">
												<table class="table table-bordered table-striped text-center">
													<tr>
														<td align="left" valign="top"><form name="form1"
																method="post" action="" style="margin: 0px;">
																<table class="table table-bordered table-striped text-center">
																	<tr></tr>
																	<tr>
																		<td >Sr. No.</td>
																		<td >Category</td>
																		<td >Lot No.</td>
																		<td >Materials
																			Name</td>
																		<td >Remark</td>
																		<td >Length
																			Range</td>
																		<td >Actual
																			Length <br> (Approx) 
																		</td>
																		<td >Qty</td>
																	</tr>
																	<tr>
																		<td >${status.index+1}.
																		</td>
																		<td >${bidItem.category.categoryName}</td>
																		<td >${bidItem.bidItemId}</td>
																		<td >${bidItem.name}</td>
																		<c:if test="${fn:length(bidItem.itemLots) == 1}">
																			<c:forEach items="${bidItem.itemLots}"
																				var="itemLotUnique" varStatus="status2">
																				<td >${itemLotUnique.remark}</td>
																				<td >${itemLotUnique.lengthRange}</td>
																				<td >${itemLotUnique.actualLengh}</td>
																			</c:forEach>
																		</c:if>
																		<c:if test="${fn:length(bidItem.itemLots) > 1}">
																			<td >&nbsp;</td>
																			<td >&nbsp;</td>
																			<td>&nbsp;</td>
																		</c:if>
																		<td >${bidItem.totalQuantity}
																			${bidItem.unit}</td>
																	</tr>


																	<c:if test="${fn:length(bidItem.itemLots) > 1}">
																		<c:forEach items="${bidItem.itemLots}" var="itemLot"
																			varStatus="status1">
																			<tr>
																				<td >${status1.index+1}
																				</td>
																				<td >${bidItem.category.categoryName}</td>
																				<td >${itemLot.lotId}</td>
																				<td >${itemLot.name}</td>
																				<td >${itemLot.remark}</td>
																				<td >${itemLot.lengthRange}</td>
																				<td >${itemLot.actualLengh}</td>
																				<td >${itemLot.quantity}
																					${itemLot.unit}</td>
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
							</div> <input type="submit" name="button3" id="desc${status.index+1}"
							value="Desc" data-toggle="modal"data-target="#dialog_desc${status.index+1}" />
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



					<!--        <td align="center" valign="middle" class="DetailBorRight">${bidItem.totalQuantity} ${bidItem.unit}</td>-->



				</c:forEach>

			</table>
		</div>
		<!-- <div class="GreenSpacer"></div> -->

		<!-- <div class="AutoBidBlue"></div>
      <div class="Footer">© Copyright 2011 Navprayas</div>
    <div class="clr"></div>-->
	</div>
</body>
</html>
