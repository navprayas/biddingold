<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<spring:url value="/report/observerSummary1" var="report_summary1_url" />
<spring:url value="/" var="home_url" />
<spring:url value="/observer" var="observer_home_url" />
<spring:url value="/static/pdf" var="pdf_url" />
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
					<li class="active"><a href="${observer_home_url}/home">Forward Market</a></li>
					<li><a href="${report_summary1_url}">Report</a></li>
					<li><a href="${home_url}changepass">Change Password</a></li>
					<li><a href="${pdf_url}/termandcondition.pdf" target="_blank">General Terms & Conditions</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
			<div class="welcom">
				<ul class="list-inline ">
					<li>Welcome <security:authentication
							property="principal.username" /></li>
					<li><a href="<c:url value="/j_logout"/>">Logout</a></li>
				</ul>
			</div>
		</nav>
	</div>
</div>




<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/report/observerSummary1" var="report_summary1_url" />
<spring:url value="/" var="home_url" />
<spring:url value="/observer" var="observer_home_url" />
<spring:url value="/static/pdf" var="pdf_url" />
<div class="Top">
  <div class="Logo"><img src="${images_url}/maharashtra-seamless-ltd.png" width="241" height="76" /></div>
  <div class="Scroll">
  	<marquee scrollamount="2" onMouseOver="stop();" onMouseOut="start();">
  		In case of any technical difficulties, please contact support at  +912225970344
    </marquee>
  </div>   
   <div class="JindalLogo"><img src="${images_url}/jindal-logo.png" width="164" height="40"></div>
</div><div class="MenuMain"> <div class="MenuBtnselected"><a href="${observer_home_url}/home" onMouseover="ddrivetip('Forward Market','', 'auto')";
onMouseout="hideddrivetip()">Forward Market</a></div>
      <div class="MenuBtn"><a href="${report_summary1_url}" onMouseover="ddrivetip('Report','', 'auto')";
onMouseout="hideddrivetip()">Report</a></div>
      <div class="partici" title="Auction Participants" style="display:none;">
    <table width="700" border="0" cellspacing="0" cellpadding="0" style="color:#000;">
  <tr>
    <td align="left" valign="top" ><form name="form1" method="post" action="" style="margin:0px;"></form>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="25" align="center" valign="middle" style="font:12px Arial, Helvetica, sans-serif;
          color:#fff; padding-left:10px;padding-right:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="50%" height="25" bgcolor="#9CBA5A"><span style="font:12px Arial, Helvetica, sans-serif;
          color:#fff; padding-left:10px;padding-top:5px; padding-top:5px;">Total No. of Users : 100&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
              <td width="50%" bgcolor="#9CBA5A"><span style="font:12px Arial, Helvetica, sans-serif;
          color:#fff; padding-left:10px;padding-top:5px; padding-top:5px;">No.of Users Logged in: 77</span></td>
            </tr>
          </table></td>
          </tr>
        <tr>
          <td align="left" valign="top" style="padding:10px;"><table width="97%" cellspacing="0" cellpadding="0">
            <tr>
              <td width="8%" height="25" align="center" bgcolor="#bdcf8c" class="td">User Id</td>
              <td width="21%" align="center" bgcolor="#bdcf8c" class="td">User Company Name</td>
              <td width="9%" align="center" bgcolor="#bdcf8c" class="td">Location</td>
              <td width="13%" align="center" bgcolor="#bdcf8c" class="td">Bidder name</td>
              <td width="11%" align="center" bgcolor="#bdcf8c" class="td">Mobile No.</td>
              <td width="10%" align="center" bgcolor="#bdcf8c" class="td">Role</td>
              <td width="14%" align="center" bgcolor="#bdcf8c" class="td">Logged Status</td>
              <td width="14%" align="center" bgcolor="#bdcf8c" class="td">User Status</td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#efefe7" class="td">Akgupta</td>
              <td align="center" bgcolor="#efefe7" class="td">&nbsp;</td>
              <td align="center" bgcolor="#efefe7" class="td">&nbsp;</td>
              <td align="center" bgcolor="#efefe7" class="td">AK Gupta</td>
              <td align="center" bgcolor="#efefe7" class="td">&nbsp;</td>
              <td align="center" bgcolor="#efefe7" class="td">OBSERVER</td>
              <td align="center" bgcolor="#efefe7" class="td">Logged in</td>
              <td align="center" bgcolor="#efefe7" class="td" ><input type="submit" name="button" id="button" value="Active" class="ui-state-default-active-btn "></td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#dee7ce" class="td">Akgupta</td>
              <td align="center" bgcolor="#dee7ce" class="td">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce" class="td">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce" class="td">AK Gupta</td>
              <td align="center" bgcolor="#dee7ce" class="td">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce" class="td">OBSERVER</td>
              <td align="center" bgcolor="#dee7ce" class="td">Not Logged</td>
              <td align="center" bgcolor="#dee7ce" class="td"><input type="submit" name="button2" id="button2" value="Deactive" class="ui-state-default-active-btn "></td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#efefe7" class="td">Akgupta</td>
              <td align="center" bgcolor="#efefe7" class="td">&nbsp;</td>
              <td align="center" bgcolor="#efefe7" class="td">&nbsp;</td>
              <td align="center" bgcolor="#efefe7" class="td">AK Gupta</td>
              <td align="center" bgcolor="#efefe7" class="td">&nbsp;</td>
              <td align="center" bgcolor="#efefe7" class="td">OBSERVER</td>
              <td align="center" bgcolor="#efefe7" class="td">Logged in</td>
              <td align="center" bgcolor="#efefe7" class="td"><input type="submit" name="button3" id="button3" value="Active" class="ui-state-default-active-btn "></td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#dee7ce" class="td">Akgupta</td>
              <td align="center" bgcolor="#dee7ce" class="td">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce" class="td">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce" class="td">AK Gupta</td>
              <td align="center" bgcolor="#dee7ce" class="td">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce" class="td">OBSERVER</td>
              <td align="center" bgcolor="#dee7ce" class="td">Not Logged</td>
              <td align="center" bgcolor="#dee7ce" class="td"><input type="submit" name="button4" id="button4" value="Deactive" class="ui-state-default-active-btn "></td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#efefe7" class="td">Akgupta</td>
              <td align="center" bgcolor="#efefe7" class="td">&nbsp;</td>
              <td align="center" bgcolor="#efefe7" class="td">&nbsp;</td>
              <td align="center" bgcolor="#efefe7" class="td">AK Gupta</td>
              <td align="center" bgcolor="#efefe7" class="td">&nbsp;</td>
              <td align="center" bgcolor="#efefe7" class="td">OBSERVER</td>
              <td align="center" bgcolor="#efefe7" class="td">Not Logged</td>
              <td align="center" bgcolor="#efefe7" class="td"><input type="submit" name="button5" id="button5" value="Active" class="ui-state-default-active-btn "></td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#dee7ce" class="td">Akgupta</td>
              <td align="center" bgcolor="#dee7ce" class="td">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce" class="td">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce" class="td">AK Gupta</td>
              <td align="center" bgcolor="#dee7ce" class="td">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce" class="td">OBSERVER</td>
              <td align="center" bgcolor="#dee7ce" class="td">Logged in</td>
              <td align="center" bgcolor="#dee7ce" class="td">
              <input type="submit" name="button6" id="button6" value="Active" class="ui-state-default-active-btn "></td>
            </tr>
          </table></td>
        </tr>
      </table>
    </form>    </td>
  </tr>
