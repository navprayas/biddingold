
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>


<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<spring:url value="/bidder/active" var="bidder_active_url" />
<spring:url value="/bidder/closed" var="bidder_close_url" />

<spring:url value="/bidder/marketlist" var="form_url" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<%-- <link type="text/css" href="${css_url}/bootstrap.css" rel="stylesheet">
	<link href="${css_url}/font-awesome.min.css" rel="stylesheet">
<link href="${css_url}/style.css" rel="stylesheet" />
 --%>
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
<link href="${css_url}/bootstrap.css" rel="stylesheet">
	<link href="${css_url}/font-awesome.min.css" rel="stylesheet">
		<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
		<!-- Custom styles for this template -->
		<link href="${css_url}/custom.css" rel="stylesheet">
			<%-- <script type="text/javascript" src="${js_url}/tooltip.js"></script> --%>
			<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
			<script type="text/javascript"
				src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
			<script type="text/javascript" src="${js_url}/json.min.js"></script>
			<script type='text/javascript' src='/Bidding/dwr/engine.js'> </script>
			<script type='text/javascript' src='/Bidding/dwr/util.js'> </script>
			<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>


			<script type="text/javascript">

	function onSubmit(pageNo) {
		document.paginationForm.category.value = document.forms["categoryform"].category.value;
		document.paginationForm.page.value=pageNo;
		document.paginationForm.submit();
	}
		
	function setPreferenceDisplay(bidId)
	{
		blah(document.getElementById("itemRow"+bidId));
	}

  	function display( notifier, str ) {
    	document.getElementById(notifier).innerHTML = str;
  	}
	
  	function toHourAndMinuteAndSecond( x ) {
    	return Math.floor(x/3600) + ":" + Math.floor((x%3600)/60) + ":" + x%60;
  	}
	
	var timeSpans = new Array();
  	var bidItemIds = new Array();
  	
  	function setTimeLefts( remain, bidItemId) {
		timeSpans.push(remain);
		bidItemIds.push(bidItemId);
  	}

  	function displayTimes()	{
  		var extendTime = document.getElementById("extn").value;
 		var count = document.getElementById("lLCount").value;
  		if(count > 5) { return false; }
   		for(i = 0; i < bidItemIds.length; i++) {
  			ts = timeSpans[i];
  			ex = parseInt(extendTime);
  			diff = 0;
  			if(i == 0 && ex > 0) {
  				diff = ex - ts;
  				if(diff < 0) diff = 0;
   				timeSpans[0] = ex;
  			}
  			else {
  				timeSpans[i] += diff;
  			}
  			
  			if(timeSpans[i] <= 0) {
  				refreshPage();
  			}
  			else {
  				document.getElementById("countdown"+bidItemIds[i]).innerHTML = toHourAndMinuteAndSecond(timeSpans[i]);
  	  			timeSpans[i] -= 1;
  			}
  		}
  		document.getElementById("extn").value = 0;
  		setTimeout("displayTimes()",1000);
  	}

  	function refreshPage() {
  		var count = document.getElementById("lLCount").value;
  		var timee = document.getElementById("lLTime").value;
  		var currentTime = new Date();
  		diff = currentTime.getTime() - parseInt(timee);
  		if(diff < 15000) {
  			document.getElementById("lLCount").value = parseInt(count) + 1;
  			document.getElementById("lLTime").value = currentTime.getTime();
  			return false;
  		}
  		document.getElementById("lLTime").value = currentTime.getTime();
  		window.location.reload(true); 
  	}
  
 </script>
			<script type="text/javascript">
