<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/admin/initcache" var="admin_initcache_url" />
<spring:url value="admin/closeAuction" var="close_auction_url" />
<body>
	<!-- { middle } -->
	<section class="main">
		<div class="container">
			<div class="table-container">
				<div class="top-line">
					<div class="col-xs-12 col-sm-6">
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a
								aria-controls="home" role="tab" data-toggle="tab"
								href="#summary">Auctions</a></li>
							<!-- <li><a aria-controls="home" role="tab" data-toggle="tab"
								href="#bidder">Bidder Wise</a></li> -->
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
									<th>Auction Id</th>
									<th>Auction Name</th>
									<th>Status</th>
									<th>Auction Start Time</th>
									<th>Auction End Time</th>
									<th>Action</th>
								</tr>
								<c:forEach items="${AuctionList}" var="auction"
									varStatus="status">
									<tr>
										<td>${status.index+1}</td>
										<td>${auction.auctionId}</td>
										<td>${auction.name}</td>
										<td>${auction.status}</td>
										<td>${auction.auctionStartTime}</td>
										<td>${auction.auctionEndTime}</td>
										<td><c:if test="${auction.status == 'Start'}">
												<c:if test="${aunctionRunningOrClosedPresent == 0}">
													<a
														href="${admin_initcache_url}?auctionId=${auction.auctionId}">Start</a>
												</c:if>
												<c:if test="${aunctionRunningOrClosedPresent == 1}">
     					Close Running or Ended Auction First
     				</c:if>
											</c:if> <c:if test="${auction.status == 'End'}">
												<a
													href="${close_auction_url}?auctionId=${auction.auctionId}">Close</a>
											</c:if> <c:if test="${auction.status == 'Running'}">
												<a
													href="${close_auction_url}?auctionId=${auction.auctionId}">Close</a>
											</c:if></td>
									</tr>


								</c:forEach>


							</table>
						</div>
					</div>
					<!-- <div role="tabpanel" class="tab-pane" id="bidder">
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
						<div class="table-responsive user-map">
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
						</div>
					</div> -->
				</div>
			</div>
		</div>
		<!-- /container -->
	</section>


</body>
<script>
	function initializeAuction(time) {
		var auctionId = document.getElementById("auctionId").value;
		var location1 = "${admin_initcache_url}?auctionId=" + auctionId
				+ "&auctionTimeExt=" + time;
		window.location.href = location1;
	}
</script>




<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*,java.text.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/admin/initcache" var="admin_initcache_url" />
<spring:url value="admin/closeAuction" var="close_auction_url"/>

<html>
<script type="text/javascript">
function initializeAuction(time){
	var auctionId = document.getElementById("auctionId").value;
	var location1 = "${admin_initcache_url}?auctionId="+auctionId+"&auctionTimeExt="+time;
	window.location.href=location1;
}
</script>
<head>
<title>MSL Auction - Initialize the Cache</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
</head>
<body>

<%@ include file="/WEB-INF/jsp/admin/superadmin_top.jsp"%>


<br/>
<div class="Mian">
  <h2>Auction Management</h2>
  <% if(request.getParameter("Message") != null && !((String)request.getParameter("Message")).equalsIgnoreCase("") && !((String)request.getParameter("Message")).equalsIgnoreCase("null")) {
  		out.println("<font size='5px' color=blue>" + request.getParameter("Message")+ "</font>");
  	}
  %>
  <div class="DetailDiv">
  <table width="100%" border="0" style = "font:14px bold;" bgcolor="#dce6f2" cellspacing="0" cellpadding="0">
     <tr>
          <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Sr. No.</td>
          <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Auction Id</td>
          <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Auction Name</td>
          <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Status</td>
          <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Auction Start Time</td>
          <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Auction End Time</td>
          <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Action</td>
     </tr>
     <c:forEach items="${AuctionList}" var="auction" varStatus="status">
 		<tr class="table">
     		<td align="center" valign="middle" bgcolor="#f7c794" style="border:1px solid #fff;">
     			${status.index+1}
      		</td>
      		<td align="center" valign="middle" bgcolor="#f7c794" style="border:1px solid #fff;">
     			${auction.auctionId}
      		</td>
      		<td align="center" valign="middle" bgcolor="#f7c794" style="border:1px solid #fff;">
     			${auction.name}
      		</td>
      		<td align="center" valign="middle" bgcolor="#f7c794" style="border:1px solid #fff;">
     			${auction.status}
      		</td>
      		<td align="center" valign="middle" bgcolor="#f7c794" style="border:1px solid #fff;">
     			${auction.auctionStartTime}
      		</td>
      		<td align="center" valign="middle" bgcolor="#f7c794" style="border:1px solid #fff;">
     			${auction.auctionEndTime}
      		</td>
      		<td align="center" valign="middle" bgcolor="#f7c794" style="border:1px solid #fff;">
      			<c:if test="${auction.status == 'Start'}" >
      			    <c:if test="${aunctionRunningOrClosedPresent == 0}">
     					<a href="${admin_initcache_url}?auctionId=${auction.auctionId}">Start</a>
     				</c:if>
     				<c:if test="${aunctionRunningOrClosedPresent == 1}">
     					Close Running or Ended Auction First
     				</c:if>
     			</c:if>
     			<c:if test="${auction.status == 'End'}" >
     				<a href="${close_auction_url}?auctionId=${auction.auctionId}">Close</a>
     			</c:if>
     			<c:if test="${auction.status == 'Running'}" >
     				<a href="${close_auction_url}?auctionId=${auction.auctionId}">Close</a>
     			</c:if>
      		</td>
      	</tr>
  	</c:forEach>
  </table>
  </div>
  </div>
	<br/>
 <div class="clr"></div>
<div class="Footer" style="margin-top:380px">&copy; Copyright 2011 Navprayas</div>
   
   
</body>
</html> --%>