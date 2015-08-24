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
<link href="${css_url}/menu.css" rel="stylesheet" media="screen" />
<script type="text/javascript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>

<body>
<div class="Mian">
	<!--Observer_top.html-->
  
  <div class="summeryDiv">
    <form id="form1" name="form1" method="post" action="" style="margin:0px;">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr style="font:bold 14px Arial, Helvetica, sans-serif; color:#fff;">
          <td width="9%" height="29" align="center" bgcolor="#4A82BD"><a href="observer_summary2.html" class="SummeryLink">Summary 1</a></td>
          <td width="9%" align="center" bgcolor="#4A82BD" style="border-left:1px solid #fff; border-right:1px solid #fff;" ><a href="observer_summary2.html" class="SummeryLink">Summary 2</a></td>
          <td width="9%" align="center" bgcolor="#9CBA5A"><a href="observer_bidder_wise_popup.html" class="SummeryLink">Bidder wise</a></td>
          <td width="58%">&nbsp;</td>
          <td width="15%"><input type="submit" name="button3" id="button3" value="Export to Excel" />
              <input type="submit" name="button4" id="button4" value="Print" /></td>
        </tr>
      </table>
    </form>
  </div>
  <div class="CheckBoxMenu">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="29" align="left" valign="middle" style="font:bold 12px Arial, Helvetica, sans-serif;">Raigad Corporation's Won Bids on 13 March, 2010</td>
      </tr>
    </table>
  </div>
  <div class="DetailDiv">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Sr. No</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Description</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Lot No.</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><select name="select" id="select">
          <option selected="selected">Category</option>
          <option>ERW</option>
          <option>Pipe &amp; Cutting</option>
          <option>Commercial </option>
          <option>Melting</option>
          <option>Others</option>
        </select>        </td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Market Name</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Remark</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Length Range</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Actual Length<br />
        (Approx)</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Quantity</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Zone</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Parchase Date &amp; Time</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Parchase Price per Unit</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Basic Price <br />
(TP=Q X P)</td>
        <td colspan="2" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Taxes</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">Total Amount</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle"><span class="DetailBorLastTitle">EMD (INR)</span></td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc"  class="SecDivBorder">Excise (INR)
(10.3% of TP)</span></td>
        <td align="center" valign="middle" bgcolor="#4f81bc"  class="SecDivBorder">Vat / CST (INR)</span></td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
        <td align="center" valign="middle" bgcolor="#4f81bc" class="DetailBorRightTitle">&nbsp;</td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">1.</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">
        
        <div id="description" style="display:none;"></div>
	<div id="despopup" style="display:none;">

		<table width="700" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" valign="top" style="border:1px solid #000;"><form name="form1" method="post" action="" style="margin:0px;">
      <table width="700" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td height="30" colspan="8" bgcolor="#9bbb58"><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="56%" style="font:bold 14px Arial, Helvetica, sans-serif; color:#fff;"><strong>&nbsp;&nbsp;Item Description</strong>&nbsp;&nbsp;</td>
              <td width="44%" align="right"><img src="${images_url}/closelable.jpg" width="31" height="17" border="0" onclick="popup('despopup')">&nbsp;&nbsp;</td>
            </tr>
          </table></td>
          </tr>
        <tr>
          <td width="49" height="30" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Sr. No.</td>
          <td width="92" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Category</td>
          <td width="56" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Lot No. </td>
          <td width="131" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Market Name</td>
          <td width="64" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Remark</td>
          <td width="96" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Length Range</td>
          <td width="125" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Actual Length <br>
            (Approx)</td>
          <td width="87" align="center" valign="middle" bgcolor="#abcb67" style="border-right:1px solid #fff;">Qty</td>
        </tr>
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">2. </td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">Commercial</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">1001</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">Mix Commercial</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">&nbsp;</td>
          <td align="center" valign="middle" bgcolor="#f7c794" style="border-right:1px solid #fff;">16 MT</td>
        </tr>
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">2. </td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">Commercial</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">1005</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">70.50 X 3.91 Pipe Cutting</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">Offcut</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">4' to 5'</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">4'3&quot;</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">8 MT</td>
        </tr>
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">2. </td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">Commercial</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">1009</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">70.50 X 3.91 Pipe Cutting</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">Offcut</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">4' to 5'</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">4'3&quot;</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">4 MT</td>
        </tr>
        <tr>
          <td height="30" align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">2.</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">Commercial</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">1001</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">70.50 X 3.91 Pipe Cutting</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">Offcut</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">4' to 5'</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">4'3&quot;</td>
          <td align="center" valign="middle" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">4 MT</td>
        </tr>
      </table>
        </form>    </td>
  </tr>