<!--
function getResultForCategory()
{
	document.forms["categoryform"].submit();
}
function getPageForMarketType(marketType)
{
	var location1 = ""
	if(marketType == "1")
		location1 = "${bidder_home_url}/marketlist";
	else if(marketType == "2")
		location1 = "${bidder_home_url}/active";
	else if(marketType == "3")
		location1 = "${bidder_home_url}/closed";		
	window.location.href=location1
}
//-->
</script>
			<script type="text/javascript">
			$(function(){
				// Dialog			
				
				$('.desc').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.bids').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.removediv').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
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
			
				
				// Dialog Link
				
				$('.description').click(function(){
				
				//	$('.desc').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.autobid').click(function(){

					$('#dialog_'+$(this).attr('id')).dialog('open');
					//$('.bids').dialog('open');
					return false;
				});
				$('.remove').click(function(){
				
					//$('.removediv').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
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
			
				
			});
		</script>
			<script type="text/javascript">
	
	$(function() {
		$(".desc").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
	
		$(".bids").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
	
		$(".removediv").dialog({
			bgiframe: false,
			modal: true,
			});
		$(".change").dialog({
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
	});

	
	
	
	function openDialog(divId) {
		$('#' + divId).dialog();
		return false;
	}
	
	
	
	
	</script>
			<script language="javascript">
function blah( oCB )
{    for( oElem = oCB; oElem.tagName!= "TR"; oElem = oElem.parentNode );
    oElem.className = oCB.checked? "selected": "table";
}
</script>
</head>

<body onload="displayTimes();">
	<%-- <%@ include file="/WEB-INF/jsp/bidder/bidder_top.jsp" %> --%>
	<div class="container">
		<input id="extn" type="hidden" name="extn" value="0" /> <input
			id="lLTime" type="hidden" name="lastLoadTime" value="0" /> <input
			id="lLCount" type="hidden" name="freqCounts" value="0" />
		<div class="mark-check1 mktlst">
			<form id="form1" name="form1" method="post" action="">
				<table class="table table-bordered table-striped text-center">
					<tr>
						<td colspan="3"><input type="radio" checked name="radio"
							id="radio" value="1" /> <a href="#"
							 class="subTitleLink">&nbsp;Market
								List</a></td>
						<td colspan="3"><input type="radio" name="radio" id="radio2"
							value="2" onClick="getPageForMarketType(this.value)" /> <a
							href="${bidder_active_url}"
							class="subTitleLink">&nbsp;Active
								Market</a></td>
						<td colspan="3"><input type="radio" name="radio" id="radio3"
							value="3" onClick="getPageForMarketType(this.value)" /> <a
							href="${bidder_close_url}"
							 class="subTitleLink">&nbsp;Closed
								Market</a></td>
						<td colspan="7"><strong>Total No. of Forward Markets
								in Active List: <c:out value="${fn:length(bidItemsList)}" />
						</strong></td>
					</tr>
				</table>
			</form>
		</div>
		<form:form action="${form_url}" name="paginationForm">
			<input type="hidden" name="page"
				value="<c:out value='${navigationInfo.currentPage}' />" />
			<input type="hidden" name="category" value="0" />
		</form:form>
		<div class="table-responsive user-map nofound itemlist">
			<table class="table table-bordered table-striped text-center">
				<tr>
					<td width="100%" align="right"><display:table
							name="navigationInfo" requestURI="${Paginationform_url}"
							excludedParams="*" cellspacing="0px"
							cellpadding="0px 0px 0px 0px">
							<display:setProperty name="paging.banner.onepage" value="<br/>"></display:setProperty>
							<display:setProperty name="basic.msg.empty_list" value=""></display:setProperty>
							<display:setProperty name="basic.msg.empty_list_row" value=""></display:setProperty>
							<display:setProperty name="paging.banner.first">
								<table id="pagetable" width="100%" border="0" cellspacing="0"
									cellpadding="0" align="center">
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

										<td></td>

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
		<div class="table-responsive user-map">
			<table class="table table-bordered table-striped text-center">

				<tr>
					<td><a href="#">Select</a></td>
					<td><a href="#" >Sr. No</a><a href="#"></a></td>
					<td><a href="#">Description</a></td>
					<td><a href="#">Lot No.</a></td>
					<td>
						<form name="categoryform" action="marketlist" method="post">
							<select name="category" id="category"
								onchange="getResultForCategory()">
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
					<td><a href="#"
						>Material Name</a></td>
					<td><a href="#">Remark</a></td>
					<td><a href="#"
						>Length Range</a></td>
					<td><a href="#"
						>Actual Length<br /> (Approx)
					</a></td>
					<td><a href="#" >Quantity</a></td>
					<td><a href="#" >Zone</a></td>
					<td><a href="#"
						>Start Price (INR)</a></td>
					<td ><a href="#">Minimum Increment <br />
							(INR)
					</a></td>
					<td><a href="#"
						>Time to start</a></td>

					<td><a href="#"> Auto Bid</a></td>

				</tr>
				<c:forEach items="${bidItemsList}" var="bidItem" varStatus="status">
					<tr class="table">

						<td><input id="itemRow${bidItem.bidItemId}"
							<c:if test='${bidItemPrefferMap[bidItem.bidItemId] == 1}'><c:out value="checked"/></c:if>
							onclick="setPreference(this, ${bidItem.bidItemId}); blah(this);"
							type="checkbox" name="checkbox" id="checkbox" /> <script>setPreferenceDisplay('${bidItem.bidItemId}');</script>
						</td>
						<td><div id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
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
											<h4 class="modal-title" id="dialog_desc${status.index+1}">Description</h4>
										</div>
										<div class="modal-body">

											<div id="dialog_desc${status.index+1}"
												title="Item Description">
												<table border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td align="left" valign="top"><form name="form1"
																method="post" action="" style="margin: 0px;">
																<table border="0" cellspacing="0" cellpadding="0">
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
																			style="border-right: 1px solid #fff;">${bidItem.serialNo}.
																		</td>
																		<td align="center" valign="middle" bgcolor="#f7c794"
																			style="border-right: 1px solid #fff;">${bidItem.category.categoryName}</td>

																		<c:forEach items="${bidItem.itemLots}"
																			var="itemLotUnique" varStatus="status2">
																			<c:if test="${status2.index+1 == 1}">
																				<td align="center" valign="middle" bgcolor="#f7c794"
																					style="border-right: 1px solid #fff;">${itemLotUnique.lotNo}</td>
																			</c:if>
																		</c:forEach>

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
																		<c:if test="${fn:length(bidItem.itemLots) == 1}">
																			<c:forEach items="${bidItem.itemLots}"
																				var="itemLotUnique" varStatus="status2">
																				<td align="center" valign="middle" bgcolor="#f7c794"
																					style="border-right: 1px solid #fff;">${itemLotUnique.zone}</td>
																			</c:forEach>
																		</c:if>
																		<c:if test="${fn:length(bidItem.itemLots) > 1}">
																			<td align="center" valign="middle" bgcolor="#f7c794"
																				style="border-right: 1px solid #fff;">&nbsp;</td>
																		</c:if>
																	</tr>
																	<c:if test="${fn:length(bidItem.itemLots) > 1}">
																		<c:forEach items="${bidItem.itemLots}" var="itemLot"
																			varStatus="status1">
																			<tr>
																				<td height="30" align="center" valign="middle"
																					bgcolor="#f0f3ea"
																					style="border-right: 1px solid #fff;">${status1.index+1}
																				</td>
																				<td align="center" valign="middle" bgcolor="#f0f3ea"
																					style="border-right: 1px solid #fff;">${bidItem.category.categoryName}</td>
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
							</div> <input type="submit" name="button3" bgcolor="#9cba5a"
							id="dialog_desc${status.index+1}" value="Desc"
							data-toggle="modal" data-target="#dialog_desc${status.index+1}" />
						</td>

						<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
							varStatus="status2">
							<c:if test="${status2.index+1 == 1}">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
							</c:if>
						</c:forEach>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="categoryName${bidItem.bidItemId}">${bidItem.category.categoryName}</div></td>
						<td align="center" valign="middle" class="DetailBorRight">
							<div id="bidItemName${bidItem.bidItemId}" style="display: none">${bidItem.name}</div>
							<a href="#" class="LinkSelected"
							onclick="javascript:setIdForBiddingHistory(${bidItem.bidItemId});">${bidItem.name}</a>
						</td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}</td>
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>

							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>

						</c:if>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="totalQuantity${bidItem.bidItemId}">${bidItem.totalQuantity}
								${bidItem.unit}</div></td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.zone}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
						</c:if>


						<td align="center" valign="middle" class="DetailBorRight"><div
								id="currentMarketPrice${bidItem.bidItemId}">
								${bidItem.currentMarketPrice}</div></td>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="minBidIncrement${bidItem.bidItemId}">
								${bidItem.minBidIncrement}</div></td>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="countdown${bidItem.bidItemId}"></div> <script>setTimeLefts(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}');</script>
							<!-- 
        	<script>setTimer(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}', {
	     0: function () { refreshPage();       }
	  });
	  
	  </script>
	   --></td>
						<td align="center" valign="middle" class="DetailBorRight"><c:if
								test="${!bidItem.autoBidFlag}">





								<div class="modal fade" id="dialog_bids${bidItem.bidItemId}"
									tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
												<h4 class="modal-title" id="${bidItem.bidItemId}">Auto
													Bid</h4>
											</div>
											<div class="modal-body">

												<div id="dialog_bids${bidItem.bidItemId}" class="bids"
													title="Auto Bid">
													<table>
														<tr>
															<td align="left" valign="top">
																<form action="marketlist/saveautobid" method="post"
																	name="saveautobidform1"
																	id="saveAutoBidForm${bidItem.bidItemId}"
																	style="margin: 0px;">
																	<input type="hidden" name="bidItemId"
																		value="${bidItem.bidItemId}" /> <input type="hidden"
																		name="categoryId" id="categoryId${bidItem.bidItemId}"
																		value="0" />
																	<table width="400" border="0" cellspacing="0"
																		cellpadding="0">

																		<tr>
																			<td height="30" colspan="3" align="left"
																				bgcolor="#dee7d2" class="td"
																				style="border-right: 1px solid #fff;">&nbsp;
																				${bidItem.serialNo}.
																				&nbsp;&nbsp;&nbsp;&nbsp;${bidItem.name}
																				&nbsp;&nbsp;&nbsp;&nbsp;${bidItem.totalQuantity}
																				${bidItem.unit}</td>
																		</tr>

																		<tr>
																			<td width="110" height="30" bgcolor="#DEE7D6"
																				class="td" style="border-right: 1px solid #fff;">&nbsp;
																				Auto Bid Limit</td>
																			<td colspan="2" bgcolor="#DEE7D6" class="td"
																				style="padding-left: 10px;"><input type="text"
																				name="autoBidAmount"
																				id="autoBidLimit${bidItem.bidItemId}"
																				class="PopupField" /></td>
																		</tr>
																		<tr>
																			<td height="30" bgcolor="#F7F3EF" class="td"
																				style="border-right: 1px solid #fff;">&nbsp;&nbsp;Comments</td>
																			<td height="60" colspan="2" bgcolor="#F7F3EF"
																				class="td" style="padding-left: 10px;"><textarea
																					name="textfield2" id="comments${bidItem.bidItemId}"
																					class="PopupFieldComm"></textarea></td>
																		</tr>
																		<tr>
																			<td height="30" bgcolor="#DEE7D6" class="td"
																				style="border-right: 1px solid #fff;">&nbsp;</td>
																			<td colspan="2" bgcolor="#DEE7D6" class="td"
																				style="padding-left: 10px;"><input
																				type="button" name="button" id="button"
																				value="Submit"
																				onClick="autoBidSave('${bidItem.bidItemId}', '${bidItem.currentMarketPrice}', '${bidItem.minBidIncrement}');" /></td>
																		</tr>
																	</table>
																</form>
															</td>
														</tr>
													</table>
												</div>

											</div>
										</div>
									</div>
								</div>
								<input type="submit" name="button3" bgcolor="#9cba5a"
									id="bids${bidItem.bidItemId}" value="Auto Bid"
									data-toggle="modal"
									data-target="#dialog_bids${bidItem.bidItemId}" />
							</c:if> <c:if test="${bidItem.autoBidFlag}">       
          ${bidItem.amountAutoBid} <br></br>
								<div class="modal fade"
									id="dialog_removediv${bidItem.bidItemId}" tabindex="-1"
									role="dialog" aria-labelledby="myModalLabel">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
												<h4 class="modal-title" id="${bidItem.bidItemId}">Auto
													Bid</h4>
											</div>
											<div class="modal-body">

												<div id="dialog_removediv${bidItem.bidItemId}"
													class="removediv" title="Auto Bid : Remove">
													<table width="400" border="0" cellspacing="0"
														cellpadding="0">
														<tr>
															<td align="left" valign="top">
																<form name="deleteAutoBidForm"
																	id="deleteAutoBidForm${bidItem.bidItemId}"
																	method="post" action="marketlist/deleteautobid"
																	style="margin: 0px;">
																	<input type="hidden" name="autoBidId"
																		value="${bidItem.currentAutoBidId}" /> <input
																		type="hidden" name="categoryId"
																		id="categoryId${bidItem.bidItemId}" value="0" />
																	<table width="400" border="0" cellspacing="0"
																		cellpadding="0">

																		<tr>
																			<td colspan="8" align="center" valign="middle"
																				style="border-right: 1px solid #fff;"><table
																					width="100%" cellpadding="0" cellspacing="0"
																					class="td">
																					<tr class="td">

																						<td width="66%" height="25" align="center"
																							bgcolor="#dee7d6" class="td">${bidItem.serialNo}.
																							&nbsp;&nbsp;${bidItem.name}
																							&nbsp;&nbsp;&nbsp;&nbsp;${bidItem.totalQuantity}
																							${bidItem.unit}</td>
																					</tr>
																					<tr class="td">
																						<td height="25" colspan="2" align="center"
																							bgcolor="#EFEFE7" class="td">Are you sure,
																							you want to Remove the Auto Bid</td>
																					</tr>
																					<tr class="td">
																						<td height="30" colspan="2" align="center"
																							bgcolor="#DEE7D6" class="td"><input
																							type="submit" name="button" id="button"
																							value="Yes"
																							onclick="removeAutoBid('${bidItem.bidItemId}')" />
																							<input type="submit" name="button2"
																							id="removediv${bidItem.bidItemId}" value="No"
																							onclick="closeRemoveAutoBid('${bidItem.bidItemId}'); return false;" /></td>
																					</tr>
																				</table></td>
																		</tr>
																	</table>
																</form>
															</td>
														</tr>
													</table>

												</div>

											</div>
										</div>
									</div>
								</div>
								<input type="submit" name="button6"
									id="removediv${bidItem.bidItemId}" value="Remove"
									data-toggle="modal"
									data-target="#dialog_removediv${bidItem.bidItemId}" />
							</c:if></td>
					</tr>

				</c:forEach>
			</table>

		</div>
		<script>
     function autoBidSave(bidId, CurMarketPrice, minBidIncrement)
     {
  	   var formVal = document.getElementById("saveAutoBidForm"+bidId);
  	   //alert("AutoBidLimit setting: formVal " + formVal);
  	   var categoryField = document.getElementById("categoryId"+bidId);
  	   //alert("AutoBidLimit setting: categoryField " + categoryField);
  	   
  	   	var bidAmount = document.getElementById("autoBidLimit"+bidId).value
  	  var parsedBidAmount = parseFloat(bidAmount)
  	if(!isNumber(bidAmount))
	{
		alert("Amount provided is not a number: " + bidAmount)
		return false;
	}
	var parsedCurMarketPrice = parseFloat(CurMarketPrice)
	var parsedMinBidIncrement = parseFloat(minBidIncrement)
	
	if(parsedBidAmount < (parsedCurMarketPrice+parsedMinBidIncrement))
	{
		alert("Amount provided is less than start price plus minimum bid increment amount " + parsedBidAmount)	
		//$("#dialog_bids" + bidId).dialog('close');
		return false;
	}
	
	var calculation = (parsedBidAmount - parsedCurMarketPrice) % parsedMinBidIncrement ;
	//alert("calculation " + calculation)
	if(calculation != 0)
	{
		alert("Not a valid multiple of minimum bid increment " + parsedBidAmount)
		//$("#dialog_bids" + bidId).dialog('close');
		return false;
	}
	
	   categoryField.value = 1;
	   formVal.submit();
   }
   function removeAutoBid(bidId)
   {
	   var formVal = document.getElementById("deleteAutoBidForm"+bidId);
	   //alert("AutoBidLimit setting: formVal " + formVal);
	   var categoryField = document.getElementById("categoryId"+bidId);
	   //alert("AutoBidLimit setting: categoryField " + categoryField);
	   categoryField.value = 1;
   }
   function closeRemoveAutoBid(bidId)
   {
	   $("#dialog_removediv" + bidId).dialog('close');
	   return false;
   }

