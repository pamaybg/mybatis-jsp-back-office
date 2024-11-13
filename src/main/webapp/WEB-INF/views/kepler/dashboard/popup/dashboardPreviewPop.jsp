<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/analysisTools.jsp" />

<script type="text/javascript">
	var DASHBOARD_PREVIEW_CONFIG = {};
	DASHBOARD_PREVIEW_CONFIG.DASHBOARD_ID = null;
	DASHBOARD_PREVIEW_CONFIG.PUBLISH_FLAG = true;
	DASHBOARD_PREVIEW_CONFIG.ANALYSIS_SETUP_BTN_LAYOUT = "<i class='fa fa-cog'></i>";

	DASHBOARD_PREVIEW_CONFIG.DASHBOARD_PREVIEW_POP_ID = null;
	DASHBOARD_PREVIEW_CONFIG.ANALYSIS_MASTER_FLAG = "N";
	DASHBOARD_PREVIEW_CONFIG.PREVIEW_PREFIX = "preview_";

	var getDashboardPreviewDetail = function(targetObj) {
		DASHBOARD_PREVIEW_CONFIG.DASHBOARD_ID = targetObj.dashboardId;
		DASHBOARD_PREVIEW_CONFIG.ANALYSIS_MASTER_FLAG = targetObj.analysisMasterFlag;
		DASHBOARD_PREVIEW_CONFIG.DASHBOARD_PREVIEW_POP_ID = targetObj.dashboardPreviewPopId;

		$.ifvPostJSON("<ifv:action name='getPublishDashboardDetail' />", {
			dashboardId : DASHBOARD_PREVIEW_CONFIG.DASHBOARD_ID,
			analysisMasterFlag : DASHBOARD_PREVIEW_CONFIG.ANALYSIS_MASTER_FLAG
		}, function(resData) {
			$("#dashboardData").data("dashboardData", resData);
			// 대시보드 프롬프트 설정
			var dashboardPromptList = resData.dashboardPromptList;
			if ($.fn.ifvmIsNotEmpty(dashboardPromptList)) {
				// Row를 분리해야하는지 체크값
				var rowCount = null;
				var rowDivList = new Array();

				// 템플릿 생성
				$.each(dashboardPromptList, function(dataIdx, dataObject) {
					var dashboardPromptTemplate = $("#dashboardPromptTemplate").tmpl(dataObject);
					dashboardPromptTemplate.data("promptData", dataObject);

					var tempRowDiv = null;
					if ($.fn.ifvmIsEmpty(rowCount)) {
						rowCount = 0;
						rowCount++;
						tempRowDiv = $("<div class='row qt_border' />");
						rowDivList.push(tempRowDiv);
					} else if (Math.floor(dataIdx / 3) === rowCount) {
						rowCount++;
						tempRowDiv = $("<div class='row qt_border' />");
						rowDivList.push(tempRowDiv);
					} else {
						tempRowDiv = rowDivList[rowCount - 1];
					}

					tempRowDiv.append(dashboardPromptTemplate);
				});

				// DATE_BETWEEN, DATE 일 시 이벤트 설정
				$("#dashboardPromptArea").append(rowDivList);
				$("#dashboardPromptArea span").click(function(evt) {
					var thisIdx = $(this).closest(".control_content").index();
					thisIdx = thisIdx === 2 ? 1 : 0;

					var thisObject = $(this).closest(".promptData").prev().data("promptData");
					thisObject.thisIdx = thisIdx;

					showDashboardSetupPromptPop(thisObject);
				});

				// LIST_BOX 인 경우 data Value 설정
				$.each(dashboardPromptList, function(dataIdx, dataObject) {
					var promptTypeCode = dataObject.promptTypeCode;
					if (promptTypeCode === "LIST_BOX") {
						var upperPromptId = dataObject.upperPromptId;
						var lowerChangFlag = false;
						if ($.fn.ifvmIsNotEmpty(upperPromptId)) {
							var upperPromptData = $("#" + upperPromptId).data("promptData");
							var upperPromptTypeCode = upperPromptData.promptTypeCode;

							if (upperPromptTypeCode === "LIST_BOX") {
								$("#" + upperPromptId).next().find("select").change({
									promptData : dataObject
								}, function(evt) {
									var promptData = evt.data.promptData;
									var upperPromptData = $(this).parent().prev().data("promptData");
									var upperPromptValue = $(this).val();

									promptData.upperColumnId = upperPromptData.columnId;
									promptData.conditionValue = upperPromptValue;
									setPromptValueList(promptData);
								});

								lowerChangFlag = true;
							}
						}

						if (lowerChangFlag === false) {
							setPromptValueList(dataObject);
						}
					} else {
						var promptId = dataObject.promptId;
						var promptValue1CodeName = dataObject.promptValue1CodeName;
						var promptValue2CodeName = dataObject.promptValue2CodeName;

						if ($.fn.ifvmIsNotEmpty(promptValue1CodeName)) {
							$("#" + promptId).next().find("input").eq(0).val(promptValue1CodeName);
						}

						if ($.fn.ifvmIsNotEmpty(promptValue2CodeName)) {
							$("#" + promptId).next().find("input").eq(1).val(promptValue2CodeName);
						}
					}
				});
			} else {
				$("#dashboardPromptArea").parent().remove();
			}

			var layoutHtml = resData.layoutHtml;
			$("#dashboardAreaPreview").append(layoutHtml);
			$("#dashboardAreaPreview .icon_area").append(DASHBOARD_PREVIEW_CONFIG.ANALYSIS_SETUP_BTN_LAYOUT);
			$("#dashboardAreaPreview .icon_area").click(function(evt) {
				var analysisData = $(this).closest("[class^='dashboard_box_type']").find(".chart_area").children().data("analysisData");
				var targetId = analysisData.targetId;

				$.fn.KPRAnalysisSettingPop({
					targetId : targetId,
					instFlag : DASHBOARD_PREVIEW_CONFIG.ANALYSIS_MASTER_FLAG === "Y" ? "ORIGINAL" : "INSTANCE",
					publishFlag : DASHBOARD_PREVIEW_CONFIG.PUBLISH_FLAG
				}, showAnalysisDetail);
			});

			var analysisList = resData.analysisList;
			if ($.fn.ifvmIsNotEmpty(analysisList)) {
				$.each(analysisList, function(dataIdx, dataObject) {
					var targetHtml = $("#dashboardAreaPreview").children().eq(dataIdx);
					var thisId = dataObject.analysisId;
					var thisName = dataObject.analysisName;
					var thisEmbedType = dataObject.dashboardEmbedType;

					targetHtml.find("p[id*='" + (dataIdx + 1) + "']").text(thisName);
					var targetHtmlId = targetHtml.find("div[id*='" + (dataIdx + 1) + "']").attr("id");
					targetHtmlId = DASHBOARD_PREVIEW_CONFIG.PREVIEW_PREFIX + targetHtmlId;
					targetHtml.find("div[id*='" + (dataIdx + 1) + "']").attr("id", targetHtmlId);

					var targetObj = {
						targetId : targetHtmlId,
						analysisId : thisId,
						analysisMasterFlag : DASHBOARD_PREVIEW_CONFIG.ANALYSIS_MASTER_FLAG === "Y" ? "Y" : "N",
						analysisTypeCode : thisEmbedType,
						publishFlag : DASHBOARD_PREVIEW_CONFIG.PUBLISH_FLAG,
						previewFlag : "PREVIEW"
					};

					$("#" + targetHtmlId).data("analysisId", thisId);
					$("#" + targetHtmlId).data("dashboardEmbedType", thisEmbedType);
					$("#" + targetHtmlId).data("analysisData", targetObj);

					showAnalysisDetail(targetObj);
				});
			}
		});
	};

	var showAnalysisDetail = function(analysisData) {
		var dashboardPromptDataObject = new Object();
		var dashboardPromptDataMap = new Array();
		var dashboardPromptList = $("#dashboardPromptArea").find("select, input");
		if ($.fn.ifvmIsNotEmpty(dashboardPromptList)) {
			$.each(dashboardPromptList, function(dataIdx, dataObject) {
				var thisValue = $(dataObject).val();

				if ($.fn.ifvmIsNotEmpty(thisValue)) {
					var promptData = $(dataObject).closest(".promptData").prev().data("promptData");

					var promptId = promptData.promptId;
					if ($.fn.ifvmIsEmpty(dashboardPromptDataObject[promptId])) {
						promptData.promptValue = "'" + thisValue + "'";
						dashboardPromptDataObject[promptId] = promptData;
					} else {
						var tempValue = dashboardPromptDataObject[promptId].promptValue;
						tempValue += " AND '" + thisValue + "'";

						promptData.promptValue = tempValue;
						dashboardPromptDataObject[promptId] = promptData;
					}
				}
			});

			var dashboardPromptList = $("#dashboardData").data("dashboardData").dashboardPromptList;
			$.each(dashboardPromptList, function(dataIdx, dataObject) {
				var promptId = dataObject.promptId;
				var dashboardPromptData = dashboardPromptDataObject[promptId];

				if ($.fn.ifvmIsNotEmpty(dashboardPromptData)) {
					dashboardPromptDataMap.push(dashboardPromptData);
				}
			});

			analysisData.dashboardPromptDataMap = dashboardPromptDataMap;
		}

		$.fn.KPRAnalysisCreateReport(analysisData);
		var targetId = analysisData.targetId;
		$("#" + targetId).css("background", "#ffffff");
	};

	var setPromptValueList = function(promptData) {
		var promptId = promptData.promptId;
		var upperColumnId = $.fn.ifvmIsNotEmpty(promptData.upperColumnId) ?  promptData.upperColumnId : null;
		var conditionValue = $.fn.ifvmIsNotEmpty(promptData.conditionValue) ? promptData.conditionValue : null;

		$.ifvPostJSON("<ifv:action name='getCommonColumnValueList' />", {
			columnId : promptData.columnId,
			upperColumnId : upperColumnId,
			conditionValue : conditionValue,
			pagingFlag : false
		}, function(resData) {
			var dataList = resData.rows;
			var dashboardPromptDataTemplate = $("#dashboardPromptDataTemplate").tmpl(dataList);

			$("#" + promptId).next().find("select").empty();
			$("#" + promptId).next().find("select").append("<option value=''>전체</option>");
			$("#" + promptId).next().find("select").append(dashboardPromptDataTemplate);
		});
	};

	var showDashboardSetupPromptPop = function(promptData) {
		var promptSetupPromptPopId = "promptSetupPromptPop";
		var promptSetupPromptPop = $("#" + promptSetupPromptPopId);

		if ($.fn.ifvmIsEmpty(promptSetupPromptPop)) {
			promptSetupPromptPop = $("<div class='popup_container' />");
			promptSetupPromptPop.attr("id", promptSetupPromptPopId);
		}

		promptSetupPromptPop.data("promptData", promptData);
		promptSetupPromptPop.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='dashboardSetupPromptPop' />",
			contentType : "ajax",
			title : "<spring:message code='M01476' />",
			ajaxSuccess : function(args) {
				setDashboardSetupPromptValueList(promptData);
			},
			beforeClose : function(args) {
				var dataFlag = promptSetupPromptPop.data("dataFlag");

				if ($.fn.ifvmIsNotEmpty(dataFlag) && dataFlag) {
					var promptData = promptSetupPromptPop.data("promptData");
					var promptId = promptData.promptId;
					var thisIdx = promptData.thisIdx;

					var promptValue = promptSetupPromptPop.data("promptValue");
					$("#" + promptId).next().find("input").eq(thisIdx).val(promptValue);
				}
			}
		});
	};

	$(document).ready(function() {
		$("#dashboardExecute").click(function(evt) {
			var analysisList = $("#dashboardAreaPreview").find("[class^='dashboard_box_type'] .chart_area");
			if ($.fn.ifvmIsNotEmpty(analysisList)) {
				$.each(analysisList, function(dataIdx, dataObject) {
					var analysisData = $(dataObject).data("analysisData");
					showAnalysisDetail(analysisData);
				});
			}
		});

		$("#dashboardPreviewCloseBtn").click(function(evt) {
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("ejDialog").close();
		});
	});
