
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix='security'
	uri='http://www.springframework.org/security/tags'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

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



<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:url value="/static/images" var="images_url" />
<spring:url value="/bidderHistory/marketList" var="bidder_history_url" />

<script type="text/javascript">
	function getBiddingHistory() {
		var bidItemId = "";
		var bidItem = "";
		var quantity = "";
		var seqId = "";
		if (document.getElementById("bidItemIdVal")) {
			bidItemId = document.getElementById("bidItemIdVal").value;
		}
		if (bidItemId == "" || bidItemId.length < 1) {
			alert("Please first select the Material name for getting history for that");
			return false;
		}
		if (document.getElementById("seqId" + bidItemId)) {
			seqId = document.getElementById("seqId" + bidItemId).innerHTML;
		}
		if (document.getElementById("bidItemName" + bidItemId)) {
			bidItem = document.getElementById("bidItemName" + bidItemId).innerHTML;
		}
		if (document.getElementById("categoryName" + bidItemId)) {
			bidItem = bidItem
					+ " "
					+ document.getElementById("categoryName" + bidItemId).innerHTML;
		}
		if (document.getElementById("totalQuantity" + bidItemId)) {
			quantity = document.getElementById("totalQuantity" + bidItemId).innerHTML;
		}

		var location1 = "${bidder_history_url}?bidItemId=" + bidItemId
				+ "&bidItem=" + bidItem + "&quantity=" + quantity + "&seqId="
				+ seqId;
		PopupCenter(location1, 'BiddingHistory', 700, 400);
	}

	function PopupCenter(pageURL, title1, w, h) {
		var left = (screen.width / 2) - (w / 2);
		var top = (screen.height / 2) - (h / 2);
		var options = 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=auto, resizable=yes, width='
				+ w + ', height=' + h + ', top=' + top + ', left=' + left;
		window.open(pageURL, title1, options);
	}

	function setBiddingDetailVal() {
		var bidItemId = "";
		var bidItem = "";
		if (document.getElementById("bidItemIdVal")) {
			bidItemId = document.getElementById("bidItemIdVal").value;
		}

		if (document.getElementById("bidItemName" + bidItemId)) {
			bidItem = document.getElementById("bidItemName" + bidItemId).innerHTML;
		}
		if (document.getElementById("seqId" + bidItemId)) {
			document.getElementById('seq').innerHTML = document
					.getElementById("seqId" + bidItemId).innerHTML;
		}
		if (document.getElementById("bidStartTime" + bidItemId)) {
			document.getElementById('starttime').innerHTML = document
					.getElementById("bidStartTime" + bidItemId).innerHTML;
		}
		if (document.getElementById("endtimeMain" + bidItemId)) {
			document.getElementById('endtime').innerHTML = document
					.getElementById("endtimeMain" + bidItemId).innerHTML;
		}
		if (document.getElementById("categoryName" + bidItemId)) {
			//bidItem = bidItem + " " +document.getElementById("categoryName"+bidItemId).innerHTML;
		}
		if (document.getElementById("totalQuantity" + bidItemId)) {
			document.getElementById('quantity').innerHTML = document
					.getElementById("totalQuantity" + bidItemId).innerHTML;
		}
		document.getElementById('BidItemObj').innerHTML = bidItem;
		if (document.getElementById("currentMarketPrice" + bidItemId)) {
			document.getElementById('initOfferPrice').innerHTML = document
					.getElementById("currentMarketPrice" + bidItemId).innerHTML;
		}
		if (document.getElementById("Item" + bidItemId)) {
			document.getElementById('initOfferPrice').innerHTML = document
					.getElementById("Item" + bidItemId).innerHTML;
		}
		if (document.getElementById("minBidIncrement" + bidItemId)) {
			document.getElementById('minIncrPrice').innerHTML = document
					.getElementById("minBidIncrement" + bidItemId).innerHTML;
		}
	}

	function setIdForBiddingHistory(bidItem) {
		document.getElementById("bidItemIdVal").value = bidItem;
	}