</script>

		<!-- 	<div class="GreenSpacer"></div>


		<div class="clr"></div> -->
	</div>

	<script>


function setPreference(checkBoxObj, bidId)
{
	if(checkBoxObj.checked)
	{
		setPreffered(bidId)
	}
	else
	{
		removePreffered(bidId)
	}
	blah(document.getElementById("itemRow"+bidId));
}
function setPreffered(bidId) 
{
	 $.getJSON("setPreffered", { bidItemId:  bidId }, function(data){});	
}

function removePreffered(bidId) 
{
	 $.getJSON("removePreffered", { bidItemId:  bidId }, function(data){});	
}

function isNumber(n) {
	  return !isNaN(parseFloat(n)) && isFinite(n);
	}
	
function fn()
{
    dwr.engine.setActiveReverseAjax(true); // Initiate reverse ajax polling
    dwr.engine.setNotifyServerOnPageUnload(true);
    dwr.engine.setErrorHandler(errorHandler); // Optional - Called when a call and all retry attempts fail
    dwr.engine.setPollStatusHandler(updatePollStatus); // Optional - function to call when the reverse ajax status changes (e.g. online to offline)
    updatePollStatus(true); // Optional - We are online right now!  Until DWR determines we are not!
    //Tabs.init('tabList', 'tabContents'); // Initialize the tabs for this display      

	//var param = "<security:authentication property='principal.username'/>"+"bidder_active";
	//alert("In fn " + param)
	//addScriptSession(param);
}
fn();