</script>

<div class="pop_inner_wrap" id="dashboardData">
	<div class="well form-horizontal well_bt5">
		<div id="dashboardPromptArea"></div>
	</div>

	<div class="analysis_wrap">
		<div class="dashboard_area" id="dashboardAreaPreview"></div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="dashboardExecute">
		<spring:message code="M00603" />
	</button>

	<button class="btn btn-sm btn_gray" id="dashboardPreviewCloseBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
</div>

<script id="dashboardPromptTemplate" type="text/x-jquery-tmpl">
<div class="col-xs-1 control-label text-right" id="\${promptId}">
	\${displayName}
</div>
<div class="col-xs-3 promptData">
{{if promptTypeCode == "DATE_BETWEEN"}}
	<div class="col-sm-6 control_content col-lg-6 pd0 cal_frt">
		<div class="input-group">
			<input type="text" class="form-control">
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
			<input type="text" class="form-control">
			<span style="cursor: pointer" class="input-group-addon searchDateFuncBtn">
				<i class="fa fa-search"></i>
			</span>
		</div>
	</div>
{{else promptTypeCode == "DATE"}}
	<div class="col-sm-12 control_content pd0">
		<div class="input-group">
			<input type="text" class="form-control">
			<span style="cursor: pointer" class="input-group-addon searchDateFuncBtn">
				<i class="fa fa-search"></i>
			</span>
		</div>
	</div>
{{else}}
	<ifv:input type="select" />
{{/if}}
</div>
</script>

<script id="dashboardPromptDataTemplate" type="text/x-jquery-tmpl">
<option value="{{= $data}}">{{= $data}}</option>
</script>