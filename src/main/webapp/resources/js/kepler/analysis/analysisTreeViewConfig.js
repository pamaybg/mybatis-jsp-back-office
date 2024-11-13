/**
 * Attribute Group Column Tree 관련
 */
// Attribute Group Column Tree 에서 노드를 드래그 시작했을 때 체크
// 하위 노드가 존재할 경우 드래그 불가하도록 처리
//var setAnalysisAtribGroupColumnTreeNodeDragStart = function(args) {
//	var childrenCount = args.targetElementData.count;
//
//	if (childrenCount !== 0) {
//		args.cancel = true;
//	}
//};

// 노드를 드래그 했을 시 처리.
var setAnalysisAtribGroupColumnTreeNodeDragStop = function(args) {
	var target = args.dropTarget;

	// 타겟에 e-item 혹은 e-ul이 있다면 tree 내부 이므로 이동 가능성이 있어 취소 시킴
	if (target.hasClass("e-item") || target.hasClass("e-ul")) {
		args.cancel = true;
	}
};

var setAnalysisAttribGroupColumnTreeNodeCollapseExpanded = function (args) {
	var thisId = args.id;
	var allowMultiSelection = this.model.allowMultiSelection;
	this.model.allowMultiSelection = false;
	
	this.unselectNode(thisId);
	this.model.allowMultiSelection = allowMultiSelection;
};

// 노드를 드랍 했을 때의 위치에 따른 처리
// 각 Tree View 위에 드랍 했을 때만 처리함.
var setAnalysisAtribGroupColumnTreeNodeDropped = function(args) {
	var target = args.dropTarget;
	var targetTree = null;
	if (target.hasClass("ans_box")) {
		targetTree = target.find("[id*=Tree]");
	} else if (target.closest(".ans_box").hasClass("ans_box")) {
		target = target.closest(".ans_box");
		targetTree = target.find("[id*=Tree]");
	} else {
		args.cancel = true;
		return;
	}

	var targetTreeId = targetTree.attr("id");
	var thisDataSource = this.getTreeData();
	var thisDataList = new Array();
	
	var dropElementId = args.droppedElementData.id;

	$.each(thisDataSource, function(dataIdx, dataObject) {
		var selectedFlag = Boolean(dataObject.selected);
		
		if (selectedFlag) {
			dataObject.atribGroupColumnId = dataObject.atribGroupColId;
			thisDataList.push(dataObject);
		}
		
		if (!selectedFlag) {
			if (dataObject.id === dropElementId) {
				dataObject.atribGroupColumnId = dataObject.atribGroupColId;
				thisDataList.push(dataObject);
			}
		}
	})

	this.unselectAll();

	// 노드 드랍한 대상 Tree 아이디를 가지고 구분
	if (targetTreeId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN) > -1) {
		// Column Tree
		setAnalysisColumn(targetTreeId, thisDataList, ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN);
	} else if (targetTreeId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW) > -1) {
		// Row Tree
		setAnalysisColumn(targetTreeId, thisDataList, ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW);
	} else if (targetTreeId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.PROMPT) > -1) {
		// Prompt Tree
		setAnalysisPrompt(targetTreeId, thisDataList, ANALYSIS_CONFIG.COL_USE_TYPE_CD.PROMPT);
	} else {
		args.cancel = true;
		return;
	}
};

/**
 * Column, Row, Prompt 트리 관련
 */
