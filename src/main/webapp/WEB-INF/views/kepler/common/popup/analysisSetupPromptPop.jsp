<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<script type="text/javascript">
	var ANALYSIS_SETUP_PROMPT_CONFIG = {};
	ANALYSIS_SETUP_PROMPT_CONFIG.TARGET_ID = null;
	ANALYSIS_SETUP_PROMPT_CONFIG.ATRIB_GROUP_COLUMN_ID = null;
	ANALYSIS_SETUP_PROMPT_CONFIG.TARGET_INDEX = null;
	
	var promptDateValueList = null;
	var getAnalysisSetupPromptValueList = function( thisObj ) {
		ANALYSIS_SETUP_PROMPT_CONFIG.TARGET_ID = thisObj.targetId;
		ANALYSIS_SETUP_PROMPT_CONFIG.ATRIB_GROUP_COLUMN_ID = thisObj.atribGroupColumnId;
		ANALYSIS_SETUP_PROMPT_CONFIG.TARGET_INDEX = thisObj.targetIdx;
		
		var externalFlag = thisObj.externalFlag;
		var targetUrl = null;
		if( $.fn.ifvmIsNotEmpty( externalFlag ) && externalFlag === true ) {
			targetUrl = "<ifv:action name='getExternalAttributeGroupColumnValueList' />";
		} else {
			targetUrl = "<ifv:action name='getAnalysisAtribGroupColumnValueList' />";
		}
		
		var jqGridOptions = {
			url: targetUrl
			, serializeGridData : function( data ) {
				data.atribGroupColumnId = ANALYSIS_SETUP_PROMPT_CONFIG.ATRIB_GROUP_COLUMN_ID;
				data.analysisMasterFlag = "Y";
				data.pagingFlag = true;
			}
			, colNames: [
				"<spring:message code='M01233' />"
			]
			, colModel: [
				{ name:"colValue", index:"colValue", width: "200px", align: "center", resizable : false }
			]
			, sortname: "1"
			, sortorder: "desc"
			, radio: true
			, tempId: "ifvGridOriginTemplete"
		};
		
		promptDateValueList = $( "#promptDateValueList" ).ifvGrid({
			jqGridOption: jqGridOptions
		});
	};
	
	var setAnalysisSetupPromptValuePopSave = function() {
		var checkedList = promptDateValueList.getCheckedList();

		if( $.fn.ifvmIsNotEmpty(checkedList) ) {
			var colValue = checkedList[0].colValue;
			var targetId = ANALYSIS_SETUP_PROMPT_CONFIG.TARGET_ID;
			var targetIdx = ANALYSIS_SETUP_PROMPT_CONFIG.TARGET_INDEX;
			
			delete ANALYSIS_SETUP_PROMPT_CONFIG;

			setAnalysisSetupPromptValueSave( targetId, targetIdx, colValue );
		} else {
			alert( "<spring:message code='M00004' />" );	
		}
	};
	
	$( document ).ready(function() {
		$( "#promptDateValueChoiceBtn" ).click(function() {
			setAnalysisSetupPromptValuePopSave();
		});

		$( "#promptDateValueCancelBtn" ).click(function() {
			$( "#promptDateValuePop" ).data( "ejDialog" ).close();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div id="promptDateValueList" class="grid_bd0 con_size"></div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="promptDateValueChoiceBtn">
		<i class="glyphicon glyphicon-check"></i> <spring:message code="C00038" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="promptDateValueCancelBtn"><spring:message code="C00040" /></button>
</div>