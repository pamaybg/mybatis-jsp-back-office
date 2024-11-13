<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/js/marketing/diagram/css/diagramStyle.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/analysisTools.jsp" />

<script type="text/javascript">
	var ANALYSIS_VIEW_CONFIG = {};
	ANALYSIS_VIEW_CONFIG.ANALYSIS_ID = null;
	ANALYSIS_VIEW_CONFIG.ANALYSIS_EMBED_TYPE = null;
	ANALYSIS_VIEW_CONFIG.PUBLISH_FLAG = null;
	
	var getAnalysisViewDetail = function() {
		var targetObj = {
			targetId: "chartContent"
			, analysisId: ANALYSIS_VIEW_CONFIG.ANALYSIS_ID
			, analysisMasterFlag: "Y"
			, analysisTypeCode: ANALYSIS_VIEW_CONFIG.ANALYSIS_EMBED_TYPE
			, publishFlag: ANALYSIS_VIEW_CONFIG.PUBLISH_FLAG
		};

		$.fn.KPRAnalysisCreateReport( targetObj );
		
		$( "#chartContent" ).css( "background", "#FFFFFF" );
	};

	$( document ).ready(function() {
		ANALYSIS_VIEW_CONFIG.ANALYSIS_ID = $.ifvGetParam( "analysisId" );
		ANALYSIS_VIEW_CONFIG.ANALYSIS_EMBED_TYPE = $.ifvGetParam( "analysisEmbedType" );
		ANALYSIS_VIEW_CONFIG.USER_ID = $.ifvmGetRowID();
		
		$( "#analysisSettingPop" ).click(function( evt ) {
			$.fn.KPRAnalysisSettingPop({
				targetId: "chartContent"
				, instFlag: "ORIGINAL"
				, publishFlag: ANALYSIS_VIEW_CONFIG.PUBLISH_FLAG
			});
		});
		
		$.ifvSyncPostJSON( "<ifv:action name='getAnalysisName' />", {
			analysisId: ANALYSIS_VIEW_CONFIG.ANALYSIS_ID
			, analysisMasterFlag: "Y"
		}, function( resData ) {
			$( "#analysisNameText" ).text( resData.analysisName );
			getAnalysisViewDetail();
		});
	});
</script>

<div class="page-title">
	<h1><spring:message code="M01529" /></h1>
</div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span id="analysisNameText"></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
	</div>
</div>

<div class="dashboard_box_type1">
	<div class="header_chart">
		<p class="tit_chart" id="chartTitle"></p>
		<span class="icon_area">
			<a id="analysisSettingPop"><i class="fa fa-cog"></i></a>
		</span>
	</div>
	<div class="chart_area" id="chartContent"></div>
</div>