// Analysis 에서 사용하는 Column, Row, Tree 의 기본 세팅
var setAnalysisTreeSetting = function() {
	$("#columnTree").ifvsfTree({
		allowDragAndDrop : true,
		allowDragAndDropAcrossControl : true,
		allowDropChild : false,
		allowDropSibling : false,
		allowMultiSelection : false,
		template : "#analysisTreeNodeTemplate",
		fields : {
			id : "nodeId",
			text : "nodeText",
			parentId : "parNodeId",
			expanded : "expandedFlag"
		},
		nodeDropped : setAnalysisColumnTreeNodeDropped,
		nodeClick : setAnalysisTreeNodeClick,
		beforeSelect : setAnalysisTreeNodeBeforeSelect
	});

	$("#rowTree").ifvsfTree({
		allowDragAndDrop : true,
		allowDragAndDropAcrossControl : true,
		allowDropChild : false,
		allowDropSibling : false,
		allowMultiSelection : false,
		template : "#analysisTreeNodeTemplate",
		fields : {
			id : "nodeId",
			text : "nodeText",
			parentId : "parNodeId",
			expanded : "expandedFlag"
		},
		nodeDropped : setAnalysisColumnTreeNodeDropped,
		nodeClick : setAnalysisTreeNodeClick,
		beforeSelect : setAnalysisTreeNodeBeforeSelect
	});

	$("#promptTree").ifvsfTree({
		allowDragAndDrop : true,
		allowDragAndDropAcrossControl : true,
		allowDropChild : false,
		allowDropSibling : false,
		allowMultiSelection : false,
		template : "#analysisTreeNodeTemplate",
		fields : {
			id : "nodeId",
			text : "nodeText",
			parentId : "parNodeId"
		},
		nodeDragStop : setAnalysisPromptTreeNodeDragStop,
		nodeDropped : setAnalysisPromptTreeNodeDropped,
		nodeClick : setAnalysisTreeNodeClick,
		beforeSelect : setAnalysisTreeNodeBeforeSelect
	});
};

