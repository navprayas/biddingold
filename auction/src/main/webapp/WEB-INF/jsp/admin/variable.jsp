<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/admin" var="admin_home_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="${js_url}/csspopup.js"></script>
 <link rel="stylesheet" media="screen" href="${css_url}/zd_dialog.css"/>
    <script language='JavaScript' type='text/JavaScript' src='${js_url}/zd_draganddrop.js'></script>
<link href="css/menu.css" rel="stylesheet" media="screen" />
</head>
<body>
<div class="Mian">
	<!--admin_top.html-->
	<div class="DetailDiv">
	<c:out value="${message_variable}" /><br/>
    <form name="form" method="post" action="add" commandName="variable"> 
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="27%" height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Variables</td>
        <td width="73%" align="left" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Set Value </td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Time extention after every bid is enetered </td>
        <td align="left" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">
         	 <label>
         		 <input type="text" width="40"  name="textfield" path="timeExtension" />
             </label>Minutes
        </td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">Time difference between two active lots </td>
        <td align="left" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">
           <label>
            <input type="text" width="40"  name="textfield2" path="timeDiffernrce" />
          </label>
          Minutes
         </td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Number of active lots visible at a time
		</td>
        <td align="left" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">
          		<label>
          		<input type="text" width="40" path="activeLots" />
          		</label>
		</td>
      </tr>
	  <tr>
	  <td height="40" align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">&nbsp;</td>
        <td align="left" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight"><input type="submit" name="Submit" value="Edit" />
          <input type="submit" name="Submit2" value="submit" /></td>
	  </tr>
	</table>
	</form>
  </div>
  <div class="Footer">&copy; Copyright 2011 Navprayas </div>
    <div class="clr"></div>
</div>
</body>
</html>
