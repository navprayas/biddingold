
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<spring:url value="/static/js" var="js_url" />
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<spring:url value="/static/pdf" var="pdf_url" />
<spring:url value="/" var="home_url" />
<spring:url value="/bidder" var="bidder_home_url" />
<script type="text/javascript" src="${js_url}/json.min.js"></script>
<spring:url value="bidder/bidderReport" var="bidder_report_url"/>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="${css_url}/style.css" rel="stylesheet" media="screen"/>
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

<div class="MenuMain"> <div class="MenuBtnselected"><a href="${bidder_home_url}/home" onMouseover="ddrivetip('Forward Market Price','', 'auto')";
onMouseout="hideddrivetip()">Forward Market</a></div>
    <div class="MenuBtn"><a href="${bidder_home_url}/bidderReport" onMouseover="ddrivetip('Won Bids','', 'auto')";
onMouseout="hideddrivetip()">Won Bids</a></div>
      <div class="MenuBtn"><a href="${pdf_url}/termandcondition.pdf" target="_blank" onMouseover="ddrivetip('General Terms &amp; Condition','', 'auto')";
onMouseout="hideddrivetip()">General Terms &amp; Condition</a></div>      

<div class="MenuBtn"><a href="${home_url}changepass"  class="ui-corner-all" onMouseover="ddrivetip('Change Password','', 'auto')";
onMouseout="hideddrivetip()">Change Password</a></div>
      
      <div class="MenuBtn"><a href="#" onMouseover="ddrivetip('Coming Soon','', 'auto')";
onMouseout="hideddrivetip()">Help</a></div>
      <div class="WelcomeUser">Welcome <security:authentication property="principal.username"/> &nbsp;| &nbsp; <a href="<c:url value="/j_logout"/>" class="logout">Logout</a></div>
      
      </div>
      </body>
      </html>
      