<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='sec' uri='http://www.springframework.org/security/tags' %>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>MSL Auction - Forgot Password</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<style>
.MainLoginBox {
	width:434px;
	height:178px;
	float:left;
	-moz-border-radius:4px 4px 4px 4px;
	border:1px solid #4f81bc;
	position:absolute;
	top:30%;
	left:38%;
}
.LoginTitle {
	width:416px;
	height:28px;
	background:#4f81bc;
	color:#fff;
	padding-top:5px;
	font:bold 15px calibri;
	padding-left:10px;
	
}
.LoginInner {
	width:416px;
	height:140px;
	float:left;
	padding:10px;
	font:14px calibri;
	color:#4f81bc;
	-moz-border-radius:4px 4px 4px 4px;
}
.input {
	width:185px;
	height:20px;
	-moz-border-radius:4px 4px 4px 4px;
	color:#666666;
	border:1px solid #4f81bc;
	padding-left:5px;
	padding-right:5px;
}
.ui-state-default-active-btn { border: 1px solid #cccccc; background: #f6f6f6 url(css/images/ui-bg_glass_100_f6f6f6_1x400.png) 50% 50% repeat-x; font-weight: bold; color: #1c94c4;  text-decoration:none; font:bold 12px Arial, Helvetica, sans-serif ; -moz-border-radius:5px; padding:5px;  }
</style>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
</head>
<body>

<div class="Top">
  <div class="Logo"><span class="MahaLogo"><img src="${images_url}/maharashtra-seamless-ltd.png" width="241" height="76"></span></div>
  <div class="Scroll">
  	<marquee scrollamount="2" onMouseOver="stop();" onMouseOut="start();">
  		In case of any technical difficulties, please contact support at +912225970344
    </marquee>
  </div>
        <div class="JindalLogo"><img src="${images_url}/jindal-logo.png" width="164" height="40"></div>
</div>
<div class="MenuMain"> 
   
  </div>
	
		<div class="MainLoginBox"> 
		<div class="LoginTitle">Forgot Password </div>
		   <c:if test="${not empty param.ChangePassMessage}">
        <table width="316">
        <tr>
		<td colspan="2" style="font:16px calibri; color:red;">
			<font color="red">
				<c:out value="${ChangePassMessage}"/>.
			</font>
        </td>
        </tr>
        </table>
        </c:if>
		
		</br>
   <form id="forgotPasswordForm" name="forgotPasswordForm" method="post" action="forgotPasswordSendMail" style="margin:0px;">
      <table width="416" border="0" cellspacing="0" cellpadding="0">

        <tr>
		<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">User Id:</td>
          <td width="210"><input type="text" name="userId" id="userId" class="inputField" /></td>
        </tr>
		<tr>
		<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">Password Question: Favourite Movie</td>
          <td width="150"><input type="text" name="secretAnswer" id="secretAnswer" class="inputField" /></td>
        </tr>
        <tr>
          <td height="30">&nbsp;</td>
          <td valign="middle"><input type="submit" name="button" id="button" value="Submit" class="ui-corner-all" /></td>
        </tr>
        <tr>
        	<td height="30">&nbsp;</td>
			<td style="font:16px calibri;" valign="middle">
				<a href="/bidding/login.jsp">Back to Login Page</a>
					</td>
        </tr>
        </table>
    </form></div>
      
      </body>
      </html>
  </div>