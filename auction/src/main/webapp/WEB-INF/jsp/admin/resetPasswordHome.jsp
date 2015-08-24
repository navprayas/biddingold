<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin/superAdmin" var="admin_url" />
<body>
	<!-- { middle } -->
	<section class="main">
		<div class="container">
			<div class="form-container">
				<h1>
					<i class="fa fa-sign-in"></i> Forgot Password
				</h1>
				<c:if test="${not empty resetPasswordMessage}">
					<c:out value="${resetPasswordMessage}" />.
				</c:if>


				<form role="form" id="resetPasswordForm" name="resetPasswordForm"
					method="Post" action="admin/resetPassword">

					<div class="form-group">
						<label for="exampleInputPassword1">User Id</label> <input
							type="text" class="form-control" placeholder="USER Id"
							name="username" id="username">
					</div>

					<div class="form-group">
						<div class="form-group">
							<label for="exampleInputPassword1">New Password</label> <input
								type="password" class="form-control" placeholder="New Password"
								name="password" id="password">


						</div>

					</div>
					<div class="form-group">
						<div class="form-group">
							<label for="exampleInputPassword1">Confirm Password</label> <input
								type="password" class="form-control"
								placeholder=" Confirm Password" name="Cnfpass" id="Cnfpass">
						</div>
					</div>
					<div class="form-group form-submit">

						<button type="button" class="btn btn-primary pull-right"
							name="button" id="button" onclick="checkPassword();">Reset Password</button>
							
						<div class="clearfix"></div>
					</div>
				</form>
			</div>
		</div>
		<!-- /container -->
	</section>

</body>

<script>
	function checkPassword() {

		var Newpass = document.getElementById("password").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		var userName = document.getElementById("username").value;

		if (userName == "") {
			alert("User Id Cannot Be Blank!!")
			return false;
		}
		if (Newpass == "" || Cnfpass == "") {
			alert("Passowrd Fields Cannot Be Blank!!")
			return false;
		} else if (Newpass != Cnfpass) {
			alert("Both New Password Should be Identical!!")
			return false;
		} else if (Newpass.length < 4) {
			alert("New Password Should be atleast 4 charater long.!")
			return false;
		} else {
			document.resetPasswordForm.submit();
		}
	}
</script>



<%-- 
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin/superAdmin" var="admin_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>MSL Auction - Reset Password</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" rel="stylesheet" href="${css_url}/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>
<script type="text/javascript" src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
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

<script>
	function checkPassword()
	{
		
		var Newpass = document.getElementById("password").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		var userName = document.getElementById("username").value;
		
		if( userName=="") {
			alert("User Id Cannot Be Blank!!")
			return false;
    	}
	    if( Newpass=="" || Cnfpass=="" ) {
			alert("Passowrd Fields Cannot Be Blank!!")
			return false;
    	}else if(Newpass != Cnfpass){
			alert("Both New Password Should be Identical!!")
			return false;
		}
	 	else if(Newpass.length < 4)
			{
			alert("New Password Should be atleast 4 charater long.!")
			return false;
		}
		else{
			document.resetPasswordForm.submit();  
		}
 	}
</script>
		

<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
</head>
<body>

<script type="text/javascript">
pathToImages = "${static_url}" + pathToImages;
</script>
<%@ include file="/WEB-INF/jsp/admin/superadmin_top.jsp"%>
<div class="Mian">
			  
		<div style="font:14px calibri; color:#4f81bc; align:middle;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="36%" align="center" valign="middle">Reset Password</td>
				</tr>
			</table>
		 </div>
		<table width="316">
		        <tr>
					<td colspan="2" style="font:16px calibri; color:red;">
						<font color="red">
							<c:out value="${resetPasswordMessage}"/>
						</font>
			        </td>
		        </tr>
		  </table>      
		
		<br/>
   <form id="resetPasswordForm" name="resetPasswordForm" method="Post" action="admin/resetPassword" style="margin:0px;">
      <table width="416" border="0" cellspacing="0" cellpadding="0">
             
   		<tr>
		  <td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">User Id:</td>
          <td width="210"><input type="text" name="username" id="username" class="inputField" /></td>
        </tr>
             
		<tr>
		  <td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">New Password :</td>
          <td width="150"><input type="password" name="password" id="password" class="inputField" value=""/></td>
        </tr>
         <tr>
          <td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">Confirm Password:</td>
          <td width="150"><input type="password" name="Cnfpass" id="Cnfpass" class="inputField" value=""/></td>
        </tr>
        
        <tr>
          <td height="30">&nbsp;</td>
          <td valign="middle"><input type="button" name="button" id="button" value="Submit" class="ui-corner-all"  onclick="checkPassword();"/></td>
        </tr>
        
        </table>
    </form>
      </div>
      <!-- <div class="Footer" style="margin-top:300px">&copy; Copyright 2011 Navprayas</div>
 <div class="clr"></div>
       --></body>
      </html>
  </div> --%>