
<section class="main">
	<div class="container">
		<div class="form-container form-container-cr user-registraton">
			<h1>
				<i class="fa fa-user"></i> User Registration
			</h1>
			<form class="form-horizontal">
				<div class="form-group">
					<label for="inputname2" class="col-xs-12 col-sm-4 control-label">First
						Name</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="firstName" id="firstName"
							placeholder="First Name">
					</div>
				</div>
				<div class="form-group">
					<label for="inputname3" class="col-xs-12 col-sm-4 control-label">Middle
						Name</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="middleName" id="middleName"
							placeholder="Middle Name">
					</div>
				</div>
				<div class="form-group">
					<label for="inputname4" class="col-xs-12 col-sm-4 control-label">Last
						Name</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="lastName" id="lastName"
							placeholder="Last Name">
					</div>
				</div>
				<div class="form-group">
					<label for="inputage2" class="col-xs-12 col-sm-4 control-label">Age</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="age" id="age"
							placeholder="Age">
					</div>
				</div>
				<div class="form-group">
					<label for="inputgender2" class="col-xs-12 col-sm-4 control-label">Gender</label>
					<div class="col-xs-12 col-sm-8">
						<select class="form-control" name="gender" id="gender">
							<option value="0">select</option>					          
		        <option value="Male" >Male</option>
		        <option value="Female" >Female</option>	
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="inputEmail4" class="col-xs-12 col-sm-4 control-label">Email</label>
					<div class="col-xs-12 col-sm-8">
						<input type="email" class="form-control" name="email" id="email"
							placeholder="Email">
					</div>
				</div>
				<div class="form-group">
					<label for="inputphone2" class="col-xs-12 col-sm-4 control-label">Phone</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="phone" id="phone"
							placeholder="Phone Number">
					</div>
				</div>
				<div class="form-group">
					<label for="inputmobile2" class="col-xs-12 col-sm-4 control-label">Mobile</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="mobile" id="mobile"
							placeholder="Mobile Number">
					</div>
				</div>
				<div class="form-group">
					<label for="inputuserid2" class="col-xs-12 col-sm-4 control-label">User
						Id</label>
					<div class="col-xs-12 col-sm-8">
						<input type="text" class="form-control" name="username" id="username"
							placeholder="User Id">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword4"
						class="col-xs-12 col-sm-4 control-label">Password</label>
					<div class="col-xs-12 col-sm-8">
						<input type="password" class="form-control" name="password" id="password"
							placeholder="Password">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword5"
						class="col-xs-12 col-sm-4 control-label">Confirm Password</label>
					<div class="col-xs-12 col-sm-8">
						<input type="password" class="form-control" name="Cnfpass" id="Cnfpass"
							placeholder="Confirm Password">
					</div>
				</div>
				<div class="form-group">
					<label for="inputrole2" class="col-xs-12 col-sm-4 control-label">Role</label>
					<div class="col-xs-12 col-sm-8">
						<select class="form-control" name="role" id="role">
							<option value="0">select</option>					          
		        <option value="ROLE_BIDDER" selected="selected">BIDDER</option>
		        <option value="ROLE_OBSERVER" >OBSERVER</option>
		        <option value="ROLE_SUPER_ADMIN">SUPERADMIN</option> 
						</select>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-4 col-sm-8">
						<button type="button" class="btn btn-primary" id="button" name="button"  onclick="checkLogin();">Submit</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- /container -->
</section>

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
			alert("Last Name Cannot Be Blank.")
			return false;
		}

		if (email == "") {
			alert("email Cannot Be Blank.")
			return false;
		}

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
			document.usersForm.submit();
		}
	}
</script>





<%-- <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<sprin<script>
	function checkLogin()
	{
		
		var firstName = document.getElementById("firstName").value;
		var lastName = document.getElementById("lastName").value;
		var userName = document.getElementById("username").value;
		var Newpass = document.getElementById("password").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		var email = document.getElementById("email").value;
		
		if( firstName=="") {
			alert("First Name Cannot Be Blank.")
			return false;
    	}
		if( lastName=="") {
			alert("Last Name Cannot Be Blank.")
			return false;
    	}
		
		if( email=="") {
			alert("email Cannot Be Blank.")
			return false;
    	}
		
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
			document.usersForm.submit();  
		}
 	}
</script>


<script>
	function checkLogin()
	{
		
		var firstName = document.getElementById("firstName").value;
		var lastName = document.getElementById("lastName").value;
		var userName = document.getElementById("username").value;
		var Newpass = document.getElementById("password").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		var email = document.getElementById("email").value;
		
		if( firstName=="") {
			alert("First Name Cannot Be Blank.")
			return false;
    	}
		if( lastName=="") {
			alert("Last Name Cannot Be Blank.")
			return false;
    	}
		
		if( email=="") {
			alert("email Cannot Be Blank.")
			return false;
    	}
		
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
			document.usersForm.submit();  
		}
 	}
