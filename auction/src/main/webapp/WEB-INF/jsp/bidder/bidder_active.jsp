<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<spring:url value="/bidder/marketlist" var="bidder_market_url" />
<spring:url value="/bidder/closed" var="bidder_close_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<!--New Script-->
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
	<link type="text/css" href="${css_url}/custom.css"
	rel="stylesheet" />
<%-- <script type="text/javascript" src="${js_url}/tooltip.js"></script> --%>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>



<script type="text/javascript" src="${js_url}/json.min.js"></script>
<script type='text/javascript' src='/Bidding/dwr/engine.js'> </script>
<script type='text/javascript' src='/Bidding/dwr/util.js'> </script>
<script type='text/javascript'>

function changeStyleSelectedHover()
{
	if(document.getElementById("ranktd"))
	{
		document.getElementById("ranktd").style.background = "#d2e4b0";
	}
	if(document.getElementById("currentpricetd"))
	{
	document.getElementById("currentpricetd").style.background = "#d2e4b0";
	}
}
function changeStyleSelectedOut()
{
	if(document.getElementById("ranktd"))
	{
		document.getElementById("ranktd").style.background = "#eaedf4";
	}
	if(document.getElementById("currentpricetd"))
	{
	document.getElementById("currentpricetd").style.background = "#eaedf4";
	}
}
function setNextBidDisabled(nextBidButton)
{
	if(document.getElementById(nextBidButton))
		{
		document.getElementById(nextBidButton).disabled = true;
		document.getElementById(nextBidButton).style.color = "#C0BFBF";
		}
}
	function setPreferenceDisplay(bidId) {
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

window.onload = function() {
}

</script>

<script type="text/javascript">
			$(function(){
				
				// Dialog			
				$('.dialog').dialog({
					autoOpen: false,
					width:'auto',
					close: function(ev, ui) 
	                {
	                    $(this).close;
	                },
				});
				$('.amt').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.desc').dialog({
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
				
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
				});
				// Dialog Link
				$('.dialog_link').click(function(){
				//alert("");
				$('#dialog_'+$(this).attr('id')).dialog('open');
					$('.dialog').dialog('open');
					return false;
				});
		
				$('.changeamot').click(function(){
					$('#dialog_'+$(this).attr('id')).dialog('open');
					$('.amt').dialog('open');
					return false;
				});
				$('.description').click(function(){
				
					$('.desc').dialog('open');
					//alert(this);
					$('#dialog_'+$(this).attr('id')).dialog('open');
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
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
					return false;
				});
			});
		</script>
