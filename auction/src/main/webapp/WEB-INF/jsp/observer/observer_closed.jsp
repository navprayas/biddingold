
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>

<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<spring:url value="/observer" var="observer_home_url" />
<spring:url value="/observer/approveH1" var="observer_h1_url" />
<spring:url value="/observer/marketlist" var="observer_market_url" />
<spring:url value="/observer/active" var="observer_active_url" />

<spring:url value="/observer/closed" var="Paginationform_url" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
	<link type="text/css" href="${css_url}/custom.css"
	rel="stylesheet" />
<link type="text/css" href="${css_url}/custom.css" rel="stylesheet" />
<%-- <script type="text/javascript" src="${js_url}/tooltip.js"></script> --%>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript">
	
	function onSubmit(pageNo) {
		document.paginationForm.category.value = document.forms["categoryform"].category.value;
		document.paginationForm.page.value=pageNo;
		document.paginationForm.submit();
	}
	
	function MM_openBrWindow(theURL,winName,features) { //v2.0
		  window.open(theURL,winName,features);
	}
	function getResultForCategory()
	{
		document.forms["categoryform"].submit(); 
	}
	function getPageForMarketType(marketType)
	{
		var location1 = ""
		if(marketType == "1")
			location1 = "${observer_home_url}/marketlist";
		else if(marketType == "2")
			location1 = "${observer_home_url}/active";
		else if(marketType == "3")
			location1 = "${observer_home_url}/closed";		
		window.location.href=location1
	}
	/*function submitFormH1(bidItemid, bidAmount, bidderName){
		var location1 = "${observer_h1_url}?bidItemid="+bidItemid+"&bidAmount="+bidAmount+"&bidderName="+bidderName;
		window.location.href = location1			
	}*/
	function submitFormH1H2H3(bidItemid, bidAmount, bidderName, bidStatus){
		
		
		document.observerForm.bidItemId.value = bidItemid;
		document.observerForm.bidAmount.value = bidAmount;
		document.observerForm.bidderName.value = bidderName;
		document.observerForm.categoryId.value = document.getElementById("category").value;
		document.observerForm.pageO.value = document.paginationForm.page.value;
		
		document.observerForm.bidStatus.value = bidStatus;
		document.observerForm.submit();
					
	}


</script>

<script type="text/javascript">
			$(function(){
				// Dialog			
				
				$('.desc').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.partici').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.bidhistory').dialog({
					autoOpen: false,
					width:'auto',
					height:310,
				});
				$('.biddetail').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.textension').dialog({
					autoOpen: false,
					width:'auto',
					height:310,
				});
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
				});
				
				$('.h1btn').dialog({
					autoOpen: false,
					width:'auto',
					close: function(ev, ui) 
	                {
	                    $(this).close;
	                },
				});
				$('.h2btn').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.rejectbtn').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.description').click(function(){
				
					//$('.desc').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.partcipents').click(function(){
				
					$('.partici').dialog('open');
					return false;
				});
				$('.history').click(function(){
				
					$('.bidhistory').dialog('open');
					return false;
				});
				$('.detail').click(function(){
				
					if(document.getElementById("bidItemIdVal")){
						var bidItemId = document.getElementById("bidItemIdVal").value;
						if(bidItemId=="" || bidItemId.length < 1) {
							alert("Please first select the Material name for getting detail for that");
							return false;
						}							
					}				
					$('.biddetail').dialog('open');
					return false;
				});
				$('.time').click(function(){
				
					$('.textension').dialog('open');
					return false;
				});
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
					return false;
				});
				$('.h1').click(function(){
				
					//$('.h1btn').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.h2').click(function(){
				
					//$('.h2btn').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.reject').click(function(){
				
					//$('.rejectbtn').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
			});
		</script>
<script type="text/javascript">
	
	$(function() {
		$(".desc").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".partici").dialog({
			bgiframe: false,
			modal: true,
			
		});
			$(".bidhistory").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".biddetail").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".textension").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".change").dialog({
			bgiframe: false,
			modal: true,
			
		});
		
		$(".h1btn").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
		$(".h2btn").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
		$(".rejectbtn").dialog({
			bgiframe: false,
			modal: true,
			
		});

	});
	</script>
<script language="javascript">
function blah( oCB )
{    for( oElem = oCB; oElem.tagName!= "TR"; oElem = oElem.parentNode );
    oElem.className = oCB.checked? "selected": "";
}
</script>
</head>

