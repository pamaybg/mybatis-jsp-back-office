var ANALYSIS_CONFIG = {};
ANALYSIS_CONFIG.ANALYSIS_ID = null;
ANALYSIS_CONFIG.ANALYSIS_NAME = null;
ANALYSIS_CONFIG.FOLDER_ID = null;
ANALYSIS_CONFIG.DASHBOARD_ID = null;
ANALYSIS_CONFIG.LOGICAL_COMP_ID = null;
ANALYSIS_CONFIG.CHART_TYPE_CD = null;
ANALYSIS_CONFIG.ANALYSIS_MST_FLAG = "N";
ANALYSIS_CONFIG.COMBINATION = "COMBINATION";
ANALYSIS_CONFIG.FILTER_COUNT = -1;
ANALYSIS_CONFIG.ANALYSIS_TYPE_FLAG = null; // 0 -> 테이블, 1 -> 차트

ANALYSIS_CONFIG.COL_TYPE_CD = {};
ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE = "MEASURE";
ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION = "DIMENSION";

ANALYSIS_CONFIG.COL_USE_TYPE_CD = {};
ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN = "COLUMN";
ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW = "ROW";
ANALYSIS_CONFIG.COL_USE_TYPE_CD.PROMPT = "PROMPT";

ANALYSIS_CONFIG.PROMPT_TYPE_CD = {};
ANALYSIS_CONFIG.PROMPT_TYPE_CD.LIST_BOX = "LIST_BOX";
ANALYSIS_CONFIG.PROMPT_TYPE_CD.DATE = "DATE";
ANALYSIS_CONFIG.PROMPT_TYPE_CD.DATE_BETWEEN = "DATE_BETWEEN";

ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE = {};
ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE.SUM = "SUM";
ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE.AVERAGE = "AVG";
ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE.COUNT = "COUNT";
ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE.COUNT_DISTINCT = "COUNT(DISTINCT)";

ANALYSIS_CONFIG.COMB_COL_TYPE_CD = {};
ANALYSIS_CONFIG.COMB_COL_TYPE_CD.COLUMN = "COLUMN";
ANALYSIS_CONFIG.COMB_COL_TYPE_CD.LINE = "LINE";

ANALYSIS_CONFIG.POPUP_ID = {};
ANALYSIS_CONFIG.POPUP_ID.LOGICAL_COMP_LIST_POP = "logicalComponentListPopup";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_MEASURE_POP = "ANALYSIS_COLUMN_MEASURE_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_DIMENSION_POP = "ANALYSIS_COLUMN_DIMENSION_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_POP = "ANALYSIS_PROMPT_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PROMPT_DATE_FUNC_POP = "ANALYSIS_PROMPT_DATE_FUNC_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_FILTER_POP = "ANALYSIS_FILTER_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_FILTER_DETAIL_POP = "ANALYSIS_FILTER_DETAIL_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_SAVE_POP = "ANALYSIS_SAVE_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_SAVE_AS_POP = "ANALYSIS_SAVE_AS_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PREVIEW_POP = "ANALYSIS_PREVIEW_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_PREVIEW_SET_POP = "ANALYSIS_PREVIEW_SET_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_CHART_LABEL_DETAIL_POP = "ANALYSIS_CHART_LABEL_DETAIL_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_CHART_LABEL_FONT_POP = "ANALYSIS_CHART_LABEL_FONT_POP";
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_TABLE_DETAIL_POP = "ANALYSIS_TABLE_DETAIL_POP";
// 제거 필요
ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_SQL_POP = "ANALYSIS_SQL_POP";

ANALYSIS_CONFIG.BTN_SETTING = {};
ANALYSIS_CONFIG.BTN_SETTING.SET = "SET";
ANALYSIS_CONFIG.BTN_SETTING.DEL = "DEL";

