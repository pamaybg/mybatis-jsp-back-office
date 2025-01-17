<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/js/marketing/diagram/css/diagramStyle.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/analysisTools.jsp" />

<div class="page-title">
	<h1>
		<spring:message code="M01532" />
	</h1>
</div>

<div class="page_btn_area" id="dashboardData">
	<div class="col-xs-7">
		<span id="dashboardName"></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="dashboardExecute">
			<spring:message code="M00603" />
		</button>
	</div>
</div>

<div class="well form-horizontal well_bt5">
	<div id="dashboardPromptArea"></div>

	<div class="row qt_border">
		<div class="col-xs-12">
			<div class="col-xs-2"></div>
			<div class="col-xs-10" id="analyslsListArea"></div>
		</div>
	</div>
</div>

<div class="dashboard_area">
	<div class="dashboard_box_type1">
		<div class="header_chart">
			<p class="tit_chart" id="analysisName"></p>

			<span class="icon_area" id="analysisSetting"> <i class="fa fa-cog"></i>
			</span>
		</div>
		<div class="chart_area" id="analysisView"></div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		/**
		 * 01. 화면에 보여줄 대시보드 아이디 설정
		 * */
		var dashboardId = "";

		showDashboardDetail(dashboardId);

		$("#dashboardExecute").click(function(evt) {
			var analysisData = $("#analyslsListArea").find("input[type='radio']:checked").closest("div[id]").data("analysisData");

			showAnalysisDetail(analysisData);
		});
	});

	var showDashboardDetail = function(dashboardId) {
		$.ifvPostJSON("<ifv:action name='getPublishDashboardDetail' />", {
			dashboardId : dashboardId,
			analysisMasterFlag : "Y"
		}, function(resData) {
			$("#dashboardData").data("dashboardData", resData);
			// 대시보드 명 설정
			var dashboardName = resData.dashboardName;
			$("#dashboardName").text(dashboardName);

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

				$("#dashboardPromptArea").next().children().addClass("search_condition_top");
			}

			// 분석 리스트 설정
			var analyslsListArea = $("#analyslsListArea");
			var analysisList = resData.analysisList;
			if ($.fn.ifvmIsNotEmpty(analysisList)) {
				var firstAnalysisId = null;

				$.each(analysisList, function(dataIdx, dataObject) {
					var analysisId = dataObject.analysisId;
					var analysisEmbedType = dataObject.dashboardEmbedType;

					var analysisData = {
						targetId : "analysisView",
						analysisId : analysisId,
						analysisMasterFlag : "Y",
						analysisTypeCode : analysisEmbedType,
						publishFlag : true
					};

					if (analysisEmbedType === "TABLE") {
						/**
						 * 02. 실제 TABLE 형태의 분석에서 Value 값을 클릭 했을 때 실행될 함수 추가
						 * */
						 analysisData.valueCellClick = valueCellClick;
					}

					var analysisRadioTemplate = $("#analysisRadioTemplate").tmpl(dataObject);
					if (dataIdx === 0) {
						analysisRadioTemplate.find("input[type='radio']").prop("checked", true);
						firstAnalysisId = analysisId;
					}

					analysisRadioTemplate.click(analysisRadioClick);
					analysisRadioTemplate.data("analysisData", analysisData);
					analyslsListArea.append(analysisRadioTemplate);
				});

				if ($.fn.ifvmIsNotEmpty(firstAnalysisId)) {
					$("#" + firstAnalysisId).trigger("click");
				}
			}
		});
	};

	var analysisRadioClick = function(evt) {
		var analysisData = $(this).data("analysisData");

		$("#analysisView").empty();
		$("#analyslsListArea input[type='radio']").prop("checked", false);
		$("#" + analysisData.analysisId + " input[type='radio']").prop("checked", true);

		showAnalysisDetail(analysisData);
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
		$("#analysisView").css("background", "#ffffff");

		$("#analysisSetting").unbind("click");
		$("#analysisSetting").click({
			analysisData : analysisData
		}, function(evt) {
			var analysisData = evt.data.analysisData;

			$.fn.KPRAnalysisSettingPop({
				targetId : analysisData.targetId,
				instFlag : "ORIGINAL",
				publishFlag : true
			}, showAnalysisDetail);
		});
	};

	var setPromptValueList = function(promptData) {
		var promptId = promptData.promptId;
		var upperColumnId = $.fn.ifvmIsNotEmpty(promptData.upperColumnId) ? promptData.upperColumnId : null;
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
			$("#" + promptId).next().find("select").append("<option />");
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
	
	/**
	 * 03. Value 를 클릭 했을 시 실행되는 함수.
	 * */
	var valueCellClick = function(clickDataObject) {
		// clickDataObject로 넘어오는 데이터를 확인하여 데이터 처리 후 팝업 호출
	};
</script>

<script id="analysisRadioTemplate" type="text/x-jquery-tmpl">
<div class="col-xs-2" id="\${analysisId}">
	<label class="radio-inline">
		<input type="radio">\${analysisName}
	</label>
</div>
</script>

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