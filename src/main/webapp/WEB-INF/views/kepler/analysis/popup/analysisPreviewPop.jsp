<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/js/kepler/diagram/css/diagramStyle.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />
<%-- <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/style.css" />
 --%>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/analysisTools.jsp" />

<script type="text/javascript">
	var ANALYSIS_PREVIEW_CONFIG = {};
	ANALYSIS_PREVIEW_CONFIG.ANALYSIS_ID = null;
	ANALYSIS_PREVIEW_CONFIG.PUBLISH_FLAG = true;
	ANALYSIS_PREVIEW_CONFIG.DASHBRD_EBD_TYPE_CD = "DASHBRD_EBD_TYPE_CD";

	ANALYSIS_PREVIEW_CONFIG.EXECUTE_FLAG = {};
	ANALYSIS_PREVIEW_CONFIG.EXECUTE_FLAG.CHART = false;
	ANALYSIS_PREVIEW_CONFIG.EXECUTE_FLAG.TABLE = false;
	
	ANALYSIS_PREVIEW_CONFIG.EXECUTE_TYPE = {};
	ANALYSIS_PREVIEW_CONFIG.EXECUTE_TYPE.CH = "CH";
	ANALYSIS_PREVIEW_CONFIG.EXECUTE_TYPE.TA = "TA";
	
	ANALYSIS_PREVIEW_CONFIG.ANALYSIS_PREVIEW_POP_ID = null;
	ANALYSIS_PREVIEW_CONFIG.ANALYSIS_MASTER_FLAG = "N";
	ANALYSIS_PREVIEW_CONFIG.PREVIEW_PREFIX = "preview_";
	
	var getAnalysisPreviewDetail = function( targetObj ) {
		ANALYSIS_PREVIEW_CONFIG.ANALYSIS_ID = targetObj.analysisId;
		ANALYSIS_PREVIEW_CONFIG.ANALYSIS_MASTER_FLAG = targetObj.analysisMasterFlag;
		ANALYSIS_PREVIEW_CONFIG.ANALYSIS_PREVIEW_POP_ID = targetObj.analysisPreviewPopId;
		
		$( "#analysisPreviewCloseBtn" ).click(function( evt ) {
			$( "#" + ANALYSIS_PREVIEW_CONFIG.ANALYSIS_PREVIEW_POP_ID ).data( "ejDialog" ).close();
		});
		
		$( "#analysisTabContainer" ).data( "ejTab" ).showItem(0);
	};
	
	var getShowAnalysisData = function( executeType ) {
		var targetId = executeType + "_CONTENT_CONTAINER";
		var targetPopId = targetId + "_POP";
		
		var targetObj = {
			targetId: targetId
			, analysisId: ANALYSIS_PREVIEW_CONFIG.ANALYSIS_ID
			, publishFlag: ANALYSIS_PREVIEW_CONFIG.PUBLISH_FLAG
			, analysisMasterFlag: ANALYSIS_PREVIEW_CONFIG.ANALYSIS_MASTER_FLAG === "Y" ? "Y" : "N"
			, previewFlag: "PREVIEW"
		};
		
		var tmpl = $( "#analysisPreviewTemplate" ).tmpl({
			targetTagId: targetId
			, targetPopupTagId: targetPopId
		});
		
		if( executeType === ANALYSIS_PREVIEW_CONFIG.EXECUTE_TYPE.TA ) {
			targetObj.analysisTypeCode = "TABLE";
			$( "#" + ANALYSIS_PREVIEW_CONFIG.PREVIEW_PREFIX + "TABLE" ).append( tmpl );
		} else {
			targetObj.analysisTypeCode = "CHART";
			$( "#" + ANALYSIS_PREVIEW_CONFIG.PREVIEW_PREFIX + "CHART" ).append( tmpl );
		}

		$.fn.KPRAnalysisCreateReport( targetObj, "getAnalysisPreviewDataCallbackFunction" );
		
		$( "#" + targetPopId ).click(function( evt ) {
			$.fn.KPRAnalysisSettingPop({
				targetId: targetId
				, instFlag: ANALYSIS_PREVIEW_CONFIG.ANALYSIS_MASTER_FLAG === "Y" ? "ORIGINAL" : "INSTANCE"
				, publishFlag: ANALYSIS_PREVIEW_CONFIG.PUBLISH_FLAG
			});
		});
		
		$( "#" + targetId ).css( "background", "#ffffff" );
	};
	
	var getAnalysisPreviewDataCallbackFunction = function( dataObj ) {
		var targetId = dataObj.targetId;

		if( dataObj.noDataFlag === true ) {
			$( "#" + targetId + " #emptyDiv" ).remove();
			$( "#" + targetId ).append( "<div id='emptyDiv'><spring:message code='M01712' /></div>" );
		} else {
			$( "#" + targetId + " #emptyDiv" ).remove();
		}
		
		$( "#" + ANALYSIS_PREVIEW_CONFIG.ANALYSIS_PREVIEW_POP_ID ).data( "ejDialog" ).refresh();
	};

	$( document ).ready(function() {
		$.ifvSyncPostJSON( "<ifv:action name='getCommCodeList' />", {
			groupCode: ANALYSIS_PREVIEW_CONFIG.DASHBRD_EBD_TYPE_CD
			, enableNA : false
		}, function( resData ) {
			var codeList = resData.rows;
			
			var codeIdArr = new Array();
			var codeNameArr = new Array();
			if( $.fn.ifvmIsNotEmpty( codeList ) ) {
				codeList.forEach(function( codeObj, idx ) {
					codeIdArr.push( ANALYSIS_PREVIEW_CONFIG.PREVIEW_PREFIX + codeObj.codeName );
					codeNameArr.push( codeObj.markName );
					
					ANALYSIS_PREVIEW_CONFIG.EXECUTE_FLAG[ codeObj.codeName ] = true;
				});
			}
			
			$( "#analysisTabContainer" ).ifvsfTab({
				tabId : codeIdArr
				, msgCode : codeNameArr
				, itemActive: function( args ) {
					// Tab 클릭시 설정
					var targetTag = $( args.activeHeader ).find( "a" );
					var targetTagAtrib = targetTag.attr( "href" );
					
					if( targetTagAtrib.indexOf( "CHART" ) > -1 ) {
						if( ANALYSIS_PREVIEW_CONFIG.EXECUTE_FLAG.CHART === true ) {
							ANALYSIS_PREVIEW_CONFIG.EXECUTE_FLAG.CHART = false;

							getShowAnalysisData( "CH" );
						}
					} else if( targetTagAtrib.indexOf( "TABLE" ) > -1 ) {
						if( ANALYSIS_PREVIEW_CONFIG.EXECUTE_FLAG.TABLE === true ) {
							ANALYSIS_PREVIEW_CONFIG.EXECUTE_FLAG.TABLE = false;

							getShowAnalysisData( "TA" );
						}
					} else {
						
					}
				}
			});
		});
	});
</script>

<div class="pop_inner_wrap">
	<div id="analysisTabContainer"></div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisPreviewCloseBtn">
		<i class="glyphicon glyphicon-check"></i> <spring:message code="C00039" />
	</button>
</div>

<script id="analysisPreviewTemplate" type="text/x-jquery-tmpl">
	<div class="dashboard_box_type1">
		<div class="header_chart">
			<p class="tit_chart"></p>
			<span class="icon_area">
				<a id="${'${'}targetPopupTagId}"><i class="fa fa-cog"></i></a>
			</span>
		</div>
		<div class="chart_area" id="${'${'}targetTagId}"></div>
	</div>
</script>