ANALYSIS_CONFIG.GROUP_CODE_LIST = {};
ANALYSIS_CONFIG.GROUP_CODE_LIST.DASHBRD_EBD_TYPE_CD = "DASHBRD_EBD_TYPE_CD";
ANALYSIS_CONFIG.GROUP_CODE_LIST.ANL_RPT_CHART_TYPE_CD = "ANL_RPT_CHART_TYPE_CD";

ANALYSIS_CONFIG.ANALYSIS_TOOLS = {};
ANALYSIS_CONFIG.ANALYSIS_TOOLS.TABLE = "TABLE";
ANALYSIS_CONFIG.ANALYSIS_TOOLS.CHART = "CHART";

ANALYSIS_CONFIG.EXECUTE_FLAG = {};
ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE = false;
ANALYSIS_CONFIG.EXECUTE_FLAG.CHART = false;

// 제거 필요
ANALYSIS_CONFIG.ANALYSIS_SQL = {};
ANALYSIS_CONFIG.ANALYSIS_SQL.BASE_SQL = "";
ANALYSIS_CONFIG.ANALYSIS_SQL.CHART_SQL = "";
ANALYSIS_CONFIG.ANALYSIS_SQL.TABLE_SQL = "";

// Column, Row Tree View 에서 Measure 를 묶기위해 사용하는 헤더노드를 생성한다.
var getParentMeasureNode = function() {
	var parentMeasureNode = new Object();
	parentMeasureNode.nodeId = ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;
	parentMeasureNode.nodeText = ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;
	parentMeasureNode.expandedFlag = true;

	return parentMeasureNode;
};

// Target Tree 에 노드를 추가한다.
var setAddNode = function(targetTree, targetTreeDataSource, targetDataList, columnUseTypeCode) {
	var targetUrl = null;
	var targetObject = new Object();
	if (columnUseTypeCode === ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN || columnUseTypeCode === ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW) {
		targetUrl = ANALYSIS_URL_CONFIG.ADD_ANALYSIS_COLUMN_DETAIL;
		targetObject = {
			columnList : targetDataList
		};
	} else {
		targetUrl = ANALYSIS_URL_CONFIG.ADD_ANALYSIS_PROMPT_DETAIL;
		targetObject = {
			promptList : targetDataList
		};
	}

	$.ifvProgressControl(true);
	$.ifvPostJSON(targetUrl, targetObject, function(resData) {
		$.ifvProgressControl(false);

		if (columnUseTypeCode === ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN || columnUseTypeCode === ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW) {
			$.each(targetDataList, function(dataIdx, dataObject) {
				$.each(resData, function(resIdx, resObject) {
					if (dataObject.columnId === resObject.columnId && $.fn.ifvmIsNotEmpty(resObject.columnDisplayName)) {
						dataObject.nodeText = resObject.columnDisplayName;
						return false;
					}
				});
			});
		}

		var targetTreeData = targetTree.data("ejTreeView");
		targetTreeDataSource = targetTreeDataSource.concat(targetDataList);
		targetTreeData.dataSource(targetTreeDataSource);
		targetTreeData.refresh();

		setNodeSequence(columnUseTypeCode);
	}, function(rst) {
		$.ifvProgressControl(false);
		$.messageCheckr(rst.message);
	});
};

