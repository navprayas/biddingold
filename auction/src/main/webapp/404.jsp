<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.springframework.security.core.AuthenticationException" %> 
<%@ page import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter" %>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction - Exception</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<style>
.MainLoginBox {
	width:336px;
	height:183px;
	float:left;
	-moz-border-radius:4px 4px 4px 4px;
	border:1px solid #4f81bc;
	position:absolute;
	top:30%;
	left:38%;
}
.LoginTitle {
	width:326px;
	height:28px;
	background:#4f81bc;
	color:#fff;
	padding-top:5px;
	font:bold 15px calibri;
	padding-left:10px;
	
}
.LoginInner {
	width:316px;
	height:130px;
	float:left;
	padding:10px;
	font:14px calibri;
	color:#4f81bc;
	-moz-border-radius:4px 4px 4px 4px;
}
.input {
	width:155px;
	height:20px;
	-moz-border-radius:4px 4px 4px 4px;
	color:#666666;
	border:1px solid #4f81bc;
	padding-left:5px;
	padding-right:5px;
}
.ui-state-default-active-btn { border: 1px solid #cccccc; background: #f6f6f6 url(css/images/ui-bg_glass_100_f6f6f6_1x400.png) 50% 50% repeat-x; font-weight: bold; color: #1c94c4;  text-decoration:none; font:bold 12px Arial, Helvetica, sans-serif ; -moz-border-radius:5px; padding:5px;  }
</style>
</head>

<body>
<div class="Top">
  <div class="Logo"><span class="MahaLogo"><img src="${images_url}/maharashtra-seamless-ltd.png" width="241" height="76"></span></div>
    <div class="Scroll">
  	<marquee scrollamount="2" onMouseOver="stop();" onMouseOut="start();">
  		In case of any technical difficulties, please contact support at  +912225970344
    </marquee>
  </div>
  <div class="JindalLogo"><img src="${images_url}/jindal-logo.png" width="164" height="40"></div>
</div>
<div class="MenuMain"> 
   
  </div>
<div class="MainLoginBox">
  <div class="LoginTitle">&nbsp;Requested Resource Not Found</div>
    
	<div class="LoginInner">
		<c:if test="${error}">
	Message: <br /><font color=red><%=request.getAttribute("error")%> </font><br />
	</c:if>
	<h3>Please contact support/Administrator at ++912225970344</h3>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="Back" onclick="javascript:history.back()"/>
	</div>
</div>
</body>
</html>
