<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script src='${pageContext.request.contextPath}/resources/js/jquery.splitter-0.14.0.js' type="text/javascript"></script>

<link href="${pageContext.request.contextPath}/resources/js/kepler/diagram/css/diagramStyle.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<%--  <link rel="stylesheet" type="text/css" media="screen,print" href="${pageContext.request.contextPath}/resources/css/marketing/style.css" />
 --%> 
 
<script src="${pageContext.request.contextPath}/resources/js/kepler/analysis/analysisConfig.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/kepler/analysis/analysisTreeViewConfig.js" type="text/javascript"></script>

<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/analysisTools.jsp" />
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/analyticsExportTools.jsp" />

<style type="text/css">
/*
 * 차트아이콘 타이틀 영역 
 */
.tool_box.chart_box li.chart_title {
	width: 100%;
	height: 23px;
	text-align: left;
	font-weight: bold;
	font-size: 13px;
	background-color: #FFF;
	border-bottom: 1.3px solid #535454;
	margin-top: 5px;
	margin-bottom: 5px;
}
</style>

<script type="text/javascript">
	// 기본 URL 설정, javascript 파일 내에서는 *.tag 설정한 값을 사용할 수 없으므로 별도로 설정
	var ANALYSIS_URL_CONFIG = {};
	ANALYSIS_URL_CONFIG.GET_ANALAYSIS_ATRIB_GROUP_COLUMN_DEATIL = "<ifv:action name='getAnalysisAtribGroupColumnDetail' />";

	ANALYSIS_URL_CONFIG.ADD_ANALYSIS_COLUMN_DETAIL = "<ifv:action name='addAnalysisColumnDetail' />";
	ANALYSIS_URL_CONFIG.EDIT_ANALYSIS_COLUMN_ALL_SEQUENCE = "<ifv:action name='editAnalysisColumnAllSequence' />";
	ANALYSIS_URL_CONFIG.EDIT_ANALYSIS_COLUMN_TYPE_CODE_CHANGE = "<ifv:action name='editAnalysisColumnTypeCodeChange' />";
	ANALYSIS_URL_CONFIG.REMOVE_ANALYSIS_COLUMN_DETAIL = "<ifv:action name='removeAnalysisColumnDetail' />";

	ANALYSIS_URL_CONFIG.ADD_ANALYSIS_PROMPT_DETAIL = "<ifv:action name='addAnalysisPromptDetail' />";
	ANALYSIS_URL_CONFIG.EDIT_ANALYSIS_PROMPT_ALL_SEQUENCE = "<ifv:action name='editAnalysisPromptAllSequence' />";
	ANALYSIS_URL_CONFIG.REMOVE_ANALYSIS_PROMPT_DETAIL = "<ifv:action name='removeAnalysisPromptDetail' />";
	ANALYSIS_URL_CONFIG.EDIT_ANALYSIS_COLUMN_GROUP_FLAG = "<ifv:action name='editAnalysisColumnGroupFlag' />";

	// 분석 데이터 조회 함수
	var getAnalysisData = function() {
		// 1. DATE_KEY_YN 값 체크
		$.ifvPostJSON("<ifv:action name='getAnalysisDateFilterCheck' />", {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID
		}, function(rst) {
			var dateFlag = rst.dateFlag;
			var executeFlag = false;

			// 2. DATE_KEY_YN 값이 0 이거나, 날짜 관련 필터가 존재하면 패스.
			if (dateFlag === true) {
				executeFlag = true;
			} else {
				// 2-1. 날짜 관련 필터가 없다면, 진행 여부 확인
				executeFlag = confirm("<spring:message code='M01711' />");
			}

			// 3. 실행
			if (executeFlag) {
				var targetId = null;
				var analysisTypeFlag = ANALYSIS_CONFIG.ANALYSIS_TYPE_FLAG;
				analysisTypeFlag = $.fn.ifvmIsNotEmpty(analysisTypeFlag) ? analysisTypeFlag : ANALYSIS_CONFIG.ANALYSIS_TOOLS.TABLE;

				if (analysisTypeFlag === ANALYSIS_CONFIG.ANALYSIS_TOOLS.TABLE) {
					targetId = ANALYSIS_CONFIG.ANALYSIS_TOOLS.TABLE;
					ANALYSIS_CONFIG.ANALYSIS_TYPE_FLAG = ANALYSIS_CONFIG.ANALYSIS_TOOLS.TABLE;
					ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE = false;
				} else {
					targetId = ANALYSIS_CONFIG.ANALYSIS_TOOLS.CHART;
					ANALYSIS_CONFIG.ANALYSIS_TYPE_FLAG = ANALYSIS_CONFIG.ANALYSIS_TOOLS.CHART;
					ANALYSIS_CONFIG.EXECUTE_FLAG.CHART = false;
				}

				$.fn.KPRAnalysisCreateReport({
					targetId : targetId,
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					analysisMasterFlag : "N",
					analysisTypeCode : analysisTypeFlag
				}, "getAnalysisDataCallbackFunction");
			}
		});
	};

	// 테이블/차트 생성 후 콜백 함수
	var getAnalysisDataCallbackFunction = function(dataObj) {
		// 제거 필요
		ANALYSIS_CONFIG.ANALYSIS_SQL.BASE_SQL = dataObj.baseSQL;

		if (dataObj.noDataFlag) {
			alert("<spring:message code='M01712' />");
		} else {
			var analysisTypeCode = dataObj.analysisTypeCode;
			if (analysisTypeCode === "CHART") {
				$("#CHART").unbind("resize");
				$("#CHART").resizeEnd(function(targetObj) {
					$.fn.KPRAnalysisPublishChartResize(targetObj.attr("id"));
				});
			}
		}
	};

	// 분석 상세 조회 함수 
	var getAnalysisDetail = function() {
		$.ifvPostJSON("<ifv:action name='getAnalysisDetail' />", {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
		}, function(rst) {
			// 1. 기본 정보 설정, 폴더 아이디, 대시보드 아이디, 로지컬 컴포넌트 아이디, 차트 타입, 필터 갯수
			ANALYSIS_CONFIG.FOLDER_ID = rst.folderId;
			ANALYSIS_CONFIG.DASHBOARD_ID = rst.dashboardId;
			ANALYSIS_CONFIG.LOGICAL_COMP_ID = rst.logicalCompId;
			ANALYSIS_CONFIG.CHART_TYPE_CD = rst.chartType;
			ANALYSIS_CONFIG.FILTER_COUNT = rst.filterCount;

			// 2. 로지컬 컴포넌트명 설정
			$("#logicalCompName").val(rst.logicalCompName);

			// 3. 분석명이 존재하면 분석명 설정
			if ($.fn.ifvmIsNotEmpty(rst.analysisName)) {
				ANALYSIS_CONFIG.ANALYSIS_NAME = rst.analysisName;

				var analysisName = $("#analysisName").text() + " | " + ANALYSIS_CONFIG.ANALYSIS_NAME;
				$("#analysisName").text(analysisName);
			}

			// 4. 컬럼 그룹 설정
			var columnGroupFlag = rst.columnGroupFlag;
			$("#btnAnalysisFieldGroup").attr("checked", columnGroupFlag === "1" ? true : false);

			// 5. 대시보드 타입이 존재하면, 해당 타입에 따라 탭을 지움.
			var dashboardType = rst.dashboardType;
			if ($.fn.ifvmIsNotEmpty(dashboardType)) {
				var analysisTab = $("#analysisTab");
				var analysisTabData = analysisTab.data("ejTab");
				var removeTarget = $("#analysisTab").find("[id='" + dashboardType + "']").index();

				// index 함수는 1 부터 시작, removeItem 함수는 0부터 시작으므로
				// 차트 타입일 시, 테이블 탭을 지우기 위해서는 인덱스 값에 -2 를 해준다.
				if (ANALYSIS_CONFIG.ANALYSIS_TOOLS.CHART === dashboardType) {
					removeTarget = removeTarget - 2;
				}

				analysisTabData.removeItem(removeTarget);
			}

			// 6. 로지컬 컴포넌트 상세 조회
			getAnalysisLogicalCompDetail();

			// 7. 컬럼, 로우, 프롬프트 리스트 조회
			getAnalysisColumnList();
			getAnalysisRowList();
			getAnalysisPromptList();

			$.ifvProgressControl(false);
		}, function(rst) {
			$.ifvProgressControl(false);
			$.messageCheckr(rst.message);
		});
	};

	// 컬럼 리스트 조회 함수
	var getAnalysisColumnList = function() {
		$.ifvPostJSON("<ifv:action name='getAnalysisColumnList' />", {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			columnUseTypeCode : ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN
		}, function(rst) {
			var measureIdx = -1;
			// 부모 아이디가 Measure 라면 해당 위치값 체크
			rst.forEach(function(nodeObj, idx) {
				if (nodeObj.parNodeId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
					measureIdx = idx;
					return false;
				}
			});

			// Measure 의 위치값이 -1 이 아니라면, 리스트에 Measure 헤더 노드 추가
			if (measureIdx !== -1) {
				rst.splice(measureIdx, 0, getParentMeasureNode());
			}

			var columnTree = $("#columnTree").data("ejTreeView");
			columnTree.dataSource(rst);
			columnTree.refresh();
		});
	};

	var getAnalysisRowList = function() {
		$.ifvPostJSON("<ifv:action name='getAnalysisColumnList' />", {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			columnUseTypeCode : ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW
		}, function(rst) {
			var measureIdx = -1;
			rst.forEach(function(nodeObj, idx) {
				if (nodeObj.parNodeId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
					measureIdx = idx;
				}
			});

			if (measureIdx !== -1) {
				rst.splice(measureIdx, 0, getParentMeasureNode());
			}

			var rowTree = $("#rowTree").data("ejTreeView");
			rowTree.dataSource(rst);
			rowTree.refresh();
		});
	};

	var getAnalysisPromptList = function() {
		$.ifvPostJSON("<ifv:action name='getAnalysisPromptList' />", {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID
		}, function(rst) {
			var promptTree = $("#promptTree").data("ejTreeView");
			promptTree.dataSource(rst);
			promptTree.refresh();
		});
	};

	var getAnalysisLogicalCompDetail = function() {
		$.ifvPostJSON("<ifv:action name='getLogicalComponentTreeList' />", {
			logicalCompId : ANALYSIS_CONFIG.LOGICAL_COMP_ID
		}, function(rst) {
			if (rst.length > 0) {
				var atribGroupColumnList = $("#atribGroupColumnList");
				var accordionData = atribGroupColumnList.data("ejAccordion");

				if ($.fn.ifvmIsNotEmpty(accordionData)) {
					accordionData.destroy();
					atribGroupColumnList.empty();
				}

				$("#atribGroupColumnList").ifvmCreateAccordionTree("atribGroupColumnList", {
					enableMultipleOpen : true,
					treeOption : {
						allowDragAndDrop : true,
						allowDragAndDropAcrossControl : true,
						allowDropChild : false,
						allowDropSibling : false,
						allowMultiSelection : true,
						nodeDragStop : setAnalysisAtribGroupColumnTreeNodeDragStop,
						nodeDropped : setAnalysisAtribGroupColumnTreeNodeDropped,
						nodeExpand : setAnalysisAttribGroupColumnTreeNodeCollapseExpanded,
						nodeCollapse : setAnalysisAttribGroupColumnTreeNodeCollapseExpanded,
						template : "#ifvAttributeGroupColumnTreeViewTemplate"
					}
				}, rst);
			}
		});
	};

	var logicalCompPopupListClose = function(evt) {
		$("#" + ANALYSIS_CONFIG.POPUP_ID.LOGICAL_COMP_LIST_POP).data("ejDialog").destroy();
	};

	var logicalComponentListPopConfirm = function() {
		if ($.fn.ifvmIsNotEmpty(logicalComponentListGrid.getCheckedList())) {
			var logicalCompId = logicalComponentListGrid.getCheckedList()[0].logicalCompId; //로지컬 컴포넌트 아이디
			var logicalCompName = logicalComponentListGrid.getCheckedList()[0].logicalCompName; //로지컬 컴포넌트명

			if ($.fn.ifvmIsNotEmpty(ANALYSIS_CONFIG.LOGICAL_COMP_ID)) {
				if (ANALYSIS_CONFIG.LOGICAL_COMP_ID !== logicalCompId) {
					$.ifvPostJSON("<ifv:action name='resetAnalysisDetail' />", {
						analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
						logicalCompId : logicalCompId
					}, function(rst) {
					});

					var columnTreeData = $("#columnTree").data("ejTreeView");
					columnTreeData.dataSource(new Array());
					columnTreeData.refresh();

					var rowTreeData = $("#rowTree").data("ejTreeView");
					rowTreeData.dataSource(new Array());
					rowTreeData.refresh();

					var promptTreeData = $("#promptTree").data("ejTreeView");
					promptTreeData.dataSource(new Array());
					promptTreeData.refresh();

					// 로지컬 컴포넌트가 수정되었을 경우
					// 핕터 카운드 0, 타입 플래그 0, 1번째 탭을 쇼, table, chart 하위 태그 지움
					ANALYSIS_CONFIG.FILTER_COUNT = -1;
					$("#analysisTab").data("ejTab").showItem(0);

					var chart = $("#CHART");
					var table = $("#TABLE");

					if ($.fn.ifvmIsNotEmpty(table)) {
						table.empty();
						ANALYSIS_CONFIG.ANALYSIS_TYPE_FLAG = ANALYSIS_CONFIG.ANALYSIS_TOOLS.CHART;
					}

					if ($.fn.ifvmIsNotEmpty(chart)) {
						chart.empty();
						ANALYSIS_CONFIG.ANALYSIS_TYPE_FLAG = ANALYSIS_CONFIG.ANALYSIS_TOOLS.TABLE;
					}
				}
			} else {
				$.ifvPostJSON("<ifv:action name='editAnalysisLogicalCompId' />", {
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					logicalCompId : logicalCompId
				}, function(rst) {
				});
			}

			ANALYSIS_CONFIG.LOGICAL_COMP_ID = logicalCompId;
			$("#logicalCompName").val(logicalCompName);

			getAnalysisLogicalCompDetail();

			$("#" + ANALYSIS_CONFIG.POPUP_ID.LOGICAL_COMP_LIST_POP).data("ejDialog").destroy();
		} else {
			alert("<spring:message code='M01471' />");
		}
	};

	var setAnalysisColumnMeasurePop = function(columnId) {
		var analysisColumnMeasurePop = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_MEASURE_POP);
		var tempPopObj = null;

		if (!$.fn.ifvmIsNotEmpty(analysisColumnMeasurePop)) {
			tempPopObj = $("<div class='popup_container' />");
			tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_MEASURE_POP);
		} else {
			tempPopObj = analysisColumnMeasurePop;
		}

		tempPopObj.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='analysisColumnMeasurePop'/>",
			contentType : "ajax",
			title : "<spring:message code='M01454' />",
			ajaxSuccess : function(args) {
				getAnalysisColumnMeasureDetail(columnId);
			},
			beforeClose : function(args) {
				ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE = false;
				ANALYSIS_CONFIG.EXECUTE_FLAG.CHART = false;
			}
		});
	};

	var setAnalysisColumnDimensionPop = function(columnId) {
		var analysisColumnDimensionPop = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_DIMENSION_POP);
		var tempPopObj = null;

		if (!$.fn.ifvmIsNotEmpty(analysisColumnDimensionPop)) {
			tempPopObj = $("<div class='popup_container' />");
			tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_DIMENSION_POP);
		} else {
			tempPopObj = analysisColumnDimensionPop;
		}

		tempPopObj.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='analysisColumnDimensionPop'/>",
			contentType : "ajax",
			title : "<spring:message code='M01454' />",
			ajaxSuccess : function(args) {
				getAnalysisColumnDimensionDetail(columnId);
			},
			beforeClose : function(args) {
				ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE = false;
				ANALYSIS_CONFIG.EXECUTE_FLAG.CHART = false;
			}
		});
	};

	var setAnalysisPromptPop = function(promptId) {
		var analysisPromptPop = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_POP);
		var tempPopObj = null;

		if (!$.fn.ifvmIsNotEmpty(analysisPromptPop)) {
			tempPopObj = $("<div class='popup_container' />");
			tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_POP);
		} else {
			tempPopObj = analysisPromptPop;
		}

		tempPopObj.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='analysisPromptPop'/>",
			contentType : "ajax",
			title : "<spring:message code='M01612' />",
			ajaxSuccess : function(args) {
				getAnalysisPromptDetail(promptId);
			}
		});
	};

	// 현재 Column 트리뷰에 설정된 Dimension의 개수를 체크하여 존재 여부를 리턴한다.
	var getColumnTreeDimensionCountFlag = function() {
		var columnTreeView = $("#columnTree");
		var columnTreeViewData = columnTreeView.data("ejTreeView");
		var columnTreeViewDataSource = columnTreeViewData.getTreeData();
		var rstFlag = false;

		if ($.fn.ifvmIsNotEmpty(columnTreeViewDataSource)) {
			columnTreeViewDataSource.forEach(function(thisObj, idx) {
				var nodeId = thisObj.nodeId;
				var parNodeId = thisObj.parNodeId;

				if (nodeId !== ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE && parNodeId !== ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
					rstFlag = true;
					return false;
				}
			});
		}

		return rstFlag;
	};

	var getShowAnalysisFilterPop = function(analysisExcuteFlag, analysisPreviewFlag) {
		if ($.fn.ifvmIsNotEmpty(ANALYSIS_CONFIG.LOGICAL_COMP_ID)) {
			ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE = false;
			ANALYSIS_CONFIG.EXECUTE_FLAG.CHART = false;

			var analysisFilterPop = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_FILTER_POP);
			var tempPopObj = null;

			if (!$.fn.ifvmIsNotEmpty(analysisFilterPop)) {
				tempPopObj = $("<div class='popup_container' />");
				tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_FILTER_POP);
			} else {
				tempPopObj = analysisFilterPop;
			}

			tempPopObj.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : "<ifv:url name='analysisFilterPop'/>",
				contentType : "ajax",
				title : "<spring:message code='M01626' />",
				beforeClose : function(args) {
					if (ANALYSIS_CONFIG.FILTER_COUNT > -1 && $.fn.ifvmIsNotEmpty(analysisExcuteFlag) && "Y" === analysisExcuteFlag) {
						ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE = true;
						ANALYSIS_CONFIG.EXECUTE_FLAG.CHART = true;

						getAnalysisData();
					}

					if (ANALYSIS_CONFIG.FILTER_COUNT > -1 && $.fn.ifvmIsNotEmpty(analysisPreviewFlag) && "Y" === analysisPreviewFlag) {
						getShowAnalysisPreviewPop();
					}
				}
			});
		} else {
			alert("<spring:message code='M01471' />");
		}
	};

	var getShowAnalysisPreviewPop = function() {
		var analysisPreviewPop = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PREVIEW_POP);
		var tempPopObj = null;

		if (!$.fn.ifvmIsNotEmpty(analysisPreviewPop)) {
			tempPopObj = $("<div class='popup_container' />");
			tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PREVIEW_POP);
		} else {
			tempPopObj = analysisPreviewPop;
		}

		tempPopObj.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='analysisPreviewPop'/>",
			contentType : "ajax",
			title : "<spring:message code='M01620' />",
			width : "800",
			ajaxSuccess : function(args) {
				getAnalysisPreviewDetail({
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					analysisPreviewPopId : ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PREVIEW_POP,
					analysisMasterFlag : "N"
				});
			}
		});
	};

	/**
	 * 차트 설정 
	 * 
	 * @edit 2017. 8. 7. jh.kim
	 */
	var chartTypeInit = function() {

		$.ifvPostJSON("<ifv:action name='getCommCodeList'/>", {
			groupCode : ANALYSIS_CONFIG.GROUP_CODE_LIST.ANL_RPT_CHART_TYPE_CD,
			enableNA : false
		}, function(rst) {

			// is not empty rst.rows
			if ($.fn.ifvmIsNotEmpty(rst) && $.fn.ifvmIsNotEmpty(rst.rows)) {

				var arry2DChartList = new Array();
				var arry3DChartList = new Array();

				// 아이콘 출력을 위한 2D차트와 3D 차트 목록 생성
				$.each(rst.rows, function(chartTypeIdx, chartTypeObj) {
					var attrib02 = chartTypeObj.attrib02;
					var codeName = chartTypeObj.codeName;
					if (attrib02 === "2D") {
						if (!(codeName === "BUBBLE" || codeName === "SCATTER")) {
							arry2DChartList.push(chartTypeObj);
						}
					} else {
						arry3DChartList.push(chartTypeObj);
					}
				});

				// [2D Chart] title
				$("#chartTypeCodeList").append($("#analysisChartTitleTemplate").tmpl({
					title : "2D Chart"
				}));
				// [2D Chart] chart icon 
				var tmpl = $("#analysisChartCodeTemplate").tmpl(arry2DChartList);
				$("#chartTypeCodeList").append(tmpl);

				// 공통코드에 3D 차트가 등록되어있을 때 
				if ($.fn.ifvmIsNotEmpty(arry3DChartList) && arry3DChartList.length > 0) {

					// [3D Chart] title
					$("#chartTypeCodeList").append($("#analysisChartTitleTemplate").tmpl({
						title : "3D Chart"
					}));
					// [3D Chart] chart icon 
					var tmpl3D = $("#analysisChartCodeTemplate").tmpl(arry3DChartList);
					$("#chartTypeCodeList").append(tmpl3D);
				}

				rst.rows.forEach(function(thisObj) {
					$("#" + thisObj.codeName).click(function(evt) {
						ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE = false;
						ANALYSIS_CONFIG.EXECUTE_FLAG.CHART = false;

						// 상위 이벤트를 실행하지 않음.
						evt.stopPropagation();

						var thisId = $(this).attr("id");
						var combColumnTypeCode = null;
						var combColumnTypeChangeFlag = false;

						// 1. 현재 CHART_TYPE_CD 가 COMBINATION 인데, 지금 선택한 것은 COMBINATION X
						// 2. 현재 CHART_TYPE_CD 가 COMBINATION x 인데, 지금 선택한 것은 COMBINATION
						if ((ANALYSIS_CONFIG.CHART_TYPE_CD === ANALYSIS_CONFIG.COMBINATION && thisId !== ANALYSIS_CONFIG.COMBINATION) || (ANALYSIS_CONFIG.CHART_TYPE_CD !== ANALYSIS_CONFIG.COMBINATION && thisId === ANALYSIS_CONFIG.COMBINATION)) {
							if (ANALYSIS_CONFIG.COMBINATION === thisId) {
								combColumnTypeCode = ANALYSIS_CONFIG.COMB_COL_TYPE_CD.COLUMN;
							}
							combColumnTypeChangeFlag = true;
						}

						// 현재 차트 타입을 현재 아이디로 저장
						if (ANALYSIS_CONFIG.CHART_TYPE_CD !== thisId) {
							ANALYSIS_CONFIG.CHART_TYPE_CD = thisId;

							$.ifvPostJSON("<ifv:action name='editAnalysisChartTypeChange'/>", {
								analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
								chartTypeCode : ANALYSIS_CONFIG.CHART_TYPE_CD
							}, function(rst) {
								if (thisId !== "COMBINATION") {
									var targetChartId = $("#" + ANALYSIS_CONFIG.ANALYSIS_TOOLS.CHART).children().attr("id");
									var columnChartTypeList = $("#" + targetChartId).data("columnChartTypeList");
									if ($.fn.ifvmIsNotEmpty(columnChartTypeList)) {
										$("#" + targetChartId).data("columnChartTypeList", null);
									}
								}
							});
						}

						if (combColumnTypeChangeFlag === true) {
							// column 테이블의 모든 combColumnTypeCode를 위에서 설정한 코드로 변경
							$.ifvPostJSON("<ifv:action name='editAnalysisColumnCombTypeChange' />", {
								analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
								combColumnTypeCode : combColumnTypeCode
							}, function(rst) {
							});
						}

						$("#analysisToolBar li").find("ul.tool_box").hide();
					});

				}); // rst.rows.forEach END 

			} // is not empty rst.rows END

		});
	}

	/**
	 * 파일 Export 용 공통 함수
	 * */
	var getAnalyticsExportFile = function(exportType) {
		var targetList = new Array();
		var divList = $("#analysisTab").children("[id]");

		var selectedItemIndex = $("#analysisTab").data("ejTab").selectedItemIndex();

		for (var dIdx = 0; dIdx < divList.length; dIdx++) {
			if (selectedItemIndex === dIdx) {
				targetList.push({
					targetId : $(divList[dIdx]).attr("id"),
					targetName : $(divList[dIdx]).attr("id")
				});
			}
		}

		$.QTAnalyticsExport(exportType, ANALYSIS_CONFIG.ANALYSIS_NAME, targetList);
	};

	$(document).ready(function() {

		$.ifvmLnbSetting('analysisList');

		$.ifvProgressControl(true);

		// 툴바 이벤트 설정
		$("#toolbarEvents").ifvsfToolbar();
		$("#analysisToolBar li").click(function(evt) {
			var toolboxVisibleFlag = $("#analysisToolBar li").find("ul.tool_box").is(":visible");
			$("#analysisToolBar li").find("ul.tool_box").hide();

			if ($(this).find("ul.tool_box").length !== 0) {
				if (toolboxVisibleFlag === false) {
					$(this).find("ul.tool_box").show();
				}
			}
		});

		// Page URL 에서 분석 ID를 가져옴
		ANALYSIS_CONFIG.ANALYSIS_ID = $.ifvGetParam("analysisId");
		// Column, Row, Prompt TreeView 이벤트 설정
		setAnalysisTreeSetting();

		// Tab 설정
		$.ifvPostJSON("<ifv:action name='getCommCodeList'/>", {
			groupCode : ANALYSIS_CONFIG.GROUP_CODE_LIST.DASHBRD_EBD_TYPE_CD,
			enableNA : false
		}, function(rst) {
			var tabIdArray = new Array();
			var tabNameArray = new Array();

			if ($.fn.ifvmIsNotEmpty(rst.rows)) {
				rst.rows.forEach(function(thisObj) {
					tabIdArray.push(thisObj.codeName);
					tabNameArray.push(thisObj.markName);
				});
			}

			$("#analysisTab").ifvsfTab({
				tabId : tabIdArray,
				msgCode : tabNameArray,
				itemActive : function(args) {
					// Tab 클릭시 설정
					var targetTag = $(args.activeHeader).find("a");
					var targetTagAtrib = targetTag.attr("href");

					if (targetTagAtrib.indexOf(ANALYSIS_CONFIG.ANALYSIS_TOOLS.TABLE) > -1) {
						ANALYSIS_CONFIG.ANALYSIS_TYPE_FLAG = ANALYSIS_CONFIG.ANALYSIS_TOOLS.TABLE;

						if (ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE === true) {
							getAnalysisData();
						}
					} else {
						ANALYSIS_CONFIG.ANALYSIS_TYPE_FLAG = ANALYSIS_CONFIG.ANALYSIS_TOOLS.CHART;

						if (ANALYSIS_CONFIG.EXECUTE_FLAG.CHART === true) {
							getAnalysisData();
						} else {
							$("#CHART").unbind("resize");
							$("#CHART").resizeEnd(function(targetObj) {
								$.fn.KPRAnalysisPublishChartResize(targetObj.attr("id"));
							});
						}
					}
				},
				beforeActive : function(args) {
					$("#CHART").unbind("resize");
				}
			});

			// 분석 아이디가 존재 한다면, 분석 아이디 기준으로 분석 정보 세팅
			if ($.fn.ifvmIsNotEmpty(ANALYSIS_CONFIG.ANALYSIS_ID)) {
				getAnalysisDetail();
			} else {
				ANALYSIS_CONFIG.ANALYSIS_ID = $.ifvmGetRowID();
				ANALYSIS_CONFIG.CHART_TYPE_CD = ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN;
				ANALYSIS_CONFIG.FILTER_COUNT = -1;

				$.ifvPostJSON("<ifv:action name='addAnalysisDetail' />", {
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					chartTypeCode : ANALYSIS_CONFIG.CHART_TYPE_CD
				}, function(rst) {
					$.ifvProgressControl(false);
				});
			}
		});

		// 차트 설정 
		chartTypeInit();

		// 로지컬 컴포넌트 검색 버튼
		$("#btnLogicalCompListSearch").click(function(evt) {
			var logicalCompListPopup = $("#" + ANALYSIS_CONFIG.POPUP_ID.LOGICAL_COMP_LIST_POP);
			var tempPopObj = null;

			if ($.fn.ifvmIsEmpty(logicalCompListPopup)) {
				tempPopObj = $("<div class='popup_container' />");
				tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.LOGICAL_COMP_LIST_POP);
			} else {
				tempPopObj = logicalCompListPopup;
			}

			tempPopObj.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : "<ifv:url name='commonLogicalComponentListPop'/>",
				contentType : "ajax",
				title : "<spring:message code='M01474' />",
				close : "logicalCompPopupListClose"
			});
		});

		// 분석 신규 버튼
		$("#btnAnalysisCreate").click(function(evt) {
			var confirmFlag = confirm("<spring:message code='M01613' />");

			if (confirmFlag === true) {
				$.ifvPostJSON("<ifv:action name='removeAnalysisDetail' />", {
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
				}, function(rst) {
					qtjs.href("<ifv:url name='analysisDetail' />");
				});
			}
		});

		// 대시보드 신규 버튼
		$("#btnDashboardCreate").click(function(evt) {
			var confirmFlag = confirm("<spring:message code='M01613' />");

			if (confirmFlag === true) {
				$.ifvPostJSON("<ifv:action name='removeAnalysisDetail' />", {
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
				}, function(rst) {
					qtjs.href("<ifv:url name='dashboardDetail' />");
				});
			}
		});

		// 분석 삭제 버튼
		$("#btnAnalysisRemove").click(function(evt) {
			var confirmFlag = confirm("<spring:message code='M01614' />");

			if (confirmFlag == true) {
				var tempId = $.ifvGetParam("analysisId");
				var analysisMstFlag = "N";

				if ($.fn.ifvmIsNotEmpty(tempId)) {
					analysisMstFlag = "Y";
				}

				$.ifvPostJSON("<ifv:action name='removeAnalysisDetail' />", {
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					analysisMasterFlag : analysisMstFlag
				}, function(rst) {
					alert("<spring:message code='M00003' />");

					qtjs.href("<ifv:url name='analysisList' />");
				});
			}
		});

		// 나가기 버튼
		$("#btnAnalysisList").click(function(evt) {
			var confirmFlag = confirm("<spring:message code='M01613' />");

			if (confirmFlag === true) {
				$.ifvPostJSON("<ifv:action name='removeAnalysisDetail' />", {
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					dashboardId : ANALYSIS_CONFIG.DASHBOARD_ID,
					analysisMasterFlag : "N"
				}, function(rst) {
					if (!$.fn.ifvmIsNotEmpty(ANALYSIS_CONFIG.DASHBOARD_ID)) {
						qtjs.href("<ifv:url name='analysisList' />");
					} else {
						qtjs.href("<ifv:url name='dashboardDetail' />" + "?dashboardId=" + ANALYSIS_CONFIG.DASHBOARD_ID);
					}
				});
			}
		});

		// 툴바에 필터 버튼
		$("#btnAnalysisToolbarFilter").click(function(evt) {
			getShowAnalysisFilterPop("N", "N");
		});

		// 필터 버튼
		$("#btnAnalysisFilter").click(function(evt) {
			getShowAnalysisFilterPop("N", "N");
		});

		// 실행 버튼
		$("#btnAnalysisExecute").click(function(evt) {
			if (ANALYSIS_CONFIG.FILTER_COUNT > -1) {
				ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE = true;
				ANALYSIS_CONFIG.EXECUTE_FLAG.CHART = true;

				getAnalysisData();
			} else {
				getShowAnalysisFilterPop("Y", "N");
			}
		});

		// 분석 미리보기 버튼
		$("#btnAnalysisPreview").click(function(evt) {
			if (ANALYSIS_CONFIG.FILTER_COUNT > -1) {
				getShowAnalysisPreviewPop();
			} else {
				getShowAnalysisFilterPop("N", "Y");
			}
		});

		// 필드 그룹 체크
		$("#btnAnalysisFieldGroup").click(function(evt) {
			var dimensionFlag = getColumnTreeDimensionCountFlag();
			var columnGroupFlag = $(this).is(":checked");

			if (dimensionFlag === true) {
				$.ifvPostJSON("<ifv:action name='editAnalysisColumnGroupFlag' />", {
					analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
					columnGroupFlag : columnGroupFlag === true ? "1" : "0"
				}, function(rst) {
				});
			} else {
				alert("<spring:message code='M01645' />");
				$(this).attr("checked", !columnGroupFlag);
			}
		});

		// 분석 저장 버튼
		$("#btnAnalysisSave").click(function(evt) {
			var analysisSavePop = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_SAVE_POP);
			var tempPopObj = null;

			if (!$.fn.ifvmIsNotEmpty(analysisSavePop)) {
				tempPopObj = $("<div class='popup_container' />");
				tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_SAVE_POP);
			} else {
				tempPopObj = analysisSavePop;
			}

			tempPopObj.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : "<ifv:url name='analysisSavePop'/>",
				contentType : "ajax",
				title : "<spring:message code='M01547' />",
				beforeOpen : function(args) {
					setAnalysisBaseInfo();
				}
			});
		});

		// 분석 다른 이름으로 저장 버튼
		$("#btnAnalysisSaveAs").click(function(evt) {
			var dashboardId = ANALYSIS_CONFIG.DASHBOARD_ID;

			if (!$.fn.ifvmIsNotEmpty(dashboardId)) {
				var analysisSaveAsPop = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_SAVE_AS_POP);
				var tempPopObj = null;

				if (!$.fn.ifvmIsNotEmpty(analysisSaveAsPop)) {
					tempPopObj = $("<div class='popup_container' />");
					tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_SAVE_AS_POP);
				} else {
					tempPopObj = analysisSaveAsPop;
				}

				tempPopObj.ifvsfPopup({
					enableModal : true,
					enableResize : false,
					contentUrl : "<ifv:url name='analysisSaveAsPop'/>",
					contentType : "ajax",
					title : "<spring:message code='M01615' />"
				});
			} else {
				alert("<spring:message code='M01616' />");
			}
		});

		// PDF Export 버튼
		$("#btnAnalysisExportPDF").click(function(evt) {
			getAnalyticsExportFile("PDF");
		});

		// Excel Export 버튼
		$("#btnAnalysisExprotExcel").click(function(evt) {
			getAnalyticsExportFile("EXCEL");
		});

		// Word Export 버튼
		$("#btnAnalysisExportWord").click(function(evt) {
			getAnalyticsExportFile("WORD");
		});

		// HWP Export 버튼
		$("#btnAnalysisExportHWP").click(function(evt) {
			getAnalyticsExportFile("HWP");
		});

