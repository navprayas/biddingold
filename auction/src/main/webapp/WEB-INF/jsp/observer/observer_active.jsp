<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/observer" var="observer_home_url" />
<spring:url value="/observer/marketlist" var="observer_market_url" />
<spring:url value="/observer/closed" var="observer_close_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
<script type="text/javascript" src="${js_url}/json.min.js"></script>
<%-- <script type="text/javascript" src="${js_url}/tooltip.js"></script> --%>
<script type='text/javascript' src='/Bidding/dwr/engine.js'> </script>
<script type='text/javascript' src='/Bidding/dwr/util.js'> </script>

<script type="text/javascript">
function isNumber(n) {
	return !isNaN(parseFloat(n)) && isFinite(parseFloat(n));
}
window.onunload = function() {
	dwr.engine.setActiveReverseAjax(false);
}
  function display( notifier, str ) {
    document.getElementById(notifier).innerHTML = str;
  }
	
  function toHourAndMinuteAndSecond( x ) {
    return Math.floor(x/3600) + ":" + Math.floor((x%3600)/60) + ":" + x%60;
  }
	
	function setTimeLefts( remain, bidItemId) {
		timeSpans.push(remain);
		bidItemIds.push(bidItemId);
  	}
  
	var timeSpans = new Array();
	var bidItemIds = new Array();
	
	function displayTimes()	{
  		var extendTime = document.getElementById("extn").value;
 		var count = document.getElementById("lLCount").value;
 		
 		if(extendTime == null || extendTime.length == 0 || count == null || count.length == 0 ) {
  			return false;
  		}
  		if(!isNumber(extendTime)  ||  !isNumber(count)) {
  			return false;
  		}
  		
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
  		update();
  		setTimeout("displayTimes()",1000);
  	}
  
  function refreshPage()
  {
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
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
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
//-->
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

	});
	
	

	</script>
</head>

<body onload="displayTimes();">
	<div class="container">

		<input id="extn" type="hidden" name="extn" value="0" /> <input
			id="lLTime" type="hidden" name="lastLoadTime" value="0" /> <input
			id="lLCount" type="hidden" name="freqCounts" value="0" />

		<div class="mark-check1 mktlst">
			<form id="form1" name="form1" method="post" action="">
				<table class="table table-bordered table-striped text-center">
					<tr>
					<td colspan="3"><input type="radio" name="radio" id="radio"
						value="1" onclick="getPageForMarketType(this.value)" /> <a
						href="${observer_market_url}"
						onmouseover="ddrivetip('Market List','', 'auto')"
						;
onmouseout="hideddrivetip()">&nbsp;Market List</a></td>
					<td colspan="3"><input type="radio" checked name="radio"
						id="radio2" value="2" /><a href="#"
						onmouseover="ddrivetip('Active Market','', 'auto')"
						;
onmouseout="hideddrivetip()">&nbsp;Active Market</a></td>
					<td colspan="3"><input type="radio" name="radio" id="radio3" value="3"
						onclick="getPageForMarketType(this.value)" /> <a
						href="${observer_close_url}"
						onmouseover="ddrivetip('Closed Market','', 'auto')"
						;
onmouseout="hideddrivetip()">&nbsp;Closed Market</a></td>
					<td colspan="7" align="right" ><strong>Total
							No. of Forward Markets in Active List: <c:out
								value="${fn:length(bidItemsList)}" />
					</strong></td>
				</tr>
				</table>
			</form>
		</div>

		<div class="table-responsive user-map nofound itemlist">
			<table class="table table-bordered table-striped text-center">

				<tr>
					<td><a href="#" onmouseover="ddrivetip('Sr No','', 'auto')"
						;
onmouseout="hideddrivetip()">Sr. No</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Description','', 'auto')"
						;
onmouseout="hideddrivetip()">Description</a></td>
					<td><a href="#" onmouseover="ddrivetip('Lot No','', 'auto')"
						;
onmouseout="hideddrivetip()">Lot No.</a></td>
					<td>
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
						onmouseover="ddrivetip('Market Name','', 'auto')"
						;
onmouseout="hideddrivetip()">Market Name</a></td>
					<td><a href="#" onmouseover="ddrivetip('Remark','', 'auto')"
						;
onmouseout="hideddrivetip()">Remark</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Length Range','', 'auto')"
						;
