<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var PROMPT_DATE_CONFIG = {};
	PROMPT_DATE_CONFIG.TARGET_ID = null;

	var analysisPromptDateFuncListGrid = null;
	var setPromptDateFuncList = function( targetIdx ) {
		if( !$.fn.ifvmIsNotEmpty( targetIdx ) || targetIdx === 0 ) {
			
			var	jqGridOptions = {
				serializeGridData : function( data ) {
					data.atribGroupColumnId = PROMPT_CONFIG.ATRIB_GROUP_COLUMN_ID;
					data.pagingFlag = true;
				}
			    ,url: "<ifv:action name='getAnalysisAtribGroupColumnValueList'/>"
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
		} else {
		 	var jqGridOptions = {
				url: "<ifv:action name='getCommonDateCodeList' />"
				, colNames: [
					"<spring:message code='M01206' />"
					, "<spring:message code='M01233' />"
					, "<spring:message code='M01725' />"
				]
				, colModel: [
					{ name: "codeName", index: "codeName", resizable: false, align: "center" }
					, { name: "markName", index: "markName", resizable: false, align: "center" }
					, { name: "funcValue", resizable: false, align: "center" }
				]
				, sortname: "seq"
				, sortorder: "asc"
				, radio: true
				, tempId: "ifvGridOriginTemplete"
			};
		}

		analysisPromptDateFuncListGrid = $( "#analysisPromptDateFuncListGrid" ).ifvGrid({
			jqGridOption: jqGridOptions
		});
	};
	
	var setAnalysisPromptDateFuncPopSave = function() {
		if ( $.fn.ifvmIsNotEmpty( analysisPromptDateFuncListGrid.getCheckedList() ) ) {
			var checkedList = analysisPromptDateFuncListGrid.getCheckedList();
			var codeName = "";
			var markName = "";
			
			if( $.fn.ifvmIsNotEmpty( checkedList[0].colValue ) ) {
				codeName = checkedList[0].colValue;
				markName = checkedList[0].colValue;
			} else {
				codeName = checkedList[0].codeName;
				markName = checkedList[0].markName;
			}
			
			setAnalysisPromptDateFuncSave( PROMPT_DATE_CONFIG.TARGET_ID, codeName, markName );
		} else {
			alert( "<spring:message code='M00004' />" );
		}
	};

	$( document ).ready(function() {
		$( "input[name=promptTypeCode]" ).change(function( evt ) {
			var targetIdx = $( this ).closest( "label" ).index();

			setPromptDateFuncList( targetIdx );
		});

		$( "#analysisPromptDateFuncChoiceBtn" ).click(function() {
			setAnalysisPromptDateFuncPopSave();
		});
		
		$( "#analysisPromptDateFuncCancelBtn" ).click(function() {
			$( "#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_DATE_FUNC_POP ).data( "ejDialog" ).close();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div class="">
		<label class="radio-inline">
			<ifv:input type="radio" names="promptTypeCode" values="NON_DATE_FUNC" checked="true" id="promptTypeCode" />
			<spring:message code="M01726" />
		</label>
		<label class="radio-inline">
			<ifv:input type="radio" names="promptTypeCode" values="DATE_FUNC" id="promptTypeCode" />
			<spring:message code="M01727" />
		</label>
	</div>

	<div id="analysisPromptDateFuncListGrid" class="grid_bd0 con_size"></div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisPromptDateFuncChoiceBtn">
		<i class="glyphicon glyphicon-check"></i> <spring:message code="C00038" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisPromptDateFuncCancelBtn"><spring:message code="C00040" /></button>
</div>