<body>
	<div id="dhtmltooltip"></div>
	<%-- <%@ include file="/WEB-INF/jsp/observer/observer_top.jsp"%>
 --%>
	<div class="container">

		<div class="mark-check1 mktlstcl">
			<form id="form1" name="form1" method="post" action=""
				style="margin: 0px;">
				
				<div class="table-responsive user-map nofound itemlist">
				<table class="table table-bordered table-striped text-center">
					<tr>
					<td colspan="3"><input type="radio" name="radio" id="radio"
						value="1" onclick="getPageForMarketType(this.value)" /> <a
						href="${observer_market_url}"
						>&nbsp;Market List</a></td>
					<td colspan="3"><input type="radio" name="radio"
						id="radio2" value="2" onClick="getPageForMarketType(this.value)"  /><a href="${observer_active_url}"
						>&nbsp;Active Market</a></td>
					<td colspan="3"><input type="radio" checked name="radio" id="radio3" value="3"
						onclick="getPageForMarketType(this.value)" /> <a
						href="${observer_close_url}"
						>&nbsp;Closed Market</a></td>
					<td colspan="7" align="right" ><strong>Total
							No. of Forward Markets in Active List: <c:out
								value="${fn:length(bidItemsList)}" />
					</strong></td>
				</tr>
				</table>
				</div>
			</form>
		</div>

		<form:form action="${Paginationform_url}" name="paginationForm">
			<input type="hidden" name="page"
				value="<c:out value='${navigationInfo.currentPage}' />" />
			<input type="hidden" name="category" value="0" />
		</form:form>
		<div  class="table-responsive user-map nofound itemlist">
			<table class="table table-bordered table-striped text-center tfhnml">

				<tr>
					<td><display:table name="navigationInfo"
							requestURI="${Paginationform_url}" excludedParams="*"
							cellspacing="0px" cellpadding="0px 0px 0px 0px">
							<display:setProperty name="paging.banner.onepage" value="<br/>"></display:setProperty>
							<display:setProperty name="basic.msg.empty_list" value=""></display:setProperty>
							<display:setProperty name="basic.msg.empty_list_row" value=""></display:setProperty>
							<display:setProperty name="paging.banner.first">
								<table>
									<tr>
										<td><div style="width: 100%; text-align: center">
												<span class="pagelinks"> First | Prev&nbsp;<c:out
														value="${navigationInfo.pageSize}" /> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage+1}' />')"
													id="id3">Next&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.pageCount}' />')"
													id="id4">Last</a>
												</span>
											</div></td>
									</tr>
								</table>
							</display:setProperty>
							<display:setProperty name="paging.banner.full">
								<table id="pagetable" width="100%" border="0" cellspacing="0"
									cellpadding="0" align="center">
									<tr>
										<td><div style="width: 100%; text-align: center">
												<span class="pagelinks"> <a href="#"
													onclick="javascript: onSubmit('1')" id="id5">First</a> | <a
													href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage-1}' />')"
													id="id6">Prev&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage+1}' />')"
													id="id3">Next&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | <a href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.pageCount}' />')"
													id="id4">Last </a>
												</span>
											</div></td>
									</tr>
								</table>
							</display:setProperty>
							<display:setProperty name="paging.banner.last">
								<table id="pagetable" width="100%" border="0" cellspacing="0"
									cellpadding="0" align="center">
									<tr>
										<td><div style="width: 100%; text-align: center">
												<span class="pagelinks"> <a href="#"
													onclick="javascript: onSubmit('1')" id="id5">First</a> | <a
													href="#"
													onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage-1}' />')"
													id="id6">Prev&nbsp;<c:out
															value="${navigationInfo.pageSize}" /></a> | Next&nbsp;<c:out
														value="${navigationInfo.pageSize}" /> | Last
												</span>
											</div></td>
									</tr>
								</table>
							</display:setProperty>
						</display:table></td>
				</tr>
			</table>
		</div>
		<div class="table-responsive user-map nofound itemlist">
			<form action="${observer_h1_url}" method="post"
				modelAttribute="observerVO" name="observerForm">
				<input type="hidden" name="bidItemId" value="" /> <input
					type="hidden" name="bidAmount" value="" /> <input type="hidden"
					name="bidderName" value="" /> <input type="hidden"
					name="bidStatus" value="" /> <input type="hidden"
					name="categoryId" value="" /> <input type="hidden" name="pageO"
					value="<c:out value='${navigationInfo.currentPage}' />" />
			</form>

			<table class="table table-bordered table-striped text-center">
			
				<tr>
					<td ><a href="#"
						>Sr. No</a></td>
					<td ><a href="#"
						>Description</a></td>
					<td ><a href="#"
						 >Lot No.</a></td>
					<td >
						<form name="categoryform" action="closed" method="post">
							<select name="category" id="category"
								onChange="getResultForCategory()">
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
							</select>
						</form>
					</td>
					<td ><a href="#"
						>Material Name</a></td>
					<td><a href="#"
						 >Remark</a></td>
					<td ><a href="#"
						>Length Range</a></td>
					<td ><a href="#"
						>Actual Length<br />
							(Approx)
					</a></td>
					<td ><a href="#"
						>Quantity</a></td>
					<td ><a href="#"
						>Zone</a></td>
					<td ><a href="#"
						>Close Date
							&amp; Time</a></td>
					<td ><a href="#"
						>Current
							Price(INR)</a></td>
					<td ><a href="#"
						>H1</a></td>
					<td ><a href="#"
						>Reserved
							Price(INR)</a></td>
					<td ><a href="#"
						>Last
							Price(INR)</a></td>
					<td ><a href="#"
						>Bid <br />
							Approval
					</a></td>
					<td ><a href="#"
						>Winning<br />
							Firm Name
					</a></td>
				</tr>
				<c:forEach items="${bidsList}" var="bid" varStatus="status">
					<tr class="table">
						<td height="40" align="center" valign="middle"
							class="DetailBorRight"><div
								id="seqId${bid.bidItem.bidItemId}">${bid.bidItem.serialNo}.</div></td>
						<td align="center" valign="middle">



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
												class="table-responsive user-map" title="Item Description"
												>
												<table
													class="table table-bordered table-striped text-center">
													<tr>
														<td align="left" valign="top"><form name="form1"
																method="post" action="" style="margin: 0px;">
																<table>

																	<tr>
																		<td width="49" height="30" align="center"
																			valign="middle" bgcolor="#abcb67"
																			style="border-right: 1px solid #fff;">Sr. No.</td>
																		<td width="92" align="center" valign="middle"
																			bgcolor="#abcb67"
																			style="border-right: 1px solid #fff;">Category</td>
																		<td width="56" align="center" valign="middle"
																			bgcolor="#abcb67"
																			style="border-right: 1px solid #fff;">Lot No.</td>
																		<td width="131" align="center" valign="middle"
																			bgcolor="#abcb67"
																			style="border-right: 1px solid #fff;">Material
																			Name</td>
																		<td width="64" align="center" valign="middle"
																			bgcolor="#abcb67"
																			style="border-right: 1px solid #fff;">Remark</td>
																		<td width="96" align="center" valign="middle"
																			bgcolor="#abcb67"
																			style="border-right: 1px solid #fff;">Length
																			Range</td>
																		<td width="125" align="center" valign="middle"
																			bgcolor="#abcb67"
																			style="border-right: 1px solid #fff;">Actual
																			Length <br> (Approx)
																		</td>
																		<td width="87" align="center" valign="middle"
																			bgcolor="#abcb67"
																			style="border-right: 1px solid #fff;">Qty</td>
																		<td width="87" align="center" valign="middle"
																			bgcolor="#abcb67"
																			style="border-right: 1px solid #fff;">Zone</td>
																	</tr>
																	<tr>
																		<td height="30" align="center" valign="middle"
																			bgcolor="#f7c794"
																			style="border-right: 1px solid #fff;">${bid.bidItem.serialNo}.
																		</td>
																		<td align="center" valign="middle" bgcolor="#f7c794"
																			style="border-right: 1px solid #fff;"><div
																				id="categoryName${bid.bidItem.bidItemId}">
																				${bid.bidItem.category.categoryName}</div></td>
																		<c:forEach items="${bid.bidItem.itemLots}"
																			var="itemLotUnique" varStatus="status2">
																			<c:if test="${status2.index+1 == 1}">
																				<td align="center" valign="middle" bgcolor="#f7c794"
																					style="border-right: 1px solid #fff;">${itemLotUnique.lotNo}</td>
																			</c:if>
																		</c:forEach>
																		<td align="center" valign="middle" bgcolor="#f7c794"
																			style="border-right: 1px solid #fff;">${bid.bidItem.name}</td>
																		<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
																			<c:forEach items="${bid.bidItem.itemLots}"
																				var="itemLotUnique" varStatus="status2">
																				<td align="center" valign="middle" bgcolor="#f7c794"
																					style="border-right: 1px solid #fff;">${itemLotUnique.remark}</td>
																				<td align="center" valign="middle" bgcolor="#f7c794"
																					style="border-right: 1px solid #fff;">${itemLotUnique.lengthRange}</td>
																				<td align="center" valign="middle" bgcolor="#f7c794"
																					style="border-right: 1px solid #fff;">${itemLotUnique.actualLengh}</td>
																			</c:forEach>
																		</c:if>
																		<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
																			<td align="center" valign="middle" bgcolor="#f7c794"
																				style="border-right: 1px solid #fff;">&nbsp;</td>
																			<td align="center" valign="middle" bgcolor="#f7c794"
																				style="border-right: 1px solid #fff;">&nbsp;</td>
																			<td align="center" valign="middle" bgcolor="#f7c794"
																				style="border-right: 1px solid #fff;">&nbsp;</td>
																		</c:if>
																		<td align="center" valign="middle" bgcolor="#f7c794"
																			style="border-right: 1px solid #fff;">${bid.bidItem.totalQuantity}
																			${bid.bidItem.unit}</td>
																		<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
																			<c:forEach items="${bid.bidItem.itemLots}"
																				var="itemLotUnique" varStatus="status2">
																				<td align="center" valign="middle" bgcolor="#f7c794"
																					style="border-right: 1px solid #fff;">${itemLotUnique.zone}</td>
																			</c:forEach>
																		</c:if>
																		<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
																			<td align="center" valign="middle" bgcolor="#f7c794"
																				style="border-right: 1px solid #fff;">&nbsp;</td>
																		</c:if>
																	</tr>
																	<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
																		<c:forEach items="${bid.bidItem.itemLots}"
																			var="itemLot" varStatus="status1">
																			<tr>
																				<td height="30" align="center" valign="middle"
																					bgcolor="#f0f3ea"
																					style="border-right: 1px solid #fff;">${status1.index+1}.
																				</td>
																				<td align="center" valign="middle" bgcolor="#f0f3ea"
																					style="border-right: 1px solid #fff;">${bid.bidItem.category.categoryName}</td>
																				<td align="center" valign="middle" bgcolor="#f0f3ea"
																					style="border-right: 1px solid #fff;">${itemLot.lotNo}</td>
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
																				<td align="center" valign="middle" bgcolor="#f0f3ea"
																					style="border-right: 1px solid #fff;">${itemLot.zone}</td>
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
						<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique"
							varStatus="status2">
							<c:if test="${status2.index+1 == 1}">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
							</c:if>
						</c:forEach>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="categoryName${bid.bidItem.bidItemId}">${bid.bidItem.category.categoryName}</div></td>
						<td align="center" valign="middle" class="DetailBorRight">
							<div id="bidItemName${bid.bidItem.bidItemId}"
								style="display: none">${bid.bidItem.name}</div> <a href="#"
							class="LinkSelected"
							onclick="javascript:setIdForBiddingHistory(${bid.bidItem.bidItemId});">${bid.bidItem.name}</a>
						</td>
						<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
							<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="totalQuantity${bid.bidItem.bidItemId}">
								${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</div></td>
						<c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
							<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.zone}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight">
							${bid.bidItem.bidEndTime}</td>
						<td align="center" valign="middle" class="DetailBorRight">${bid.bidItem.currentMarketPrice}</td>
						<td align="center" valign="middle" class="DetailBorRight">${bid.bidderName}</td>
						<td align="center" valign="middle" class="DetailBorRight">
							<div id="Item${bid.bidItem.bidItemId}" style="display: none">${bid.bidItem.minBidPrice}</div>
						</td>
						<td align="center" valign="middle" class="DetailBorRight">
							<div id="minBidIncrement${bid.bidItem.bidItemId}"
								style="display: none">${bid.bidItem.minBidIncrement}</div>
						</td>
						<td align="center" valign="middle" class="DetailBorRight">


