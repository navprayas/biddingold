
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='sec' uri='http://www.springframework.org/security/tags' %>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/static/pdf" var="pdf_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>MSL Auction - Change Password</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="${js_url}/tooltip.js"></script>
<style>
.MainLoginBox {
	width:324px;
	height:178px;
	float:left;
	-moz-border-radius:4px 4px 4px 4px;
	border:1px solid #4f81bc;
	position:absolute;
	top:30%;
	left:38%;
}
.LoginTitle {
	width:316px;
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

<script>

function checkPassword()
{
	var Oldpass = document.getElementById("Oldpass").value;
	var Newpass = document.getElementById("Newpass").value;
	var Cnfpass = document.getElementById("Cnfpass").value;
    if(Oldpass=="" || Newpass=="" || Cnfpass=="" )
    	{
		alert("Fields Cannot Be Blank!!")
		return false;
    	}
 	else if(Newpass != Cnfpass)
 		{
		alert("Both New Password Should be Identical!!")
		return false;
	}
 	else if(Newpass.length < 4)
		{
		alert("New Password Should be atleast 4 charater long.!")
		return false;
	}
	else{
	//document.ChangePasswordForm.action = 'changepassword'; 
		document.ChangePasswordForm.submit();   
		//return true;
	}
 }
</script>

<div class="Top">
  <div class="Logo"><span class="MahaLogo"><img src="${images_url}/maharashtra-seamless-ltd.png" width="241" height="76"></span></div>
  <div class="Scroll">
  	<marquee scrollamount="2" onMouseOver="stop();" onMouseOut="start();">
  		In case of any technical difficulties, please contact support at  +912225970344
    </marquee>
  </div>
  <div class="JindalLogo"><img src="${images_url}/jindal-logo.png" width="164" height="40"></div>
</div><div class="MenuMain">
      <div class="MenuBtn"><a href="${pdf_url}/termandcondition.pdf" target="_blank" onMouseover="ddrivetip('General Terms &amp; Condition','', 'auto')";
onMouseout="hideddrivetip()">General Terms &amp; Condition</a></div>      

      <div class="MenuBtn"><a href="#" onMouseover="ddrivetip('Coming Soon','', 'auto')";
onMouseout="hideddrivetip()">Help</a></div>
      <div class="WelcomeUser">Welcome <sec:authentication property="principal.username"/> &nbsp;| &nbsp; <a href="<c:url value="/j_logout"/>" class="logout">Logout</a></div>
      
      </div>      	
		<div class="MainLoginBox"> 
		<div class="LoginTitle">Change Password - First time Login Confirmation</div>		
	        <table width="316">
	        <tr>
			<td colspan="2" align="center">
				<font style="font:16px calibri; color:blue;">
					<c:out value="${ChangePassMessage}"/>
				</font>
	        </td>
	        </tr>
	        <tr>
			<td colspan="2" align="center">
				<a href="<c:url value="/j_logout"/>">Logout</a>
	        </td>
	        </tr>
	        </table>
    </div>      
  </body>
</html>