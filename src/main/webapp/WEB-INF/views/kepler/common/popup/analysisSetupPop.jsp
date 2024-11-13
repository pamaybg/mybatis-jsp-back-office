<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<script type="text/javascript">
	var ANALYSIS_SETUP_CONFIG = {};
	ANALYSIS_SETUP_CONFIG.THIS_OBJ = null;
	ANALYSIS_SETUP_CONFIG.PROMPT_LIST = null;
	ANALYSIS_SETUP_CONFIG.COLUMN_LIST = null;

	ANALYSIS_SETUP_CONFIG.PROMPT_TYPE_CD = {};
	ANALYSIS_SETUP_CONFIG.PROMPT_TYPE_CD.LIST_BOX = "LIST_BOX";
	ANALYSIS_SETUP_CONFIG.PROMPT_TYPE_CD.DATE = "DATE";
	ANALYSIS_SETUP_CONFIG.PROMPT_TYPE_CD.DATE_BETWEEN = "DATE_BETWEEN";

	var setAnalysisSetupDetail = function(analysisObj) {
		ANALYSIS_SETUP_CONFIG.THIS_OBJ = analysisObj;
		var promptFlag = analysisObj.promptFlag;
		var fieldGroupFlag = analysisObj.fieldGroupFlag;

		if (Boolean(promptFlag)) {
			getPromptList(analysisObj);
		} else {
			$("#promptArea").remove();
		}

		if (Boolean(fieldGroupFlag)) {
			getColumnList(analysisObj);
		} else {
			$("#columnGroupArea").remove();
		}
	};

	var getPromptList = function(analysisObj) {
		$.ifvSyncPostJSON("<ifv:action name='getAnalysisSetupPromptList' />", {
			rptId : analysisObj.analysisId,
			instFlag : analysisObj.instFlag
		}, function(rst) {
			ANALYSIS_SETUP_CONFIG.PROMPT_LIST = rst;

			var target = $("#promptSelectBoxArea");
			var tmpl = $("#dashboardRptPromptListTemplate").tmpl(rst);
			target.append(tmpl);
			$("#promptSelectBoxArea span").click(function() {
				var targetIdx = $(this).closest(".control_content").index();
				var targetObj = $(this).closest(".row").children("label").data();
				targetObj.targetId = $(this).closest(".row").children("label").attr("id");
				targetObj.targetIdx = targetIdx;

				showSetupPromptValuePop(targetObj);
			});

			ANALYSIS_SETUP_CONFIG.PROMPT_LIST.forEach(function(thisObj, idx) {
				var target = $("#" + thisObj.promptAlias);
				target.data("atribGroupColumnId", thisObj.atribGroupColumnId);
				target.data("tableAliasColumnName", thisObj.tableAliasColumnName);
				target.data("promptTypeCode", thisObj.promptTypeCode);

				var promptValueList = thisObj.promptValueList;
				if ($.fn.ifvmIsNotEmpty(promptValueList)) {
					var itemTmpl = $("#dashboardRptPromptListItemTemplate").tmpl(promptValueList);

					var thisTarget = target.parent().find("select");
					thisTarget.append("<option></option>");
					thisTarget.append(itemTmpl);
				}
			});

			var promptDataList = analysisObj.promptDataList;
			if ($.fn.ifvmIsNotEmpty(promptDataList)) {
				promptDataList.forEach(function(promptDataObj, idx) {
					var promptTypeCode = promptDataObj.promptTypeCode;
					var promptValue = promptDataObj.promptValue;
					var promptAlias = promptDataObj.promptAlias;

					promptValue = promptValue.replaceAll("'", "");

					var targetList = $("#" + promptAlias).parent().find("select, input");

					if (ANALYSIS_SETUP_CONFIG.PROMPT_TYPE_CD.DATE_BETWEEN === promptTypeCode) {
						var andIdx = promptValue.indexOf(" AND ");
						var preValue = promptValue.substring(0, andIdx);
						var postValue = promptValue.substring(andIdx + " AND ".length);

						targetList.eq(0).val(preValue);
						targetList.eq(1).val(postValue);
					} else {
						targetList.val(promptValue);
					}
				});
			}
		});
	};

	var showSetupPromptValuePop = function(targetObj) {
		var promptDateValuePop = $("#promptDateValuePop");
		var tempPopObj = null;

		if (!$.fn.ifvmIsNotEmpty(promptDateValuePop)) {
			tempPopObj = $( "<div class='popup_container' />" );
			tempPopObj.attr("id", "promptDateValuePop");
		} else {
			tempPopObj = promptDateValuePop;
		}

		var externalFlag = ANALYSIS_SETUP_CONFIG.THIS_OBJ.externalFlag;
		var targetUrl = null;
		if ($.fn.ifvmIsNotEmpty(externalFlag) && externalFlag === true) {
			targetUrl = "<ifv:url name='externalAnalysisSetupPromptPop' />";
			targetObj.externalFlag = externalFlag;
		} else {
			targetUrl = "<ifv:url name='analysisSetupPromptPop' />";
			targetObj.externalFlag = false;
		}

		tempPopObj.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : targetUrl,
			contentType : "ajax",
			title : "<spring:message code='M01476' />",
			ajaxSuccess : function(args) {
				getAnalysisSetupPromptValueList(targetObj);
			}
		});
	};

	var setAnalysisSetupPromptValueSave = function(targetId, targetIdx, promptValue) {
		$("#" + targetId).closest(".row").children("div").children().eq(targetIdx).find("input").val(promptValue);

		$("#promptDateValuePop").data("ejDialog").close();
	};

	var getColumnList = function(analysisObj) {
		$.ifvSyncPostJSON("<ifv:action name='getAnalysisSetupColumnList' />", {
			rptId : analysisObj.analysisId,
			instFlag : analysisObj.instFlag
		}, function(rst) {
			ANALYSIS_SETUP_CONFIG.COLUMN_LIST = rst;

			var tmpl = $("#dashboardRptColumnListTemplate").tmpl(rst);
			$("#columnSelectBox").append("<option></option>");
			$("#columnSelectBox").append(tmpl);
		});
	};

	var getAnalysisSetupDetail = function(_this) {
		var popupObject = $(_this).closest(".popup_container");
		popupObject.data("dataFlag", true);

		var promptArea = $("#promptSelectBoxArea");
		var promptDataMap = new Object();

		// 선택한 프롬프트 리스트 설정
		if ($.fn.ifvmIsNotEmpty(promptArea)) {
			var promptList = $("#promptSelectBoxArea").children();

			$.each(promptList, function(idx, thisObj) {
				var target = $(thisObj);
				var labelTarget = target.find("label");
				var selectTarget = target.find("select, input");
				
				var promptAlias = labelTarget.attr("id");

				var dataObj = {
					atribGroupColumnId : labelTarget.data("atribGroupColumnId"),
					tableColumnAlias : labelTarget.data("tableAliasColumnName"),
					promptAlias : promptAlias,
					promptTypeCode : labelTarget.data("promptTypeCode"),
					promptFlag : false
				};

				if (selectTarget.length > 1) {
					var preValue = selectTarget.eq(0).val();
					var postValue = selectTarget.eq(1).val();

					var preValueFlag = $.fn.ifvmIsNotEmpty(preValue);
					var postValueFlag = $.fn.ifvmIsNotEmpty(postValue);

					var selectTargetValue = null;

					// 둘 다 선택한 경우
					if (preValueFlag === true && postValueFlag === true) {
						selectTargetValue = "'" + preValue + "' AND '" + postValue + "'";
						dataObj.promptValue = selectTargetValue;

						promptDataMap[promptAlias] = dataObj;
						// 둘 중 시작일만 선택한 경우
					}
				} else {
					var selectTargetValue = selectTarget.val();

					if ($.fn.ifvmIsNotEmpty(selectTargetValue)) {
						selectTargetValue = "'" + selectTargetValue + "'";
						dataObj.promptValue = selectTargetValue;

						promptDataMap[promptAlias] = dataObj;
					}
				}
			});
		}

		var columnGroupArea = $("#columnGroupArea");
		var columnId = null;

		if ($.fn.ifvmIsNotEmpty(columnGroupArea)) {
			columnId = $("#columnSelectBox").val();
		}

		var thisObj = ANALYSIS_SETUP_CONFIG.THIS_OBJ;
		var targetObj = $.extend(thisObj, {
			promptDataMap : promptDataMap,
			fieldGroupColumnId : columnId,
			setupFlag : true
		});
		delete ANALYSIS_SETUP_CONFIG;

		// $.fn.KPRAnalysisCreateReport(targetObj);
		popupObject.data("analysisData", targetObj);
		popupObject.data("ejDialog").close();
	};

	$(document).ready(function() {
		$("#btnConfirm").click(function(evt) {
			getAnalysisSetupDetail(this);
		});

		$("#btnCancel").click(function(evt) {
			delete ANALYSIS_SETUP_CONFIG;
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("dataFlag", false);
			popupObject.data("ejDialog").close();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div id="promptArea">
		<header class="temp_title_bb"> Prompt </header>
		<div id="promptSelectBoxArea" class="analysis_setup_prompt form-horizontal"></div>
	</div>

	<div id="columnGroupArea">
		<header class="temp_title_bb"> Field Group </header>

		<div class="row qt_border">
			<div class="col-xs-12 control_content">
				<ifv:input type="select" id="columnSelectBox" names="columnSelectBox" />
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnConfirm">
		<spring:message code="C00039" />
	</button>

	<button class="btn btn-sm btn_lightGray2" id="btnCancel">
		<spring:message code="C00040" />
	</button>
</div>

<script id="dashboardRptColumnListTemplate" type="text/x-jquery-tmpl">
<option value=${'${'}columnId}>${'${'}columnDisplayName}</option>
</script>

<script id="dashboardRptPromptListTemplate" type="text/x-jquery-tmpl">
<div class="row qt_border">	
	<label id=${'${'}promptAlias} class="col-xs-2 control-label text-right">${'${'}atribGroupColumnName}</label>
	<div class="col-xs-10 control_content">
	{{if promptTypeCode == "DATE_BETWEEN"}}
		<div class="col-sm-6 control_content col-lg-6 pd0 cal_frt">
			<div class="input-group">
				<input type="text" class="form-control" readonly="readonly">
				<span style="cursor: pointer" class="input-group-addon searchDateFuncBtn">
					<i class="fa fa-search"></i>
				</span>
			</div>
		</div>
		<div class="col-sm-1 swung_dash">
			<label>~</label>
		</div>
		<div class="col-sm-6 control_content col-lg-6 pd0 cal_scd">
			<div class="input-group">
				<input type="text" class="form-control" readonly="readonly">
				<span style="cursor: pointer" class="input-group-addon searchDateFuncBtn">
					<i class="fa fa-search"></i>
				</span>
			</div>
		</div>
	{{else promptTypeCode == "DATE"}}
		<div class="col-sm-12 control_content pd0">
			<div class="input-group">
				<input type="text" class="form-control" readonly="readonly">
				<span style="cursor: pointer" class="input-group-addon searchDateFuncBtn">
					<i class="fa fa-search"></i>
				</span>
			</div>
		</div>
	{{else}}
			<ifv:input type="select" />
	{{/if}}
	</div>
</div>
</script>

<script id="dashboardRptPromptListItemTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}promptValue}">${'${'}promptValue}</option>
</script>