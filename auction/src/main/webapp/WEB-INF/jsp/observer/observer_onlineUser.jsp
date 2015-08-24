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
									<th align="center">User Name</th>
								</tr>
								<c:forEach var="onlineUserVO" items="${onlineUserVOList}"
									varStatus="status">
									<tr>
										<td align="center">${status.index+1}</td>
										<td align="center">${onlineUserVO.userId}</td>
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

<table width="100%" cellpadding="0" cellspacing="0" >
     <tr style="color:#fff;">
      	<td width="30%" height="30" align="center" valign="middle" bgcolor="#9CBA5A" class="td" >Online User</td>
       </tr>
        <c:forEach var="onlineUserVO" items="${onlineUserVOList}">
         <tr>
           <td align="center" valign="middle" bgcolor="#EFEFF7" class="td">${onlineUserVO.userId}</td>
         </tr>
        </c:forEach> 
</table>

 --%>