<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Spring 3 MVC Series - BIDITEM</title>
<style type="text/css">
		body {
			font-family: sans-serif;
		}
		.data, .data td {
			border-collapse: collapse;
			width: 100%;
			border: 1px solid #aaa;
			margin: 2px;
			padding: 2px;
		}
		.data th {
			font-weight: bold;
			background-color: #5C82FF;
			color: white;
		}
	</style>
	
	<h2>BidItem Details</h2>
<br/><br/>
<a href="<c:url value="/j_logout"/>">Logout</a> 
<br/><br/>

<form:form method="post" action="add.html" commandName="contact">

	<table>
	<tr>
		<td><form:label path="bidItemId"><spring:message code="label.bidItemId"/></form:label></td>
		<td><form:input path="bidItemId" /></td> 
	</tr>
	<tr>
		<td><form:label path="groupCode"><spring:message code="label.groupCode"/></form:label></td>
		<td><form:input path="groupCode" /></td>
	</tr>
	<tr>
		<td><form:label path="materialName"><spring:message code="label.materialName"/></form:label></td>
		<td><form:input path="materialName" /></td>
	</tr>
	<tr>
		<td><form:label path="location"><spring:message code="label.location"/></form:label></td>
		<td><form:input path="location" /></td>
	</tr>
	<tr>
		<td><form:label path="city"><spring:message code="label.city"/></form:label></td>
		<td><form:input path="city" /></td>
	</tr>
	<tr>
		<td><form:label path="lastUpDateTime"><spring:message code="label.lastUpDateTime"/></form:label></td>
		<td><form:input path="lastUpDateTime" /></td>
	</tr>
	<tr>
		<td><form:label path="firstCreatedTime"><spring:message code="label.firstCreatedTime"/></form:label></td>
		<td><form:input path="firstCreatedTime" /></td>
	</tr>
	<tr>
		<td><form:label path="lengthRange"><spring:message code="label.lengthRange"/></form:label></td>
		<td><form:input path="lengthRange" /></td>
	</tr>
	<tr>
		<td><form:label path="actualLength"><spring:message code="label.actualLength"/></form:label></td>
		<td><form:input path="actualLength" /></td>
	</tr>
	<tr>
		<td><form:label path="document"><spring:message code="label.document"/></form:label></td>
		<td><form:input path="document" /></td>
		
	</tr>
	<tr>
		<td><form:label path="categoryId"><spring:message code="label.categoryId"/></form:label></td>
		<td><form:input path="categoryId" /></td>
	</tr>
	<tr>
		<td><form:label path="marketId"><spring:message code="label.marketId"/></form:label></td>
		<td><form:input path="marketId" /></td>
	</tr>
	
	
	
	
	<tr>
		<td colspan="2">
			<input type="submit" value="<spring:message code="label.addBidItem"/>"/>
		</td>
	</tr>
</table>	
</form:form>
<h3>BidItem</h3>
<c:if test="${!empty bidItemList }">
<table class="data">
<tr>
<th>BidItemId</th>
<th>Group Code</th>
<th>Material Name</th>
<th>Location</th>
<th>City</th>
<th>LastUpDateTime</th>
<th>FirstCreatedTime</th>
<th>Length Range</th>
<th>Actual Length</th>
<th>Document</th>
<th>CategoryId</th>
<th>MarketId</th>
<th>&nbsp;</th>

</tr>
//<c:forEach items="${bidItemList}" var="biditem" >
<tr>
<td>${biditem.bidItemId}</td>
<td>${biditem.groupCode}</td>
<td>${biditem.materialName}</td>
<td>${biditem.location}</td>
<td>${biditem.city}</td>
<td>${biditem.lastUpDateTime}</td>
<td>${biditem.firstCreatedTime}</td>
<td>${biditem.lengthRange}</td>
<td>${biditem.actualLength}</td>
<td>${biditem.document}</td>
<td>${biditem.categoryId}</td>
<td>${biditem.marketId}</td>
<td>${biditem.currency}</td>
<td>${biditem.bidStartTime}</td>
<td>${biditem.bidEndTime}</td>

<td><a href="delete/${biditem.id}">delete</a></td>
</tr>

</c:forEach>
</table>

</c:if>

	
</head>
<body>

</body>
</html>