<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>MSL Auction</title>
<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="${js_url}/csspopup.js"></script>
 <link rel="stylesheet" media="screen" href="zd_dialog.css"/>
    <script language='JavaScript' type='text/JavaScript' src='zd_draganddrop.js'></script>
<link href="${css_url}/menu.css" rel="stylesheet" media="screen" />
</head>

<body>
<div class="Mian">
	<!--observer_top.html-->
    <div class="summeryDiv">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr style="font:bold 14px Arial, Helvetica, sans-serif; color:#fff;">
        <td width="9%" height="29" align="center" bgcolor="#4A82BD"><a href="observer_summary1.html" class="SummeryLink">Summary 1</a></td>
        <td width="9%" align="center" bgcolor="#4A82BD" style="border-left:1px solid #fff; border-right:1px solid #fff;" ><a href="observer_summary2.html" class="SummeryLink">Summary 2</a></td>
        <td width="9%" align="center" bgcolor="#9CBA5A"><a href="observer_bidder_wise_popup.html" class="SummeryLink">Bidder wise</a></td>
        <td width="58%">&nbsp;</td>
        <td width="15%">&nbsp;</td>
      </tr>
    </table>
  </div>
  <div class="DetailDiv">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="4%" height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Select</td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Firm Name</td>
        <td width="4%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Person Name</td>
        <td width="10%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Place (City)</td>
        <td width="8%" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">User Status</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><input type="radio" name="radio" id="radio" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">AKGupta</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">AKgupta</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Mumbai</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Active</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight"><input type="radio" name="radio" id="radio2" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">Trader2</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">PKjain</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">Kolkatta</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">Active</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><input type="radio" name="radio" id="radio3" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">AKGupta</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">AKgupta</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Thane</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Active</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight"><input type="radio" name="radio" id="radio4" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Trader22</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Pkjain</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Delhi</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Active</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight"><input type="radio" name="radio" id="radio5" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">AKgupta</td>
        <td align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">Ak gupta</td>
        <td align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">Mumbai</td>
        <td align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">Active</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight"><input type="radio" name="radio" id="radio6" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">AKGupta</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">AKgupta</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Mumbai</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Active</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight"><input type="radio" name="radio" id="radio7" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">Trader22</td>
        <td align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">PKjain</td>
        <td align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">Delhi</td>
        <td align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">Inactive</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight"><input type="radio" name="radio" id="radio8" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">AKGupta</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">AKgupta</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Thane</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Inactive</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight"><input type="radio" name="radio" id="radio9" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">Trader22</td>
        <td align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">PKjain</td>
        <td align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">Kolkatta</td>
        <td align="center" valign="middle" bgcolor="#EFEFF7" class="DetailBorRight">Active</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight"><input type="radio" name="radio" id="radio10" value="radio" onclick="location.href='observer_bidderwise.html'" /></td>
        <td height="40" align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Trader22</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">PKjain</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Mumbai</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">Active</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#FFFFFF" class="DetailBorRight">&nbsp;</td>
        <td height="40" align="center" valign="middle" bgcolor="#FFFFFF" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#FFFFFF" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#FFFFFF" class="DetailBorRight">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#FFFFFF" class="DetailBorRight">1 | 2 |&nbsp;3&nbsp;|&nbsp;4&nbsp;|&nbsp;5 | <strong>Next &raquo;</strong></td>
      </tr>
    </table>
  </div>
  <div class="Footer">&copy; Copyright 2011 Navprayas </div>
    <div class="clr"></div>
</div>
</body>
</html>
