<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin/superAdmin" var="admin_home_url" />
<spring:url value="/static/pdf" var="pdf_url" />
<spring:url value="/admin/userauctionmap" var="user_auction_map_url" />
<spring:url value="/admin/registrationPage" var="userRegistration_url" />
<spring:url value="/admin/vendorRegistrationPage"
	var="vendorRegistration_url" />
<spring:url value="/admin/resetPasswordPage" var="passwordReset_url" />
<spring:url value="/admin/FileUpload" var="fileupload_url" />
<spring:url value="/admin/CreateAuction" var="createauction_url" />
<spring:url value="/" var="home_url" />
<link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${css_url}/custom.css" rel="stylesheet">
<link type="text/css" rel="stylesheet"
	href="${css_url}/dhtmlgoodies_calendar.css?random=20051112"
	media="screen"></link>
<script type="text/javascript"
	src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
	<script src="${js_url}/jquery-1.10.2.min.js"></script>
<div class="container">
	<div class="col-xs-12 col-sm-3 hdr-lft">
		<div class="hdr-lft-in">
			<img src="${images_url}/maharashtra-seamless-ltd.png">
		</div>
	</div>
	<div class="col-xs-12 col-sm-6 hdr-mdl">
		<div class="hdr-mdl-in">
			<marquee scrollamount="2" onmouseover="stop();" onmouseout="start();">
				In case of any technical difficulties, please contact support at
				+912225970344 </marquee>
		</div>
	</div>
	<div class="col-xs-12 col-sm-3 hdr-rgt">
		<div class="hdr-rgt-in text-right">
			<img src="${images_url}/jindal-logo.png">
		</div>
	</div>
</div>
<div class="strip-bar">
	<div class="container">
		<nav class="navbar">
			<div class="navbar-header">
				<button aria-controls="navbar" aria-expanded="false"
					data-target="#navbar" data-toggle="collapse"
					class="navbar-toggle collapsed" type="button">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
			</div>
			<div class="navbar-collapse collapse" id="navbar">
				<ul class="nav navbar-nav auction-menu">


					<li class="active"><a href="${admin_home_url}">Auction
							Management</a></li>
					<li><a href="${user_auction_map_url}">User Auction Map</a></li>

					<li><a href="${vendorRegistration_url}">Create Vendor</a></li>
					<li><a href="${userRegistration_url}">Create User</a></li>
					<li><a href="${passwordReset_url}">Reset Password</a></li>
					<li><a href="${home_url}changepass">Change Password</a></li>
					<li><a href="${createauction_url}">Create Auction</a></li>
					<li><a href="${fileupload_url}">File Upload</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
			<div class="welcom">
				<ul class="list-inline">
					<li>Welcome <security:authentication
							property="principal.username" /></li>
					<li><a href="<c:url value="/j_logout"/>">Logout</a></li>
				</ul>
			</div>
		</nav>
	</div>
</div>
