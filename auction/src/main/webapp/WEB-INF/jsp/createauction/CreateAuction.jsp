
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/" var="static_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin/superAdmin" var="admin_url" />
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" rel="stylesheet"
	href="${css_url}/dhtmlgoodies_calendar.css?random=20051112"
	media="screen"></link>
<script type="text/javascript"
	src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
	<%-- <link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet"> --%>
<section class="main">


	<div class="container">



		<div class="form-container form-container-cr">

			<h1>
				<i class="fa fa-user"></i> E-Create Auction
			</h1>
			<form role="form" id="createAuction" name="createAuction"
				method="post" action="createAuction" modelAttribute="firmDetails">

				<c:if test="${not empty auctionDetails.auctionId}">

					<input type="hidden" name="auctionId" id="auctionId"
						value="${auctionDetails.auctionId}" />


				</c:if>


				<div class="form-group">
					<label for="exampleAuctionName">Auction Name</label> <input
						type="text" class="form-control" name="name" id="name"
						value="${auctionDetails.name}" placeholder="Auction Name">
				</div>
				<div class="form-group">
					<label for="exampleInputstatus">Status</label> <select
						name="status" id="status" class="form-control">
						<option
							<c:if test="${auctionDetails.status=='0'}">selected='selected'</c:if>
							value="0">select</option>
						<option
							<c:if test="${auctionDetails.status=='Start'}">selected='selected'</c:if>
							value="Start">Start</option>
						<option
							<c:if test="${auctionDetails.status=='Running'}">selected='selected'</c:if>
							value="Running">Running</option>
					</select>
				</div>
				<div class="form-group">
					<label for="exampleIsapproved">Is Approved</label> <select
						name="isApproved" id="isApproved" class="form-control">
						<option
							<c:if test="${auctionDetails.isApproved=='-1'}">selected='selected'</c:if>
							value="-1">select</option>
						<option
							<c:if test="${auctionDetails.isApproved=='1'}">selected='selected'</c:if>
							value="1">Yes</option>
						<option
							<c:if test="${auctionDetails.isApproved=='0'}">selected='selected'</c:if>
							value="0">No</option>
					</select>
				</div>
				<div class="form-group">
					<label for="exampleCreatedTime">Created Time</label> <input
						type="text" class="form-control" name="createdTimeFormat"
						id="createdTimeFormat" readonly
						onclick="displayCalendar(document.createAuction.createdTimeFormat,'yyyy/mm/dd',this)"
						value="${auctionDetails.createdTime}" placeholder="Created Time">
				</div>
				<div class="form-group form-submit">
					<label style="color: red"><c:if test="${not empty messages}"></c:if> <c:out
							value="${messages}"></c:out> </label>
					<button class="btn btn-primary pull-right" type="submit"
						name="button" id="button" value="Submit"
						onclick="javascript:checkAuction();">Create Auction</button>
					<div class="clearfix"></div>
				</div>
			</form>
		</div>
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
				<c:if test="${not empty auctionlist}">


					<div class="table-responsive user-map">
						<table class="table table-bordered table-striped text-center">
							<tr>
	<th>Sr. No.</th>
								<th>Auction Name</th>
								<th>Auction Status</th>
								<th>Auction Approved</th>
								<th>Modify Auction</th>
							</tr>
							<c:forEach items="${auctionlist}" var="auction"
								varStatus="status">
								<tr>
									<td>${status.index+1}</td>
									<td>${auction.name}</td>
									<td>${auction.status}</td>
									<td><c:choose>

											<c:when test="${auction.isApproved==1}">
					Appoved
					</c:when>
											<c:otherwise>
					Not Approved
					</c:otherwise>
										</c:choose></td>
									<td><a href="editauction?auctionId=${auction.auctionId}">Modify
									</a></td>
								</tr>
							</c:forEach>
						</table>



					</div>


				</c:if>
			</div>
		</div>





	</div>
	<!-- /container -->
</section>

<script>
	function checkAuction() {

		var Name = document.getElementById("name").value;
		var CreatedTimeFormat = document.getElementById("createdTimeFormat").value;
		var Status = document.getElementById("status").value;
		var IsApproved = document.getElementById("isApproved").value;

		if (Name == "") {
			alert(" Name Cannot Be Blank.");
			return false;
		}

		if (Status == 0) {
			alert(" Select Status.");
			return false;
		}
		if (IsApproved == -1) {
			alert(" Select IsApproved.");
			return false;
		}
		if (CreatedTimeFormat == "") {
			alert("Created Time Cannot Be Blank.");
			return false;
		}
		document.createAuction.submit();

	}
</script>


<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/" var="static_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin/superAdmin" var="admin_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL E-Auction Vendor Registration Form</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" rel="stylesheet"
	href="${css_url}/dhtmlgoodies_calendar.css?random=20051112"
	media="screen"></link>