</table>
	</div>
          <input name="button7" type="submit" id="button7"  value="Desc" onclick="popup('despopup')" /></td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">1003</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Commercial</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><a href="#services" class="LinkSelected">60.30 X 3.91 Pipe</a></td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Fishtail</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">4&quot; To 5'</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">4'3&quot;</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">16 MT</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">CG</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">24/2/2011 10:12:18</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">INR 35,000</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">4,88,00</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><div id="blanket" style="display:none;"></div>
          <div id="popUpDiv" style="display:none;">
            <table width="400" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="left" valign="top" style="border:1px solid #000;"><form action="" method="post" name="form1" id="form2" style="margin:0px;">
                      <table width="400" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td height="30" bgcolor="#9bbb58">&nbsp;&nbsp;Auto Bid</td>
                          <td height="30" colspan="2" align="right" bgcolor="#9bbb58"><img src="${images_url}/closelable.jpg" width="31" height="17" border="0" onclick="popup('popUpDiv')" />&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                          <td width="110" height="30" align="right" bgcolor="#dee7d2" style="border-right:1px solid #fff;">1. &nbsp;</td>
                          <td width="212" bgcolor="#dee7d2" style="padding-left:10px;">60.30 X 3.91 Pipes Cutting</td>
                          <td width="78" bgcolor="#dee7d2" style="padding-left:10px;">16 MT</td>
                        </tr>
                        <!--<tr>
                          <td width="110" height="30" bgcolor="#f0f3ea" style="border-right:1px solid #fff;">&nbsp; Bid Type</td>
                          <td colspan="2" bgcolor="#f0f3ea"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="20" style="padding-left:10px;"><input type="radio" name="radio" id="radio4" value="radio" class="checkbox" /></td>
                                <td width="87">Normal Bid</td>
                                <td width="10" style="padding-left:10px;"><input type="radio" name="radio" id="radio5" value="radio" class="checkbox" /></td>
                                <td width="132">Auto Bid</td>
                              </tr>
                          </table></td>
                        </tr>-->
                        <tr>
                          <td width="110" height="30" bgcolor="#DEE7D6" style="border-right:1px solid #fff;">&nbsp; Auto Bid Limit</td>
                          <td colspan="2" bgcolor="#DEE7D6" style="padding-left:10px;"><input type="text" name="textfield" id="textfield" class="PopupField" /></td>
                        </tr>
                        <tr>
                          <td height="30" bgcolor="#F7F3EF" style="border-right:1px solid #fff;">&nbsp;&nbsp;Comments</td>
                          <td height="60" colspan="2" bgcolor="#F7F3EF" style="padding-left:10px;"><textarea name="textfield2" id="textfield2" class="PopupFieldComm"></textarea></td>
                        </tr>
                        <tr>
                          <td height="30" bgcolor="#DEE7D6" style="border-right:1px solid #fff;">&nbsp;</td>
                          <td colspan="2" bgcolor="#DEE7D6" style="padding-left:10px;"><input type="submit" name="button" id="button" value="Submit" /></td>
                        </tr>
                      </table>
                </form></td>
              </tr>
            </table>
        </div>          
        5,555</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">80,000</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><span class="DetailBorLast">1,80,000</span></td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><span class="DetailBorLast">80,000</span></td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">2.</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight"><input name="button5" type="submit" id="button5"  value="Desc" onclick="popup('despopup')" /></td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">1003</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">Commercial</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight"><a href="#" class="Link">60.30 X 3.91 Pipe</a></td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">Fishtail</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">4&quot; To 5'</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">4'3&quot;</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">16 MT</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">CG</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">24/2/2011 10:12:18</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">INR 35,000</td>
        <td align="center" valign="middle" bgcolor="#d0d7e7" class="DetailBorRight">4,88,00</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">5,555</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight">80,000</td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight"><span class="DetailBorLast">1,80,000</span></td>
        <td align="center" valign="middle" bgcolor="#D6D7E7" class="DetailBorRight"><span class="DetailBorLast">80,000</span></td>
      </tr>
      <tr>
        <td height="40" align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">3.</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><input name="button6" type="submit" id="button6"  value="Desc" onclick="popup('despopup')" /></td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">1003</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Commercial</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><a href="#" class="Link">60.30 X 3.91 Pipe</a></td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">Fishtail</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">4&quot; To 5'</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">4'3&quot;</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">16 MT</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">CG</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">24/2/2011 10:12:18</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">INR 35,000</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">4,88,00</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">5,555</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight">80,000</td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><span class="DetailBorLast">1,80,000</span></td>
        <td align="center" valign="middle" bgcolor="#e9edf3" class="DetailBorRight"><span class="DetailBorLast">80,000</span></td>
      </tr>
      <tr>
        <td height="40" colspan="13" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight">&nbsp;</td>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>Total</strong></td>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>11,47,110</strong></td>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>5,40,000</strong></td>
        <td height="40" align="center" valign="middle" bgcolor="#9CBA5A" class="DetailBorRight"><strong>2,40,000</strong></td>
      </tr>
    </table>
  </div>
  
  

  
  <!--observer_footer.html-->
    <div class="clr"></div>
</div>
</body>
</html>