// 		// HTML Export 버튼
// 		$("#btnAnalysisExportHTML").click(function(evt) {
// 			getAnalyticsExportFile("HTML");
// 		});

		// 분석 차트 상세 버튼
		$("#btnAnalysisChartLabelDetail").click(function() {
			var analysisChartLabelDetail = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_CHART_LABEL_DETAIL_POP);
			var tempPopObj = null;

			if ($.fn.ifvmIsEmpty(analysisChartLabelDetail)) {
				tempPopObj = $("<div class='popup_container' />");
				tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_CHART_LABEL_DETAIL_POP);
			} else {
				tempPopObj = analysisChartLabelDetail;
			}

			tempPopObj.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : "<ifv:url name='analysisChartLabelDetailPop'/>",
				contentType : "ajax",
				title : "<spring:message code='M01719' />",
				ajaxSuccess : function(args) {
					setAnalysisChartSettingDetail(ANALYSIS_CONFIG.ANALYSIS_ID);
				}
			});
		});

		// 분석 테이블 버튼
		$("#btnAnalysisTableDetail").click(function() {
			var analysisTableDetail = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_TABLE_DETAIL_POP);
			var tempPopObj = null;

			if ($.fn.ifvmIsNotEmpty(analysisTableDetail)) {
				analysisTableDetail.remove();
			}

			analysisTableDetail = $("<div class='popup_container' />");
			analysisTableDetail.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_TABLE_DETAIL_POP);

			analysisTableDetail.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : "<ifv:url name='analysisTableDetailPop'/>",
				contentType : "ajax",
				title : "테이블 속성 설정",
				ajaxSuccess : function(args) {
					setAnalysisTableDetail(ANALYSIS_CONFIG.ANALYSIS_ID);
				}
			});
		});

		// 로지컬 컴포넌트 TreeView 쪽 리사이징
		$("#atribGroupColumnList").parent().resize(function() {
			var targetHeight = $(".ans_box_wrap").outerHeight() - $(".ans_top").outerHeight() - 15;
			$("#atribGroupColumnList").css("height", targetHeight);
		});

		// SQL 보기 버튼
		$("#btnAnalysisSql").click(function(evt) {
			var analysisSqlPop = $("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_SQL_POP);
			var tempPopObj = null;

			if (!$.fn.ifvmIsNotEmpty(analysisSqlPop)) {
				tempPopObj = $("<div class='popup_container' />");
				tempPopObj.attr("id", ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_SQL_POP);
			} else {
				tempPopObj = analysisSqlPop;
			}

			tempPopObj.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : "<ifv:url name='analysisSqlPop'/>",
				contentType : "ajax",
				title : "<spring:message code='M01192' />"
			});
		});
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="M01545" />
		&gt;
		<spring:message code="M01529" />
	</h1>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span id="analysisName"><spring:message code="M01529" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<%-- *** SQL 화면 보기용 *** 제거 필요 --%>
			<button class="btn btn-sm" id="btnAnalysisSql" objCode="btnAnalysisSql_OBJ">
				<spring:message code="M01192" />
			</button>
			<button class="btn btn-sm" id="btnAnalysisList" objCode="btnAnalysisList_OBJ">
				<spring:message code="M01717" />
			</button>
		</div>
	</div>
	
	<!-- 툴바 -->
	<div class="dashboard-header">
		<div class="dashboard-Toolbar">
			<div id="toolbarEvents" class="analysis_tool">
				<ul id="analysisToolBar" class="analysis_ico_tool">
					<li title="<spring:message code='M01533' />" id="btnAnalysisCreate"><i class="fa fa-pie-chart"></i></li>
					<li title="<spring:message code='M01534' />" id="btnDashboardCreate"><i class="fa fa-tachometer"></i></li>
					<li title="<spring:message code='M00165' />" id="btnAnalysisRemove"><i class="fa fa-trash-o"></i></li>
					<li title="<spring:message code='M00170' />" id="btnAnalysisSave"><i class="fa fa-floppy-o"></i></li>
					<li title="<spring:message code='M01615' />" id="btnAnalysisSaveAs"><i class="fa fa-files-o"></i></li>
					<li title="<spring:message code='M01618' />" id="btnAnalysisExportPDF"><i class="fa fa-file-pdf-o"></i></li>
					<li title="<spring:message code="M01716" />" id="btnAnalysisExprotExcel"><i class="fa fa-file-excel-o"></i></li>
					<li title="<spring:message code="M02253" />" id="btnAnalysisExportWord"><i class="fa fa-file-word-o"></i></li>
					<li title="<spring:message code="M02254" />" id="btnAnalysisExportHWP"><i class="fa"><img src="<ifv:image name='ico_hwp' />" /></i></li>
	<%-- 				<li title="<spring:message code="M02255" />" id="btnAnalysisExportHTML"><i class="fa"><img src="<ifv:image name='ico_html' />" /></i></li> --%>
					<li title="<spring:message code='M01617' />" class="tool_box_wrap"><i class="fa fa-bar-chart"></i>
						<ul class="tool_box chart_box" id="chartTypeCodeList"></ul></li>
					<li title="<spring:message code='M01719' />" id="btnAnalysisChartLabelDetail"><i class="fa fa-sliders"></i></li>
					<li title="테이블 설정" id="btnAnalysisTableDetail"><i class="fa fa-cogs"></i></li>
					<li title="<spring:message code='M01619' />" id="btnAnalysisToolbarFilter"><i class="fa fa-filter"></i></li>
					<li title="<spring:message code='M01620' />" id="btnAnalysisPreview"><i class="fa fa-eye"></i></li>
				</ul>
			</div>
		</div>
	</div>
	
	<div class="analysis_wrap">
		<div class="analysis_tree">
			<div class="ans_top">
				<label><spring:message code="M02956" /></label>
				<ifv:input type="text" id="logicalCompName" className="search_input" />
				<button class="btn btn_lightGray row_btn search_btn" id="btnLogicalCompListSearch" objCode="btnLogicalCompListSearch_OBJ" style="min-width:65px">
					<spring:message code="C00034" />
				</button>
			</div>
			<div id="atribGroupColumnList" class="acrdn_scroll_01 logical_component_tree"></div>
		</div>
	
		<div class="ans_box_wrap">
			<div class="analysis_box">
				<button id="btnAnalysisExecute" class="btn btn-sm analysis_btn" objCode="btnAnalysisExecute_OBJ">
					<i class="fa fa-play"></i>
					<spring:message code="M00603" />
				</button>
				<button id="btnAnalysisFilter" class="btn btn-sm analysis_btn" objCode="btnAnalysisFilter_OBJ">
					<i class="fa fa-filter"></i>
					<spring:message code="M01619" />
				</button>
			</div>
	
			<div class="ans_box">
				<header class="h_box">
					<span><spring:message code="M01107" /></span> <label class="chk_box"> <ifv:input type="checkbox" id="btnAnalysisFieldGroup" /> <spring:message code="M01621" />
					</label>
				</header>
				<div class="analysis_node_tree logical_component_tree">
					<div id="columnTree" class="box_con"></div>
				</div>
			</div>
	
			<div class="ans_box">
				<header class="h_box">
					<span><spring:message code="M01622" /></span>
				</header>
				<div class="analysis_node_tree logical_component_tree">
					<div id="rowTree" class="box_con"></div>
				</div>
			</div>
	
			<div class="ans_box">
				<header class="h_box">
					<span><spring:message code="M01623" /></span>
				</header>
				<div class="analysis_node_tree logical_component_tree">
					<div id="promptTree" class="box_con"></div>
				</div>
			</div>
		</div>
	
		<div class="diagram_area">
			<div id="analysisTab"></div>
		</div>
	</div>