<script type="text/javascript">
	$(function() {
		$(".dialog").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
		
		$(".amt").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
	
		$(".desc").dialog({
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
		$(".change").dialog({
			bgiframe: false,
			modal: true,
			
		});
		
	});
	</script>

<script language="javascript">
function blah( oCB )
{    for( oElem = oCB; oElem.tagName!= "TR"; oElem = oElem.parentNode );
    	oElem.className = oCB.checked? "selected": "table";
    
    changeStyleSelectedHover();
}
</script>
<!--End-->
<style type="text/css">
<!--
.disabledButton {
	background: url("${images_url}/ui-bg_glass_100_f6f6f6_1x400.png")
		repeat-x scroll 50% 50% #F6F6F6;
	border: 1px solid #CCCCCC;
	color: #C0BFBF;
	cursor: pointer;
	font: bold 12px Arial, Helvetica, sans-serif;
	padding: 5px;
	text-decoration: none;
}

.td1 {
	background-color: #e9edf3;
	color: #ff0000;
}

.td3 {
	background-color: #d0d7e7;
	color: #ff0000;
}

.ttip {
	border: 1px solid black;
	font-size: 12px;
	layer-background-color: lightyellow;
	background-color: lightyellow
}
-->
</style>

</head>

<body onload="displayTimes();">
	<%-- <%@ include file="/WEB-INF/jsp/bidder/bidder_top.jsp"%> --%>
	<div class="container">

		<input id="extn" type="hidden" name="extn" value="0" /> <input
			id="lLTime" type="hidden" name="lastLoadTime" value="0" /> <input
			id="lLCount" type="hidden" name="freqCounts" value="0" /> <span
			id="pollStatus"></span>
		<div id="error"></div>
		<div class="mark-check1 mktlst">
			<form id="form1" name="form1" method="post" action=""
				style="margin: 0px;">
				<table class="table table-bordered table-striped text-center">
					<tr>
					<td colspan="3"><input type="radio" name="radio" id="radio"
						value="1" onClick="getPageForMarketType(this.value)" /> <a
						href="${bidder_market_url}"
						onmouseover="ddrivetip('Market List','', 'auto')"
						onMouseout="hideddrivetip()" class="subTitleLink">&nbsp;Market
							List</a></td>
					<td colspan="3"><input type="radio" checked name="radio"
						id="radio2" value="2" /> <a href="#"
						onmouseover="ddrivetip('Active Market','', 'auto')"
						onMouseout="hideddrivetip()" class="subTitleLink">&nbsp;Active
							Market</a></td>
					<td colspan="3"><input type="radio" name="radio" id="radio3"
						value="3" onClick="getPageForMarketType(this.value)" /> <a
						href="${bidder_close_url}"
						onmouseover="ddrivetip('Closed Market','', 'auto')"
						onMouseout="hideddrivetip()" class="subTitleLink">&nbsp;Closed
							Market</a></td>

					<td colspan="8" align="right"><strong>Total No. of
							Forward Markets in Active List: <c:out
								value="${fn:length(bidItemsList)}" />
					</strong></td>
				</tr>
				</table>
			</form>
		</div>
		<div class="table-responsive user-map nofound itemlist">
			
			<!-- <table class="table table-bordered table-striped text-center">
				<tr>
					<td width="100%" height="10px" align="right">&nbsp;</td>
				</tr>
			</table> -->
			
			<table class="table table-bordered table-striped text-center">
				
				<tr>
					<td><a href="#" onmouseover="ddrivetip('Select','', 'auto')"
						onMouseout="hideddrivetip()">Select</a></td>
					<td><a href="#" onmouseover="ddrivetip('Sr No','', 'auto')"
						onMouseout="hideddrivetip()">Sr. No</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Description','', 'auto')"
						onMouseout="hideddrivetip()">Description</a></td>
					<td><a href="#" onmouseover="ddrivetip('Lot No','', 'auto')"
						onMouseout="hideddrivetip()">Lot No.</a></td>
					<td class="vikd">
						<form name="categoryform" action="active" method="get">
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
						onmouseover="ddrivetip('Material Name','', 'auto')"
						onMouseout="hideddrivetip()">Material Name</a></td>
					<td><a href="#" onmouseover="ddrivetip('Remark','', 'auto')"
						onMouseout="hideddrivetip()">Remark</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Length Range','', 'auto')"
						onMouseout="hideddrivetip()">Length Range</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Actual Length','', 'auto')"
						onMouseout="hideddrivetip()">Actual Length<br />(Approx)
					</a></td>
					<td><a href="#" onmouseover="ddrivetip('Quantity','', 'auto')"
						onMouseout="hideddrivetip()">Quantity</a></td>
					<td><a href="#" onmouseover="ddrivetip('Zone','', 'auto')"
						onMouseout="hideddrivetip()">Zone</a></td>
					<td><a href="#">Min Increment</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Current Price','', 'auto')"
						onMouseout="hideddrivetip()">Current Price (INR)</a></td>
					<td><a href="#" onmouseover="ddrivetip('Rank','', 'auto')"
						onmouseout="hideddrivetip()">Rank</a><a href="#"
						onmouseover="ddrivetip('Rank','', 'auto'); changeStyleSelectedHover();"
						onMouseout="hideddrivetip(); changeStyleSelectedOut();"></a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Time Left','', 'auto')"
						onMouseout="hideddrivetip()">Time Left</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Time Left','', 'auto');"
						onmouseout="hideddrivetip()">Next Bid</a><a href="#"
						onmouseover="ddrivetip('Next Bid','', 'auto')"
						onMouseout="hideddrivetip()"></a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Other Bids','', 'auto');"
						onMouseout="hideddrivetip();"> Other Bids</a></td>
				</tr>
				<c:forEach items="${bidItemsList}" var="bidItem" varStatus="status">
					<div id="bidStartTime${bidItem.bidItemId}" style="display: none">${bidItem.bidStartTime}</div>
					<tr class="table" onmouseover="changeStyleSelectedHover()"
						onmouseout="changeStyleSelectedOut()">
						<td height="40" align="center" valign="middle"
							class="DetailBorRight"><input
							id="itemRow${bidItem.bidItemId}"
							<c:if test='${bidItemPrefferMap[bidItem.bidItemId] == 1}'><c:out value="checked"/></c:if>
							onclick="setPreference(this, ${bidItem.bidItemId}); blah(this);"
							type="checkbox" name="checkbox" id="checkbox" /> <script>setPreferenceDisplay('${bidItem.bidItemId}');</script>
						</td>
						<td height="40" align="center" valign="middle"
							class="DetailBorRight"><div id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
						<td align="center" valign="middle" class="DetailBorRight">

							<div class="modal fade" id="dialog_desc${status.index+1}" tabindex="-1"
								role="dialog" aria-labelledby="myModalLabel">
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
												title="Item Description"   class="table-responsive user-map"> 
												<table  class="table table-bordered table-striped text-center">
													<tr>
														<td align="left" valign="top">
															<form name="form1" method="post" action=""
																>
																<table>
																	<tr></tr>
																	<tr>
																		<td>Sr. No.</td>
																		<td>Category</td>
																		<td>Lot No.</td>
																		<td>Material Name</td>
																		<td>Remark</td>
																		<td>Length Range</td>
																		<td>Actual Length <br> (Approx)
																		</td>
																		<td>Qty</td>
																		<td>Zone</td>
																	</tr>
																	<tr>
																		<td>${bidItem.serialNo}.</td>
																		<td>${bidItem.category.categoryName}</td>
																		<c:forEach items="${bidItem.itemLots}"
																			var="itemLotUnique" varStatus="status2">
																			<c:if test="${status2.index+1 == 1}">
																				<td>${itemLotUnique.lotNo}</td>
																			</c:if>
																		</c:forEach>
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
																		<c:if test="${fn:length(bidItem.itemLots) == 1}">
																			<c:forEach items="${bidItem.itemLots}"
																				var="itemLotUnique" varStatus="status2">
																				<td>${bidItem.zone}</td>
																			</c:forEach>
																		</c:if>
																		<c:if test="${fn:length(bidItem.itemLots) > 1}">
																			<td>&nbsp;</td>
																		</c:if>
																	</tr>
																	<c:if test="${fn:length(bidItem.itemLots) > 1}">
																		<c:forEach items="${bidItem.itemLots}" var="itemLot"
																			varStatus="status1">
																			<tr>
																				<td>${status1.index+1}</td>
																				<td><div id="categoryName${bidItem.bidItemId}">${bidItem.category.categoryName}</div></td>
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
															</form>
														</td>
													</tr>
												</table>
											</div>



										</div>
									</div>
								</div>
							</div> <input type="submit" name="button3" id="desc${status.index+1}"
							value="Desc" data-toggle="modal"
							data-target="#dialog_desc${status.index+1}" />
						</td>
						<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
							varStatus="status2">
							<c:if test="${status2.index+1 == 1}">
								<td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
							</c:if>
						</c:forEach>

						<td align="center" valign="middle" class="DetailBorRight">${bidItem.category.categoryName}</td>
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
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="totalQuantity${bidItem.bidItemId}">${bidItem.totalQuantity}
								${bidItem.unit}</div></td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
						</c:if>


						<td align="center" valign="middle" class="DetailBorRight"><div
								id="minBidIncrement${bidItem.bidItemId}">${bidItem.minBidIncrement}</div></td>
						<td align="center" valign="middle" id="currentpricetd"
							class="DetailBorRight" onmouseover="changeStyleSelectedHover()"
							onmouseout="changeStyleSelectedOut()">
							<div id="Item${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div>
						</td>
						<td align="center" valign="middle" id="ranktd"
							class="DetailBorRight" onmouseover="changeStyleSelectedHover()"
							onmouseout="changeStyleSelectedOut()">
							<div id="rank${bidItem.bidItemId}">
								<c:out value='${bidItemWithRanks[bidItem.bidItemId]}' />
							</div>
						</td>
						<td align="center" valign="middle" class="DetailBorRight">
							<div id="countdown${bidItem.bidItemId}"></div> <script>setTimeLefts(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}');</script>

						</td>
						<td align="center" valign="middle" class="DetailBorRight"><c:choose>
								<c:when
									test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1} '>
									<input type="submit" name="button3"
										id="NextBid${bidItem.bidItemId}" value="Next Bid"
										onclick="doNextBid('${bidItem.bidItemId}', '${bidItem.minBidIncrement}'); return false;"
										disabled="disabled"  />
								</c:when>
								<c:otherwise>
									<input type="submit" name="button3"
										id="NextBid${bidItem.bidItemId}" value="Next Bid"
										onclick="doNextBid('${bidItem.bidItemId}', '${bidItem.minBidIncrement}'); return false;"
										/>
								</c:otherwise>
							</c:choose></td>
						<td align="center" class="DetailBorLast"><c:choose>
								<c:when
									test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1}'>
									<div class="amt" id="dialog_amt${bidItem.bidItemId}"
										title="Change AutoBid">
								</c:when>
								<c:otherwise>

									<div class="modal fade" id="dialog_dialog${bidItem.bidItemId}"
										tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
										<div class="modal-dialog" role="document">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-label="Close">
														<span aria-hidden="true">&times;</span>
													</button>
													<h4 class="modal-title" id="myModalLabel">Bid</h4>
												</div>
												<div class="modal-body">

													<%-- <div class="dialog" id="dialog_dialog${bidItem.bidItemId}"
														title="Bid"> --%>
								</c:otherwise>
							</c:choose>

							<table>
								<tr>
									<td align="left" valign="top">
										<form action="" method="post" name="form1" id="form2"
											style="margin: 0px;">
											<table class="table table-bordered table-striped text-center">
												<tr>
													<td height="30" colspan="3" align="left" bgcolor="#dee7d2"
														style="border-right: 1px solid #fff;">&nbsp;
														${status.index+1}. &nbsp;&nbsp;&nbsp;&nbsp;${bidItem.name}
														&nbsp;&nbsp;&nbsp;&nbsp;${bidItem.totalQuantity}
														${bidItem.unit}</td>
												</tr>
												<tr>
													<td width="110" height="30" bgcolor="#f0f3ea"
														style="border-right: 1px solid #fff;">&nbsp; Bid Type</td>
													<td  bgcolor="#f0f3ea">
														<table>
															<tr>
																<td width="20" style="padding-left: 10px;" align="left"><input
																	type="radio" name="radio"
																	id="NormalBid${bidItem.bidItemId}" value="radio"
																	class="checkbox"
																	onclick="changeBidText(1, '${bidItem.bidItemId}')" /></td>
																<td width="87">Normal Bid</td>
																<td width="10" style="padding-left: 10px;" align="left"><input
																	type="radio" name="radio"
																	id="AutoBid${bidItem.bidItemId}" value="radio"
																	class="checkbox"
																	onclick="changeBidText(2, '${bidItem.bidItemId}')" /></td>
																<td width="132">Auto Bid</td>
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td width="110" height="30" bgcolor="#DEE7D6"
														style="border-right: 1px solid #fff;"><c:if
															test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 1}'>
															<div id="bidAmountText${bidItem.bidItemId}">&nbsp;Bid
																amount</div>
														</c:if> <c:if
															test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2}'>
															<div id="autoBidText${bidItem.bidItemId}">&nbsp;Auto
																Bid Limit</div>
														</c:if></td>
													<td  bgcolor="#DEE7D6"
														style="padding-left: 10px;" align="left"><input type="text"
														name="textfield" id="Amount${bidItem.bidItemId}"
														width="200" /></td>
												</tr>
												<tr>
													<td height="30" bgcolor="#F7F3EF"
														style="border-right: 1px solid #fff;">&nbsp;&nbsp;Comments</td>
													<td height="60" colspan="2" bgcolor="#F7F3EF"
														style="padding-left: 10px;"><textarea
															name="textfield2" id="Comments${bidItem.bidItemId}"
															class="PopupFieldComm"></textarea></td>
												</tr>
												<tr>
													<td height="30" bgcolor="#DEE7D6"
														style="border-right: 1px solid #fff;">&nbsp;</td>
													<td colspan="2" bgcolor="#DEE7D6"
														style="padding-left: 10px;"><input type="submit"
														name="button" id="button" value="Submit"
														onclick="doBid('${bidItem.bidItemId}', '${bidItem.currentMarketPrice}', '${bidItem.minBidIncrement}'); return false;" /></td>
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



							<div id="bidButtonDiv${bidItem.bidItemId}">
								<c:choose>
									<c:when
										test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1}'>
										<div id='actualAutoBid${bidItem.bidItemId}'>
											<c:out value="${bidItem.amountAutoBid}" />
										</div>
										<script>setNextBidDisabled('NextBid${bidItem.bidItemId}');</script>
										<input type="submit" name="button7"
											id="bidSubmit${bidItem.bidItemId}" value="Change AutoBid"
											onclick="setAttributes(this.value, '${bidItem.bidItemId}','${bidItem.minBidIncrement}'); return false;"
											data-toggle="modal"
											data-target="#dialog_dialog${bidItem.bidItemId}" />
									</c:when>
									<c:otherwise>
										<input type="submit" name="button3"
											id="bidSubmit${bidItem.bidItemId}" value="Bid"
											onclick="setAttributes(this.value, '${bidItem.bidItemId}','${bidItem.minBidIncrement}'); return false;"
											data-toggle="modal"
											data-target="#dialog_dialog${bidItem.bidItemId}" />
									</c:otherwise>
								</c:choose>
							</div></td>
					</tr>

				</c:forEach>
			</table>
		</div>
	</div>

	<script>
	/* 
	function opneDialogBox(divId) {
		$('#' + divId).dialog({
			autoResize : true
		});
		return false;
	}
	 */
	
	

