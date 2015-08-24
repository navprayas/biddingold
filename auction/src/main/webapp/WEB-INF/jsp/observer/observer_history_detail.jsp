
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<spring:url value="/static/images" var="images_url" />

<spring:url value="/static/css" var="css_url" />
<spring:url value="/static/js" var="js_url" />

<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="${images_url}/favicon.png">

<title>Reports</title>

<!-- Bootstrap core CSS -->
<link href="${css_url}/bootstrap.css" rel="stylesheet">
<link href="${css_url}/font-awesome.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${css_url}/custom.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>


	<!-- { middle } -->
	<section class="main">
		<div class="container">
			<div class="table-container">
				<div class="top-line">
					<div class="col-xs-12 col-sm-6">
						<ul class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a
								aria-controls="home" role="tab" data-toggle="tab"
								href="#summary">Online Users</a></li>
						</ul>
					</div>
					<div class="col-xs-12 col-sm-6"></div>
					<div class="clearfix"></div>
				</div>
				<!-- { tab-Effects } -->
				<div class="tab-content">
					<div role="tabpanel" class="tab-pane active" id="summary">
						<div class="table-responsive user-map">
							<table class="table table-bordered table-striped text-center">
								<tr align="center">
									<th align="center">Sr. No.</th>
									<th align="center">Bidding Company</th>
									<th align="center">Location</th>
									<th align="center">Bid Date &amp; Time</th>

									<th align="center">Bid Amount</th>
									<th align="center">Comments</th>
									<th align="center">Rank</th>
									<th align="center">Bid Type</th>

								</tr>
								<c:forEach var="biddingHistoryBean"
									items="${BiddingHistoryBean}" varStatus="status">
									<tr>
										<td align="center">${status.index+1}</td>
										<td align="center">${biddingHistoryBean.biddingCompany}</td>
										<td align="center">${biddingHistoryBean.location}</td>
										<td align="center">${biddingHistoryBean.bidDateAndTime}</td>
										<td align="center">${biddingHistoryBean.bidAmount}</td>
										<td align="center">${biddingHistoryBean.rank}</td>
										<td align="center">${biddingHistoryBean.bidType}</td>
									</tr>
								</c:forEach>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /container -->
	</section>





	<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
                              <td height="30" valign="middle" ><span class="style2" style="font:bold 12px Arial, Helvetica, sans-serif; padding-bottom:10px;">Bids</span></td>
                          </tr>
                            <tr>
                              <td><table width="100%" cellpadding="0" cellspacing="0" >
                              <tr style="color:#fff;">
                               		<td width="30%" height="30" align="center" valign="middle" bgcolor="#9CBA5A" class="td" >Bidding Company</td>
                       				 <td width="14%" align="center" valign="middle" bgcolor="#9CBA5A" class="td">Location</td>
                                    <td height="30" align="center" valign="middle" bgcolor="#9CBA5A" class="td" >Bid Date &amp; Time</td>
                                    <td align="center" valign="middle" bgcolor="#9CBA5A" class="td">Bid Amount</td>
<!--                                    <td align="center" valign="middle" bgcolor="#9CBA5A" class="td">Comments</td>-->
                                    <td align="center" valign="middle" bgcolor="#9CBA5A" class="td">Rank</td>
                                    <td align="center" valign="middle" bgcolor="#9CBA5A" class="td">Bid Type</td>
                                </tr>
                                 <c:forEach var="biddingHistoryBean" items="${BiddingHistoryBean}">
                                  <tr>
                                    <td align="center" valign="middle" bgcolor="#EFEFF7" class="td">${biddingHistoryBean.biddingCompany}</td>
                                      <td align="center" valign="middle" bgcolor="#EFEFF7" class="td">${biddingHistoryBean.location}</td>
                                    <td height="20" align="center" valign="middle" bgcolor="#EFEFF7" class="td">${biddingHistoryBean.bidDateAndTime}</td>
                                    <td align="center" valign="middle" bgcolor="#EFEFF7" class="td">${biddingHistoryBean.bidAmount}</td>
<!--                                    <td align="center" valign="middle" bgcolor="#EFEFF7" class="td"></td>-->
                                    <td align="center" valign="middle" bgcolor="#EFEFF7" class="td">${biddingHistoryBean.rank}</td>
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
        </div> --%>