</script>
<input id="bidItemIdVal" type="hidden" name="bidItemIdVal" />
<div class="AutoBidMain">
	<div class="AutoBidMain">
		<div class="Menusdiv">
			<div class="biddetail" title="Bidding Detail" style="display: none">
				<table width="400" border="0" cellspacing="0" cellpadding="0"
					style="color: #000;">
					<tr>
						<td align="left" valign="top"><form action="" method="post"
								name="form1" id="form3" style="margin: 0px;">
								<table width="400" cellspacing="0" cellpadding="0">

									<tr>
										<td height="10"></td>
									</tr>
									<tr>
										<td height="30" colspan="2" align="left" bgcolor="#9CBA5A"
											style="border-right: 1px solid #fff; padding-left: 10px;"><table
												width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr style="color: #fff; font-weight: bold;">
													<td width="7%"><div id="seq"></div></td>
													<td width="52%"><div id="BidItemObj"></div></td>
													<td width="41%"><div id="quantity"></div></td>
												</tr>
											</table></td>
									</tr>
									<tr>
										<td width="219" height="30" bgcolor="#f0f3ea" class="td"
											style="border-right: 1px solid #fff; padding-left: 10px;">Start
											Time :</td>
										<td bgcolor="#f0f3ea" class="td" style="padding-left: 10px;"><div
												id="starttime"><%=new java.util.Date()%></div></td>
									</tr>
									<tr>
										<td width="219" height="30" bgcolor="#f0f3ea" class="td"
											style="border-right: 1px solid #fff; padding-left: 10px;">End
											Time :</td>
										<td bgcolor="#f0f3ea" class="td" style="padding-left: 10px;"><div
												id="endtime"></div></td>
									</tr>
									<tr>
										<td height="30" bgcolor="#f0f3ea" class="td"
											style="border-right: 1px solid #fff; padding-left: 10px;">Initial
											Bid Time :</td>
										<td bgcolor="#f0f3ea" class="td" style="padding-left: 10px;">3
											Mins</td>
									</tr>
									<tr>
										<td height="30" bgcolor="#f0f3ea" class="td"
											style="border-right: 1px solid #fff; padding-left: 10px;">Time
											extension after every bid:</td>
										<td bgcolor="#f0f3ea" class="td" style="padding-left: 10px;">1
											Mins</td>
									</tr>
									<tr>
										<td height="30" bgcolor="#f0f3ea" class="td"
											style="border-right: 1px solid #fff; padding-left: 10px;">Initial
											Offer Price :</td>
										<td bgcolor="#f0f3ea" class="td" style="padding-left: 10px;"><div
												id="initOfferPrice"></div></td>
									</tr>
									<tr>
										<td height="30" bgcolor="#f0f3ea" class="td"
											style="border-right: 1px solid #fff; padding-left: 10px;">Minimum
											Increment Price :</td>
										<td bgcolor="#f0f3ea" class="td" style="padding-left: 10px;"><div
												id="minIncrPrice"></div></td>
									</tr>
									<!--  <tr>
                      <td height="30" bgcolor="#f0f3ea" class="td" style="border-right:1px solid #fff; padding-left:10px;">Lot Related Documents :</td>
                      <td bgcolor="#f0f3ea" class="td" style="padding-left:10px;"><a href="#" class="termlink">Terms &amp;  Conditions</a></td>
                    </tr>-->

								</table>
							</form></td>
					</tr>
				</table>
			</div>
			<div class="MenuBtn">
				<a href="#" class="detail  ui-corner-all"
					onclick="javascript:setBiddingDetailVal();"
					onMouseover="ddrivetip('Bidding Detail','', 'auto')"
					;