<div class="modal fade" id="dialog_h1btn${status.index+1}"
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






							<div id="dialog_h1btn${status.index+1}" class="h1btn"
								title="Bid Approval : H1" >

								<table width="400" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="left" valign="top"><form name="form1"
												method="post" action="" style="margin: 0px;">
												<table width="400" border="0" cellspacing="0"
													cellpadding="0">

													<tr>
														<td colspan="8" align="center" valign="middle"
															style="border-right: 1px solid #fff;"><table
																width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>

																	<td width="66%" height="25" align="center"
																		bgcolor="#dee7d6" class="td">${status.index+1}.
																		&nbsp;&nbsp;${bid.bidItem.name}
																		&nbsp;&nbsp;&nbsp;&nbsp;${bid.bidItem.totalQuantity}
																		${bid.bidItem.unit}</td>
																</tr>
																<c:if test="${not empty bid.bidId}">
																	<tr>
																		<td height="25" colspan="2" align="center"
																			bgcolor="#EFEFE7" class="td">Are you sure, you
																			want to grant bid to H1</td>
																	</tr>
																	<tr>
																		<td height="30" colspan="2" align="center"
																			bgcolor="#DEE7D6" class="td"><input
																			type="button" name="button"
																			onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount}','${bid.bidderName}','H1');"
																			value="Yes" /> <input type="button" name="button2"
																			value="No"
																			onclick="$('#dialog_h1btn${status.index+1}').dialog('close');return false;" /></td>
																	</tr>
																</c:if>
																<c:if test="${empty bid.bidId}">
																	<tr>
																		<td height="25" colspan="2" align="center"
																			bgcolor="#EFEFE7" class="td">No bidding on this
																			bid.</td>
																	</tr>
																</c:if>
															</table></td>
													</tr>
												</table>
											</form></td>
									</tr>
								</table>
							</div> 
							
							</div>
							</div>
							</div>
							</div>
							
							
							<c:if test="${empty bid.bidItem.isProcessed}">
								<input type="submit" name="button7" id="h1btn${status.index+1}"
									value="H1"  data-toggle="modal" data-target="#dialog_h1btn${status.index+1}"  />
							</c:if>
							
							<div class="modal fade" id="dialog_h2btn${status.index+1}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="dialog_h2btn${status.index+1}">H2/H3</h4>
      </div>
      <div class="modal-body">
							
							
							

							<div id="dialog_h2btn${status.index+1}" class="h2btn"
								title="Bid Approval : H2/H3" >

								<table >
									<tr>
										<td align="left" valign="top" style=""><form name="form1"
												method="post" action="" style="margin: 0px;">
												<table >

													<tr>
														<td colspan="8" align="left" valign="middle"><table
																width="100%" border="0" cellpadding="0" cellspacing="0"
																bordercolor="#FFFFFF">
																<tr>
																	<td width="11%" height="25" align="center"
																		bgcolor="#dee7d6" class="td">${status.index+1}.</td>
																	<td width="89%" height="35" colspan="4" align="left"
																		bgcolor="#dee7d6" class="td">&nbsp;&nbsp;${bid.bidItem.name}&nbsp;&nbsp;&nbsp;
																		${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</td>
																</tr>
																<c:if
																	test="${not empty bid.bidAmount2 || not empty bid.bidAmount3}">
																	<tr>
																		<td height="35" align="center" bgcolor="#dee7d6"
																			class="td"><p>&nbsp;</p></td>
																		<td height="25" align="center" bgcolor="#dee7d6"
																			class="td">Bidder Rank</td>
																		<td align="center" bgcolor="#dee7d6" class="td">Bidding
																			Company</td>
																		<td align="center" bgcolor="#dee7d6" class="td">Bidder
																			Name</td>
																		<td align="center" bgcolor="#dee7d6" class="td">Bid
																			Amount</td>
																	</tr>
																</c:if>
																<c:if test="${not empty bid.bidAmount2}">
																	<tr>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td"><input type="radio" name="radioH2"
																			id="radioH2" value="H2"
																			onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount2}','${bid.bidderName2}','H2');" /></td>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td">H2</td>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td">${bid.bidderName2}</td>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td">${bid.bidderName2}</td>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td">INR ${bid.bidAmount2}</td>
																	</tr>
																</c:if>
																<c:if test="${not empty bid.bidAmount3}">
																	<tr>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td"><input type="radio" name="radioH2"
																			id="radioH2" value="H3"
																			onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount3}','${bid.bidderName3}','H3');" /></td>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td">H3</td>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td">${bid.bidderName3}</td>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td">${bid.bidderName3}</td>
																		<td height="25" align="center" bgcolor="#efefe7"
																			class="td">INR ${bid.bidAmount3}</td>
																	</tr>
																</c:if>
																<c:if
																	test="${empty bid.bidAmount3 && empty bid.bidAmount2}">
																	<tr>
																		<td width="89%" height="35" colspan="5" align="left"
																			bgcolor="#dee7d6" class="td">&nbsp;&nbsp; No H2,
																			H3 Value present for this bid.</td>
																	</tr>
																</c:if>
															</table></td>
													</tr>
													<tr>
														<td colspan="8" align="left" valign="middle"
															bgcolor="#efefe7" style="border-right: 1px solid #fff;">&nbsp;</td>
													</tr>
												</table>
											</form></td>
									</tr>
								</table>
							</div> 
							
							</div></div></div></div>
							
							<c:if test="${empty bid.bidItem.isProcessed}">
								<input type="submit" name="button7" id="h2btn${status.index+1}"
									value="H2/H3" data-toggle="modal" data-target="#dialog_h2btn${status.index+1}"/>
							</c:if>