window.onunload = function() {
	//var param = "<security:authentication property='principal.username'/>"+"bidder_active";
	//removeScriptSession(param);
    dwr.engine.setActiveReverseAjax(false);
}
function errorHandler(message, ex) {
    dwr.util.setValue("error", "<font color='red'>Cannot connect to server. Initializing retry logic.</font>", {escapeHtml:false});
    setTimeout(function() { dwr.util.setValue("error", ""); }, 5000)
}

function updatePollStatus(pollStatus) {
    //dwr.util.setValue("pollStatus", pollStatus ? "<font color='green'>Online</font>" : "<font color='red'>Offline</font>", {escapeHtml:false});
}
</script>

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
<spring:url value="/bidder" var="bidder_home_url" />
<spring:url value="/bidder/active" var="bidder_active_url" />
<spring:url value="/bidder/closed" var="bidder_close_url" />

<spring:url value="/bidder/marketlist" var="form_url" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css" rel="stylesheet" />
<link type="text/css" href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">	
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript" src="${js_url}/json.min.js"></script>
<script type='text/javascript' src='/Bidding/dwr/engine.js'> </script>
<script type='text/javascript' src='/Bidding/dwr/util.js'> </script>

<script type="text/javascript">

	function onSubmit(pageNo) {
		document.paginationForm.category.value = document.forms["categoryform"].category.value;
		document.paginationForm.page.value=pageNo;
		document.paginationForm.submit();
	}
		
	function setPreferenceDisplay(bidId)
	{
		blah(document.getElementById("itemRow"+bidId));
	}

  	function display( notifier, str ) {
    	document.getElementById(notifier).innerHTML = str;
  	}
	
  	function toHourAndMinuteAndSecond( x ) {
    	return Math.floor(x/3600) + ":" + Math.floor((x%3600)/60) + ":" + x%60;
  	}
	
	var timeSpans = new Array();
  	var bidItemIds = new Array();
  	
  	function setTimeLefts( remain, bidItemId) {
		timeSpans.push(remain);
		bidItemIds.push(bidItemId);
  	}

  	function displayTimes()	{
  		var extendTime = document.getElementById("extn").value;
 		var count = document.getElementById("lLCount").value;
  		if(count > 5) { return false; }
   		for(i = 0; i < bidItemIds.length; i++) {
  			ts = timeSpans[i];
  			ex = parseInt(extendTime);
  			diff = 0;
  			if(i == 0 && ex > 0) {
  				diff = ex - ts;
  				if(diff < 0) diff = 0;
   				timeSpans[0] = ex;
  			}
  			else {
  				timeSpans[i] += diff;
  			}
  			
  			if(timeSpans[i] <= 0) {
  				refreshPage();
  			}
  			else {
  				document.getElementById("countdown"+bidItemIds[i]).innerHTML = toHourAndMinuteAndSecond(timeSpans[i]);
  	  			timeSpans[i] -= 1;
  			}
  		}
  		document.getElementById("extn").value = 0;
  		setTimeout("displayTimes()",1000);
  	}

  	function refreshPage() {
  		var count = document.getElementById("lLCount").value;
  		var timee = document.getElementById("lLTime").value;
  		var currentTime = new Date();
  		diff = currentTime.getTime() - parseInt(timee);
  		if(diff < 15000) {
  			document.getElementById("lLCount").value = parseInt(count) + 1;
  			document.getElementById("lLTime").value = currentTime.getTime();
  			return false;
  		}
  		document.getElementById("lLTime").value = currentTime.getTime();
  		window.location.reload(true); 
  	}
  
 </script>