<script type="text/javascript"
	src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/admin/superadmin_top.jsp"%>
	<script type="text/javascript">
		pathToImages = "${static_url}" + pathToImages;
	</script>
	<div class="Mian">
		<form id="createAuction" name="createAuction" method="post"
			action="createAuction" modelAttribute="firmDetails">
			<table width="100%" border="0" cellspacing="0" cellpadding="0"
				align="center">

				<tr>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="center"><b>E-Create
							Auction</b><br /></td>
					<td valign="middle"></td>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="right"><b><c:out
								value="${messages }"></c:out></b><br /></td>
					<td valign="middle"></td>
				</tr>
				<c:if test="${not empty auctionDetails.auctionId}">
					<tr>
						<td width="266" height="30" align="center"
							style="font: 14px calibri; color: #4f81bc;" align="left"></td>
						<td width="150" align="left"><input type="hidden"
							name="auctionId" id="auctionId"
							value="${auctionDetails.auctionId}" /></td>

					</tr>
				</c:if>

				<tr>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="left">Auction
						Name :</td>
					<td width="150" align="left"><input type="text" name="name"
						id="name"  value="${auctionDetails.name}" /></td>

				</tr>
				<tr>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="left">Status</td>
					<td width="150" align="left"><select name="status" id="status">
							<option
								<c:if test="${auctionDetails.status=='0'}">selected='selected'</c:if>
								value="0">select</option>
							<option
								<c:if test="${auctionDetails.status=='Start'}">selected='selected'</c:if>
								value="Start">Start</option>
							<option
								<c:if test="${auctionDetails.status=='Running'}">selected='selected'</c:if>
								value="Running">Running</option>
					</select></td>
				</tr>
				<tr>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="left">Is
						Approved</td>
					<td width="150" align="left"><select name="isApproved"
						id="isApproved">
							<option
								<c:if test="${auctionDetails.isApproved=='-1'}">selected='selected'</c:if>
								value="-1">select</option>
							<option
								<c:if test="${auctionDetails.isApproved=='1'}">selected='selected'</c:if>
								value="1">Yes</option>
							<option
								<c:if test="${auctionDetails.isApproved=='0'}">selected='selected'</c:if>
								value="0">No</option>
					</select></td>
				</tr>



				<tr>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="left">Created
						Time</td>
					<td width="150" align="left"><input type="text"
						name="createdTimeFormat" id="createdTimeFormat" readonly
						onclick="displayCalendar(document.createAuction.createdTimeFormat,'yyyy/mm/dd',this)"
						value="${auctionDetails.createdTime}" /></td>
				</tr>

				<tr>
					<td height="30">&nbsp;</td>
					<td valign="middle"><input type="button" name="button"
						id="button" value="Submit" onclick="javascript:checkAuction();"
						onclass="ui-corner-all" /></td>
				</tr>
			</table>
		</form>

		<table width="100%" border="1" cellspacing="0" cellpadding="0">
			<c:if test="${not empty auctionlist}">
				<tr>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="center"><b>Auction
							Id</b><br /></td>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="center"><b>Auction
							Name</b><br /></td>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="center"><b>Auction
							Status</b><br /></td>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="center"><b>Auction
							Is Approved</b><br /></td>
					<td width="266" height="30" align="center"
						style="font: 14px calibri; color: #4f81bc;" align="center"><b>Modify
							Auction</b><br /></td>

				</tr>


				<c:forEach var="auction" items="${auctionlist}" varStatus="status">
					<tr>

						<td width="266" height="30" align="center"
							style="font: 12px calibri;" align="center"><b>${status.index+1}</b><br /></td>
						<td width="266" height="30" align="center"
							style="font: 12px calibri;" align="center"><b>${auction.name}</b><br /></td>

						<td width="266" height="30" align="center"
							style="font: 12px calibri;" align="center"><b>${auction.status}</b><br /></td>

						<td width="266" height="30" align="center"
							style="font: 12px calibri;" align="center"><b> <c:choose>

									<c:when test="${auction.isApproved==1}">
					Appoved
					</c:when>
									<c:otherwise>
					Not Approved
					</c:otherwise>
								</c:choose>
						</b><br /></td>
						<td width="266" height="30" align="center"
							style="font: 12px calibri;" align="center"><b><a
								href="editauction?auctionId=${auction.auctionId}">Modify </a></b><br /></td>


					</tr>
				</c:forEach>
			</c:if>
		</table>







	</div>
	<br />
	<div class="Footer">&copy; Copyright 2011 Navprayas</div>
	<div class="clr"></div>
	<script>
		function checkAuction() {

			var Name = document.getElementById("name").value;
			var CreatedTimeFormat = document
					.getElementById("createdTimeFormat").value;
			var Status = document.getElementById("status").value;
			var IsApproved = document.getElementById("isApproved").value;

			if (Name == "") {
				alert(" Name Cannot Be Blank.")
				return false;
			}

			if (Status == 0) {
				alert(" Select Status.")
				return false;
			}
			if (IsApproved == -1) {
				alert(" Select IsApproved.")
				return false;
			}
			if (CreatedTimeFormat == "") {
				alert("Created Time Cannot Be Blank.")
				return false;
			}
			document.createAuction.submit();

		}
	</script>
</body>
</html> --%>