<div class="modal fade" id="dialog_rejectbtn${status.index+1}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Reject</h4>
      </div>
      <div class="modal-body">



							<div id="dialog_rejectbtn${status.index+1}" class="rejectbtn"
								title="Bid Approval :&nbsp; Reject">

								<table width="400" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td align="left" valign="top"><form name="form1"
												method="post" action="" style="margin: 0px;">
												<table width="400" border="0" cellspacing="0"
													cellpadding="0">

													<tr>
														<td colspan="8" align="center" valign="middle"
															style="border-right: 1px solid #fff;"><table
																width="100%" border="0" cellspacing="0" cellpadding="0">
																<tr>

																	<td width="66%" height="25" align="center"
																		bgcolor="#dee7d6" class="td">${status.index+1}.
																		&nbsp;&nbsp;${bid.bidItem.name}
																		&nbsp;&nbsp;&nbsp;&nbsp;${bid.bidItem.totalQuantity}
																		${bid.bidItem.unit}</td>
																</tr>
																<tr>
																	<td height="25" colspan="2" align="center"
																		bgcolor="#EFEFE7" class="td">Are you sure, you
																		want to Reject the bid</td>
																</tr>
																<tr>
																	<td height="30" colspan="2" align="center"
																		bgcolor="#DEE7D6" class="td"><input type="button"
																		name="button"
																		onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount}','${bid.bidderName}','Rejected');"
																		value="Yes" /> <input type="button" name="button2"
																		value="No"
																		onclick="$('#dialog_rejectbtn${status.index+1}').dialog('close');return false;" /></td>
																</tr>
															</table></td>
													</tr>
												</table>
											</form></td>
									</tr>
								</table>
							</div> 
							
							</div></div></div></div>
							
							<c:if test="${empty bid.bidItem.isProcessed}">
								<input type="submit" name="button7"
									id="rejectbtn${status.index+1}" value="Reject"
									data-toggle="modal" data-target="#dialog_rejectbtn${status.index+1}" />
							</c:if> <c:if test="${not empty bid.bidItem.isProcessed}">
								<c:out value="${bid.bidItem.isProcessed}" />
							</c:if>
						</td>
						<td align="center" class="DetailBorLast"><c:if
								test="${not empty bid.bidItem.isProcessed}">
								<c:if test="${bid.bidItem.isProcessed == 'H1'}">
									<c:out value="${bid.bidderName}"></c:out>
								</c:if>
								<c:if test="${bid.bidItem.isProcessed == 'H2'}">
									<c:out value="${bid.bidderName2}"></c:out>
								</c:if>
								<c:if test="${bid.bidItem.isProcessed == 'H3'}">
									<c:out value="${bid.bidderName3}"></c:out>
								</c:if>

							</c:if></td>
					</tr>
				</c:forEach>
			</table>

			<%
				if (request.getAttribute("H1Approved") != null
						&& !(Boolean) request.getAttribute("H1Approved")) {
					out.println("<script>function printErrorH1Approved() { alert('Approval Could not happened. Please check with support team.') } printErrorH1Approved();</script>");
				}
			%>

		</div>
	</div>