</table>
    </div>
    <div class="MenuBtn">
   <!--<a href="#"  class="partcipents  ui-corner-all" onMouseover="ddrivetip('Coming Soon','', 'auto')";
onMouseout="hideddrivetip()">Participants</a></div>
 
   -->
   <a href="#"  onMouseover="ddrivetip('Coming Soon','', 'auto')";
onMouseout="hideddrivetip()">Participants</a></div>
   <div class="change" title="Change Password" style="display:none;">
       <form id="form1" name="form1" method="post" action="" style="margin:0px;">
      <table width="316" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="106" height="30" style="font:14px calibri;
	color:#4f81bc;">Old Password :</td>
          <td width="210"><input type="text" name="textfield" id="textfield" class="inputField" /></td>
        </tr>

        <tr>
          <td height="30"><span style="font:14px calibri;
	color:#4f81bc;">New Password :</span></td>
          <td valign="middle"><input type="text" name="textfield2" id="textfield2" class="inputField" /></td>
        </tr>
        <tr>
          <td height="30"><span style="font:14px calibri;
	color:#4f81bc;">Confirm Password  :</span></td>
          <td valign="middle"><input type="text" name="textfield3" id="textfield3" class="inputField" /></td>
        </tr>
        <tr>
          <td height="30">&nbsp;</td>
          <td height="40" valign="bottom"><input type="submit" name="button" id="button" value="Submit" class="ui-state-default-active-btn-Login ui-corner-all" /></td>
        </tr>
        </table>
    </form></div>
      <div class="MenuBtn"><a href="${home_url}changepass"  class="ui-corner-all" onMouseover="ddrivetip('Change Password','', 'auto')" onMouseout="hideddrivetip()">Change Password</a></div>
    <div class="MenuBtn"><a href="${pdf_url}/termandcondition.pdf" target="_blank" onMouseover="ddrivetip('General Terms & Conditions','', 'auto')" onMouseout="hideddrivetip()">General Terms & Conditions</a></div>
       <div class="WelcomeUser">Welcome <security:authentication property="principal.username"/> &nbsp;| &nbsp; <a href="<c:url value="/j_logout"/>" class="logout" onMouseover="ddrivetip('Logout','', 'auto')";
onMouseout="hideddrivetip()">Logout</a></div>
      
  </div> --%>