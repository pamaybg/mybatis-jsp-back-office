<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var ANALYSIS_PROG_REGI_CONFIG = {};
	ANALYSIS_PROG_REGI_CONFIG.ANALYSIS_ID = null;
	ANALYSIS_PROG_REGI_CONFIG.ANALYSIS_NAME = null;

	var getAnalysisProgRegiData = function( targetObj ) {
		ANALYSIS_PROG_REGI_CONFIG.ANALYSIS_ID = targetObj.analysisId;
		ANALYSIS_PROG_REGI_CONFIG.ANALYSIS_NAME = targetObj.analysisName;
	};
	
	var setAnalysisProgRegi = function( analysisEmbedType ) {
		var userInfo = $.ifvmGetUserInfo();
		var progUrl = "<ifv:url name='progDetail' />";		// 프로그램 등록 화면 URL
		progUrl += "?acid=" + userInfo.accountId;				// 어카운트 아이디
		progUrl += "&analysisId=" + ANALYSIS_PROG_REGI_CONFIG.ANALYSIS_ID;		// 분석 아이디  :: 프로그램 ID로 사용됨 + 프로그램 경로를 설정함
		progUrl += "&analysisNm=" + encodeURIComponent(ANALYSIS_PROG_REGI_CONFIG.ANALYSIS_NAME);	// 분석 명	:: 프로그램 제목으로 사용됨
		progUrl += "&analysisEmbedType=" + analysisEmbedType;

		qtjs.href(progUrl);
	};

	$( document ).ready(function() {
		$( "#analysisProgRegiTableBtn" ).click(function( evt ) {
			setAnalysisProgRegi( "TABLE" );
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("ejDialog").close();
		});		

		$( "#analysisProgRegiChartBtn" ).click(function( evt ) {
			setAnalysisProgRegi( "CHART" );
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("ejDialog").close();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div class="form-horizontal">
		<label><spring:message code="M01791" /></label>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisProgRegiTableBtn">
		<spring:message code="M01175"/>
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisProgRegiChartBtn">
		<spring:message code="M01540"/>
	</button>
</div>