</body>
</html>





<%--  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>

<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<spring:url value="/observer" var="observer_home_url" />
<spring:url value="/observer/approveH1" var="observer_h1_url" />
<spring:url value="/observer/marketlist" var="observer_market_url" />
<spring:url value="/observer/active" var="observer_active_url" />

<spring:url value="/observer/closed" var="Paginationform_url" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css" rel="stylesheet" />	
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript">
	
	function onSubmit(pageNo) {
		document.paginationForm.category.value = document.forms["categoryform"].category.value;
		document.paginationForm.page.value=pageNo;
		document.paginationForm.submit();
	}
	
	function MM_openBrWindow(theURL,winName,features) { //v2.0
		  window.open(theURL,winName,features);
	}
	function getResultForCategory()
	{
		document.forms["categoryform"].submit(); 
	}
	function getPageForMarketType(marketType)
	{
		var location1 = ""
		if(marketType == "1")
			location1 = "${observer_home_url}/marketlist";
		else if(marketType == "2")
			location1 = "${observer_home_url}/active";
		else if(marketType == "3")
			location1 = "${observer_home_url}/closed";		
		window.location.href=location1
	}
	/*function submitFormH1(bidItemid, bidAmount, bidderName){
		var location1 = "${observer_h1_url}?bidItemid="+bidItemid+"&bidAmount="+bidAmount+"&bidderName="+bidderName;
		window.location.href = location1			
	}*/
	function submitFormH1H2H3(bidItemid, bidAmount, bidderName, bidStatus){
		
		
		document.observerForm.bidItemId.value = bidItemid;
		document.observerForm.bidAmount.value = bidAmount;
		document.observerForm.bidderName.value = bidderName;
		document.observerForm.categoryId.value = document.getElementById("category").value;
		document.observerForm.pageO.value = document.paginationForm.page.value;
		
		document.observerForm.bidStatus.value = bidStatus;
		document.observerForm.submit();
					
	}


</script>
		
        <script type="text/javascript">
			$(function(){
				// Dialog			
				
				$('.desc').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.partici').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.bidhistory').dialog({
					autoOpen: false,
					width:'auto',
					height:310,
				});
				$('.biddetail').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.textension').dialog({
					autoOpen: false,
					width:'auto',
					height:310,
				});
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
				});
				
				$('.h1btn').dialog({
					autoOpen: false,
					width:'auto',
					close: function(ev, ui) 
	                {
	                    $(this).close;
	                },
				});
				$('.h2btn').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.rejectbtn').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.description').click(function(){
				
					//$('.desc').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.partcipents').click(function(){
				
					$('.partici').dialog('open');
					return false;
				});
				$('.history').click(function(){
				
					$('.bidhistory').dialog('open');
					return false;
				});
				$('.detail').click(function(){
				
					if(document.getElementById("bidItemIdVal")){
						var bidItemId = document.getElementById("bidItemIdVal").value;
						if(bidItemId=="" || bidItemId.length < 1) {
							alert("Please first select the Material name for getting detail for that");
							return false;
						}							
					}				
					$('.biddetail').dialog('open');
					return false;
				});
				$('.time').click(function(){
				
					$('.textension').dialog('open');
					return false;
				});
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
					return false;
				});
				$('.h1').click(function(){
				
					//$('.h1btn').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.h2').click(function(){
				
					//$('.h2btn').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.reject').click(function(){
				
					//$('.rejectbtn').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
			});
		</script>
		<script type="text/javascript">
	
	$(function() {
		$(".desc").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".partici").dialog({
			bgiframe: false,
			modal: true,
			
		});
			$(".bidhistory").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".biddetail").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".textension").dialog({
			bgiframe: false,
			modal: true,
			
		});
		$(".change").dialog({
			bgiframe: false,
			modal: true,
			
		});
		
		$(".h1btn").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
		$(".h2btn").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
		$(".rejectbtn").dialog({
			bgiframe: false,
			modal: true,
			
		});

	});
	</script>
<script language="javascript">
function blah( oCB )
{    for( oElem = oCB; oElem.tagName!= "TR"; oElem = oElem.parentNode );
    oElem.className = oCB.checked? "selected": "";
}
</script>
</head>

<body><div id="dhtmltooltip"></div>
<%@ include file="/WEB-INF/jsp/observer/observer_top.jsp" %>

<div class="Mian">

<div class="CheckBoxMenu">
    <form id="form1" name="form1" method="post" action="" style="margin:0px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="1%" height="29" align="left" valign="middle"><input type="radio" name="radio" id="radio1" value="1" class="checkbox" onClick="getPageForMarketType(this.value)"/></td>
          <td width="6%" align="left" valign="middle"><a href="${observer_market_url}" onmouseover="ddrivetip('Market List','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink" >&nbsp;Market List</a></td>
          <td width="1%" align="left" valign="middle"><input type="radio" name="radio" id="radio2" value="2" class="checkbox" onClick="getPageForMarketType(this.value)"/></td>
          <td width="7%" align="left" valign="middle"><a href="${observer_active_url}" onmouseover="ddrivetip('Active Market','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink">&nbsp;Active Market</a></td>
          <td width="1%" align="left" valign="middle"><input type="radio" checked  name="radio" id="radio3" value="3" class="checkbox"/></td>
          <td width="49%" align="left" valign="middle">&nbsp;Closed Market</td>
          <td width="32%" align="right" valign="middle"><strong>Total No. of Forward Markets in Closed List: <c:out value="${fn:length(bidsList)}"/></strong></td>
        </tr>
      </table>
    </form>
  </div>
  
