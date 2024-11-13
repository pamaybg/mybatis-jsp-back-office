<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<% 
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Pragma","no-cache"); 
 response.setDateHeader("Expires",0);
%>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common/login.css">
<script src='${pageContext.request.contextPath}/resources/js/lib/placeholders.min.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>

<script src='${pageContext.request.contextPath}/resources/js/cryptoJS/aes.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/cryptoJS/pbkdf2.js' type="text/javascript"></script>


<script>
$(document).ready(function() {
	
	$.ifvErrorPop('<spring:message code="C00007" />');
	setTimeout(function(){
		window.top.location.href = '<ifvm:url name="MKTLogin"/>';
	},500 ); 
});
</script>
