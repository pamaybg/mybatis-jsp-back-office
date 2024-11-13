<%@page import="com.icignal.common.util.CommonUtil"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"       prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
    <!-- <meta charset="utf-10"  > -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>DESCENTE KOREA CRM MOBILE</title>
    <meta name="description" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <script src='${pageContext.request.contextPath}/resources/1.4/ifvCommon/js/jquery-2.1.4.min.js' type="text/javascript"></script>
    <!-- Basic Styles -->
		<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/mobile/style.css">
		<!-- ifvPopup Style -->
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/1.4/ifvPopup/css/ifvPopup.css">
    <!-- FAVICONS -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon/DESCENTE_logo_BI.png" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon/DESCENTE_logo_BI.png" type="image/x-icon">
    <!-- GOOGLE FONT -->
    <link rel="stylesheet" href="//fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,300,400,700">
   	<script src='${pageContext.request.contextPath}/resources/1.4/ifvCommon/js/lib.js' type="text/javascript"></script>
		<script src='${pageContext.request.contextPath}/resources/1.4/ifvCommon/js/util.js' type="text/javascript"></script>
		<script src='${pageContext.request.contextPath}/resources/1.4/ifvPopup/js/ifvPopup.js' type="text/javascript"></script>
        
    <jsp:include page="/WEB-INF/views/layouts/default/sessionScript.jsp" />
    
		<!-- JQUERY VALIDATE -->
		<script src="${pageContext.request.contextPath}/resources/bootstrap/js/plugin/jquery-validate/jquery.validate.min.js"></script>
		 <!-- jQuery Modal -->
    <script src="${pageContext.request.contextPath}/resources/js/lib/jquery.modal.min.js"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/mobile/jquery.modal.min.css">
</head>
<tiles:insertAttribute name="content" />
<script>
    $(document).ready(function() {
        //window.top.document.getElementById('mainIframe').width = "100%";
        //window.top.document.getElementById('mainIframe').height = window.top.document.body.scrollHeight + "px";
    });
</script>
</html>