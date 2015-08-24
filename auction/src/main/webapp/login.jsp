<!DOCTYPE html>
<html lang="en">

<%@ page
	import="org.springframework.security.core.AuthenticationException"%>
<%@ page
	import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/users/forgotPassword" var="forgotpassword_url" />
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="images/favicon.png">

<title>Signin</title>

<!-- Bootstrap core CSS -->
<link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${css_url}/custom.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

	<!-- { header } -->
	<header class="header">
		<div class="container">
			<div class="col-xs-12 col-sm-3 hdr-lft">
				<div class="hdr-lft-in">
					<img src="${images_url}/maharashtra-seamless-ltd.png">
				</div>
			</div>
			<div class="col-xs-12 col-sm-6 hdr-mdl">
				<div class="hdr-mdl-in">
					<marquee scrollamount="2" onmouseover="stop();"
						onmouseout="start();"> In case of any technical
						difficulties, please contact support at +912225970344 </marquee>
				</div>
			</div>
			<div class="col-xs-12 col-sm-3 hdr-rgt">
				<div class="hdr-rgt-in text-right">
					<img src="${images_url}/jindal-logo.png">
				</div>
			</div>
		</div>
		<div class="strip-bar"></div>
	</header>

	<!-- { middle } -->
	<section class="main">
		<div class="container">
			<div class="form-container">
				<h1>
					<i class="fa fa-sign-in"></i> Sign In
				</h1>
				<form role="form" method="post"
					action="<c:url value='j_spring_security_check'/>">
					<div class="form-group">
						<label for="exampleInputName">User Name</label> <input type="text"
							class="form-control" name='j_username'
							value='<c:if test="${not empty param.login_error}"><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:if>'
							placeholder="Enter Your Name">
					</div>
					<div class="form-group">
						<label for="exampleInputPassword1">Password</label> <input
							type="password" name="j_password" class="form-control"
							id="exampleInputPassword1" placeholder="Password">
					</div>
					<div class="form-group form-submit">
						<a href="${forgotpassword_url}">Forget Password</a>
						<button type="submit" class="btn btn-primary pull-right">Sign
							In</button>
						<div class="clearfix"></div>
					</div>
				</form>
			</div>
		</div>
		<!-- /container -->
	</section>

	<!-- { footer } -->
	<footer class="footer">
		<div class="container">
			<div class="col-xs-12 col-sm-6 copyrgt">
				<p>Copyright &copy; 2015 Navprayas</p>
			</div>
			<div class="col-xs-12 col-sm-6 poweredby text-right">
				<p>
					Developed By: <a href="http://cfeindia.com/">CFE India</a>
				</p>
			</div>
		</div>
	</footer>

	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="${js_url}/bootstrap.min.js"></script>
	<script src="${js_url}/ie10-viewport-bug-workaround.js"></script>
</body>
</html>













<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.springframework.security.core.AuthenticationException" %> 
<%@ page import="org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter" %>   
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/users/forgotPassword" var="forgotpassword_url" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction - Login</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<style>
.MainLoginBox {
	width:336px;
	height:213px;
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
	height:160px;
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
.Footer {
width:100%;
height:30px;
text-align:center;
background:#d0d7e7;
   position:absolute;
   bottom:0;
   clear:both;
}
.ui-state-default-active-btn { border: 1px solid #cccccc; background: #f6f6f6 url(${css_url}/images/ui-bg_glass_100_f6f6f6_1x400.png) 50% 50% repeat-x; font-weight: bold; color: #1c94c4;  text-decoration:none; font:bold 12px Arial, Helvetica, sans-serif ; -moz-border-radius:5px; padding:5px;  }
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
  <div class="LoginTitle">Login </div>
  		<c:if test="${not empty param.login_error}">
			<font color="red">
			Your login attempt was not successful, try again.<br/>
			Reason: <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>.
			</font>
			</c:if>  
			<c:if test="${not empty param.session_error}">
			<font color="red">
			Session Problem. Session might be expired or invalid. Please login again.<br/>
			</font>
		</c:if>     
    <div class="LoginInner">
    
      <form id="form1" name="form1" method="post" action="<c:url value='j_spring_security_check'/>" style="margin:0px;">
        <table width="316" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="96" height="30">Username :</td>
            <td width="220"><input type="text" id="textfield" class="input" name='j_username'  value='<c:if test="${not empty param.login_error}"><c:out value="${SPRING_SECURITY_LAST_USERNAME}"/></c:if>'/></td>
          </tr>
          <tr>
            <td height="30">Password :</td>
            <td><input type="password" name='j_password' id="textfield2" class="input" /></td>
          </tr>
          <tr>
            <td height="30">&nbsp;</td>
            <td height="40">
            	<input type="submit" name="button" id="button" value="Login" class="ui-state-default-active-btn ui-corner-all" />
            </td>
          </tr>
          
          <tr>
            <td height="30">&nbsp;</td>
            <td height="40" valign="middle">
            	<a href="${forgotpassword_url}">Forgot Password?</a>
            </td>
          </tr>          
        </table>
        
      </form>
    </div>  
</div>
<div class="clr"></div>
<div class="Footer">&copy; Copyright 2011 Navprayas</div>
 
</body>
</html>
 --%>