// Target Tree 에 올려놓은 노드 순서에 맞게, Sequence 를 업데이트 한다.
var setNodeSequence = function(columnUseTypeCode) {
	var tempArray = new Array();
	var tempIdx = 0;

	if (columnUseTypeCode === ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN || columnUseTypeCode === ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW) {
		var columnTreeView = $("#columnTree").data("ejTreeView");
		var columnTreeViewDataSource = columnTreeView.dataSource();

		// NODE ID가 Measure 제외 Seq 설정
		if ($.fn.ifvmIsNotEmpty(columnTreeViewDataSource)) {
			columnTreeViewDataSource.forEach(function(thisObj, idx) {
				if (thisObj.nodeId !== ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
					var tempObj = {
						columnId : thisObj.columnId,
						seq : ++tempIdx
					};
					tempArray.push(tempObj);
				}
			});
		}

		var rowTreeView = $("#rowTree").data("ejTreeView");
		var rowTreeViewDataSource = rowTreeView.dataSource();

		if ($.fn.ifvmIsNotEmpty(rowTreeViewDataSource)) {
			rowTreeViewDataSource.forEach(function(thisObj, idx) {
				if (thisObj.nodeId !== ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
					var tempObj = {
						columnId : thisObj.columnId,
						seq : ++tempIdx
					};
					tempArray.push(tempObj);
				}
			});
		}

		$.ifvProgressControl(true);
		$.ifvPostJSON(ANALYSIS_URL_CONFIG.EDIT_ANALYSIS_COLUMN_ALL_SEQUENCE, {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			columnList : tempArray,
			columnUseTypeCode : columnUseTypeCode,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
		}, function(rst) {
			$.ifvProgressControl(false);

			ANALYSIS_CONFIG.EXECUTE_FLAG.TABLE = false;
			ANALYSIS_CONFIG.EXECUTE_FLAG.CHART = false;
		}, function(rst) {
			$.ifvProgressControl(false);
			$.messageCheckr(rst.message);
		});
	} else {
		var promptTreeView = $("#promptTree").data("ejTreeView");
		var promptTreeViewDataSource = promptTreeView.dataSource();

		if ($.fn.ifvmIsNotEmpty(promptTreeViewDataSource)) {
			promptTreeViewDataSource.forEach(function(thisObj, idx) {
				var tempObj = {
					promptId : thisObj.promptId,
					seq : ++tempIdx
				};
				tempArray.push(tempObj);
			});
		}

		$.ifvProgressControl(true);
		$.ifvPostJSON(ANALYSIS_URL_CONFIG.EDIT_ANALYSIS_PROMPT_ALL_SEQUENCE, {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			promptList : tempArray,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
		}, function(rst) {
			$.ifvProgressControl(false);
		}, function(rst) {
			$.ifvProgressControl(false);
			$.messageCheckr(rst.message);
		});
	}
};

var setColumnNodeTextUpdate = function(targetId, targetNodeText) {
	var targetTree = $("#" + targetId).closest("div[id*=Tree]");
	var targetTreeData = targetTree.data("ejTreeView");
	var targetTreeDataSource = targetTreeData.dataSource();

	targetTreeDataSource.forEach(function(thisObj, idx) {
		if (thisObj.nodeId === targetId) {
			thisObj.nodeText = targetNodeText;
		}
	});

	targetTreeData.dataSource(targetTreeDataSource);
	targetTreeData.refresh();
};

