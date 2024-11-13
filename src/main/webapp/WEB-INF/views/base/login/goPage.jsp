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
<script>
$(document).ready(function() {
  	location.href = '${pageContext.request.contextPath}/'+'<%=session.getAttribute("URL")%>';
});
</script>