// Column, Row Tree View 에서 다른 Tree View 로 노드를 드랍 했을 때 발생.
var setAnalysisColumnTreeNodeDropped = function(args) {
	var thisTree = this.element;
	
	var target = args.dropTarget;
	var targetTree = null;
	if (target.hasClass("ans_box")) {
		targetTree = target.find("[id*='Tree']");
	} else if (target.closest(".ans_box").hasClass("ans_box")) {
		target = target.closest(".ans_box");
		targetTree = target.find("[id*='Tree']");
	} else {
		var tempId = target.attr("id");
		var tempTarget = $("#" + tempId);
		var tempTree = tempTarget.closest(".ans_box").find("[id*='Tree']");
		var tempTreeId = tempTree.attr("id");
		
		if ($.fn.ifvmIsNotEmpty(tempTreeId)) {
			target = tempTarget.closest(".ans_box");
			targetTree = tempTree;
		} else {
			args.cancel = true;
			return;
		}
	}
	
	var thisTreeId = $.fn.ifvmIsNotEmpty(thisTree) ? thisTree.attr("id") : null;
	var targetTreeId = $.fn.ifvmIsNotEmpty(targetTree) ? targetTree.attr("id") : null;
	
	var thisElementData = args.droppedElementData;
	var thisElementDataId = thisElementData.id;
	var thisElementDataParentId = thisElementData.parentId;
	
	var thisTreeView = thisTree.data("ejTreeView");
	var thisTreeViewDataSource = thisTreeView.getTreeData();
	var thisDataObject = null;
	
	var thisDataMeasureFlag = false;
	if (thisElementDataId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE || thisElementDataParentId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
		thisDataMeasureFlag = true;
	}
	
	var columnUseTypeCode = null;
	var thisColumnUseTypeCode = null;
	if (thisTreeId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN) > -1) {
		thisColumnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN;
		columnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW;
	}
	
	if (thisTreeId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW) > -1) {
		thisColumnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW;
		columnUseTypeCode = ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN;
	}
	
	if (thisTreeId === targetTreeId) {
		var targetElementData = args.targetElementData;
		var targetElementDataId = targetElementData.id;
		var targetElementDataParentId = targetElementData.parentId;
		
		$.each(thisTreeViewDataSource, function(dataIdx, dataObject) {
			if (dataObject.nodeId === thisElementDataId) {
				thisDataObject = dataObject;
				return false;
			}
		});
		
		if ($.fn.ifvmIsNotEmpty(targetElementDataId) && thisElementDataId !== targetElementDataId) {
			var resTreeViewDataSource = new Array();
			
			var targetDataMeasureFlag = false;
			if (targetElementDataId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE || targetElementDataParentId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
				targetDataMeasureFlag = true;
			}
			
			var measureDataList = new Array();
			var measureStartIdx = -1;
			if (thisDataMeasureFlag || targetDataMeasureFlag) {
				$.each(thisTreeViewDataSource, function(dataIdx, dataObject) {
					if (dataObject.nodeId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE || dataObject.parNodeId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
						measureDataList.push(dataObject);
						
						if (measureStartIdx === -1) {
							measureStartIdx = dataIdx;
						}
					}
				});
			}
			
			var measureDataConcatFlag = false;
			$.each(thisTreeViewDataSource, function(dataIdx, dataObject) {
				if ((thisDataMeasureFlag && targetDataMeasureFlag) || (!thisDataMeasureFlag && !targetDataMeasureFlag)) {
					if (dataObject.nodeId !== thisElementDataId) {
						resTreeViewDataSource.push(dataObject);
						
						if (dataObject.nodeId === targetElementDataId) {
							resTreeViewDataSource.push(thisDataObject);
						}
					}
				} else {
					if (dataObject.columnTypeCode === ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION) {
						if (targetDataMeasureFlag) {
							if (dataObject.nodeId === thisElementDataId) {
								var resTreeViewDataSourceLength = resTreeViewDataSource.length;
								
								if (resTreeViewDataSourceLength > measureStartIdx) {
									$.each(measureDataList, function (measureIdx, measureObject) {
										resTreeViewDataSource.splice((measureStartIdx + measureIdx), 0, measureObject);
									});
									
									resTreeViewDataSource.splice((measureStartIdx + measureDataList.length), 0, thisDataObject);
								} else {
									resTreeViewDataSource = resTreeViewDataSource.concat(measureDataList);
									resTreeViewDataSource.push(thisDataObject);
								}
							} else {
								resTreeViewDataSource.push(dataObject);
							}
						} else {
							resTreeViewDataSource.push(dataObject);
							
							if (dataObject.nodeId === targetElementDataId) {
								resTreeViewDataSource = resTreeViewDataSource.concat(measureDataList);	
							}
						}
					}
				}
			});
			
			thisTreeView.dataSource(resTreeViewDataSource);
			thisTreeView.refresh();
			
			setNodeSequence(thisColumnUseTypeCode);
		} else {
			args.cancel = true;
			return;
		}
	} else if (targetTreeId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN) > -1 || targetTreeId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW) > -1) {
		var columnUseTypeChangeList = new Array();
		
		$.each(thisTreeViewDataSource, function (dataIdx, dataObject) {
			var changeFlag = false;
			
			if (thisDataMeasureFlag) {
				if (dataObject.parNodeId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
					changeFlag = true;
				}
			} else {
				if (dataObject.nodeId === thisElementDataId) {
					changeFlag = true;
				}
			}
			
			if (changeFlag) {
				dataObject.columnUseTypeCode = columnUseTypeCode;
				columnUseTypeChangeList.push(dataObject);
			}
		});
		
		$.ifvProgressControl(true);
		$.ifvPostJSON(ANALYSIS_URL_CONFIG.EDIT_ANALYSIS_COLUMN_TYPE_CODE_CHANGE, {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			changeColumnUseTypeCode : columnUseTypeCode,
			columnUseTypeCode : thisColumnUseTypeCode,
			columnList : columnUseTypeChangeList,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
		}, function (resData) {
			$.ifvProgressControl(false);
			
			var targetTreeView = targetTree.data("ejTreeView");
			var targetTreeViewDataSource = targetTreeView.getTreeData();
			
			if ($.fn.ifvmIsEmpty(targetTreeViewDataSource)) {
				targetTreeViewDataSource = new Array();
			}
			
			if (thisDataMeasureFlag) {
				targetTreeViewDataSource.push(getParentMeasureNode());
				thisTreeView.removeNode(ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE);
			} else {
				thisTreeView.removeNode(thisElementDataId);
			}
			
			targetTreeViewDataSource = targetTreeViewDataSource.concat(columnUseTypeChangeList);
			targetTreeView.dataSource(targetTreeViewDataSource);
			targetTreeView.refresh();
			
			setNodeSequence(thisColumnUseTypeCode);
		});
	} else {
		args.cancel = true;
		return;
	}
};

