<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/static/images" var="images_url" />

<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<link href="${css_url}/style.css" rel="stylesheet" media="screen" />
<link type="text/css" href="${css_url}/jquery-ui-1.8.11.custom.css"
	rel="stylesheet" />
<script type="text/javascript" src="${js_url}/jquery-1.10.2.min.js"></script>
<script type="text/javascript"
	src="${js_url}/jquery-ui-1.8.11.custom.min.js"></script>

<div class="bidhistory" title="Bidding History" >
        <table width="700" border="0" cellspacing="0" cellpadding="0" style="color:#000;">
              <tr>
                <td align="left" valign="top" ><form action="" method="post" name="form1" id="form3" style="margin:0px;">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      
                      <tr>
                        <td colspan="2" align="left" valign="top" style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                              <td><table width="100%" cellpadding="0" cellspacing="0" class="td" style="color:#fff;">
                  <tr>
                                    <td height="25" align="left" valign="middle" bgcolor="#9CBA5A"><strong>&nbsp;&nbsp;${seqId}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                                    ${bidItem}&#13; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${quantity}</strong></td>
                                </tr>
                              </table></td>
                            </tr>
                          <tr></tr>
                          <tr></tr>
                            <tr>
                              <td height="30" valign="middle" ><span class="style2" style="font:bold 12px Arial, Helvetica, sans-serif; padding-bottom:10px;">My Bids</span></td>
                          </tr>
                            <tr>
                              <td><table width="100%" cellpadding="0" cellspacing="0" >
                              <tr style="color:#fff;">
                                    <td height="30" align="center" valign="middle" bgcolor="#9CBA5A" class="td" >Bid Date &amp; Time</td>
                                    <td align="center" valign="middle" bgcolor="#9CBA5A" class="td">Bid Amount</td>
                                    <td align="center" valign="middle" bgcolor="#9CBA5A" class="td">Comments</td>
                                    <td align="center" valign="middle" bgcolor="#9CBA5A" class="td">Bid Type</td>
                                </tr>
                                 <c:forEach var="biddingHistoryBean" items="${BiddingHistoryBean}">
                                  <tr>
                                    <td height="20" align="center" valign="middle" bgcolor="#EFEFF7" class="td">${biddingHistoryBean.bidDateAndTime}</td>
                                    <td align="center" valign="middle" bgcolor="#EFEFF7" class="td">${biddingHistoryBean.bidAmount}</td>
                                    <td align="center" valign="middle" bgcolor="#EFEFF7" class="td">${biddingHistoryBean.comment}</td>
                                    <td align="center" valign="middle" bgcolor="#EFEFF7" class="td">${biddingHistoryBean.bidType}</td>
                                  </tr>
                                 </c:forEach> 
                              </table></td>
                            </tr>
                            <tr>
                              <td height="40" align="left" valign="bottom" style="font:bold 12px Arial, Helvetica, sans-serif; padding-bottom:10px;">Bid Type Legend</td>
                            </tr>
                            
                            <tr>
                              <td><table width="100%" cellpadding="0" cellspacing="0" bordercolor="#ffffff" style="font:11px calibri;">
                              <tr>
                                    <td height="25" bgcolor="#EFEFF7" class="td" style="padding-left:10px;">A: Active </td>
                                    <td bgcolor="#EFEFF7" class="td" style="padding-left:10px;">N: Normal Bid</td>
                                </tr>
                              </table></td>
                            </tr>
                        </table></td>
                      </tr>
                    </table>
                </form></td>
              </tr>
          </table>
        </div>