<script type="text/javascript">
<!--
function getResultForCategory()
{
	document.forms["categoryform"].submit();
}
function getPageForMarketType(marketType)
{
	var location1 = ""
	if(marketType == "1")
		location1 = "${bidder_home_url}/marketlist";
	else if(marketType == "2")
		location1 = "${bidder_home_url}/active";
	else if(marketType == "3")
		location1 = "${bidder_home_url}/closed";		
	window.location.href=location1
}
//-->
</script>
<script type="text/javascript">
			$(function(){
				// Dialog			
				
				$('.desc').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.bids').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.removediv').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
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
			
				
				// Dialog Link
				
				$('.description').click(function(){
				
				//	$('.desc').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.autobid').click(function(){

					$('#dialog_'+$(this).attr('id')).dialog('open');
					//$('.bids').dialog('open');
					return false;
				});
				$('.remove').click(function(){
				
					//$('.removediv').dialog('open');
					$('#dialog_'+$(this).attr('id')).dialog('open');
					return false;
				});
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
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
			
				
			});
		</script>
		<script type="text/javascript">
	
	$(function() {
		$(".desc").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
	
		$(".bids").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
	
		$(".removediv").dialog({
			bgiframe: false,
			modal: true,
			});
		$(".change").dialog({
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
	});

	</script>
<script language="javascript">
function blah( oCB )
{    for( oElem = oCB; oElem.tagName!= "TR"; oElem = oElem.parentNode );
    oElem.className = oCB.checked? "selected": "table";
}
</script>

</head>

<body onload="displayTimes();">
<%@ include file="/WEB-INF/jsp/bidder/bidder_top.jsp" %>
<div class="Mian"><div id="dhtmltooltip"></div>
<input id="extn" type="hidden" name="extn" value="0" />
<input id="lLTime" type="hidden" name="lastLoadTime" value="0"/>
<input id="lLCount" type="hidden" name="freqCounts" value="0"/>
<div class="CheckBoxMenu">
    <form id="form1" name="form1" method="post" action="" style="margin:0px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="1%" height="29" align="left" valign="middle"><input type="radio"  checked name="radio" id="radio" value="1" class="checkbox" /></td>
          <td width="6%" align="left" valign="middle"><a href="#" onmouseover="ddrivetip('Market List','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink">&nbsp;Market List</a></td>
          <td width="1%" align="left" valign="middle"><input type="radio" name="radio" id="radio2" value="2" class="checkbox" onClick="getPageForMarketType(this.value)"/></td>
          <td width="7%" align="left" valign="middle"><a href="${bidder_active_url}" onmouseover="ddrivetip('Active Market','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink">&nbsp;Active Market</a></td>
          <td width="1%" align="left" valign="middle"><input type="radio" name="radio" id="radio3" value="3" class="checkbox" onClick="getPageForMarketType(this.value)"/></td>
          <td width="49%" align="left" valign="middle"><a href="${bidder_close_url}" onmouseover="ddrivetip('Closed Market','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink">&nbsp;Closed Market</a></td>
          <td width="32%" align="right" valign="middle"><strong>Total No. of Forward Markets in Active List: <c:out value="${fn:length(bidItemsList)}" /></strong></td>
        </tr>
      </table>
    </form>
  </div>
  <form:form action="${form_url}" name="paginationForm">
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Select</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Sr No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Sr. No</a><a href="#"></a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Description','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Description</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Lot No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lot No.</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">
        <form name="categoryform" action="marketlist" method="post">
		 <select name="category" id="category" onchange="getResultForCategory()">
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
        </select> </form>       </td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Market Name','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Material Name</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Remark','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Remark</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Length Range','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Length Range</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Actual Length','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Actual Length<br />
(Approx)</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Quantity','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Quantity</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Zone','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Zone</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Start Price','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Start Price (INR)</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Minimum Increment','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Minimum Increment <br /> (INR)</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Time to start','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Time to start</a></td>

        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Auto Bid','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink"> Auto Bid</a></td>
      
      </tr>
       <c:forEach items="${bidItemsList}" var="bidItem" varStatus="status">
 <tr class="table">

     <td height="40" align="center" valign="middle" class="DetailBorRight">
<input id="itemRow${bidItem.bidItemId}" <c:if test='${bidItemPrefferMap[bidItem.bidItemId] == 1}'><c:out value="checked"/></c:if> onclick="setPreference(this, ${bidItem.bidItemId}); blah(this);" type="checkbox" name="checkbox" id="checkbox" />
					<script>setPreferenceDisplay('${bidItem.bidItemId}');</script>	
</td>
        <td height="40" align="center" valign="middle" class="DetailBorRight"><div id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
        <td align="center" valign="middle" class="DetailBorRight">
        
        
	<div id="dialog_desc${status.index+1}" class="desc" title="Item Description" style="display:none;">
    <table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" ><form name="form1" method="post" action="" style="margin:0px;">
      <table width="700" border="0" cellspacing="0" cellpadding="0">
        <tr></tr>
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
          <td height="30" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bidItem.serialNo}. </td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bidItem.category.categoryName}</td>
           
		  <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		     <c:if test="${status2.index+1 == 1}">
        	  <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.lotNo}</td>
        	  </c:if>
          </c:forEach>
          
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bidItem.name}</td>
           <c:if test="${fn:length(bidItem.itemLots) == 1}">
		     <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		  <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.remark}</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.lengthRange}</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.actualLengh}</td>
         
		    </c:forEach>
		   </c:if>
	   <c:if test="${fn:length(bidItem.itemLots) > 1}">
		   <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
           <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
           <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
           
          </c:if>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bidItem.totalQuantity} ${bidItem.unit}</td>
          <c:if test="${fn:length(bidItem.itemLots) == 1}">
          	<c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
          	 <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.zone}</td>
          	 </c:forEach>
          </c:if>
          <c:if test="${fn:length(bidItem.itemLots) > 1}">
           <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          </c:if>
        </tr>
        <c:if test="${fn:length(bidItem.itemLots) > 1}">
		      <c:forEach items="${bidItem.itemLots}" var="itemLot" varStatus="status1">
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${status1.index+1} </td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${bidItem.category.categoryName}</td>
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
        </form>    </td>
  </tr>