<form:form action="${Paginationform_url}" name="paginationForm">
  	    <input type="hidden" name="page" value="<c:out value='${navigationInfo.currentPage}' />" />
      	<input type="hidden" name="category" value="0"/>
  </form:form>
  <div class="DetailDiv">
  <table width="100%" border="0" style = "font:14px bold;" bgcolor="#dce6f2" cellspacing="0" cellpadding="0">
      <tr>
      <td width="100%" align="right">
  <display:table name="navigationInfo" requestURI="${Paginationform_url}" excludedParams="*" cellspacing="0px" cellpadding="0px 0px 0px 0px">
	        <display:setProperty name="paging.banner.onepage" value="<br/>"></display:setProperty>
	        <display:setProperty name="basic.msg.empty_list" value=""></display:setProperty>
		<display:setProperty name="basic.msg.empty_list_row" value=""></display:setProperty>
		<display:setProperty name="paging.banner.first">
			<table id="pagetable" width="100%" border="0" cellspacing="0"
				cellpadding="0" align="center">
					<tr><td><div style="width:100%;text-align:center"><span class="pagelinks">
							First
							| Prev&nbsp;<c:out value="${navigationInfo.pageSize}" />
							| <a href="#" onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage+1}' />')" id="id3" >Next&nbsp;<c:out value="${navigationInfo.pageSize}" /></a>
							| <a href="#" onclick="javascript: onSubmit('<c:out value='${navigationInfo.pageCount}' />')" id="id4" >Last</a>
					</span></div></td></tr>
				</table>
		</display:setProperty>		
		<display:setProperty name="paging.banner.full">
			<table id="pagetable" width="100%" border="0" cellspacing="0"
				cellpadding="0" align="center">
				<tr><td><div style="width:100%;text-align:center"><span class="pagelinks">
					 <a href="#" onclick="javascript: onSubmit('1')" id="id5" >First</a>
					  | <a href="#" onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage-1}' />')" id="id6" >Prev&nbsp;<c:out value="${navigationInfo.pageSize}" /></a>
					  | <a href="#" onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage+1}' />')" id="id3" >Next&nbsp;<c:out value="${navigationInfo.pageSize}" /></a>
					  | <a href="#" onclick="javascript: onSubmit('<c:out value='${navigationInfo.pageCount}' />')" id="id4" >Last </a>
				</span></div></td></tr>
			</table>
		</display:setProperty>
		<display:setProperty name="paging.banner.last">
				<table id="pagetable" width="100%" border="0" cellspacing="0"
					cellpadding="0" align="center">
					<tr><td><div style="width:100%;text-align:center"><span class="pagelinks">
							<a href="#" onclick="javascript: onSubmit('1')" id="id5" >First</a>
							| <a href="#" onclick="javascript: onSubmit('<c:out value='${navigationInfo.currentPage-1}' />')"  id="id6" >Prev&nbsp;<c:out value="${navigationInfo.pageSize}" /></a>
							| Next&nbsp;<c:out value="${navigationInfo.pageSize}" /> 
							| Last 
					</span></div></td></tr>
				</table>
	  </display:setProperty>
	</display:table> 
	</td>
	</tr>
	</table>    
</div>
  <div class="DetailDiv"> 
  <form action="${observer_h1_url}" method="post" modelAttribute="observerVO" name="observerForm">
	   <input type="hidden" name="bidItemId" value=""/>
	   <input type="hidden" name="bidAmount" value=""/>
	   <input type="hidden" name="bidderName" value=""/>
	   <input type="hidden" name="bidStatus" value=""/>
	   <input type="hidden" name="categoryId" value=""/>
	   <input type="hidden" name="pageO" value="<c:out value='${navigationInfo.currentPage}' />" />
	  </form>
  
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="3%" height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Sr. No.','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Sr. No</a></td>
        <td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Description','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Description</a></td>
        <td width="3%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Lot No.','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lot No.</a></td>
        <td width="10%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">
          <form name="categoryform" action="closed" method="post">
	          <select name="category" id="category" onChange="getResultForCategory()">
	        	 <option value="0">All</option>
		          <c:forEach var="bidderCategory" items="${bidderCategoryList}">	
		         	<c:if test="${bidderCategory.bidderCategoryId.category.categoryId==categoryName}">           		
		               <option value="${bidderCategory.bidderCategoryId.category.categoryId}"  selected="selected">
		                 <c:out value="${bidderCategory.bidderCategoryId.category.categoryName}" />
		               </option>
		             </c:if>
		             <c:if test="${bidderCategory.bidderCategoryId.category.categoryId!=categoryName}">           		
		               <option value="${bidderCategory.bidderCategoryId.category.categoryId}" >
		                 <c:out value="${bidderCategory.bidderCategoryId.category.categoryName}" />
		               </option>
		             </c:if>
		         </c:forEach>
	        </select>
        </form>
        </td>
        <td width="9%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Material Name','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Material Name</a></td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Remark','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Remark</a></td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Length Range','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Length Range</a></td>
        <td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Actual Length','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Actual Length<br /> 
        (Approx)</a></td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Quantity','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Quantity</a></td>
        <td width="3%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Zone','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Zone</a></td>
        <td width="8%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Close Date & time','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Close Date &amp; Time</a></td>
        <td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Current Price','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Current Price(INR)</a></td>
        <td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('H1','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">H1</a></td>
        <td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Reserved Price','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Reserved Price(INR)</a></td>
        <td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Last Price','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Last Price(INR)</a></td>
        <td width="12%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Bid','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Bid <br />
        Approval</a></td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorLastTitle"> <a href="#" onmouseover="ddrivetip('Winning Firm Name','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Winning<br /> 
        Firm Name</a></td>
      </tr>
      <c:forEach items="${bidsList}" var="bid" varStatus="status">
      <tr  class="table">
        <td height="40" align="center" valign="middle" class="DetailBorRight"><div id="seqId${bid.bidItem.bidItemId}">${bid.bidItem.serialNo}.</div></td>
        <td align="center" valign="middle" class="DetailBorRight">
        
 
    
	<div id="dialog_desc${status.index+1}" class="desc" title="Item Description" style="display:none;">
    <table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" ><form name="form1" method="post" action="" style="margin:0px;">
      <table width="700" border="0" cellspacing="0" cellpadding="0">
       
        <tr>
          <td width="49" height="30" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Sr. No.</td>
          <td width="92" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Category</td>
          <td width="56" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Lot No. </td>
          <td width="131" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Material Name</td>
          <td width="64" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Remark</td>
          <td width="96" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Length Range</td>
          <td width="125" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Actual Length <br>
            (Approx)</td>
          <td width="87" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Qty</td>
          <td width="87" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Zone</td>
        </tr>
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bid.bidItem.serialNo}. </td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;"><div id="categoryName${bid.bidItem.bidItemId}">
          ${bid.bidItem.category.categoryName}</div></td>
           <c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		     <c:if test="${status2.index+1 == 1}">
        	  <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.lotNo}</td>
        	  </c:if>
          </c:forEach>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bid.bidItem.name}</td>
           <c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
			<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
			 <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.remark}</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.lengthRange}</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.actualLengh}</td>
			</c:forEach>
			</c:if>
			 <c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          </c:if>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</td>
          <c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
          	<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
          	 <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.zone}</td>
          	 </c:forEach>
          </c:if>
          <c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
           <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          </c:if>
        </tr>
        <c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
		<c:forEach items="${bid.bidItem.itemLots}" var="itemLot" varStatus="status1">
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${status1.index+1}. </td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${bid.bidItem.category.categoryName}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.lotNo}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.name}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.remark}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.lengthRange}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.actualLengh}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.quantity} ${itemLot.unit}</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${itemLot.zone}</td>
        </tr>
        </c:forEach>
        </c:if>
      </table>
        </form>    
     </td>
  </tr>
