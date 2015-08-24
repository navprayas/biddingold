<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<Title>Manage User Page</Title>
</head>
<body>
	<br />
	<br />
	<a href="<c:url value="/j_logout"/>">Logout</a>
	<br />
	<br />


	<h3>Manage Users</h3>
	<c:if test="${!empty manageuserlist}">
		<table class="data">
			<tr>
				<th>Name</th>
				<th>Role</th>
				<th>RegUserId</th>
				<th>&nbsp;</th>
			</tr>
			<c:forEach items="${manageuserlist}" var="reguser">
				<tr>
					<td>${reguser.FirstName},${reguser.MiddleName}</td>
					<td>${reguser.Role}</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>

</body>