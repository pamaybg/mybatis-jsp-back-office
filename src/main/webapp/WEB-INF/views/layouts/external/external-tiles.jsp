<%@page import="com.icignal.common.util.CommonUtil"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <title>DESCENTE KOREA CRM</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <script data-pace-options='{ "restartOnRequestAfter": true }' src="${pageContext.request.contextPath}/resources/bootstrap/js/plugin/pace/pace.min.js"></script>
    
    <!--[if lt IE 9]>
    <script src='${pageContext.request.contextPath}/resources/js/html5shiv.js' type="text/javascript"></script>
    <script src='${pageContext.request.contextPath}/resources/js/respond.min.js' type="text/javascript"></script>
    <![endif]-->
    
 	<script type="text/javascript">var frameworkReadyUrl = '<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources';</script>
    <jsp:include page="/WEB-INF/views/layouts/default/ifvFramework.jsp" />
    
    <jsp:include page="/WEB-INF/views/layouts/default/sessionScript.jsp" />
    <jsp:include page="/WEB-INF/views/layouts/default/templete.jsp" />
    <jsp:include page="/WEB-INF/views/layouts/default/common.jsp" />
    
    <script src='${pageContext.request.contextPath}/resources/js/jspdf/jspdf.min.js' type="text/javascript"></script>
    <script src='${pageContext.request.contextPath}/resources/js/html2canvas/html2canvas.js' type="text/javascript"></script>
    <script src='${pageContext.request.contextPath}/resources/js/html2canvas/html2canvas.svg.js' type="text/javascript"></script>
	<script src='${pageContext.request.contextPath}/resources/js/html2canvas/canvg.min.js' type="text/javascript"></script>

    <link href="${pageContext.request.contextPath}/resources/1.4/ifvGrid/css/jqgrid/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/1.4/ifvGrid/css/jqgrid/jquery-ui-custom.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/1.4/ifvGrid/css/ifvGrid.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/resources/js/lib/ifvGrid.js"></script>
    
    <script src="${pageContext.request.contextPath}/resources/js/lib/util.js"></script>
    <script src='${pageContext.request.contextPath}/resources/js/lib/uuid.js' type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/marketing/popup.js" type="text/javascript"></script>
    
    <!-- BOOTSTRAP -->
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/notification/SmartNotification.min.js"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/bootstrap/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/bootstrap/css/smartadmin-production.css">
   
    <!-- FAVICONS -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon/DESCENTE_logo_BI.png" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon/DESCENTE_logo_BI.png" type="image/x-icon">
    
    <!-- style -->
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/common/common.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/style.css" />
	
</head>
<body>
    <!--[if IE 7]>
    <h1>Your browser is out of date, please update your browser by going to www.microsoft.com/download</h1>
    <![endif]-->
    <div id="wrapper">
		<tiles:insertAttribute name="content" />
    </div>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/app.js"></script>
</body>
</html>