function isNumber(n) {
	  return !isNaN(parseFloat(n)) && isFinite(n);
	}

function doBid(bidId, curMarketPrice, minBidIncrement)
{
	var location1 = ""
	var NewcurMarketPrice = document.getElementById("Item"+bidId).innerHTML;
	var bidTypeObj = "NormalBid"+bidId
	//alert("bidTypeObj " + bidTypeObj)
	var bidType = 1
	var bidTypeElem = document.getElementById(bidTypeObj).checked
	if(bidTypeElem)
		{
		bidType = 1
		}
	else
		{
		bidType = 2
		}
	var bidAmountObj = "Amount"+bidId
	//alert(bidAmountObj)
	var bidAmount = document.getElementById(bidAmountObj).value
	
	if(!isNumber(bidAmount))
	{
		alert("Amount provided is not a number: " + bidAmount)
		return false;
	}
	var parsedBidAmount = parseFloat(bidAmount)
	var parsedCurMarketPrice = parseFloat(NewcurMarketPrice)
	var parsedMinBidIncrement = parseFloat(minBidIncrement)
	
	if(parsedBidAmount < (parsedCurMarketPrice+parsedMinBidIncrement))
	{
		alert("Amount provided is less than current market price plus minimum bid increment amount")	
		return false;
	}
	
	var calculation = (parsedBidAmount - parsedCurMarketPrice) % parsedMinBidIncrement ;
	//alert("calculation " + calculation)
	if(calculation != 0)
	{
		alert("Not a valid multiple of minimum bid increment")
		return false;
	}
	//alert("Bid Accepted: Please click Refresh for result");
	//alert(bidAmount)
	var commentsObj = "Comments"+bidId;
	//alert(comments)
	var comments = document.getElementById(commentsObj).value
	//onBidClick(bidAmount,bidId);
	var actualBidDialog = document.getElementById('dialog_dialog'+bidId);
	if(actualBidDialog)
	{
		$('#dialog_dialog'+bidId).modal('hide');
	}
	else
	{
		$('#dialog_amt'+bidId).modal('hide');
		
		//$('#dialog_amt'+bidId).dialog("close");
	}
	//CometPusher.onSubmit(bidId, bidType, bidAmount, handleGetData);
	//location1 = "${bidder_home_url}/bid/"+bidId+"/"+bidType+"/"+bidAmount
	//alert("location1 " + location1)
	
	//window.location.href=location1
	var flag;
	if(bidType == 1){
		flag=confirm("Are you sure you want to bid for amount - " + bidAmount + " , then Press OK");
	}
	else {
		flag=confirm("Are you sure you want to put auto bid amount - " + bidAmount + " , then Press OK");
	}
	if(flag == true) {
		$.getJSON("bid", { bidItemId:  bidId,
			bidType: bidType,
  			bidAmount:  bidAmount, comments: comments }, function(data){ 
  				//alert("It worked");
		});	
	 setNextBidDisabled('NextBid'+bidId);
	}
	 
	return false;
	
}

function doNextBid(bidItemId, minIncrementAmount)
{
	var curPriceObject = document.getElementById("Item"+bidItemId).innerHTML;	
	var nextBidPrice = parseFloat(curPriceObject) + parseFloat(minIncrementAmount);
	var flag;
	flag=confirm("Are you sure you want to put next bid for amount - " + nextBidPrice + " , then Press OK");
	//alert("In doNextBid " + bidItemId + " " + nexBidPrice + " " + minIncrementAmount)
	if(flag == true) {
		$.getJSON("bid", { bidItemId:  bidItemId,
			bidType: 1,
				bidAmount:  nextBidPrice, comments: "Next Bid" }, function(data){ 
					//alert("It worked");
	    });
		setNextBidDisabled('NextBid'+bidItemId);
	}	
	
}
function changeBidText(bidType, bidItemId)
{
	if(bidType == 1)
	{
		if(document.getElementById("bidAmountText" + bidItemId))
			document.getElementById("bidAmountText" + bidItemId).style.display = "block";
		if(document.getElementById("autoBidText" + bidItemId))
			document.getElementById("autoBidText" + bidItemId).style.display = "none";
	}
	else
	{
		if(document.getElementById("bidAmountText" + bidItemId))
			document.getElementById("bidAmountText" + bidItemId).style.display = "none";
		if(document.getElementById("autoBidText" + bidItemId))
			document.getElementById("autoBidText" + bidItemId).style.display = "block";
	}
}