</script>


g:url value="/admin/superAdmin" var="admin_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction - User Registration Home</title>
<link type="text/css" rel="stylesheet" href="${css_url}/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>
<script type="text/javascript" src="${js_url}/dhtmlgoodies_calendar.js?random=20060118"></script>
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

<script>
	function checkLogin()
	{
		
		var firstName = document.getElementById("firstName").value;
		var lastName = document.getElementById("lastName").value;
		var userName = document.getElementById("username").value;
		var Newpass = document.getElementById("password").value;
		var Cnfpass = document.getElementById("Cnfpass").value;
		var email = document.getElementById("email").value;
		
		if( firstName=="") {
			alert("First Name Cannot Be Blank.")
			return false;
    	}
		if( lastName=="") {
			alert("Last Name Cannot Be Blank.")
			return false;
    	}
		
		if( email=="") {
			alert("email Cannot Be Blank.")
			return false;
    	}
		
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
			document.usersForm.submit();  
		}
 	}
</script>


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
					<td width="36%" align="center">User Registration Form</td>
				</tr>
			</table>
		 </div>		
		
		<br/>	  
		  
   <form id="usersForm" name="usersForm" method="post" action="registration" modelAttribute="usersForm" style="margin:0px;">
      <table width="416" border="0" cellspacing="0" cellpadding="0">

        <% if(request.getParameter("registrationMessage") != null) { %>
        <tr>
			<td colspan="2" width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">
			<% out.println(request.getParameter("registrationMessage")); %></td>
        </tr>
        <% } %>
        <tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">First Name :</td>
          <td width="150"><input type="text" name="firstName" id="firstName" class="inputField" /></td>
        </tr>
        <tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">Middle Name :</td>
          <td width="150"><input type="text" name="middleName" id="middleName" class="inputField" /></td>
        </tr>
        <tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">Last Name :</td>
          <td width="150"><input type="text" name="lastName" id="lastName" class="inputField" /></td>
        </tr>
         <tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">Age :</td>
          <td width="150"><input type="text" name="age" id="age" class="inputField" /></td>
        </tr>
         <tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">Gender :</td>
            <td width="150">
          		<select name="gender" id="gender">	
				<option value="0">select</option>					          
		        <option value="Male" >Male</option>
		        <option value="Female" >Female</option>		           
			 </select> 
		  </td>
        </tr>
         <!-- <tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="middle">Date Of Birth :</td>
          <td width="150"><input type="text" name="dateofbirth" id="dateofbirth" class="inputField" /></td>
        </tr> -->
        
        <tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="center">E-Mail :</td>
          <td width="150"><input type="text" name="email" id="email" class="inputField" /></td>
        </tr>
        <tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="center">Phone :</td>
          <td width="150"><input type="text" name="phone" id="phone" class="inputField" /></td>
        </tr>
        
         <tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="center">Mobile :</td>
          <td width="150"><input type="text" name="mobile" id="mobile" class="inputField" /></td>
        </tr>
   
   		<tr>
			<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="center">User Id:</td>
          <td width="210"><input type="text" name="username" id="username" class="inputField" /></td>
        </tr>
             
		<tr>
		<td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="center">Password :</td>
          <td width="150"><input type="password" name="password" id="password" class="inputField" value=""/></td>
        </tr>
         <tr>
          <td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="center">Confirm Password :</td>
          <td valign="middle"><input type="password" name="Cnfpass" id="Cnfpass" class="inputField" value=""/></td>
        </tr>
        
        <tr>
        	 <td width="266" height="30" style="font:14px calibri; color:#4f81bc;" align="center">Role :</td>
        	<td>
        	 <select name="role" id="role">	
				<option value="0">select</option>					          
		        <option value="ROLE_BIDDER" selected="selected">BIDDER</option>
		        <option value="ROLE_OBSERVER" >OBSERVER</option>
		        <option value="ROLE_SUPER_ADMIN">SUPERADMIN</option>    
			 </select> 
        	</td>
        </tr>
        
        <tr>
          <td height="30">&nbsp;</td>
          <td valign="middle"><input type="button" name="button" id="button" value="Submit" class="ui-corner-all" onclick="checkLogin();"/></td>
        </tr>
        </table>
    </form>
    </div>
    <!-- <div class="Footer">&copy; Copyright 2011 Navprayas</div>
 <div class="clr"></div> -->
      </body>
      </html> --%>