</table>
    </div>
    
          <input type="submit" name="button3" id="desc${status.index+1}" value="Desc" class="description ui-state-default ui-corner-all" /></td>
          
          <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		     <c:if test="${status2.index+1 == 1}">
        	  <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
        	  </c:if>
          </c:forEach>
        <td align="center" valign="middle" class="DetailBorRight"><div id="categoryName${bidItem.bidItemId}">${bidItem.category.categoryName}</div></td>
        <td align="center" valign="middle" class="DetailBorRight">
        <div id="bidItemName${bidItem.bidItemId}" style="display:none">${bidItem.name}</div>
        <a href="#" class="LinkSelected" 
        onclick="javascript:setIdForBiddingHistory(${bidItem.bidItemId});">${bidItem.name}</a></td>
        <c:if test="${fn:length(bidItem.itemLots) == 1}">
           <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}</td>
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>
        
        </c:forEach>
        </c:if>
          <c:if test="${fn:length(bidItem.itemLots) > 1}">
           <td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
           <td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle"   style="border-right:1px solid #fff;">&nbsp;</td>
         
          </c:if>
          <td align="center" valign="middle" class="DetailBorRight"><div id="totalQuantity${bidItem.bidItemId}">${bidItem.totalQuantity} ${bidItem.unit}</div></td>
           <c:if test="${fn:length(bidItem.itemLots) == 1}">
           		<c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
           		     <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.zone}</td>
            	</c:forEach>
          </c:if>
           <c:if test="${fn:length(bidItem.itemLots) > 1}">
                    <td align="center" valign="middle"   style="border-right:1px solid #fff;">&nbsp;</td>
           </c:if>
        
     
        <td align="center" valign="middle" class="DetailBorRight"><div id="currentMarketPrice${bidItem.bidItemId}">
         ${bidItem.currentMarketPrice}</div></td>
        <td align="center" valign="middle" class="DetailBorRight"><div id="minBidIncrement${bidItem.bidItemId}">
         ${bidItem.minBidIncrement}</div></td>
        <td align="center" valign="middle" class="DetailBorRight"><div id="countdown${bidItem.bidItemId}"></div>
        <script>setTimeLefts(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}');</script>
        	<!-- 
        	<script>setTimer(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}', {
	     0: function () { refreshPage();       }
	  });
	  
	  </script>
	   -->	   
        </td>
        <td align="center" valign="middle" class="DetailBorRight">
         <c:if  test="${!bidItem.autoBidFlag}">
        <div id="dialog_bids${bidItem.bidItemId}" class="bids" title="Auto Bid" style="display:none;">
              <table width="400" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left" valign="top" >
                    <form action="marketlist/saveautobid"  method="post" name="saveautobidform1" id="saveAutoBidForm${bidItem.bidItemId}" style="margin:0px;">
                      <input type="hidden" name="bidItemId" value="${bidItem.bidItemId}"/>
                      <input type="hidden" name="categoryId" id="categoryId${bidItem.bidItemId}" value="0"/>
                      <table width="400" border="0" cellspacing="0" cellpadding="0">
                       
                        <tr>
                          <td height="30" colspan="3" align="left" bgcolor="#dee7d2" class="td" style="border-right:1px solid #fff;">&nbsp; ${bidItem.serialNo}. &nbsp;&nbsp;&nbsp;&nbsp;${bidItem.name} &nbsp;&nbsp;&nbsp;&nbsp;${bidItem.totalQuantity} ${bidItem.unit}</td>
                        </tr>
                        
                        <tr>
                          <td width="110" height="30" bgcolor="#DEE7D6" class="td" style="border-right:1px solid #fff;">&nbsp; Auto Bid Limit</td>
                          <td colspan="2" bgcolor="#DEE7D6" class="td" style="padding-left:10px;"><input type="text" name="autoBidAmount" id="autoBidLimit${bidItem.bidItemId}" class="PopupField" /></td>
                        </tr>
                        <tr>
                          <td height="30" bgcolor="#F7F3EF" class="td" style="border-right:1px solid #fff;">&nbsp;&nbsp;Comments</td>
                          <td height="60" colspan="2" bgcolor="#F7F3EF" class="td" style="padding-left:10px;"><textarea name="textfield2" id="comments${bidItem.bidItemId}" class="PopupFieldComm"></textarea></td>
                        </tr>
                        <tr>
                          <td height="30" bgcolor="#DEE7D6" class="td" style="border-right:1px solid #fff;">&nbsp;</td>
                          <td colspan="2" bgcolor="#DEE7D6" class="td" style="padding-left:10px;"><input type="button" name="button" id="button" value="Submit" onClick="autoBidSave('${bidItem.bidItemId}', '${bidItem.currentMarketPrice}', '${bidItem.minBidIncrement}');"/></td>
                        </tr>
                      </table>
                </form></td>
              </tr>
            </table>
          </div>
          <input type="submit" name="button3" bgcolor="#9cba5a" id="bids${bidItem.bidItemId}" value="Auto Bid" class="autobid ui-state-default ui-corner-all" />
         </c:if>
         
         <c:if  test="${bidItem.autoBidFlag}">       
          ${bidItem.amountAutoBid} <br></br>