var setAnalysisPromptTreeNodeDragStop = function(args) {
	var thisTree = args.draggedElement.closest(".ans_box").find("[id*=Tree]");

	var target = args.dropTarget;
	var targetTree = null;
	if (target.hasClass("ans_box")) {
		targetTree = target.find("[id*=Tree]");
	} else if (target.closest(".ans_box").hasClass("ans_box")) {
		target = $(target).closest(".ans_box");
		targetTree = target.find("[id*=Tree]");
	} else {
		args.cancel = true;
		return;
	}

	var thisTreeId = $.fn.ifvmIsNotEmpty(thisTree) === true ? thisTree.attr("id") : "";
	var targetTreeId = $.fn.ifvmIsNotEmpty(targetTree) === true ? targetTree.attr("id") : "";

	// 현재 아이디와 타겟 아이디가 같다면 실행
	if (thisTreeId === targetTreeId) {
		var draggedElementData = args.draggedElementData;
		var thisElementDataId = draggedElementData.id;

		var targetElementData = args.targetElementData;
		var targetElementDataId = targetElementData.id;

		// 타겟 아이디가 존재하는 경우, 겹쳤다는 의미 이므로 처리
		if ($.fn.ifvmIsNotEmpty(targetElementDataId)) {
			var thisTreeData = thisTree.data("ejTreeView");
			var thisTreeDataSource = thisTreeData.dataSource();
			var rstTreeDataSource = new Array();

			var thisDataList = thisTreeDataSource.filter(function(thisObj) {
				var nodeId = thisObj.nodeId;

				// 현재 이동한 노드 아이디와 Filtering 한 노드 아이디가 같다면.
				return thisElementDataId === nodeId;
			});
			var thisDataObj = thisDataList[0];

			thisTreeDataSource.forEach(function(thisObj, idx) {
				var nodeId = thisObj.nodeId;

				// 현재 이동한 노드의 아이디와 루핑도는 노드 아이디가 같지 않다면, 푸시
				if (thisElementDataId !== nodeId) {
					rstTreeDataSource.push(thisObj);
				}

				// 이동한 대상의 노드 아이디와 루핑도는 노드 아이디가 같다면, 위에서 필터링한 노드를 푸시
				if (targetElementDataId === nodeId) {
					rstTreeDataSource.push(thisDataObj);
				}
			});

			thisTreeData.dataSource(rstTreeDataSource);
			thisTreeData.refresh();
		}
	} else {
		args.cancel = true;
		return;
	}
};

var setAnalysisPromptTreeNodeDropped = function(args) {
	var thisElement = args.droppedElement;
	var thisElementId = thisElement.attr("id");
	var thisTree = $("#" + thisElementId).closest(".ans_box").find("[id*=Tree]");

	var target = args.target;

	var targetTree = null;
	if (target.hasClass("ans_box")) {
		targetTree = target.find("[id*=Tree]");
	} else if (target.closest(".ans_box").hasClass("ans_box")) {
		target = target.closest(".ans_box");
		targetTree = target.find("[id*=Tree]");
	} else {
		var tempId = target.attr("id");
		var tempTarget = $("#" + tempId);
		var tempTree = tempTarget.closest(".ans_box").find("[id*=Tree]");
		var tempTreeId = tempTree.attr("id");

		if ($.fn.ifvmIsNotEmpty(tempTreeId)) {
			target = tempTarget.closest(".ans_box");
			targetTree = tempTree;
		} else {
			args.cancel = true;
			return;
		}
	}

	var thisTreeId = $.fn.ifvmIsNotEmpty(thisTree) === true ? thisTree.attr("id") : "";
	var targetTreeId = $.fn.ifvmIsNotEmpty(targetTree) === true ? targetTree.attr("id") : "";

	// 현재 아이디와 타겟 아이디가 같다면 해당 데이터 리스트 순서 정렬 실행
	if (thisTreeId === targetTreeId) {
		setNodeSequence(ANALYSIS_CONFIG.COL_USE_TYPE_CD.PROMPT);
	}
};