</table>
    </div>
	<input type="submit" name="button7" id="desc${status.index+1}" value="Desc" class="description ui-state-default ui-corner-all" /></td>
        <c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		     <c:if test="${status2.index+1 == 1}">
        	  <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
        	  </c:if>
        </c:forEach>
        <td align="center" valign="middle" class="DetailBorRight"><div id="categoryName${bid.bidItem.bidItemId}">${bid.bidItem.category.categoryName}</div></td>
        <td align="center" valign="middle" class="DetailBorRight">
        <div id="bidItemName${bid.bidItem.bidItemId}" style="display:none">${bid.bidItem.name}</div>
        <a href="#" class="LinkSelected" 
        onclick="javascript:setIdForBiddingHistory(${bid.bidItem.bidItemId});">${bid.bidItem.name}</a></td>
        <c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
    <c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}</td>
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>
        </c:forEach>
        </c:if>
         <c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
          <td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
          </c:if>
        <td align="center" valign="middle" class="DetailBorRight"><div id="totalQuantity${bid.bidItem.bidItemId}">
        ${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</div></td>
         <c:if test="${fn:length(bid.bidItem.itemLots) == 1}">
           		<c:forEach items="${bid.bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
           		     <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.zone}</td>
            	</c:forEach>
          </c:if>
           <c:if test="${fn:length(bid.bidItem.itemLots) > 1}">
                    <td align="center" valign="middle"   style="border-right:1px solid #fff;">&nbsp;</td>
           </c:if>
        <td align="center" valign="middle" class="DetailBorRight"> ${bid.bidItem.bidEndTime}
        </td>
        <td align="center" valign="middle" class="DetailBorRight">${bid.bidItem.currentMarketPrice}</td>
        <td align="center" valign="middle" class="DetailBorRight">${bid.bidderName}</td>
        <td align="center" valign="middle" class="DetailBorRight"> <div id="Item${bid.bidItem.bidItemId}" style="display:none">${bid.bidItem.minBidPrice}</div></td>
        <td align="center" valign="middle" class="DetailBorRight"> <div id="minBidIncrement${bid.bidItem.bidItemId}" style="display:none">${bid.bidItem.minBidIncrement}</div></td>
        <td align="center" valign="middle" class="DetailBorRight">
        
	<div id="dialog_h1btn${status.index+1}" class="h1btn" title="Bid Approval : H1" style="display:none;">

		<table width="400" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" ><form name="form1" method="post" action="" style="margin:0px;">
      <table width="400" border="0" cellspacing="0" cellpadding="0">
       
        <tr>
          <td colspan="8" align="center" valign="middle" style="border-right:1px solid #fff;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
             
              <td width="66%" height="25" align="center" bgcolor="#dee7d6" class="td">${status.index+1}. &nbsp;&nbsp;${bid.bidItem.name} &nbsp;&nbsp;&nbsp;&nbsp;${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</td>
            </tr>
            <c:if test="${not empty bid.bidId}">
	            <tr>
	              <td height="25" colspan="2" align="center" bgcolor="#EFEFE7" class="td">Are you sure, you want to grant bid to H1</td>
	            </tr>
	            <tr>
	              <td height="30" colspan="2" align="center" bgcolor="#DEE7D6" class="td"><input type="button" name="button" 
	              	onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount}','${bid.bidderName}','H1');" value="Yes"  />
	                <input type="button" name="button2" value="No" onclick="$('#dialog_h1btn${status.index+1}').dialog('close');return false;"/></td>
	            </tr>
	       </c:if>
	       <c:if test="${empty bid.bidId}">
	            <tr>
	              <td height="25" colspan="2" align="center" bgcolor="#EFEFE7" class="td">No bidding on this bid.</td>
	            </tr>
	       </c:if>
          </table></td>
          </tr>
      </table>
        </form>    </td>
  </tr>