onmouseout="hideddrivetip()">Length Range</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Actual Range','', 'auto')"
						;
onmouseout="hideddrivetip()">Actual Length<br /> (Approx)
					</a></td>
					<td><a href="#" onmouseover="ddrivetip('Quantity','', 'auto')"
						;
onmouseout="hideddrivetip()">Quantity</a></td>
					<td><a href="#" onmouseover="ddrivetip('Zone','', 'auto')"
						;
onmouseout="hideddrivetip()">Zone</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Current Market Price','', 'auto')"
						;
onmouseout="hideddrivetip()">Current <br /> Market Price<br />(INR)
					</a></td>
					<td><a href="#" onmouseover="ddrivetip('H1','', 'auto')"
						;
onmouseout="hideddrivetip()">H1</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Time Left','', 'auto')"
						;
onmouseout="hideddrivetip()">Time Left</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Reserved Price','', 'auto')"
						;
onmouseout="hideddrivetip()">Reserve Price<br />(INR)
					</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Last Price','', 'auto')"
						;
onmouseout="hideddrivetip()">Last Price<br />(INR)
					</a></td>
					<td><a href="#"
						onmouseover="ddrivetip('Time Extension','', 'auto')"
						;
onmouseout="hideddrivetip()">Time Extension</a></td>
				</tr>
				<c:forEach items="${bidItemsList}" var="bidItem" varStatus="status">
					<tr class="table">
						<td><div id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
						<td align="center" valign="middle" class="DetailBorRight">


<div class="modal fade" id="dialog_desc${status.index+1}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      <div class="modal-body">




							<div id="dialog_desc${status.index+1}" class="desc"
								title="Item Description" >

								<table>
									<tr>
										<td align="left" valign="top"><form name="form1"
												method="post" action="" style="margin: 0px;">
												<table>

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
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Market
															Name</td>
														<td width="64" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Remark</td>
														<td width="96" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Length
															Range</td>
														<td width="125" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Actual
															Length <br /> (Approx)
														</td>
														<td width="87" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Qty</td>
														<td width="87" align="center" valign="middle"
															bgcolor="#abcb67" style="border-right: 1px solid #fff;">Zone</td>
													</tr>
													<tr>
														<td height="30" align="center" valign="middle"
															bgcolor="#f7c794" style="border-right: 1px solid #fff;">${bidItem.serialNo}.
														</td>
														<td align="center" valign="middle" bgcolor="#f7c794"
															style="border-right: 1px solid #fff;"><div
																id="categoryName${bidItem.bidItemId}">
																${bidItem.category.categoryName}</div></td>

														<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
															varStatus="status2">
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
																	style="border-right: 1px solid #fff;">${bidItem.zone}</td>
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
																	bgcolor="#f0f3ea" style="border-right: 1px solid #fff;">${status1.index+1}.
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
							
							</div></div></div></div>
							
							
							
							<input type="submit" name="button7" id="desc${status.index+1}"
							value="Desc" data-toggle="modal"
							data-target="#dialog_desc${status.index+1}" />
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
							<a href="#services" class="LinkSelected"
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
								id="totalQuantity${bidItem.bidItemId}">
								${bidItem.totalQuantity} ${bidItem.unit}</div></td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}
									<input type="hidden" value="${bidItem.bidItemId}"
									id="bidItemIdinput" />
								</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td align="center" valign="middle"
								style="border-right: 1px solid #fff;">&nbsp;</td>
						</c:if>
						<td align="center" valign="middle" id="currentpricetd"
							class="DetailBorRight"><div id="Item${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div></td>
						<td align="center" valign="middle" id="firmtd"
							class="DetailBorRight"><div id="firm${bidItem.bidItemId}">
								<c:out value="${CurrentBidder}"></c:out>
							</div></td>
						<td align="center" valign="middle" class="DetailBorRight">
							<div id="countdown${bidItem.bidItemId}"></div> <script>setTimeLefts(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}');</script>
						</td>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="Item${bid.bidItem.bidItemId}" style="display: none">${bid.bidItem.minBidPrice}</div>
						</td>
						<td align="center" valign="middle" class="DetailBorRight"><div
								id="minBidIncrement${bid.bidItem.bidItemId}"
								style="display: none">${bid.bidItem.minBidIncrement}</div></td>
						<td align="center" valign="middle" class="DetailBorRight"><input
							type="text" style="width: 5em"
							id="extendTime${bidItem.bidItemId}" name="extendTime" />&nbsp;&nbsp;Min<br />
							<input type="button" name="extension"
							id="extention${bidItem.bidItemId}" value="Extension"
							onclick="extension(${bidItem.bidItemId});"
							class="ui-state-default-time-top ui-corner-all" /></td>
					</tr>
			  </c:forEach>
			</table>
		</div>
		<script>
	function extension(bidItemId)
	{
  		var extendTime = document.getElementById('extendTime'+bidItemId).value;
  		if(extendTime == null || extendTime.length == 0) {
  			alert("Enter Extended Time in Minutes");
  			return false;
  		}
  		if(!isNumber(extendTime)) {
  			alert("Enter Valid Numeric Extended Time in Minutes");
  			return false;
  		}
  		var extendTimeInt = parseFloat(extendTime);
  		extendTimeInt *= 60;
  		$.getJSON("extension", { bidItemId:  bidItemId, extendTime: extendTimeInt }, function(data){
  			document.getElementById('extendTime'+bidItemId).value = '';
  		});	
 		return false;
	}  	
	
  </script>

		<script>
