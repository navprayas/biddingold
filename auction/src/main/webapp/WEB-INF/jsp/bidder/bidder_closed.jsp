<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/bidder/closed/" var="Paginationform_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<spring:url value="/bidder/active" var="bidder_active_url" />
<spring:url value="/bidder/marketlist" var="bidder_market_url" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<%-- <link href="${css_url}/style.css" rel="stylesheet" media="screen" /> --%>
<%-- <script type="text/javascript" src="${js_url}/tooltip.js"></script> --%>
<%-- <link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" /> --%>
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<%-- <script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script> --%>

<script type="text/javascript">

function getResultForCategory()
{
	document.forms["categoryform"].submit();
}

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
</script>

<script type="text/javascript">
			$(function(){
				// Dialog			
				$('.dialog').dialog({
					autoOpen: false,
					width:'auto',
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
					$('.dialog').dialog('open');
					return false;
				});
				
				$('.changeamot').click(function(){
				
					$('.amt').dialog('open');
					return false;
				});
				$('.description').click(function(){
				
					//$('.desc').dialog('open');
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
}
</script>

</head>

<body>
	<div class="container">
		<div id="dhtmltooltip"></div>

		<div class="mark-check1 mktlstcl">
			<form id="form1" name="form1" method="post" action=""
				style="margin: 0px;">
				<table class="table table-bordered table-striped text-center">
					<tr>
						<td colspan="3"><input type="radio" name="radio" id="radio"
							value="1" onclick="getPageForMarketType(this.value)" /> <a
							href="${bidder_market_url}"  class="subTitleLink">&nbsp;Market
								List</a></td>
						<td colspan="3"><input type="radio" name="radio" id="radio2"
							value="2" onclick="getPageForMarketType(this.value)" /> <a
							href="${bidder_active_url}"  class="subTitleLink">&nbsp;Active
								Market</a></td>
						<td colspan="3"><input type="radio" checked name="radio"
							id="radio3" value="3" /><a href="#"
							 class="subTitleLink">&nbsp;Closed
								Market</a></td>
						<td colspan="7" align="right"><strong>Total No. of
								Forward Markets in Active List: <c:out
									value="${fn:length(bidItemsList)}" />
						</strong></td>
					</tr>
				</table>
			</form>
		</div>
		<form:form action="${Paginationform_url}" name="paginationForm">
			<input type="hidden" name="page"
				value="<c:out value='${navigationInfo.currentPage}' />" />
			<input type="hidden" name="category" value="0" />
		</form:form>

		<div class="table-responsive user-map nofound itemlist">
			<table class="table table-bordered table-striped text-center">
				<tr>
					<td><display:table name="navigationInfo"
							requestURI="${Paginationform_url}" excludedParams="*"
							cellspacing="0px" cellpadding="0px 0px 0px 0px">
							<display:setProperty name="paging.banner.onepage" value="<br/>"></display:setProperty>
							<display:setProperty name="basic.msg.empty_list" value=""></display:setProperty>
							<display:setProperty name="basic.msg.empty_list_row" value=""></display:setProperty>
							<display:setProperty name="paging.banner.first">
								<table lass="table table-bordered table-striped text-center">
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
								<table class="table table-bordered table-striped text-center">
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
								<table class="table table-bordered table-striped text-center">
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
					<td><a href="#" 
						>Sr. No</a><a href="#"></a></td>
					<td><a href="#">Description</a></td>
					<td><a href="#">Lot No.</a></td>
					<td>
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
					<td><a href="#"
						>Material Name</a></td>
					<td><a href="#" >Remark</a></td>
					<td><a href="#">Length Range</a></td>
					<td><a href="#">Actual Length<br /> (Approx)
					</a></td>
					<td><a href="#">Quantity</a></td>
					<td><a href="#">Zone</a></td>
					<td><a href="#">Closed Date &amp; Time</a></td>
					<td><a href="#">Last Bidded Amount<br />(INR)
					</a></td>
					<td><a href="#" >Status</a></td>
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


							<div class="modal fade" tabindex="-1" role="dialog"
								aria-labelledby="myModalLabel" id="dialog_desc${status.index+1}">
								<div class="modal-dialog" role="document"
									id="desc${status.index+1}">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="dialog_desc${status.index+1}">Description</h4>
										</div>
										<div class="modal-body">



											<table class="table table-bordered table-striped text-center">
												<tr>
													<td align="left" valign="top"><form name="form1"
															method="post" action="" style="margin: 0px;">
															<table
																class="table table-bordered table-striped text-center">
																<tr></tr>
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
																			<td>${bidItem.category.categoryName}</td>
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
											<div id="bidStartTime${bidItem.bidItemId}">${bidItem.bidStartTime}</div>
											<div id="minBidIncrement${bidItem.bidItemId}"
												style="display: none">${bidItem.minBidIncrement}</div>
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
								<td>${itemLotUnique.lotNo}</td>
							</c:if>
						</c:forEach>
						<td>${bidItem.category.categoryName}</td>
						<td>
							<div id="bidItemName${bidItem.bidItemId}">${bidItem.name}</div> <a
							href="#services" class="LinkSelected"
							onclick="javascript:setIdForBiddingHistory(${bidItem.bidItemId});">${bidItem.name}</a>
						</td>
						<c:if test="${fn:length(bidItem.itemLots) == 1}">
							<c:forEach items="${bidItem.itemLots}" var="itemLotUnique"
								varStatus="status2">
								<td>${itemLotUnique.remark}</td>
								<td>${itemLotUnique.lengthRange}'</td>
								<td>${itemLotUnique.actualLengh}</td>
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
								<td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}</td>
							</c:forEach>
						</c:if>
						<c:if test="${fn:length(bidItem.itemLots) > 1}">
							<td>&nbsp;</td>
						</c:if>
						<td><div id="endtimeMain${bidItem.bidItemId}">${bidItem.bidEndTime}</div></td>
						<td><div id="currentMarketPrice${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div></td>
						<td>${bidItem.status}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<div class="clr"></div>
	<!-- </div> -->

	<%-- <%@ include file="/WEB-INF/jsp/bidder/bidder_footer.jsp" %> --%>

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

</script>

</body>
</html>




<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/bidder/closed/" var="Paginationform_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<spring:url value="/bidder/active" var="bidder_active_url" />
<spring:url value="/bidder/marketlist" var="bidder_market_url" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css" rel="stylesheet" />	
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript" src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>
		
<script type="text/javascript">

function getResultForCategory()
{
	document.forms["categoryform"].submit();
}

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
</script>

<script type="text/javascript">
			$(function(){
				// Dialog			
				$('.dialog').dialog({
					autoOpen: false,
					width:'auto',
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
					$('.dialog').dialog('open');
					return false;
				});
				
				$('.changeamot').click(function(){
				
					$('.amt').dialog('open');
					return false;
				});
				$('.description').click(function(){
				
					//$('.desc').dialog('open');
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
}
</script>
	
</head>

<body>
<%@ include file="/WEB-INF/jsp/bidder/bidder_top.jsp" %>
<div class="Mian"><div id="dhtmltooltip"></div>

<div class="CheckBoxMenu">
    <form id="form1" name="form1" method="post" action="" style="margin:0px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="1%" height="29" align="left" valign="middle"><input type="radio" name="radio" id="radio" value="1" class="checkbox" onclick="getPageForMarketType(this.value)"/></td>
          <td width="6%" align="left" valign="middle"><a href="${bidder_market_url}" onmouseover="ddrivetip('Market List','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink" >&nbsp;Market List</a></td>
          <td width="1%" align="left" valign="middle"><input type="radio" name="radio" id="radio2" value="2" class="checkbox" onclick="getPageForMarketType(this.value)"/></td>
          <td width="7%" align="left" valign="middle"><a href="${bidder_active_url}" onmouseover="ddrivetip('Active Market','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink">&nbsp;Active Market</a></td>
          <td width="1%" align="left" valign="middle"><input type="radio" checked  name="radio" id="radio3" value="3" class="checkbox"/></td>
          <td width="49%" align="left" valign="middle"><a href="#" onmouseover="ddrivetip('Closed Market','', 'auto')";
onmouseout="hideddrivetip()" class="subTitleLink">&nbsp;Closed Market</a></td>
          <td width="32%" align="right" valign="middle"><strong>Total No. of Forward Markets in Active List: <c:out value="${fn:length(bidItemsList)}" /></strong></td>
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
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="4%" height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Select','', 'auto')" onMouseout="hideddrivetip()" class="TitleLink">Select</a></td>
        <td height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Sr No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Sr. No</a><a href="#"></a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Description','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Description</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Lot No','', 'auto')";
onmouseout="hideddrivetip()" class="TitleLink">Lot No.</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">
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
        </select>   </form>     </td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="Material Name('Select','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Material Name</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Remark','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Remark</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Length Range','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Length Range</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Actual Length','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Actual Length<br />
(Approx)</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Quantity','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Quantity</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Zone','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Zone</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Close Date & time','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Closed Date &amp; Time</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Last Bidd Amount','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Last Bidded Amount<br />(INR)</a></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><a href="#" onmouseover="ddrivetip('Status','', 'auto')" onmouseout="hideddrivetip()" class="TitleLink">Status</a></td>
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
    <td align="left" valign="top"><form name="form1" method="post" action="" style="margin:0px;">
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
    <div id="bidStartTime${bidItem.bidItemId}" style="display:none">${bidItem.bidStartTime}</div>
<div id="minBidIncrement${bidItem.bidItemId}" style="display:none">${bidItem.minBidIncrement}</div>	
        <input type="submit" name="button3" id="desc${status.index+1}" value="Desc" class="description ui-state-default ui-corner-all" /></td>
        
         <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
		     <c:if test="${status2.index+1 == 1}">
        	  <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lotNo}</td>
        	  </c:if>
          </c:forEach>
        <td align="center" valign="middle" class="DetailBorRight">${bidItem.category.categoryName}</td>
        <td align="center" valign="middle" class="DetailBorRight">
        <div id="bidItemName${bidItem.bidItemId}" style="display:none">${bidItem.name}</div>
        <a href="#services" class="LinkSelected" onclick="javascript:setIdForBiddingHistory(${bidItem.bidItemId});">${bidItem.name}</a></td>
        <c:if test="${fn:length(bidItem.itemLots) == 1}">
           <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.remark}</td>
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.lengthRange}'</td>
        <td align="center" valign="middle" class="DetailBorRight">${itemLotUnique.actualLengh}</td>
        </c:forEach>
        </c:if>
         <c:if test="${fn:length(bidItem.itemLots) > 1}">
          <td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
          </c:if>
        <td align="center" valign="middle" class="DetailBorRight"><div id="totalQuantity${bidItem.bidItemId}">
        ${bidItem.totalQuantity} ${bidItem.unit}</div></td>
         <c:if test="${fn:length(bidItem.itemLots) == 1}">
           <c:forEach items="${bidItem.itemLots}" var="itemLotUnique" varStatus="status2">
           	  <td align="center" valign="middle" class="DetailBorRight">${bidItem.zone}</td>
            </c:forEach>
        </c:if>
         <c:if test="${fn:length(bidItem.itemLots) > 1}">
         	 <td align="center" valign="middle"  style="border-right:1px solid #fff;">&nbsp;</td>
         	 </c:if>
        <td align="center" valign="middle" class="DetailBorRight"><div id="endtimeMain${bidItem.bidItemId}">${bidItem.bidEndTime}</div></td>
        <td align="center" valign="middle" class="DetailBorRight"><div id="currentMarketPrice${bidItem.bidItemId}">${bidItem.currentMarketPrice}</div></td>
        <td align="center" valign="middle" class="DetailBorRight">${bidItem.status}</td>
      </tr></c:forEach>
    </table>
  </div>
  <div class="GreenSpacer"></div>
  <!--bidder_footer.html-->
  <!--bidder_footer.html Ends-->
</div>
<div class="clr"></div>
</div>

<%@ include file="/WEB-INF/jsp/bidder/bidder_footer.jsp" %>

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

</script>

</body>
</html>
 --%>