function checkRadioButton(bidItemId, bidType)
{
	if(bidType==1)
		document.getElementById("NormalBid" + bidItemId).checked = true;
	else
		document.getElementById("AutoBid" + bidItemId).checked = true;
}
function resetTextColor(bitItemId)
{
		document.getElementById('ranktd').style.background = '#EAEDF4';	
		document.getElementById('currentpricetd').style.background = '#EAEDF4';
		if(document.getElementById("itemRow"+bitItemId) && document.getElementById("itemRow"+bitItemId).checked) 
			changeStyleSelectedHover();
	
}
function update(message){
	//alert(message + " hello")
	var str = message.split(":");
	var bitItemId = str[0];
	
	var rankHtml = str[1];
	document.getElementById('currentpricetd').style.background = '#bbd5e6';
	if(rankHtml != 0)
	{
		var divRank = document.getElementById("rank"+bitItemId);
		document.getElementById('ranktd').style.background = '#bbd5e6';
		divRank.innerHTML = rankHtml; //str[1];
	}
	setTimeout("resetTextColor("+bitItemId+")",3000);
  	updateScreen(bitItemId, str[2]);
  	if(str[2] == "2")
  	{
	  	var divActualAutoBid = document.getElementById("actualAutoBid"+bitItemId);
	  	if(divActualAutoBid)
	  	{
	  		divActualAutoBid.innerHTML = str[3];  		
	  	}
	  	else
	  	{
	  			var bidButtonDiv  = document.getElementById("bidButtonDiv"+bitItemId);
	  			if(bidButtonDiv)
	  			{
	  				var newDiv = document.createElement('div');  			
		  			var divId = "actualAutoBid"+bitItemId;
		  			newDiv.setAttribute("id", divId)
		  			newDiv.innerHTML = str[3];
		  			bidButtonDiv.insertBefore(newDiv, bidButtonDiv.firstChild);	
	  			}
	  			
	  	}
  	}
  	else
  	{
		var actualAutoBidDiv = document.getElementById("actualAutoBid"+bitItemId);
		if(actualAutoBidDiv)
		{
			actualAutoBidDiv.innerHTML = ""
		}
		else
		{
			var bidButtonDiv  = document.getElementById("bidButtonDiv"+bitItemId);
			if(bidButtonDiv)
			{
				//if(bidButtonDiv.firstChild) bidButtonDiv.firstChild.innerHTML = ""
			}
			
		}
  	}
 	
}

function updateScreen(bidItemId, val){
	if(val == "2")
	{
			document.getElementById("bidSubmit"+bidItemId).value = "Change AutoBid";
			document.getElementById("NormalBid" + bidItemId).disabled = true;
			//alert(document.getElementById("NormalBid" + bidItemId).style);
			//document.getElementById("NormalBid" + bidItemId).style.class = "disabledButton";
			
			//document.getElementById("NormalBid" + bidItemId).checked = false;
			document.getElementById("NextBid" + bidItemId).disabled = true;
			//document.getElementById("NextBid" + bidItemId).style.class = "disabledButton";
			document.getElementById("AutoBid" + bidItemId).checked = true;
			document.getElementById("NormalBid" + bidItemId).style.color = "#C0BFBF";
			document.getElementById("NextBid" + bidItemId).style.color = "#C0BFBF";
			changeBidText(2, bidItemId);
	}
	else
	{
			document.getElementById("bidSubmit" + bidItemId).value = "Bid";
			document.getElementById("NormalBid" + bidItemId).disabled = false;
			//document.getElementById("NormalBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
			document.getElementById("NextBid" + bidItemId).disabled = false;
			//document.getElementById("NextBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
			document.getElementById("NormalBid" + bidItemId).checked = true;
			document.getElementById("NormalBid" + bidItemId).style.color = "#1c94c4";
			document.getElementById("NextBid" + bidItemId).style.color = "#1c94c4";
			document.getElementById("NextBid" + bidItemId).enabled = true;
			changeBidText(1, bidItemId);
	}
}

function enableNormalBidButton(bidItemId)
{
	document.getElementById("NormalBid" + bidItemId).checked = true;
	document.getElementById("NormalBid" + bidItemId).enabled = true;
	document.getElementById("NextBid" + bidItemId).enabled = true;
	//document.getElementById("NormalBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
	//document.getElementById("NextBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
	document.getElementById("NormalBid" + bidItemId).style.color = "#1c94c4";
	document.getElementById("NextBid" + bidItemId).style.color = "#1c94c4";
}
function disableNormalBidButton(bidItemId)
{
	document.getElementById("NormalBid" + bidItemId).disabled = true;
	document.getElementById("NextBid" + bidItemId).disabled = true;
	//document.getElementById("NormalBid" + bidItemId).style.class = "disabledButton";
	//document.getElementById("NextBid" + bidItemId).style.class = "disabledButton";
	document.getElementById("NormalBid" + bidItemId).style.color = "#C0BFBF";
	document.getElementById("NextBid" + bidItemId).style.color = "#C0BFBF";
}

function updatePollStatus(pollStatus) {
    //dwr.util.setValue("pollStatus", pollStatus ? "<font color='green'>Online</font>" : "<font color='red'>Offline</font>", {escapeHtml:false});
}