<div id="dialog_removediv${bidItem.bidItemId}" class="removediv" title="Auto Bid : Remove" style="display:none;">
    		<table width="400" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" >
    <form name="deleteAutoBidForm" id="deleteAutoBidForm${bidItem.bidItemId}" method="post" action="marketlist/deleteautobid" style="margin:0px;">
      <input type="hidden" name="autoBidId" value="${bidItem.currentAutoBidId}"/>
      <input type="hidden" name="categoryId" id="categoryId${bidItem.bidItemId}" value="0"/>
      <table width="400" border="0" cellspacing="0" cellpadding="0">
        
        <tr >
          <td colspan="8" align="center" valign="middle" style="border-right:1px solid #fff;"><table width="100%" cellpadding="0" cellspacing="0" class="td">
            <tr class="td">
             
              <td width="66%" height="25" align="center" bgcolor="#dee7d6" class="td">${bidItem.serialNo}. &nbsp;&nbsp;${bidItem.name} &nbsp;&nbsp;&nbsp;&nbsp;${bidItem.totalQuantity} ${bidItem.unit}</td>
            </tr>
            <tr class="td">
              <td height="25" colspan="2" align="center" bgcolor="#EFEFE7" class="td">Are you sure, you want to Remove the Auto Bid</td>
            </tr>
            <tr class="td">
              <td height="30" colspan="2" align="center" bgcolor="#DEE7D6" class="td">
              <input type="submit" name="button" id="button" value="Yes" onclick="removeAutoBid('${bidItem.bidItemId}')" />
                <input type="submit" name="button2" id="removediv${bidItem.bidItemId}" value="No" onclick="closeRemoveAutoBid('${bidItem.bidItemId}'); return false;" /></td>
                  </tr>
          </table></td>
          </tr>
      </table>
        </form>    </td>
      </tr>
      </table>
                
    	</div>
    	<input type="submit" name="button6" id="removediv${bidItem.bidItemId}" value="Remove" class="remove ui-state-default ui-corner-all" />
        </c:if>
        </td>
      </tr>