// Column, Row, Prompt 에서 노드 클릭 시
var setAnalysisTreeNodeClick = function(args) {
	var thisElement = $(args.currentElement).closest("[id]");
	var thisElementId = thisElement.attr("id");
	var treeView = thisElement.closest("div[id*=Tree]");
	var nodeId = thisElement.data("nodeid");
	var originColumnTypeCode = thisElement.data("origincolumntypecode");

	if (thisElementId.toUpperCase().indexOf(ANALYSIS_CONFIG.BTN_SETTING.SET) > -1) {
		if (!thisElement.hasTriggerEvent("click")) {
			thisElement.click({
				nodeId : nodeId,
				treeView : treeView,
				originColumnTypeCode : originColumnTypeCode
			}, function(evt) {
				evt.stopPropagation();

				var targetId = evt.data.nodeId;
				var treeView = evt.data.treeView;
				var originColumnTypeCode = evt.data.originColumnTypeCode;
				var treeViewId = treeView.attr("id");

				if (treeViewId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN) > -1 || treeViewId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW) > -1) {
					if (ANALYSIS_CONFIG.COL_TYPE_CD.DIMENSION === originColumnTypeCode) {
						setAnalysisColumnDimensionPop(targetId);
					} else {
						setAnalysisColumnMeasurePop(targetId);
					}
				} else {
					setAnalysisPromptPop(targetId);
				}
			});
		}

		thisElement.trigger("click");
	} else if (thisElementId.toUpperCase().indexOf(ANALYSIS_CONFIG.BTN_SETTING.DEL) > -1) {
		if (!thisElement.hasTriggerEvent("click")) {
			thisElement.click({
				nodeId : nodeId,
				treeView : treeView
			}, function(evt) {
				evt.stopPropagation();

				var targetId = evt.data.nodeId;
				var treeView = evt.data.treeView;
				var treeViewId = treeView.attr("id");

				var targetUrl = null;
				var targetDataSet = null;
				var targetColumnFlag = false;

				if (treeViewId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN) > -1 || treeViewId.toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.ROW) > -1) {
					targetColumnFlag = true;
					targetUrl = ANALYSIS_URL_CONFIG.REMOVE_ANALYSIS_COLUMN_DETAIL;
					targetDataSet = {
						analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
						columnId : targetId,
						columnUseTypeCode : ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN,
						analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
					};
				} else {
					targetColumnFlag = false;
					targetUrl = ANALYSIS_URL_CONFIG.REMOVE_ANALYSIS_PROMPT_DETAIL;
					targetDataSet = {
						analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
						promptId : targetId,
						analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
					};
				}

				$.ifvProgressControl(true);
				$.ifvPostJSON(targetUrl, targetDataSet, function(rst) {
					var treeViewData = treeView.data("ejTreeView");
					treeViewData.removeNode(targetId);

					if (targetColumnFlag === true) {
						var treeViewDataSource = treeViewData.dataSource();

						var measureCnt = -1;
						var dimensionCnt = -1;
						treeViewDataSource.forEach(function(dataObj, idx) {
							if (dataObj.parNodeId === ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
								measureCnt++;
							}

							if (dataObj.parNodeId !== ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE && dataObj.nodeId !== ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE) {
								dimensionCnt++;
							}
						});

						treeViewData.removeNode(targetId);
						if (measureCnt === -1) {
							treeViewData.removeNode(ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE);
						}

						if (treeView.attr("id").toUpperCase().indexOf(ANALYSIS_CONFIG.COL_USE_TYPE_CD.COLUMN) > -1) {
							var btnAnalysisFieldGroup = $("#btnAnalysisFieldGroup");
							var columnGroupFlag = btnAnalysisFieldGroup.is(":checked");

							if (dimensionCnt < 2 && columnGroupFlag) {
								$.ifvPostJSON(ANALYSIS_URL_CONFIG.EDIT_ANALYSIS_COLUMN_GROUP_FLAG, {
									analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
									columnGroupFlag : "0"
								}, function(rst) {
									btnAnalysisFieldGroup.attr("checked", !columnGroupFlag);
								});
							}
						}
					}

					$.ifvProgressControl(false);
				});
			});
		}

		thisElement.trigger("click");
	} else {
		args.cancel = true;
		return;
	}
};

var setAnalysisTreeNodeBeforeSelect = function(args) {
	args.cancel = true;
};