var setAnalysisColumn = function(targetTreeId, thisDataList, columnUseTypeCode) {
	var targetTree = $("#" + targetTreeId);
	var targetTreeData = targetTree.data("ejTreeView");
	var targetTreeDataSource = targetTreeData.dataSource();

	if (!$.fn.ifvmIsNotEmpty(targetTreeDataSource)) {
		targetTreeDataSource = new Array();
	}

	$.ifvPostJSON(ANALYSIS_URL_CONFIG.GET_ANALAYSIS_ATRIB_GROUP_COLUMN_DEATIL, {
		atribGroupColumnList : thisDataList
	}, function(resData) {
		var thisDataSetList = new Array();

		var measureFlag = false;
		$.each(resData, function(dataIdx, dataObject) {
			var columnTypeCode = dataObject.columnTypeCode;
			var thisId = $.ifvmGetRowID();

			var thisDataSet = $.extend(dataObject, {
				analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
				nodeId : thisId,
				columnId : thisId,
				columnUseTypeCode : columnUseTypeCode,
				groupFuncTypeCode : ANALYSIS_CONFIG.ANL_GROUP_FUNC_TYPE.SUM,
				analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG,
				columnDisplayName : dataObject.nodeText,
				combColumnTypeCode : ANALYSIS_CONFIG.COMB_COL_TYPE_CD.COLUMN
			});

			if (ANALYSIS_CONFIG.CHART_TYPE_CD === ANALYSIS_CONFIG.COMBINATION) {
				thisDataSet.combColumnTypeCode = ANALYSIS_CONFIG.COMB_COL_TYPE_CD.COLUMN;
			}

			// Loop 를 돌다 Measure 타입을 만나면, 한번만 처리 해야함으로
			if (!measureFlag && columnTypeCode === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
				measureFlag = true;

				var thisMeasureList = new Array();
				thisMeasureList = targetTreeDataSource.filter(function(treeObject) {
					return treeObject.nodeId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;
				});

				if (thisMeasureList.length === 0) {
					targetTreeDataSource.push(getParentMeasureNode());
				}

				var tempTree = null;
				if (columnUseTypeCode === ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN) {
					tempTree = $("#rowTree");
					thisColumnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW;
				}

				if (columnUseTypeCode === ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW) {
					tempTree = $("#columnTree");
					thisColumnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN;
				}

				var tempTreeData = tempTree.data("ejTreeView");
				var tempDataSource = tempTreeData.dataSource();
				if ($.fn.ifvmIsNotEmpty(tempDataSource)) {
					var measureList = new Array();
					$.each(tempDataSource, function(tempIdx, tempObject) {
						if (tempObject.columnTypeCode === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
							tempObject.columnUseTypeCode = columnUseTypeCode;
							measureList.push(tempObject);
						}
					});

					if (measureList.length !== 0) {
						$.ifvSyncPostJSON(ANALYSIS_URL_CONFIG.EDIT_ANALYSIS_COLUMN_TYPE_CODE_CHANGE, {
							analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
							changeColumnUseTypeCode : columnUseTypeCode,
							columnUseTypeCode : thisColumnUseTypeCode,
							columnList : measureList,
							analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
						}, function(resSyncData) {
							tempTreeData.removeNode(ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE);
							targetTreeDataSource = targetTreeDataSource.concat(measureList);
						});
					}
				}
			}

			if (columnTypeCode === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
				thisDataSet.parNodeId = ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;
				thisDataSet.columnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;
				thisDataSet.originColumnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE;
			} else {
				thisDataSet.columnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION;
				thisDataSet.originColumnTypeCode = ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION;
				thisDataSet.groupFuncTypeCode = null;
			}

			thisDataSetList.push(thisDataSet);
		});

		setAddNode(targetTree, targetTreeDataSource, thisDataSetList, columnUseTypeCode);
	});
};

var setAnalysisPrompt = function(targetTreeId, thisDataList, columnUseTypeCode) {
	var targetTree = $("#" + targetTreeId);
	var targetTreeData = targetTree.data("ejTreeView");
	var targetTreeDataSource = targetTreeData.dataSource();

	if (!$.fn.ifvmIsNotEmpty(targetTreeDataSource)) {
		targetTreeDataSource = new Array();
	}

	$.ifvPostJSON(ANALYSIS_URL_CONFIG.GET_ANALAYSIS_ATRIB_GROUP_COLUMN_DEATIL, {
		atribGroupColumnList : thisDataList
	}, function(resData) {
		var thisDataSetList = new Array();

		var measureFlag = false;
		$.each(resData, function(dataIdx, dataObject) {
			var thisId = $.ifvmGetRowID();
			var thisDataSet = $.extend(dataObject, {
				nodeId : thisId,
				promptId : thisId,
				columnUseTypeCode : columnUseTypeCode,
				promptTypeCode : ANALYSIS_CONFIG.PROMPT_TYPE_CD.LIST_BOX,
				analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
				analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
			});

			var columnTypeCode = dataObject.columnTypeCode;
			if (columnTypeCode !== ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
				thisDataSetList.push(thisDataSet);
			} else {
				measureFlag = true;
				return false;
			}
		});

		if (!measureFlag) {
			setAddNode(targetTree, targetTreeDataSource, thisDataSetList, columnUseTypeCode);
		} else {
			alert(MESSAGE.kepler.analysis.error_MSG_S0001);
		}
	});
};