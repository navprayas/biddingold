<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix='security' uri='http://www.springframework.org/security/tags' %>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/report/observerSummary1" var="report_summary1_url" />
<spring:url value="/observer/home" var="observer_marketlist_url"/>
<spring:url value="/static/pdf" var="pdf_url" />
<spring:url value="/" var="home_url" />
<div class="Top">
  <div class="Logo"><span class="MahaLogo"><img src="${images_url}/maharashtra-seamless-ltd.png" width="241" height="76"></span></div>
  <div class="Scroll">
  	<marquee scrollamount="2" onMouseOver="stop();" onMouseOut="stop();">
  		In case of any technical difficulties, please contact support at  +912225970344
    </marquee>
  </div>
        <div class="JindalLogo"><img src="${images_url}/jindal-logo.png" width="164" height="40"></div>
</div>
<div class="MenuMain"> <div class="MenuBtn"><a href="${observer_marketlist_url}">Forward Market</a></div>
      <div class="MenuBtnselected"><a href="${report_summary1_url}">Report</a></div>
      <div id="participate" style="display:none;"></div>
	<div id="partpopup" style="display:none;">
    <table width="700" border="0" cellspacing="0" cellpadding="0" style="color:#000;">
  <tr>
    <td align="left" valign="top" style="border:1px solid #000;"><form name="form1" method="post" action="" style="margin:0px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="60" align="left" valign="middle" bgcolor="#9CBA5A" style="font:12px Arial, Helvetica, sans-serif;
          color:#fff; padding-left:10px;padding-top:5px; padding-top:5px;">Market Paticipants<br />
Total No. of Users : 100<br />
No.of Users Logged in: 77</td>
          <td align="right" valign="top" bgcolor="#9CBA5A" style="font:bold 14px Arial, Helvetica, sans-serif;
          color:#fff; padding-left:10px; padding-top:5px;"><img src="${images_url}/closelable.jpg" width="31" height="17" border="0" onclick="popup('partpopup')">&nbsp;&nbsp;</td>
        </tr>
        <tr>
          <td colspan="2" align="left" valign="top" style="padding:10px;"><table width="100%" border="1" cellspacing="0" cellpadding="0">
            <tr>
              <td height="25" align="center" bgcolor="#bdcf8c">User Id</td>
              <td align="center" bgcolor="#bdcf8c">User Company Name</td>
              <td align="center" bgcolor="#bdcf8c">Location</td>
              <td align="center" bgcolor="#bdcf8c">Bidder name</td>
              <td align="center" bgcolor="#bdcf8c">Mobile No.</td>
              <td align="center" bgcolor="#bdcf8c">Role</td>
              <td align="center" bgcolor="#bdcf8c">Logged Status</td>
              <td align="center" bgcolor="#bdcf8c">User Status</td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#efefe7">Akgupta</td>
              <td align="center" bgcolor="#efefe7">&nbsp;</td>
              <td align="center" bgcolor="#efefe7">&nbsp;</td>
              <td align="center" bgcolor="#efefe7">AK Gupta</td>
              <td align="center" bgcolor="#efefe7">&nbsp;</td>
              <td align="center" bgcolor="#efefe7">OBSERVER</td>
              <td align="center" bgcolor="#efefe7" class="Login">Logged in</td>
              <td align="center" bgcolor="#efefe7" >Active</td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#dee7ce">Akgupta</td>
              <td align="center" bgcolor="#dee7ce">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce">AK Gupta</td>
              <td align="center" bgcolor="#dee7ce">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce">OBSERVER</td>
              <td align="center" bgcolor="#dee7ce" class="Notlogin">Not Logged</td>
              <td align="center" bgcolor="#dee7ce">Active</td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#efefe7">Akgupta</td>
              <td align="center" bgcolor="#efefe7">&nbsp;</td>
              <td align="center" bgcolor="#efefe7">&nbsp;</td>
              <td align="center" bgcolor="#efefe7">AK Gupta</td>
              <td align="center" bgcolor="#efefe7">&nbsp;</td>
              <td align="center" bgcolor="#efefe7">OBSERVER</td>
              <td align="center" bgcolor="#efefe7" class="Login">Logged in</td>
              <td align="center" bgcolor="#efefe7">Active</td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#dee7ce">Akgupta</td>
              <td align="center" bgcolor="#dee7ce">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce">AK Gupta</td>
              <td align="center" bgcolor="#dee7ce">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce">OBSERVER</td>
              <td align="center" bgcolor="#dee7ce" class="Notlogin">Not Logged</td>
              <td align="center" bgcolor="#dee7ce">Active</td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#efefe7">Akgupta</td>
              <td align="center" bgcolor="#efefe7">&nbsp;</td>
              <td align="center" bgcolor="#efefe7">&nbsp;</td>
              <td align="center" bgcolor="#efefe7">AK Gupta</td>
              <td align="center" bgcolor="#efefe7">&nbsp;</td>
              <td align="center" bgcolor="#efefe7">OBSERVER</td>
              <td align="center" bgcolor="#efefe7" class="Notlogin">Not Logged</td>
              <td align="center" bgcolor="#efefe7">Active</td>
            </tr>
            <tr>
              <td height="25" align="center" bgcolor="#dee7ce">Akgupta</td>
              <td align="center" bgcolor="#dee7ce">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce">AK Gupta</td>
              <td align="center" bgcolor="#dee7ce">&nbsp;</td>
              <td align="center" bgcolor="#dee7ce">OBSERVER</td>
              <td align="center" bgcolor="#dee7ce" class="Login">Logged in</td>
              <td align="center" bgcolor="#dee7ce">Active</td>
            </tr>
          </table></td>
        </tr>
      </table>
    </form>    </td>
  </tr>
</table>
    </div>
    <div class="MenuBtn">
    <a href="#" onclick="popup('partpopup')" onMouseover="ddrivetip('Coming Soon','', 'auto')"; onMouseout="hideddrivetip()" >Participants</a></div>
      <div class="MenuBtn"><a href="${home_url}changepass" onMouseover="ddrivetip('Change Password','', 'auto')"; onMouseout="hideddrivetip()" >Change Password</a></div>
    <div class="MenuBtn"><a href="${pdf_url}/termandcondition.pdf" target="_blank" onMouseover="ddrivetip('General Terms & Conditions','', 'auto')"; onMouseout="hideddrivetip()" >General Terms & Conditions</a></div>
      <div class="WelcomeUser">Welcome <security:authentication property="principal.username"/> &nbsp;| &nbsp; <a href="<c:url value="/j_logout"/>" class="logout">Logout</a></div>
      
  </div>