function fn()
{
	dwr.engine.setActiveReverseAjax(true);
    dwr.engine.setNotifyServerOnPageUnload(true);
    
    var bidIdObj = document.getElementById('bidItemIdinput');
    if(bidIdObj)
	{
		if(document.getElementById('Item'+bidIdObj.value)) {
    		tempVal = document.getElementById('Item'+bidIdObj.value).innerHTML;    		
		}
	}
}
fn();
var tempVal;
function update()
{
	var bidIdObj = document.getElementById('bidItemIdinput');
	if(bidIdObj)
	{
		var bitItemId = bidIdObj.value;
		if(document.getElementById('Item'+bitItemId)) {
			
			var tempVal1 = document.getElementById('Item'+bitItemId).innerHTML;
			if(tempVal != tempVal1){
				document.getElementById('firmtd').style.background = '#bbd5e6';	
				document.getElementById('currentpricetd').style.background = '#bbd5e6';
				tempVal = tempVal1;
				setTimeout("resetTextColor("+bitItemId+")",3000);
			}			
		}
		
	}
	
}
function resetTextColor(bitItemId)
{
		document.getElementById('firmtd').style.background = '#EAEDF4';	
		document.getElementById('currentpricetd').style.background = '#EAEDF4';
	
}
</script>
	</div>
</body>
</html>



<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/observer" var="observer_home_url" />
<spring:url value="/observer/marketlist" var="observer_market_url" />
<spring:url value="/observer/closed" var="observer_close_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css" rel="stylesheet" />	
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>		
<script type="text/javascript" src="${js_url}/json.min.js"></script>
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<script type='text/javascript' src='/Bidding/dwr/engine.js'> </script>
<script type='text/javascript' src='/Bidding/dwr/util.js'> </script>

<script type="text/javascript">
function isNumber(n) {
	return !isNaN(parseFloat(n)) && isFinite(parseFloat(n));
}
window.onunload = function() {
	dwr.engine.setActiveReverseAjax(false);
}
  function display( notifier, str ) {
    document.getElementById(notifier).innerHTML = str;
  }
	
  function toHourAndMinuteAndSecond( x ) {
    return Math.floor(x/3600) + ":" + Math.floor((x%3600)/60) + ":" + x%60;
  }
	
	function setTimeLefts( remain, bidItemId) {
		timeSpans.push(remain);
		bidItemIds.push(bidItemId);
  	}
  
	var timeSpans = new Array();
	var bidItemIds = new Array();
	
	function displayTimes()	{
  		var extendTime = document.getElementById("extn").value;
 		var count = document.getElementById("lLCount").value;
 		
 		if(extendTime == null || extendTime.length == 0 || count == null || count.length == 0 ) {
  			return false;
  		}
  		if(!isNumber(extendTime)  ||  !isNumber(count)) {
  			return false;
  		}
  		
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
  		update();
  		setTimeout("displayTimes()",1000);
  	}
  
  function refreshPage()
  {
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
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
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
//-->
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

	});
	
	

	</script>
<style>
a {
	color:#fff;
	cursor:default;
}
</style>
</head>

