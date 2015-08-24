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