</table>
	</div>
	<c:if test="${empty bid.bidItem.isProcessed}">
			<input type="submit" name="button7" id="h1btn${status.index+1}" value="H1" class="h1 ui-corner-all H1Button" />
    </c:if>    
       
	<div id="dialog_h2btn${status.index+1}" class="h2btn" title="Bid Approval : H2/H3" style="display:none;">

		<table width="400" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000">
  <tr>
    <td align="left" valign="top" style=""><form name="form1" method="post" action="" style="margin:0px;">
      <table width="400" border="0" cellspacing="0" cellpadding="0">
        
        <tr>
          <td colspan="8" align="left" valign="middle" ><table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF">
            <tr>
              <td width="11%" height="25" align="center" bgcolor="#dee7d6" class="td">${status.index+1}.</td>
              <td width="89%" height="35" colspan="4" align="left" bgcolor="#dee7d6" class="td">&nbsp;&nbsp;${bid.bidItem.name}&nbsp;&nbsp;&nbsp;  ${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</td>
            </tr>
           <c:if test="${not empty bid.bidAmount2 || not empty bid.bidAmount3}">
              <tr>
	              <td height="35" align="center" bgcolor="#dee7d6" class="td"><p>&nbsp;</p></td>
	              <td height="25" align="center" bgcolor="#dee7d6" class="td">Bidder Rank</td>
	              <td align="center" bgcolor="#dee7d6" class="td">Bidding Company</td>
	              <td align="center" bgcolor="#dee7d6" class="td">Bidder Name</td>
	              <td align="center" bgcolor="#dee7d6" class="td">Bid Amount</td>
             </tr>
            </c:if>
            <c:if test="${not empty bid.bidAmount2}">                        
            <tr>
              <td height="25" align="center" bgcolor="#efefe7" class="td"><input type="radio" name="radioH2" id="radioH2" value="H2" onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount2}','${bid.bidderName2}','H2');" /></td>
              <td height="25" align="center" bgcolor="#efefe7" class="td">H2</td>
              <td height="25" align="center" bgcolor="#efefe7" class="td">${bid.bidderName2}</td>
              <td height="25" align="center" bgcolor="#efefe7" class="td">${bid.bidderName2}</td>
              <td height="25" align="center" bgcolor="#efefe7" class="td">INR ${bid.bidAmount2}</td>
            </tr>
            </c:if>
           <c:if test="${not empty bid.bidAmount3}">          
            <tr>
              <td height="25" align="center" bgcolor="#efefe7" class="td"><input type="radio" name="radioH2" id="radioH2" value="H3" onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount3}','${bid.bidderName3}','H3');"/></td>
              <td height="25" align="center" bgcolor="#efefe7" class="td">H3</td>
              <td height="25" align="center" bgcolor="#efefe7" class="td">${bid.bidderName3}</td>
              <td height="25" align="center" bgcolor="#efefe7" class="td">${bid.bidderName3}</td>
              <td height="25" align="center" bgcolor="#efefe7" class="td">INR ${bid.bidAmount3}</td>
            </tr>
            </c:if>
            <c:if test="${empty bid.bidAmount3 && empty bid.bidAmount2}">
            <tr>
              <td width="89%" height="35" colspan="5" align="left" bgcolor="#dee7d6" class="td">&nbsp;&nbsp;
            	No H2, H3 Value present for this bid.
            </td>
            </tr>
            </c:if>
          </table></td>
        </tr>
        <tr>
          <td colspan="8" align="left" valign="middle" bgcolor="#efefe7" style="border-right:1px solid #fff;">&nbsp;</td>
        </tr>
      </table>
        </form>    </td>
  </tr>
</table>
	</div>
	<c:if test="${empty bid.bidItem.isProcessed}">
    	<input type="submit" name="button7" id="h2btn${status.index+1}" value="H2/H3" class="h2 ui-corner-all H2Button" />
    </c:if>
        
        
        
	<div id="dialog_rejectbtn${status.index+1}"class="rejectbtn" title="Bid Approval :&nbsp; Reject" style="display:none;">

		<table width="400" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" ><form name="form1" method="post" action="" style="margin:0px;">
      <table width="400" border="0" cellspacing="0" cellpadding="0">
        
        <tr>
          <td colspan="8" align="center" valign="middle" style="border-right:1px solid #fff;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
             
              <td width="66%" height="25" align="center" bgcolor="#dee7d6" class="td">${status.index+1}. &nbsp;&nbsp;${bid.bidItem.name} &nbsp;&nbsp;&nbsp;&nbsp;${bid.bidItem.totalQuantity} ${bid.bidItem.unit}</td>
            </tr>
            <tr>
              <td height="25" colspan="2" align="center" bgcolor="#EFEFE7" class="td">Are you sure, you want to Reject the bid</td>
            </tr>
            <tr>
              <td height="30" colspan="2" align="center" bgcolor="#DEE7D6" class="td">
              <input type="button" name="button" onclick="javascript:submitFormH1H2H3('${bid.bidItem.bidItemId}','${bid.bidAmount}','${bid.bidderName}','Rejected');" value="Yes"  />
                <input type="button" name="button2"  value="No"  onclick="$('#dialog_rejectbtn${status.index+1}').dialog('close');return false;" /></td>
            </tr>
          </table></td>
          </tr>
      </table>
        </form>    </td>
  </tr>
</table>
	</div>
	<c:if test="${empty bid.bidItem.isProcessed}">
		<input type="submit" name="button7" id="rejectbtn${status.index+1}" value="Reject" class="reject ui-corner-all rejButton" />
	</c:if>
	<c:if test="${not empty bid.bidItem.isProcessed}">
		 <c:out value="${bid.bidItem.isProcessed}" />
	</c:if>
            </td>
        <td align="center" class="DetailBorLast">
		<c:if test="${not empty bid.bidItem.isProcessed}">
			<c:if test="${bid.bidItem.isProcessed == 'H1'}">
	        	<c:out value="${bid.bidderName}"></c:out>
	        </c:if>	
	        <c:if test="${bid.bidItem.isProcessed == 'H2'}">
	        	<c:out value="${bid.bidderName2}"></c:out>
	        </c:if>
	        <c:if test="${bid.bidItem.isProcessed == 'H3'}">
	        	<c:out value="${bid.bidderName3}"></c:out>
	        </c:if>
	       
        </c:if></td>
      </tr>
    </c:forEach>
    </table>
    
    <%
    	if(request.getAttribute("H1Approved") != null && !(Boolean)request.getAttribute("H1Approved")) {
    		out.println("<script>function printErrorH1Approved() { alert('Approval Could not happened. Please check with support team.') } printErrorH1Approved();</script>");
    	}
    %>
    
  </div>
  <div class="GreenSpacer"></div>
   <%@ include file="/WEB-INF/jsp/observer/observer_footer.jsp" %>
  <div class="clr"></div>
</div>
</body>
</html>
 --%>