<body onload="displayTimes();">
<%@ include file="/WEB-INF/jsp/observer/observer_top.jsp" %>
<div class="Mian"><div id="dhtmltooltip"></div>

<input id="extn" type="hidden" name="extn" value="0" />
<input id="lLTime" type="hidden" name="lastLoadTime" value="0"/>
<input id="lLCount" type="hidden" name="freqCounts" value="0"/>
	
  <div class="CheckBoxMenu">
    <form id="form1" name="form1" method="post" action="" style="margin:0px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="1%" height="29" align="left" valign="middle"><input type="radio" name="radio" id="radio" value="1" class="checkbox" onclick="getPageForMarketType(this.value)"/></td>
          <td width="6%" align="left" valign="middle"><a href="${observer_market_url}" onmouseover="ddrivetip('Market List','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink">&nbsp;Market List</a></td>
          <td width="1%" align="left" valign="middle"><input type="radio" checked name="radio" id="radio2" value="2" class="checkbox" /></td>
          <td width="7%" align="left" valign="middle"><a href="#" onmouseover="ddrivetip('Active Market','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink">&nbsp;Active Market</a></td>
          <td width="1%" align="left" valign="middle"><input type="radio"  name="radio" id="radio3" value="3" class="checkbox" onclick="getPageForMarketType(this.value)"/></td>
          <td width="49%" align="left" valign="middle"><a href="${observer_close_url}" onmouseover="ddrivetip('Closed Market','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink">&nbsp;Closed Market</a></td>
          <td width="32%" align="right" valign="middle"><strong>Total No. of Forward Markets in Active List:  <c:out value="${fn:length(bidItemsList)}" /> </strong></td>
        </tr>
      </table>
    </form>
  </div>
  
  <div class="DetailDiv">
  <table width="100%" border="0" style = "font:14px bold;" bgcolor="#dce6f2" cellspacing="0" cellpadding="0">
        <tr>
      <td width="100%" height="10px" align="right">&nbsp;
      </td>
      </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Sr No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Sr. No</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Description','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Description</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Lot No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lot No.</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">
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
        </form></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Market Name','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Market Name</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Remark','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Remark</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Length Range','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Length Range</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Actual Range','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Actual Length<br />
        (Approx)</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Quantity','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Quantity</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Zone','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Zone</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Current Market Price','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Current <br />
          Market Price<br />(INR)</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('H1','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">H1</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Time Left','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Time Left</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"> <a href="#" onmouseover="ddrivetip('Reserved Price','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Reserve Price<br />(INR)</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Last Price','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Last Price<br />(INR)</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Time Extension','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Time Extension</a></td>
      </tr>
      <c:forEach items="${bidItemsList}" var="bidItem" varStatus="status">
      <tr  class="table">
        <td height="40" align="center" valign="middle" class="DetailBorRight"><div id="seqId${bidItem.bidItemId}">${bidItem.serialNo}.</div></td>
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
          <td width="131" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Market Name</td>
          <td width="64" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Remark</td>
          <td width="96" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Length Range</td>
          <td width="125" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Actual Length <br/>
            (Approx)</td>
          <td width="87" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Qty</td>
          <td width="87" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Zone</td>
        </tr>
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bidItem.serialNo}. </td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;"><div id="categoryName${bidItem.bidItemId}">
          ${bidItem.category.categoryName}</div></td>
          
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
			<td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">${bidItem.zone}</td>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(bidItem.itemLots) > 1}">
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
         </c:if>
        </tr>
        <c:if test="${fn:length(bidItem.itemLots) > 1}">
        <c:forEach items="${bidItem.itemLots}" var="itemLot" varStatus="status1">
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">${status1.index+1}. </td>
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
         <input type="submit" name="button7" id="desc${status.index+1}" value="Desc" class="description ui-state-default ui-corner-all" /></td>
         <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		     <c:if test="${status2.index+1 == 1}">
        	  <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
        	  </c:if>
          </c:forEach>
        <td align="center" valign="middle" class="DetailBorRight"><div id="categoryName${bidItem.bidItemId}">${bidItem.category.categoryName}</div></td>
        <td align="center" valign="middle" class="DetailBorRight">
         <div id="bidItemName${bidItem.bidItemId}" style="display:none">${bidItem.name}</div>
        <a href="#services" class="LinkSelected" 
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
          <td align="center" valign="middle" style="border-right:1px solid #fff;">&nbsp;</td>
          </c:if>
        <td align="center" valign="middle" class="DetailBorRight"><div id="totalQuantity${bidItem.bidItemId}">
        ${bidItem.totalQuantity} ${bidItem.unit}</div></td>
         <c:if test="${fn:length(bidItem.itemLots) == 1}">
   			 <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
        <td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}
        <input type="hidden" value="${bidItem.bidItemId}" id="bidItemIdinput"/></td>
        </c:forEach>
        </c:if>
         <c:if test="${fn:length(bidItem.itemLots) > 1}">
         	<td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
         </c:if>
        <td align="center" valign="middle" id="currentpricetd" class="DetailBorRight"><div id="Item${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div></td>
        <td align="center" valign="middle" id="firmtd" class="DetailBorRight"><div id="firm${bidItem.bidItemId}"><c:out value="${CurrentBidder}"></c:out></div></td>
        <td align="center" valign="middle" class="DetailBorRight"> <div id="countdown${bidItem.bidItemId}"></div>
        <script>setTimeLefts(parseInt('${bidItem.timeLeft}'), '${bidItem.bidItemId}');</script></td>
        <td align="center" valign="middle" class="DetailBorRight"><div id="Item${bid.bidItem.bidItemId}" style="display:none">${bid.bidItem.minBidPrice}</div> </td>
        <td align="center" valign="middle" class="DetailBorRight"><div id="minBidIncrement${bid.bidItem.bidItemId}" style="display:none">${bid.bidItem.minBidIncrement}</div> </td>
        <td align="center" valign="middle" class="DetailBorRight">
        <input type="text" style="width: 5em" id="extendTime${bidItem.bidItemId}" name="extendTime" />&nbsp;&nbsp;Min<br/>
        <input type="button" name="extension" id="extention${bidItem.bidItemId}" value="Extension" onclick="extension(${bidItem.bidItemId});" class="ui-state-default-time-top ui-corner-all"/>
         </td>
      </tr>
      </c:forEach>
    </table>
  </div>
  <script>
	function extension(bidItemId)
	{
  		var extendTime = document.getElementById('extendTime'+bidItemId).value;
  		if(extendTime == null || extendTime.length == 0) {
  			alert("Enter Extended Time in Minutes");
  			return false;
  		}
  		if(!isNumber(extendTime)) {
  			alert("Enter Valid Numeric Extended Time in Minutes");
  			return false;
  		}
  		var extendTimeInt = parseFloat(extendTime);
  		extendTimeInt *= 60;
  		$.getJSON("extension", { bidItemId:  bidItemId, extendTime: extendTimeInt }, function(data){
  			document.getElementById('extendTime'+bidItemId).value = '';
  		});	
 		return false;
	}  	
	
  </script> 

