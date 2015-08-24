<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:url value="/style" var="styleurl" />
<spring:url value="/" var="baseurl" />
<sec:authorize ifAnyGranted="ROLE_USER">

</sec:authorize>
<sec:authorize ifAnyGranted="ROLE_ADMIN">


</sec:authorize>

<sec:authorize ifAnyGranted="ROLE_ADMIN">


</sec:authorize>


<sec:authorize ifAnyGranted="ROLE_USER">


</sec:authorize>