function fn()
{
    dwr.engine.setActiveReverseAjax(true); // Initiate reverse ajax polling
    dwr.engine.setNotifyServerOnPageUnload(true);
    dwr.engine.setErrorHandler(errorHandler); // Optional - Called when a call and all retry attempts fail
    dwr.engine.setPollStatusHandler(updatePollStatus); // Optional - function to call when the reverse ajax status changes (e.g. online to offline)
    updatePollStatus(true); // Optional - We are online right now!  Until DWR determines we are not!    
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
	  

function setAmount(bidItemId, minIncrementAmount, bidType)
{
	if(bidType == 1)
	{
		var curPriceObject = document.getElementById("Item"+bidItemId).innerHTML;
		
		var nexBidPrice = parseFloat(curPriceObject) + parseFloat(minIncrementAmount);
		
		//alert("nexBidPrice " + nexBidPrice);
		document.getElementById("Amount"+bidItemId).value = nexBidPrice;
	}
	else
	{
		if(document.getElementById("actualAutoBid"+bidItemId))
			{
			var curAutoBid = document.getElementById("actualAutoBid"+bidItemId).innerHTML;
			
			document.getElementById("Amount"+bidItemId).value = curAutoBid;
			}
		
	}
}

function setAttributes(bidButtonType, bitItemId, minBidIncrement)
{
	
	
	if(bidButtonType == "Bid")
	{
		setAmount(bitItemId, minBidIncrement, 1); 
		enableNormalBidButton(bitItemId); 
		changeBidText(1, bitItemId); 	
		checkRadioButton(bitItemId, '1'); 
		var actualAutoBid = document.getElementById("actualAutoBid"+bitItemId)
		if(actualAutoBid)
			actualAutoBid.innerHTML = "";
		
		/* $('#dialog_dialog'+bitItemId).modal({
		    show: 'false'
		});  */
		
		
		$('#dialog_dialog'+bitItemId).on('show.bs.modal');
		/*  $('#dialog_dialog'+bitItemId).modal('toggle');  */
		
	}
	if(bidButtonType == "Change AutoBid")
	{
		setAmount(bitItemId, minBidIncrement, 2); 
		disableNormalBidButton(bitItemId); 
		changeBidText(2, bitItemId);	 
		checkRadioButton(bitItemId, '2');
		$('#dialog_amt'+bitItemId).on('show.bs.modal');
	}
}


function setPreference(checkBoxObj, bidId)
{
	if(checkBoxObj.checked)
	{
		setPreffered(bidId);
	}
	else
	{
		removePreffered(bidId)
	}
}
function setPreffered(bidId) 
{
	 $.getJSON("setPreffered", { bidItemId:  bidId }, function(data){});	
}

function removePreffered(bidId) 
{
	 $.getJSON("removePreffered", { bidItemId:  bidId }, function(data){});	
}

</script>

</body>
</html>



<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<spring:url value="/bidder/marketlist" var="bidder_market_url" />
<spring:url value="/bidder/closed" var="bidder_close_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<!--New Script-->
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>

<script type="text/javascript" src="${js_url}/json.min.js"></script>
<script type='text/javascript' src='/Bidding/dwr/engine.js'> </script>
<script type='text/javascript' src='/Bidding/dwr/util.js'> </script>
<script type='text/javascript'>

function changeStyleSelectedHover()
{
	if(document.getElementById("ranktd"))
	{
		document.getElementById("ranktd").style.background = "#d2e4b0";
	}
	if(document.getElementById("currentpricetd"))
	{
	document.getElementById("currentpricetd").style.background = "#d2e4b0";
	}
}
function changeStyleSelectedOut()
{
	if(document.getElementById("ranktd"))
	{
		document.getElementById("ranktd").style.background = "#eaedf4";
	}
	if(document.getElementById("currentpricetd"))
	{
	document.getElementById("currentpricetd").style.background = "#eaedf4";
	}
}
function setNextBidDisabled(nextBidButton)
{
	if(document.getElementById(nextBidButton))
		{
		document.getElementById(nextBidButton).disabled = true;
		document.getElementById(nextBidButton).style.color = "#C0BFBF";
		}
}
	function setPreferenceDisplay(bidId) {
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

window.onload = function() {
}

</script>

<script type="text/javascript">
			$(function(){
				
				// Dialog			
				$('.dialog').dialog({
					autoOpen: false,
					width:'auto',
					close: function(ev, ui) 
	                {
	                    $(this).close;
	                },
				});
				$('.amt').dialog({
					autoOpen: false,
					width:'auto',
				});
				$('.desc').dialog({
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
				
				$('.change').dialog({
					autoOpen: false,
					width:'auto',
					height:110,
				});
				// Dialog Link
				$('.dialog_link').click(function(){
				//alert("");
				$('#dialog_'+$(this).attr('id')).dialog('open');
					$('.dialog').dialog('open');
					return false;
				});
		
				$('.changeamot').click(function(){
					$('#dialog_'+$(this).attr('id')).dialog('open');
					$('.amt').dialog('open');
					return false;
				});
				$('.description').click(function(){
				
					$('.desc').dialog('open');
					//alert(this);
					$('#dialog_'+$(this).attr('id')).dialog('open');
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
				$('.changepass').click(function(){
				
					$('.change').dialog('open');
					return false;
				});
			});
		</script>
<script type="text/javascript">
	$(function() {
		$(".dialog").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
		
		$(".amt").dialog({
			bgiframe: false,
			modal: true,
			
		});
	
	
		$(".desc").dialog({
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
		$(".change").dialog({
			bgiframe: false,
			modal: true,
			
		});
		
	});
	</script>

<script language="javascript">
function blah( oCB )
{    for( oElem = oCB; oElem.tagName!= "TR"; oElem = oElem.parentNode );
    	oElem.className = oCB.checked? "selected": "table";
    
    changeStyleSelectedHover();
}
</script>
<!--End-->
<style type="text/css">
<!--

.disabledButton{ 
    background: url("${images_url}/ui-bg_glass_100_f6f6f6_1x400.png") repeat-x scroll 50% 50% #F6F6F6;
    border: 1px solid #CCCCCC;
    color: #C0BFBF;
    cursor: pointer;
    font: bold 12px Arial,Helvetica,sans-serif;
    padding: 5px;
    text-decoration: none;
}

.td1 {
	background-color: #e9edf3;
	color: #ff0000;
}

.td3 {
	background-color: #d0d7e7;
	color: #ff0000;
}

.ttip {
	border: 1px solid black;
	font-size: 12px;
	layer-background-color: lightyellow;
	background-color: lightyellow
}
-->
</style>

</head>

<body onload="displayTimes();">
<%@ include file="/WEB-INF/jsp/bidder/bidder_top.jsp"%>
<div class="Mian">
<div id="dhtmltooltip"></div>

<input id="extn" type="hidden" name="extn" value="0" />
<input id="lLTime" type="hidden" name="lastLoadTime" value="0"/>
<input id="lLCount" type="hidden" name="freqCounts" value="0"/>

<span id="pollStatus"></span>
<div id="error"></div>
<div class="CheckBoxMenu">
<form id="form1" name="form1" method="post" action=""
	style="margin: 0px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="1%" height="29" align="left" valign="middle"><input type="radio" name="radio" id="radio" value="1" class="checkbox" onClick="getPageForMarketType(this.value)" /></td>
		<td width="6%" align="left" valign="middle"><a href="${bidder_market_url}" onmouseover="ddrivetip('Market List','', 'auto')" onMouseout="hideddrivetip()" class="subTitleLink">&nbsp;Market List</a></td>
		<td width="1%" align="left" valign="middle"><input type="radio" checked name="radio" id="radio2" value="2" class="checkbox" /></td>
		<td width="7%" align="left" valign="middle"><a href="#" onmouseover="ddrivetip('Active Market','', 'auto')" onMouseout="hideddrivetip()" class="subTitleLink">&nbsp;Active Market</a></td>
		<td width="1%" align="left" valign="middle"><input type="radio" name="radio" id="radio3" value="3" class="checkbox" onClick="getPageForMarketType(this.value)" /></td>
		<td width="49%" align="left" valign="middle"><a href="${bidder_close_url}" onmouseover="ddrivetip('Closed Market','', 'auto')" onMouseout="hideddrivetip()" class="subTitleLink">&nbsp;Closed Market</a></td>
		<td width="32%" align="right" valign="middle"><strong>Total No. of Forward Markets in Active List: <c:out value="${fn:length(bidItemsList)}" /></strong></td>
	</tr>
</table>
</form>
</div>
<div class="DetailDiv">
<div id="tooltip" style="position: absolute; visibility: hidden; border: 1px solid black; font-size: 12px; layer-background-color: lightyellow; background-color: lightyellow; padding: 1px"></div>
<table width="100%" border="0" style = "font:14px bold;" bgcolor="#dce6f2" cellspacing="0" cellpadding="0">
        <tr>
      <td width="100%" height="10px" align="right">&nbsp;
      </td>
      </tr>
    </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td width="4%" height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Select','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Select</a></td>
		<td width="3%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Sr No','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Sr. No</a></td>
		<td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Description','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Description</a></td>
		<td width="3%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Lot No','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Lot No.</a></td>
		<td width="10%" align="center" valign="middle" bgcolor="#4f81bc"
			class="DetailBorRightTitle">
        <form name="categoryform" action="active" method="get">
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
        </select> 
        </form>
        </td>
		<td width="12%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Material Name','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Material Name</a></td>
		<td width="7%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Remark','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Remark</a></td>
		<td width="7%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Length Range','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Length Range</a></td>
		<td width="7%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Actual Length','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Actual Length<br />(Approx)</a></td>
		<td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Quantity','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Quantity</a></td>
		<td width="3%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Zone','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Zone</a></td>
		<td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Min Increment</td>
		<td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#"	onmouseover="ddrivetip('Current Price','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Current Price (INR)</a></td>
		<td width="3%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#"	onmouseover="ddrivetip('Rank','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Rank</a><a href="#" onmouseover="ddrivetip('Rank','', 'auto'); changeStyleSelectedHover();" onMouseout="hideddrivetip(); changeStyleSelectedOut();" class="TitleLink"></a></td>
		<td width="5%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Time Left','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Time Left</a></td>
		<td width="6%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#"	onmouseover="ddrivetip('Time Left','', 'auto');" onmouseout="hideddrivetip()" class="TitleLink">Next Bid</a><a href="#" onmouseover="ddrivetip('Next Bid','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink"></a></td>
		<td width="8%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorLastTitle"><a href="#" onmouseover="ddrivetip('Other Bids','', 'auto');" onMouseout="hideddrivetip();" class="TitleLink"> Other Bids</a></td>
	</tr>
	<c:forEach items="${bidItemsList}" var="bidItem" varStatus="status">
	<div id="bidStartTime${bidItem.bidItemId}" style="display:none">${bidItem.bidStartTime}</div>
		<tr class="table"  onmouseover="changeStyleSelectedHover()"  onmouseout="changeStyleSelectedOut()">
			<td height="40" align="center" valign="middle" class="DetailBorRight">
			
	      	<input id="itemRow${bidItem.bidItemId}" <c:if test='${bidItemPrefferMap[bidItem.bidItemId] == 1}'><c:out value="checked"/></c:if> onclick="setPreference(this, ${bidItem.bidItemId}); blah(this);" type="checkbox" name="checkbox" id="checkbox" />
					<script>setPreferenceDisplay('${bidItem.bidItemId}');</script>		
				</td>
			<td height="40" align="center" valign="middle" class="DetailBorRight"><div id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
			<td align="center" valign="middle" class="DetailBorRight">

			<div id="dialog_desc${status.index+1}" class="desc"
				title="Item Description" style="display: none;">
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left" valign="top">
					<form name="form1" method="post" action="" style="margin: 0px;">
					<table width="700" border="0" cellspacing="0" cellpadding="0">
						<tr></tr>
						<tr>
							<td width="49" height="30" align="center" valign="middle"
								bgcolor="#abcb67" style="border-right: 1px solid #fff;">Sr.
							No.</td>
							<td width="92" align="center" valign="middle" bgcolor="#abcb67"
								style="border-right: 1px solid #fff;">Category</td>
							<td width="56" align="center" valign="middle" bgcolor="#abcb67"
								style="border-right: 1px solid #fff;">Lot No.</td>
							<td width="131" align="center" valign="middle" bgcolor="#abcb67"
								style="border-right: 1px solid #fff;">Material Name</td>
							<td width="64" align="center" valign="middle" bgcolor="#abcb67"
								style="border-right: 1px solid #fff;">Remark</td>
							<td width="96" align="center" valign="middle" bgcolor="#abcb67"
								style="border-right: 1px solid #fff;">Length Range</td>
							<td width="125" align="center" valign="middle" bgcolor="#abcb67"
								style="border-right: 1px solid #fff;">Actual Length <br>
							(Approx)
							</td>
							<td width="87" align="center" valign="middle" bgcolor="#abcb67"
								style="border-right: 1px solid #fff;">Qty</td>
							<td width="87" align="center" valign="middle" bgcolor="#abcb67"
								style="border-right: 1px solid #fff;">Zone</td>	
						</tr>
						<tr>
							<td height="30" align="center" valign="middle" bgcolor="#f7c794"
								style="border-right: 1px solid #fff;">${bidItem.serialNo}.</td>
							<td align="center" valign="middle" bgcolor="#f7c794"
								style="border-right: 1px solid #fff;">${bidItem.category.categoryName}</td>
								 <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		                            <c:if test="${status2.index+1 == 1}">
        	                          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${itemLotUnique.lotNo}</td>
        	                            </c:if>
                                       </c:forEach>
							<td align="center" valign="middle" bgcolor="#f7c794"
								style="border-right: 1px solid #fff;">${bidItem.name}</td>
							<c:if test="${fn:length(bidItem.itemLots) == 1}">
								<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
									varStatus="status2">
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
								<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
									varStatus="status2">
									<td align="center" valign="middle" bgcolor="#f7c794"
								style="border-right: 1px solid #fff;">${bidItem.zone}
						</td>
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
										bgcolor="#f0f3ea" style="border-right: 1px solid #fff;">${status1.index+1}
									</td>
									<td align="center" valign="middle" bgcolor="#f0f3ea"
										style="border-right: 1px solid #fff;"><div id="categoryName${bidItem.bidItemId}">${bidItem.category.categoryName}</div></td>
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
										style="border-right: 1px solid #fff;">${itemLot.zone}
								</td>
								</tr>
							</c:forEach>
						</c:if>
					</table>
					</form>
					</td>
				</tr>
			</table>
			</div>
			<input type="submit" name="button3" id="desc${status.index+1}"
				value="Desc" class="description ui-state-default ui-corner-all" />
			</td>
			   <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		     <c:if test="${status2.index+1 == 1}">
        	  <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
        	  </c:if>
          </c:forEach>
			
			<td align="center" valign="middle" class="DetailBorRight">${bidItem.category.categoryName}</td>
			<td align="center" valign="middle" class="DetailBorRight">
			<div id="bidItemName${bidItem.bidItemId}" style="display:none">${bidItem.name}</div>
			<a href="#" class="LinkSelected" onclick="javascript:setIdForBiddingHistory(${bidItem.bidItemId});">${bidItem.name}</a></td>
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
			<td align="center" valign="middle" class="DetailBorRight"><div id="totalQuantity${bidItem.bidItemId}">${bidItem.totalQuantity}
			${bidItem.unit}</div></td>
			<c:if test="${fn:length(bidItem.itemLots) == 1}">
				<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
					varStatus="status2">
					<td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}</td>
					</c:forEach>
					</c:if>
					<c:if test="${fn:length(bidItem.itemLots) > 1}">
				<td align="center" valign="middle" class="DetailBorRight">&nbsp;</td>
				</c:if>
			
			
			<td align="center" valign="middle" class="DetailBorRight"><div id="minBidIncrement${bidItem.bidItemId}">${bidItem.minBidIncrement}</div></td>
			<td align="center" valign="middle" id="currentpricetd" class="DetailBorRight" onmouseover="changeStyleSelectedHover()"  onmouseout="changeStyleSelectedOut()">
			<div id="Item${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div>
			</td>
			<td align="center" valign="middle" id="ranktd" class="DetailBorRight" onmouseover="changeStyleSelectedHover()"  onmouseout="changeStyleSelectedOut()">
			<div id="rank${bidItem.bidItemId}">
				<c:out	value='${bidItemWithRanks[bidItem.bidItemId]}' /></div>
			</td>
			<td align="center" valign="middle" class="DetailBorRight">
			<div id="countdown${bidItem.bidItemId}"></div>
	  		<script>setTimeLefts(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}');</script>
	  
	  		</td>
			<td align="center" valign="middle" class="DetailBorRight">
			<c:choose>
			<c:when test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1} '>
				<input type="submit" name="button3" id="NextBid${bidItem.bidItemId}"
					value="Next Bid"
					onclick="doNextBid('${bidItem.bidItemId}', '${bidItem.minBidIncrement}'); return false;"
					disabled="disabled" class="ui-state-default ui-corner-all" />
			</c:when>
			<c:otherwise>
				<input type="submit" name="button3" id="NextBid${bidItem.bidItemId}" value="Next Bid"
					onclick="doNextBid('${bidItem.bidItemId}', '${bidItem.minBidIncrement}'); return false;" class="ui-state-default ui-corner-all" />
			</c:otherwise> 
			</c:choose>
			</td>
			<td align="center" class="DetailBorLast">
			<c:choose>
			<c:when test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1}'>
			  <div class="amt" id="dialog_amt${bidItem.bidItemId}"	title="Change AutoBid" style="display: none;">
			</c:when>
			<c:otherwise>
			  <div class="dialog" id="dialog_dialog${bidItem.bidItemId}" title="Bid" style="display: none;">
			</c:otherwise> 
			</c:choose>

			  <table width="400" border="0" cellspacing="0" cellpadding="0">
			  <tr>
			    <td align="left" valign="top">
			    <form action="" method="post" name="form1" id="form2" style="margin: 0px;">
			      <table width="400" border="0" cellspacing="0" cellpadding="0">
			      <tr>
			        <td height="30" colspan="3" align="left" bgcolor="#dee7d2" style="border-right: 1px solid #fff;">&nbsp;
					${status.index+1}. &nbsp;&nbsp;&nbsp;&nbsp;${bidItem.name}
					&nbsp;&nbsp;&nbsp;&nbsp;${bidItem.totalQuantity} ${bidItem.unit}</td>
			      </tr>
			      <tr>
			        <td width="110" height="30" bgcolor="#f0f3ea" style="border-right: 1px solid #fff;">&nbsp; Bid Type</td>
			        <td colspan="2" bgcolor="#f0f3ea">
			          <table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td width="20" style="padding-left: 10px;">
				      <input type="radio" name="radio" id="NormalBid${bidItem.bidItemId}"
					value="radio" class="checkbox"	onclick="changeBidText(1, '${bidItem.bidItemId}')" /></td>
				    <td width="87">Normal Bid</td>
				    <td width="10" style="padding-left: 10px;">
				      <input type="radio" name="radio" id="AutoBid${bidItem.bidItemId}"
					value="radio" class="checkbox"
					onclick="changeBidText(2, '${bidItem.bidItemId}')" /></td>
				    <td width="132">Auto Bid</td>
			          </tr>
			          </table>
			        </td>
			      </tr>
			      <tr>
			        <td width="110" height="30" bgcolor="#DEE7D6" style="border-right: 1px solid #fff;">
			        <c:if test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 1}'>
				<div id="bidAmountText${bidItem.bidItemId}">&nbsp;Bid amount</div>
				</c:if> 
				<c:if test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2}'>
				<div id="autoBidText${bidItem.bidItemId}">&nbsp;Auto Bid Limit</div>
				</c:if>
				</td>
				<td colspan="2" bgcolor="#DEE7D6" style="padding-left: 10px;">
				  <input type="text" name="textfield" id="Amount${bidItem.bidItemId}" width="200" />
				</td>
			      </tr>
			      <tr>
			        <td height="30" bgcolor="#F7F3EF" style="border-right: 1px solid #fff;">&nbsp;&nbsp;Comments</td>
			        <td height="60" colspan="2" bgcolor="#F7F3EF" style="padding-left: 10px;">
			          <textarea name="textfield2" id="Comments${bidItem.bidItemId}" class="PopupFieldComm"></textarea></td>
			      </tr>
			      <tr>
			<td height="30" bgcolor="#DEE7D6"
			style="border-right: 1px solid #fff;">&nbsp;</td>
			<td colspan="2" bgcolor="#DEE7D6" style="padding-left: 10px;">
			<input	type="submit" name="button" id="button" value="Submit"
			onclick="doBid('${bidItem.bidItemId}', '${bidItem.currentMarketPrice}', '${bidItem.minBidIncrement}'); return false;" /></td>
			</tr>
			</table>
			</form>
			</td>
			</tr>
			</table>
			</div>
			<div id="bidButtonDiv${bidItem.bidItemId}">
			<c:choose>
			<c:when test='${bidItemWithAutoBidFlag[bidItem.bidItemId] == 2 && bidItemWithRanks[bidItem.bidItemId] == 1}'>
				<div id='actualAutoBid${bidItem.bidItemId}'> 
					<c:out value="${bidItem.amountAutoBid}"/>    
				</div>   
				<script>setNextBidDisabled('NextBid${bidItem.bidItemId}');</script>
				<input type="submit" name="button7"
					id="bidSubmit${bidItem.bidItemId}" value="Change AutoBid"
					onclick="setAttributes(this.value, '${bidItem.bidItemId}','${bidItem.minBidIncrement}'); return false;"
					class="changeamot ui-state-default ui-corner-all" />
			</c:when>
			<c:otherwise>
				<input type="submit" name="button3"
					id="bidSubmit${bidItem.bidItemId}" value="Bid"
					onclick="setAttributes(this.value, '${bidItem.bidItemId}','${bidItem.minBidIncrement}'); return false;"
					class="dialog_link ui-state-default ui-corner-all" />
			</c:otherwise>
			</c:choose>
			</div>
			</td>
		</tr>

	</c:forEach>
</table>
</div>
<div class="GreenSpacer"></div>
<%@ include file="/WEB-INF/jsp/bidder/bidder_footer.jsp"%>

<!--bidder_footer.html--> <!--bidder_footer.html Ends-->

<div class="clr"></div>
</div>

<script>

function isNumber(n) {
	  return !isNaN(parseFloat(n)) && isFinite(n);
	}

function doBid(bidId, curMarketPrice, minBidIncrement)
{
	var location1 = ""
	var NewcurMarketPrice = document.getElementById("Item"+bidId).innerHTML;
	var bidTypeObj = "NormalBid"+bidId
	//alert("bidTypeObj " + bidTypeObj)
	var bidType = 1
	var bidTypeElem = document.getElementById(bidTypeObj).checked
	if(bidTypeElem)
		{
		bidType = 1
		}
	else
		{
		bidType = 2
		}
	var bidAmountObj = "Amount"+bidId
	//alert(bidAmountObj)
	var bidAmount = document.getElementById(bidAmountObj).value
	
	if(!isNumber(bidAmount))
	{
		alert("Amount provided is not a number: " + bidAmount)
		return false;
	}
	var parsedBidAmount = parseFloat(bidAmount)
	var parsedCurMarketPrice = parseFloat(NewcurMarketPrice)
	var parsedMinBidIncrement = parseFloat(minBidIncrement)
	
	if(parsedBidAmount < (parsedCurMarketPrice+parsedMinBidIncrement))
	{
		alert("Amount provided is less than current market price plus minimum bid increment amount")	
		return false;
	}
	
	var calculation = (parsedBidAmount - parsedCurMarketPrice) % parsedMinBidIncrement ;
	//alert("calculation " + calculation)
	if(calculation != 0)
	{
		alert("Not a valid multiple of minimum bid increment")
		return false;
	}
	//alert("Bid Accepted: Please click Refresh for result");
	//alert(bidAmount)
	var commentsObj = "Comments"+bidId
	//alert(comments)
	var comments = document.getElementById(commentsObj).value
	//onBidClick(bidAmount,bidId);
	var actualBidDialog = document.getElementById('dialog_dialog'+bidId)
	if(actualBidDialog)
	{
		$('#dialog_dialog'+bidId).dialog("close");
	}
	else
	{
		$('#dialog_amt'+bidId).dialog("close");
	}
	//CometPusher.onSubmit(bidId, bidType, bidAmount, handleGetData);
	//location1 = "${bidder_home_url}/bid/"+bidId+"/"+bidType+"/"+bidAmount
	//alert("location1 " + location1)
	
	//window.location.href=location1
	var flag;
	if(bidType == 1){
		flag=confirm("Are you sure you want to bid for amount - " + bidAmount + " , then Press OK");
	}
	else {
		flag=confirm("Are you sure you want to put auto bid amount - " + bidAmount + " , then Press OK");
	}
	if(flag == true) {
		$.getJSON("bid", { bidItemId:  bidId,
			bidType: bidType,
  			bidAmount:  bidAmount, comments: comments }, function(data){ 
  				//alert("It worked");
		});	
	 setNextBidDisabled('NextBid'+bidId);
	}
	 
	return false;
	
}

function doNextBid(bidItemId, minIncrementAmount)
{
	var curPriceObject = document.getElementById("Item"+bidItemId).innerHTML;	
	var nextBidPrice = parseFloat(curPriceObject) + parseFloat(minIncrementAmount);
	var flag;
	flag=confirm("Are you sure you want to put next bid for amount - " + nextBidPrice + " , then Press OK");
	//alert("In doNextBid " + bidItemId + " " + nexBidPrice + " " + minIncrementAmount)
	if(flag == true) {
		$.getJSON("bid", { bidItemId:  bidItemId,
			bidType: 1,
				bidAmount:  nextBidPrice, comments: "Next Bid" }, function(data){ 
					//alert("It worked");
	    });
		setNextBidDisabled('NextBid'+bidItemId);
	}	
	
}
function changeBidText(bidType, bidItemId)
{
	if(bidType == 1)
	{
		if(document.getElementById("bidAmountText" + bidItemId))
			document.getElementById("bidAmountText" + bidItemId).style.display = "block";
		if(document.getElementById("autoBidText" + bidItemId))
			document.getElementById("autoBidText" + bidItemId).style.display = "none";
	}
	else
	{
		if(document.getElementById("bidAmountText" + bidItemId))
			document.getElementById("bidAmountText" + bidItemId).style.display = "none";
		if(document.getElementById("autoBidText" + bidItemId))
			document.getElementById("autoBidText" + bidItemId).style.display = "block";
	}
}

function checkRadioButton(bidItemId, bidType)
{
	if(bidType==1)
		document.getElementById("NormalBid" + bidItemId).checked = true;
	else
		document.getElementById("AutoBid" + bidItemId).checked = true;
}
function resetTextColor(bitItemId)
{
		document.getElementById('ranktd').style.background = '#EAEDF4';	
		document.getElementById('currentpricetd').style.background = '#EAEDF4';
		if(document.getElementById("itemRow"+bitItemId) && document.getElementById("itemRow"+bitItemId).checked) 
			changeStyleSelectedHover();
	
}
function update(message){
	//alert(message + " hello")
	var str = message.split(":");
	var bitItemId = str[0];
	
	var rankHtml = str[1];
	document.getElementById('currentpricetd').style.background = '#bbd5e6';
	if(rankHtml != 0)
	{
		var divRank = document.getElementById("rank"+bitItemId);
		document.getElementById('ranktd').style.background = '#bbd5e6';
		divRank.innerHTML = rankHtml; //str[1];
	}
	setTimeout("resetTextColor("+bitItemId+")",3000);
  	updateScreen(bitItemId, str[2]);
  	if(str[2] == "2")
  	{
	  	var divActualAutoBid = document.getElementById("actualAutoBid"+bitItemId);
	  	if(divActualAutoBid)
	  	{
	  		divActualAutoBid.innerHTML = str[3];  		
	  	}
	  	else
	  	{
	  			var bidButtonDiv  = document.getElementById("bidButtonDiv"+bitItemId);
	  			if(bidButtonDiv)
	  			{
	  				var newDiv = document.createElement('div');  			
		  			var divId = "actualAutoBid"+bitItemId;
		  			newDiv.setAttribute("id", divId)
		  			newDiv.innerHTML = str[3];
		  			bidButtonDiv.insertBefore(newDiv, bidButtonDiv.firstChild);	
	  			}
	  			
	  	}
  	}
  	else
  	{
		var actualAutoBidDiv = document.getElementById("actualAutoBid"+bitItemId);
		if(actualAutoBidDiv)
		{
			actualAutoBidDiv.innerHTML = ""
		}
		else
		{
			var bidButtonDiv  = document.getElementById("bidButtonDiv"+bitItemId);
			if(bidButtonDiv)
			{
				//if(bidButtonDiv.firstChild) bidButtonDiv.firstChild.innerHTML = ""
			}
			
		}
  	}
 	
}

function updateScreen(bidItemId, val){
	if(val == "2")
	{
			document.getElementById("bidSubmit"+bidItemId).value = "Change AutoBid";
			document.getElementById("NormalBid" + bidItemId).disabled = true;
			//alert(document.getElementById("NormalBid" + bidItemId).style);
			//document.getElementById("NormalBid" + bidItemId).style.class = "disabledButton";
			
			//document.getElementById("NormalBid" + bidItemId).checked = false;
			document.getElementById("NextBid" + bidItemId).disabled = true;
			//document.getElementById("NextBid" + bidItemId).style.class = "disabledButton";
			document.getElementById("AutoBid" + bidItemId).checked = true;
			document.getElementById("NormalBid" + bidItemId).style.color = "#C0BFBF";
			document.getElementById("NextBid" + bidItemId).style.color = "#C0BFBF";
			changeBidText(2, bidItemId);
	}
	else
	{
			document.getElementById("bidSubmit" + bidItemId).value = "Bid";
			document.getElementById("NormalBid" + bidItemId).disabled = false;
			//document.getElementById("NormalBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
			document.getElementById("NextBid" + bidItemId).disabled = false;
			//document.getElementById("NextBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
			document.getElementById("NormalBid" + bidItemId).checked = true;
			document.getElementById("NormalBid" + bidItemId).style.color = "#1c94c4";
			document.getElementById("NextBid" + bidItemId).style.color = "#1c94c4";
			document.getElementById("NextBid" + bidItemId).enabled = true;
			changeBidText(1, bidItemId);
	}
}

function enableNormalBidButton(bidItemId)
{
	document.getElementById("NormalBid" + bidItemId).checked = true;
	document.getElementById("NormalBid" + bidItemId).enabled = true;
	document.getElementById("NextBid" + bidItemId).enabled = true;
	//document.getElementById("NormalBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
	//document.getElementById("NextBid" + bidItemId).style.class = "ui-state-default ui-corner-all";
	document.getElementById("NormalBid" + bidItemId).style.color = "#1c94c4";
	document.getElementById("NextBid" + bidItemId).style.color = "#1c94c4";
}
function disableNormalBidButton(bidItemId)
{
	document.getElementById("NormalBid" + bidItemId).disabled = true;
	document.getElementById("NextBid" + bidItemId).disabled = true;
	//document.getElementById("NormalBid" + bidItemId).style.class = "disabledButton";
	//document.getElementById("NextBid" + bidItemId).style.class = "disabledButton";
	document.getElementById("NormalBid" + bidItemId).style.color = "#C0BFBF";
	document.getElementById("NextBid" + bidItemId).style.color = "#C0BFBF";
}

function updatePollStatus(pollStatus) {
    //dwr.util.setValue("pollStatus", pollStatus ? "<font color='green'>Online</font>" : "<font color='red'>Offline</font>", {escapeHtml:false});
}

function fn()
{
    dwr.engine.setActiveReverseAjax(true); // Initiate reverse ajax polling
    dwr.engine.setNotifyServerOnPageUnload(true);
    dwr.engine.setErrorHandler(errorHandler); // Optional - Called when a call and all retry attempts fail
    dwr.engine.setPollStatusHandler(updatePollStatus); // Optional - function to call when the reverse ajax status changes (e.g. online to offline)
    updatePollStatus(true); // Optional - We are online right now!  Until DWR determines we are not!    
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
	  

function setAmount(bidItemId, minIncrementAmount, bidType)
{
	if(bidType == 1)
	{
		var curPriceObject = document.getElementById("Item"+bidItemId).innerHTML;
		
		var nexBidPrice = parseFloat(curPriceObject) + parseFloat(minIncrementAmount);
		
		//alert("nexBidPrice " + nexBidPrice);
		document.getElementById("Amount"+bidItemId).value = nexBidPrice;
	}
	else
	{
		if(document.getElementById("actualAutoBid"+bidItemId))
			{
			var curAutoBid = document.getElementById("actualAutoBid"+bidItemId).innerHTML;
			
			document.getElementById("Amount"+bidItemId).value = curAutoBid;
			}
		
	}
}

function setAttributes(bidButtonType, bitItemId, minBidIncrement)
{
	
	
	if(bidButtonType == "Bid")
	{
		setAmount(bitItemId, minBidIncrement, 1); 
		enableNormalBidButton(bitItemId); 
		changeBidText(1, bitItemId); 	
		checkRadioButton(bitItemId, '1'); 
		var actualAutoBid = document.getElementById("actualAutoBid"+bitItemId)
		if(actualAutoBid)
			actualAutoBid.innerHTML = ""
		
		$('#dialog_dialog'+bitItemId).dialog('open');
	}
	if(bidButtonType == "Change AutoBid")
	{
		setAmount(bitItemId, minBidIncrement, 2); 
		disableNormalBidButton(bitItemId); 
		changeBidText(2, bitItemId);	 
		checkRadioButton(bitItemId, '2');
		$('#dialog_amt'+bitItemId).dialog('open');
	}
}


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
}
function setPreffered(bidId) 
{
	 $.getJSON("setPreffered", { bidItemId:  bidId }, function(data){});	
}

function removePreffered(bidId) 
{
	 $.getJSON("removePreffered", { bidItemId:  bidId }, function(data){});	
}

</script>

</body>
</html>
 --%>