</c:forEach>    
</table>

  </div>
<script>
     function autoBidSave(bidId, CurMarketPrice, minBidIncrement)
     {
  	   var formVal = document.getElementById("saveAutoBidForm"+bidId);
  	   //alert("AutoBidLimit setting: formVal " + formVal);
  	   var categoryField = document.getElementById("categoryId"+bidId);
  	   //alert("AutoBidLimit setting: categoryField " + categoryField);
  	   
  	   	var bidAmount = document.getElementById("autoBidLimit"+bidId).value
  	  var parsedBidAmount = parseFloat(bidAmount)
  	if(!isNumber(bidAmount))
	{
		alert("Amount provided is not a number: " + bidAmount)
		return false;
	}
	var parsedCurMarketPrice = parseFloat(CurMarketPrice)
	var parsedMinBidIncrement = parseFloat(minBidIncrement)
	
	if(parsedBidAmount < (parsedCurMarketPrice+parsedMinBidIncrement))
	{
		alert("Amount provided is less than start price plus minimum bid increment amount " + parsedBidAmount)	
		//$("#dialog_bids" + bidId).dialog('close');
		return false;
	}
	
	var calculation = (parsedBidAmount - parsedCurMarketPrice) % parsedMinBidIncrement ;
	//alert("calculation " + calculation)
	if(calculation != 0)
	{
		alert("Not a valid multiple of minimum bid increment " + parsedBidAmount)
		//$("#dialog_bids" + bidId).dialog('close');
		return false;
	}
	
	   categoryField.value = 1;
	   formVal.submit();
   }
   function removeAutoBid(bidId)
   {
	   var formVal = document.getElementById("deleteAutoBidForm"+bidId);
	   //alert("AutoBidLimit setting: formVal " + formVal);
	   var categoryField = document.getElementById("categoryId"+bidId);
	   //alert("AutoBidLimit setting: categoryField " + categoryField);
	   categoryField.value = 1;
   }
   function closeRemoveAutoBid(bidId)
   {
	   $("#dialog_removediv" + bidId).dialog('close');
	   return false;
   }

</script>
                          
  <div class="GreenSpacer"></div>
  
<%@ include file="/WEB-INF/jsp/bidder/bidder_footer.jsp" %>
  <!--bidder_footer.html-->
 
    <div class="clr"></div>
</div>

<script>


function setPreference(checkBoxObj, bidId)
{
	if(checkBoxObj.checked)
	{
		setPreffered(bidId)
	}
	else
	{
		removePreffered(bidId)
	}
	blah(document.getElementById("itemRow"+bidId));
}
function setPreffered(bidId) 
{
	 $.getJSON("setPreffered", { bidItemId:  bidId }, function(data){});	
}

function removePreffered(bidId) 
{
	 $.getJSON("removePreffered", { bidItemId:  bidId }, function(data){});	
}

function isNumber(n) {
	  return !isNaN(parseFloat(n)) && isFinite(n);
	}
	
function fn()
{
    dwr.engine.setActiveReverseAjax(true); // Initiate reverse ajax polling
    dwr.engine.setNotifyServerOnPageUnload(true);
    dwr.engine.setErrorHandler(errorHandler); // Optional - Called when a call and all retry attempts fail
    dwr.engine.setPollStatusHandler(updatePollStatus); // Optional - function to call when the reverse ajax status changes (e.g. online to offline)
    updatePollStatus(true); // Optional - We are online right now!  Until DWR determines we are not!
    //Tabs.init('tabList', 'tabContents'); // Initialize the tabs for this display      

	//var param = "<security:authentication property='principal.username'/>"+"bidder_active";
	//alert("In fn " + param)
	//addScriptSession(param);
}
fn();

window.onunload = function() {
	//var param = "<security:authentication property='principal.username'/>"+"bidder_active";
	//removeScriptSession(param);
    dwr.engine.setActiveReverseAjax(false);
}
function errorHandler(message, ex) {
    dwr.util.setValue("error", "<font color='red'>Cannot connect to server. Initializing retry logic.</font>", {escapeHtml:false});
    setTimeout(function() { dwr.util.setValue("error", ""); }, 5000)
}

function updatePollStatus(pollStatus) {
    //dwr.util.setValue("pollStatus", pollStatus ? "<font color='green'>Online</font>" : "<font color='red'>Offline</font>", {escapeHtml:false});
}
</script>

</body>
</html> --%>