onMouseout="hideddrivetip()">Bidding Detail</a>
			</div>
			<div class="bidhistory" title="Bidding History"
				style="display: none;">
				<table width="700" border="0" cellspacing="0" cellpadding="0"
					style="color: #000;">
					<tr>
						<td align="left" valign="top"><form action="" method="post"
								name="form1" id="form3" style="margin: 0px;">
								<table width="100%" border="0" cellspacing="0" cellpadding="0">

									<tr>
										<td colspan="2" align="left" valign="top"
											style="padding: 10px;"><table width="100%" border="0"
												cellspacing="0" cellpadding="0">
												<tr>
													<td><table width="100%" cellpadding="0"
															cellspacing="0" class="td" style="color: #fff;">
															<tr>
																<td height="25" align="left" valign="middle"
																	bgcolor="#9CBA5A"><strong>&nbsp;&nbsp;1.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																		60.30 X 3.91 Pipe Cutting&#13;
																		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16MT</strong></td>
															</tr>
														</table></td>
												</tr>
												<tr></tr>
												<tr></tr>
												<tr>
													<td height="30" valign="middle"><span class="style2"
														style="font: bold 12px Arial, Helvetica, sans-serif; padding-bottom: 10px;">My
															Bids</span></td>
												</tr>
												<tr>
													<td><table width="100%" cellpadding="0"
															cellspacing="0">
															<tr style="color: #fff;">
																<td height="30" align="center" valign="middle"
																	bgcolor="#9CBA5A" class="td">Bid Date &amp; Time</td>
																<td align="center" valign="middle" bgcolor="#9CBA5A"
																	class="td">Bid Amount</td>
																<td align="center" valign="middle" bgcolor="#9CBA5A"
																	class="td">Comments</td>
																<td align="center" valign="middle" bgcolor="#9CBA5A"
																	class="td">Rank</td>
																<td align="center" valign="middle" bgcolor="#9CBA5A"
																	class="td">Bid Type</td>
															</tr>
															<tr>
																<td height="20" align="center" valign="middle"
																	bgcolor="#EFEFF7" class="td">24/2.2011, 11:02:05PM</td>
																<td align="center" valign="middle" bgcolor="#EFEFF7"
																	class="td">INR 20,000</td>
																<td align="center" valign="middle" bgcolor="#EFEFF7"
																	class="td">Lorem Ipsum lrem</td>
																<td align="center" valign="middle" bgcolor="#EFEFF7"
																	class="td">3</td>
																<td align="center" valign="middle" bgcolor="#EFEFF7"
																	class="td">N</td>
															</tr>
															<tr>
																<td height="20" align="center" valign="middle"
																	bgcolor="#EFEFF7" class="td">24/2.2011, 11:02:05PM</td>
																<td align="center" valign="middle" bgcolor="#EFEFF7"
																	class="td">INR 80,000</td>
																<td align="center" valign="middle" bgcolor="#EFEFF7"
																	class="td">Lorem Ipsum lrem</td>
																<td align="center" valign="middle" bgcolor="#EFEFF7"
																	class="td">&nbsp;</td>
																<td align="center" valign="middle" bgcolor="#EFEFF7"
																	class="td">A</td>
															</tr>
														</table></td>
												</tr>
												<tr>
													<td height="40" align="left" valign="bottom"
														style="font: bold 12px Arial, Helvetica, sans-serif; padding-bottom: 10px;">Bid
														Type Legend</td>
												</tr>

												<tr>
													<td><table width="100%" cellpadding="0"
															cellspacing="0" bordercolor="#ffffff"
															style="font: 11px calibri;">
															<tr>
																<td height="25" bgcolor="#EFEFF7" class="td"
																	style="padding-left: 10px;">A: Active</td>
																<td bgcolor="#EFEFF7" class="td"
																	style="padding-left: 10px;">N: Normal Bid</td>
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
			<div class="MenuBtn">
				<a href="#" onMouseover="ddrivetip('Bidding History','', 'auto')"
					;
onMouseout="hideddrivetip()"
					onclick="javascript:getBiddingHistory();"> Bidding History</a>
			</div>
		</div>
		<div class="AutoBidBlue"></div>
		<div class="Footer">© Copyright 2011 Navprayas</div>
	</div>
</div> --%>