</div>

<script id="analysisTreeNodeTemplate" type="text/x-jquery-tmpl">
<div id="{{:nodeId}}" class="{{if nodeId !== "MEASURE"}}tree_wrap{{/if}} anlNodeClass">
	<ul>
		<li style="position: relative;">
			<div style="float: left;width: 100px; text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">{{:nodeText}}</div>
			{{if nodeId !== "MEASURE"}}
			<div style="float: right;">
				<button id="{{:nodeId}}_set" data-nodeid="{{:nodeId}}" data-origincolumntypecode="{{:originColumnTypeCode}}" style="margin-right:3px;"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
				<button id="{{:nodeId}}_del" data-nodeid="{{:nodeId}}" data-origincolumntypecode="{{:originColumnTypeCode}}" style="margin-right:3px;"><i class="fa fa-times" aria-hidden="true"></i></button>
			</div>
			{{/if}}
		</li>
	</ul>
</div>
</script>

<script id="analysisChartCodeTemplate" type="text/x-jquery-tmpl">
	<li id="${'${'}codeName}" title="${'${'}markName}"><img src="${'${'}attrib01}" alt="${'${'}markName}" /></li>
</script>

<script id="analysisOptionTypeCodeTemplate" type="text/x-jquery-tmpl">
    <option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<%-- Chart Box Title --%>
<script id="analysisChartTitleTemplate" type="text/x-jquery-tmpl">
    <li class="chart_title">${'${'}title}</li>
</script>