<script>
function fn()
{
	dwr.engine.setActiveReverseAjax(true);
    dwr.engine.setNotifyServerOnPageUnload(true);
    
    var bidIdObj = document.getElementById('bidItemIdinput');
    if(bidIdObj)
	{
		if(document.getElementById('Item'+bidIdObj.value)) {
    		tempVal = document.getElementById('Item'+bidIdObj.value).innerHTML;    		
		}
	}
}
fn();
var tempVal;
function update()
{
	var bidIdObj = document.getElementById('bidItemIdinput');
	if(bidIdObj)
	{
		var bitItemId = bidIdObj.value;
		if(document.getElementById('Item'+bitItemId)) {
			
			var tempVal1 = document.getElementById('Item'+bitItemId).innerHTML;
			if(tempVal != tempVal1){
				document.getElementById('firmtd').style.background = '#bbd5e6';	
				document.getElementById('currentpricetd').style.background = '#bbd5e6';
				tempVal = tempVal1;
				setTimeout("resetTextColor("+bitItemId+")",3000);
			}			
		}
		
	}
	
}
function resetTextColor(bitItemId)
{
		document.getElementById('firmtd').style.background = '#EAEDF4';	
		document.getElementById('currentpricetd').style.background = '#EAEDF4';
	
}
</script>
<div class="GreenSpacer"></div>
  <%@ include file="/WEB-INF/jsp/observer/observer_footer.jsp" %>
<div class="clr"></div>
</body>
</html>
 --%>