<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/js/marketing/diagram/css/diagramStyle.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/analysisTools.jsp" />

<script type="text/javascript">
	var ANALYSIS_CONFIG = {};
	ANALYSIS_CONFIG.ANALYSIS_ID = null;
	ANALYSIS_CONFIG.ANALYSIS_NAME = null;
	ANALYSIS_CONFIG.PUBLISH_FLAG = true;
	ANALYSIS_CONFIG.ANALYSIS_TYPE = null;
	
	var getPublishAnalysisDetail = function() {
		var targetObj = {
			targetId: "chartContent"
			, analysisId: ANALYSIS_CONFIG.ANALYSIS_ID
			, analysisMasterFlag: "Y"
			, analysisTypeCode: ANALYSIS_CONFIG.ANALYSIS_TYPE
			, publishFlag: ANALYSIS_CONFIG.PUBLISH_FLAG
			, externalFlag: true
		};
		
		$.fn.KPRAnalysisCreateReport( targetObj );
		
		$( "#chartTitle" ).text( ANALYSIS_CONFIG.ANALYSIS_NAME );
		$( "#chartContent" ).css( "background", "#FFFFFF" );
	};

	$( document ).ready(function() {
		ANALYSIS_CONFIG.ANALYSIS_ID = "<%= request.getAttribute("analysisId") %>";
		ANALYSIS_CONFIG.ANALYSIS_NAME = "<%= request.getAttribute("analysisName") %>";
		ANALYSIS_CONFIG.ANALYSIS_TYPE = $.ifvGetParam( "analysisType" );
		
		$( "#analysisPreviewSetPop" ).click(function( evt ) {
			$.fn.KPRAnalysisSettingPop({
				targetId: "chartContent"
				, instFlag: "ORIGINAL"
				, publishFlag: ANALYSIS_CONFIG.PUBLISH_FLAG
				, externalFlag: true
			});
		});
		
		$( "#analysisPreviewCloseBtn" ).click(function( evt ) {
			$( "#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PREVIEW_POP ).data( "ejDialog" ).close();
		});
		
		getPublishAnalysisDetail();
	});
</script>

<div class="dashboard_box_type1">
	<div class="header_chart">
		<p class="tit_chart" id="chartTitle"></p>
		<span class="icon_area">
			<a id="analysisPreviewSetPop"><i class="fa fa-cog"></i></a>
		</span>
	</div>
	<div class="chart_area" id="chartContent"></div>
</div>