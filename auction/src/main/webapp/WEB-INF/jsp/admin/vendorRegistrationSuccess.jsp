<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin/superAdmin" var="admin_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL E-Auction Vendor Registration Form</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<style>
.input {
	width: 185px;
	height: 20px;
	-moz-border-radius: 4px 4px 4px 4px;
	color: #666666;
	border: 1px solid #4f81bc;
	padding-left: 5px;
	padding-right: 5px;
}

.ui-state-default-active-btn {
	border: 1px solid #cccccc;
	background: #f6f6f6 url(css/images/ui-bg_glass_100_f6f6f6_1x400.png) 50%
		50% repeat-x;
	font-weight: bold;
	color: #1c94c4;
	text-decoration: none;
	font: bold 12px Arial, Helvetica, sans-serif;
	-moz-border-radius: 5px;
	padding: 5px;
}
</style>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />

<script>
	function checkLogin() {

		var firstName = document.getElementById("firstName").value;
		var lastName = document.getElementById("lastName").value;
		var userName = document.getElementById("username").value;
		var Newpass = document.getElementById("password").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		var email = document.getElementById("email").value;

		if (firstName == "") {
			alert("First Name Cannot Be Blank.")
			return false;
		}
		if (lastName == "") {
			alert("Last Name Cannot Be Blank.");
			return false;
		}

		if (email == "") {
			alert("email Cannot Be Blank.");
			return false;
		}

		if (userName == "") {
			alert("User Id Cannot Be Blank!!");
			return false;
		}
		if (Newpass == "" || Cnfpass == "") {
			alert("Passowrd Fields Cannot Be Blank!!");
			return false;
		} else if (Newpass != Cnfpass) {
			alert("Both New Password Should be Identical!!");
			return false;
		} else if (Newpass.length < 6) {
			alert("New Password Should be atleast 6 charater long.!");
			return false;
		} else {
			document.usersForm.submit();
		}
	}
</script>


</head>
<body>

	<div class="Top">
		<div class="Logo">
			<span class="MahaLogo"><img
				src="${images_url}/maharashtra-seamless-ltd.png" width="241"
				height="76"></span>
		</div>
		<div class="Scroll">
			<marquee scrollamount="2" onMouseOver="stop();" onMouseOut="start();">
			In case of any technical difficulties, please contact support at
			+912225970344 </marquee>
		</div>
		<div class="JindalLogo">
			<img src="${images_url}/jindal-logo.png" width="164" height="40">
		</div>
	</div>
	<div class="MenuMain">
		<div class="WelcomeUser">
			Welcome
			<security:authentication property="principal.username" />
			&nbsp;| &nbsp; <a href="<c:url value="/j_logout"/>" class="logout">Logout</a>
		</div>
	</div>


	<div style="font: 14px calibri; color: #4f81bc; align: middle;">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="36%" align="center" valign="middle">Vendor
					Registered Successfully.</td>
			</tr>
		</table>
	</div>


	<a href="${admin_url}">Back to Super Admin Page</a>


</body>
</html>
</div>