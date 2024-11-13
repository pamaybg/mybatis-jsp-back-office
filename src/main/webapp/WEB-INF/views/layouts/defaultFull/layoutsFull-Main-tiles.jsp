<%@page import="com.icignal.common.util.CommonUtil"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    
   <meta charset="utf-8" http-equiv="X-UA-Compatible" content="IE=edge">
  <!--  <meta charset="utf-8"> -->

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
    
    <!-- 박선희/20171109/전체화면 스타일 수정  -->
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/marketing_style.css" />
    
</head>
    
        <tiles:insertAttribute name="content" />
    <script>
    	$(document).ready(function() {
    	});
    </script>
</html>