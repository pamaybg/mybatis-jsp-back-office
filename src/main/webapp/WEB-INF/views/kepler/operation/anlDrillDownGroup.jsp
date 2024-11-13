<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/logicalComponent.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/js/kepler/diagram/css/diagramStyle.css" rel="stylesheet" />

<div class="page-title">
	<h1>
		<spring:message code="M02256" />
	</h1>
</div>

<div class="col-xs-2 h100">
	<div class="page_btn_area">
		<span><spring:message code="M02257" /></span>
	</div>
	<div class="drilldown_area analysis_tree" id="metaServiceTreeView"></div>
</div>

<div class="col-xs-4 pl10 h100">
	<div class="page_btn_area">
		<span><spring:message code="M02258" /></span>
	</div>
	<div class="drilldown_area analysis_tree" id="metaTableColumnTreeView"></div>
</div>

<div class="col-xs-6 pl10 h100">
	<div class="page_btn_area">
		<span><spring:message code="M02259" /></span>
	</div>
	<div class="drilldown_area analysis_tree" id="metaDrillDownGroupTreeView"></div>
</div>

<script type="text/javascript">
	var getDrillDownGroupListRefresh = function(tableId, dataList) {
		$("#metaDrillDownGroupTreeView").data("tableId", tableId);

		var metaDrillDownGroupTreeView = $("#metaDrillDownGroupTreeView").data("ejTreeView");
		metaDrillDownGroupTreeView.dataSource(dataList);
		metaDrillDownGroupTreeView.refresh();
		metaDrillDownGroupTreeView.expandAll();
	};

	/**
	 * 드릴다운 그룹 Context 메뉴 열기 전 함수.
	 * */
	var anlDrillDownGroupMenuBeforeOpen = function(args) {
		var metaTableColumnTreeView = $("#metaTableColumnTreeView").data("ejTreeView");
		var metaTableColumnSelectedNode = metaTableColumnTreeView.getSelectedNode();

		// 현재 선택된 노드가 없다면, Context 메뉴를 열지 않는다.
		if ($.fn.ifvmIsNotEmpty(metaTableColumnSelectedNode)) {
			var metaTableColumnSelectedNodeId = metaTableColumnSelectedNode.attr("id");
			var metaTableColumnDataSource = metaTableColumnTreeView.dataSource();
			var thisNodeData = null;

			// 선택된 노드의 ID를 기준으로 실제 데이터 정보를 찾는다.
			$.each(metaTableColumnDataSource, function(dataIdx, dataObject) {
				if (dataObject.nodeId === metaTableColumnSelectedNodeId) {
					thisNodeData = dataObject;
					return false;
				}
			});

			// 찾은 노드의 타입이 S라면, Context 메뉴를 열지 않는다.
			var nodeType = thisNodeData.nodeType;
			if (nodeType !== "S") {
				var targetTag = $(args.target).closest(".e-item");
				var metaDrillDownGroupTreeView = $("#metaDrillDownGroupTreeView").data("ejTreeView");
				var metaDrillDownGroupSelectedNode = metaDrillDownGroupTreeView.getSelectedNode();
				if ($.fn.ifvmIsNotEmpty(targetTag)) {
					metaDrillDownGroupTreeView.selectNode(targetTag);
					metaDrillDownGroupSelectedNode = targetTag;
				} else {
					metaDrillDownGroupTreeView.unselectNode(metaDrillDownGroupSelectedNode);
					metaDrillDownGroupSelectedNode = null;
				}

				var anlDrillDownGroupMenu = $("#anlDrillDownGroupContext").data("ejMenu");
				if ($.fn.ifvmIsNotEmpty(metaDrillDownGroupSelectedNode)) {
					var targetData = metaDrillDownGroupTreeView.getNode(metaDrillDownGroupSelectedNode);

					var targetParentId = targetData.parentId;
					if ($.fn.ifvmIsEmpty(targetParentId)) {
						anlDrillDownGroupMenu.enableItemByID("modifyDrillDownGroup");
					} else {
						anlDrillDownGroupMenu.disableItemByID("modifyDrillDownGroup");
					}
					anlDrillDownGroupMenu.enableItemByID("removeDrillDownGroup");
				} else {
					anlDrillDownGroupMenu.disableItemByID("modifyDrillDownGroup");
					anlDrillDownGroupMenu.disableItemByID("removeDrillDownGroup");
				}
			} else {
				args.cancel = true;
			}
		} else {
			args.cancel = true;
		}
	};

	/**
	 * 드릴다운 그룹 Context 메뉴에서 메뉴 선택 시 실행되는 함수.
	 * */
	var anlDrillDownGroupMenuClick = function(args) {
		var thisId = args.ID;

		var metaDrillDownGroupTreeView = $("#metaDrillDownGroupTreeView").data("ejTreeView");
		var thisSelectedNode = metaDrillDownGroupTreeView.getSelectedNode();
		var thisSelectedNodeId = thisSelectedNode.attr("id");
		var thisNodeData = null;

		var thisDataSource = metaDrillDownGroupTreeView.dataSource();
		if ($.fn.ifvmIsNotEmpty(thisDataSource)) {
			$.each(thisDataSource, function(dataIdx, dataObject) {
				if (dataObject.nodeId === thisSelectedNodeId) {
					thisNodeData = dataObject;
					return false;
				}
			});
		}

		// 현재 선택된 ID 에 따라 다른 함수를 실행한다.
		switch (thisId) {
		case "createDrillDownGroup":
			showDrillDownGroupNamePop(new Object());

			break;
		case "modifyDrillDownGroup":
			showDrillDownGroupNamePop(thisNodeData);
			break;

		case "removeDrillDownGroup":
			removeDrillDownGroup(thisNodeData);
			break;

		default:
			break;
		}
	};

	/**
	 * 테이블 목록에서 노드 선택 시 실행되는 함수.
	 * */
	var metaTableColumnTreeViewNodeSelect = function(args) {
		var thisId = args.id;
		var thisDataSource = this.dataSource();
		var thisNodeData = null;

		// 선택된 노드의 ID를 기준으로 실제 데이터 정보를 갖는다.
		$.each(thisDataSource, function(dataIdx, dataObject) {
			if (dataObject.nodeId === thisId) {
				thisNodeData = dataObject;
				return false;
			}
		});

		// 노드의 타입이 T(Table) 이라면 해당 노드 ID를 
		// 노드의 타입이 C(Column) 이라면 해당 노드의 상위 노드 ID로
		// 해당 테이블에 연결된 드릴다운 그룹 목록을 가져온다.
		var nodeType = thisNodeData.nodeType;
		switch (nodeType) {
		case "T":
			getDrillDownGroupList(thisNodeData.nodeId);
			break;
		case "C":
			getDrillDownGroupList(thisNodeData.nodeParentId);
			break;

		default:
			break;
		}
	};

	/**
	 * 테이블 목록에서 드래그 시작 시 실행되는 함수.
	 * */
	var metaTableColumnTreeViewNodeDragStart = function(args) {
		var thisData = args.targetElementData;
		var thisLevel = thisData.level;

		// Column 의 레벨이 3이므로 3보다 작으면 이벤트를 취소한다.
		if (thisLevel === 3) {
			var thisDataSource = this.dataSource();
			var tmpThisData = null;

			$.each(thisDataSource, function(dataIdx, dataObject) {
				if (dataObject.nodeId === thisData.id) {
					tmpThisData = dataObject;
					return false;
				}
			});

			var targetTableId = $("#metaDrillDownGroupTreeView").data("tableId");
			if (tmpThisData.tableId !== targetTableId) {
				alert("<spring:message code='M02260' />");
				args.cancel = true;
			}
			
			var targetTreeView = $("#metaDrillDownGroupTreeView").data("ejTreeView");
			var targetDataSource = targetTreeView.dataSource();
			if($.fn.ifvmIsEmpty(targetDataSource)) {
				args.cancel = true;
			}
		} else {
			args.cancel = true;
		}
	};

	/**
	 * 테이블 목록에서 드래그 종료 시 실행되는 함수.
	 * */
	var metaTableColumnTreeViewNodeDragDropped = function(args) {
		var eventFlag = false;
		var thisNodeData = args.droppedElementData;
		var thisNodeId = thisNodeData.id;

		var targetElement = args.dropTarget.closest("li");
		// 타겟 엘리먼트가 존재할 때만 처리.
		if ($.fn.ifvmIsNotEmpty(targetElement)) {
			var targetTree = targetElement.closest(".analysis_tree");
			var targetTreeViewId = targetTree.attr("id");

			if (targetTreeViewId === "metaDrillDownGroupTreeView") {
				var targetTreeView = targetTree.data("ejTreeView");
				var targetNodeData = targetTreeView.getNode(targetElement);
				var targetNodeId = targetNodeData.id;
				var targetNodeLevel = targetNodeData.level;

				if (targetNodeLevel < 6) {
					var targetData = null;
					var targetDataSource = targetTreeView.dataSource();
					$.each(targetDataSource, function(dataIdx, dataObject) {
						if (dataObject.nodeId === targetNodeId) {
							targetData = dataObject;
							return false;
						}
					});

					var targetDataFlag = false;
					var targetDrillDownGroupId = targetData.drillDownGroupId;
					$.each(targetDataSource, function(dataIdx, dataObject) {
						if (dataObject.drillDownGroupId === targetDrillDownGroupId && dataObject.tableColumnId === thisNodeId) {
							targetDataFlag = true;
							return false;
						}
					});

					if (!targetDataFlag) {
						eventFlag = true;

						var thisData = new Object();
						thisData.tableId = targetData.tableId;
						thisData.drillDownGroupId = targetDrillDownGroupId;

						switch (targetNodeLevel) {
						case 1:
							thisData.levelId_1 = thisNodeId;
							break;

						case 2:
							thisData.levelId_2 = thisNodeId;
							break;

						case 3:
							thisData.levelId_3 = thisNodeId;
							break;

						case 4:
							thisData.levelId_4 = thisNodeId;
							break;

						case 5:
							thisData.levelId_5 = thisNodeId;
							break;

						default:
							break;
						}

						$.ifvPostJSON("<ifv:action name='editDrillDownGroup' />", thisData, function(resData) {
							getDrillDownGroupListRefresh(thisData.tableId, resData);
						});
					} else {
						alert("<spring:message code='M02262' />");
					}
				} else {
					alert("<spring:message code='M02263' />");
				}
			}
		}

		// 조건에 해당 하지 않은 결과였다면
		// eventFlag 가 변경되지 않았으므로
		// 이벤트를 취소한다.
		args.cancel = !eventFlag;
	};

	var metaDrillDownGroupTreeViewDragStart = function(args) {
		var thisData = args.targetElementData;
		var thisLevel = thisData.level;

		// Column 의 레벨이 3이므로 3보다 작으면 이벤트를 취소한다.
		if (thisLevel !== 1) {
			args.cancel = true;
		}
	};

	/**
	 * 화면에서 사용하는 TreeView 생성 함수.
	 * */
	var createDrillDownGroupDetail = function() {
		$("#metaServiceTreeView").ifvsfTree({
			allowDragAndDrop : false,
			allowDragAndDropAcrossControl : false,
			allowDropChild : false,
			allowDropSibling : false,
			template : "#anlDrillDownGroupTreeViewTemplate",
			fields : {
				id : "nodeId",
				text : "nodeName",
				parentId : "nodeParentId"
			},
			nodeSelect : "metaServiceTreeViewNodeSelect"
		});

		$("#metaTableColumnTreeView").ifvsfTree({
			allowDragAndDrop : true,
			allowDragAndDropAcrossControl : true,
			allowDropChild : false,
			allowDropSibling : false,
			template : "#anlDrillDownGroupTreeViewTemplate",
			fields : {
				id : "nodeId",
				text : "nodeName",
				parentId : "nodeParentId"
			},
			nodeSelect : "metaTableColumnTreeViewNodeSelect",
			nodeDragStart : "metaTableColumnTreeViewNodeDragStart",
			nodeDropped : "metaTableColumnTreeViewNodeDragDropped"
		});

		$("#metaDrillDownGroupTreeView").ifvsfTree({
			allowDragAndDrop : false,
			allowDragAndDropAcrossControl : false,
			allowDropChild : false,
			allowDropSibling : false,
			template : "#anlDrillDownGroupTreeViewTemplate",
			fields : {
				id : "nodeId",
				text : "nodeName",
				parentId : "nodeParentId"
			},
			nodeDragStart : "metaDrillDownGroupTreeViewDragStart"
		});

		var contextMenu = $("#anlDrillDownGroupContextTemplate").tmpl();
		contextMenu.ifvsfContextMenu({
			menuType : ej.MenuType.ContextMenu,
			openOnClick : false,
			contextMenuTarget : "#metaDrillDownGroupTreeView",
			beforeOpen : "anlDrillDownGroupMenuBeforeOpen",
			click : "anlDrillDownGroupMenuClick"
		});
	};

	/**
	 * 현재 등록된 Service 목록을 가져온다.
	 * */
	var getMetaServiceList = function() {
		$.ifvPostJSON("<ifv:action name='getMetaServiceList'/>", {}, function(resData) {
			var metaServiceTreeView = $("#metaServiceTreeView").data("ejTreeView");
			metaServiceTreeView.dataSource(resData);
			metaServiceTreeView.refresh();
		});
	};

	/**
	 * 현재 등록된 Table/Column 목록을 가져온다.
	 * */
	var metaServiceTreeViewNodeSelect = function(args) {
		var nodeId = args.id;

		getMetaTableColumnList(nodeId);
	};

	/**
	 * 현재 등록된 드릴다운 그룹 목록을 가져온다.
	 * */
	var getMetaTableColumnList = function(databaseId) {
		$.ifvPostJSON("<ifv:action name='getMetaTableColumnList' />", {
			databaseId : databaseId
		}, function(resData) {
			var metaTableColumnTreeView = $("#metaTableColumnTreeView").data("ejTreeView");
			metaTableColumnTreeView.dataSource(resData);
			metaTableColumnTreeView.refresh();
		});
	};

	/**
	 * 현재 metaTableColumnTreeView 에서 선택한 Table 에 연결되어있는 드릴다운 그룹 목록을 가져온다.
	 * */
	var getDrillDownGroupList = function(tableId) {
		$.ifvPostJSON("<ifv:action name='getDrillDownGroupList' />", {
			tableId : tableId
		}, function(resData) {
			getDrillDownGroupListRefresh(tableId, resData);
		});
	};

	/**
	 * 드릴다운 그룹명을 설정하는 팝업 호출 함수.
	 * */
	var showDrillDownGroupNamePop = function(thisNodeData) {
		var anlDrillDownGroupNamePop = "anlDrillDownGroupNamePop";
		var thisPopup = $("#" + anlDrillDownGroupNamePop);
		var tempPopObject = null;

		if ($.fn.ifvmIsEmpty(thisPopup)) {
			tempPopObject = $("<div id='" + anlDrillDownGroupNamePop + "' class='popup_container' />");
		} else {
			tempPopObject = thisPopup;
		}

		tempPopObject.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='anlDrillDownGroupNamePop'/>",
			contentType : "ajax",
			title : "<spring:message code='M02259' />",
			ajaxSuccess : function(args) {
				setDrillDownGroupName(thisNodeData);
			}
		});
	};

	/**
	 * 드릴다운 그룹 등록/수정 함수
	 * */
	var setDrillDownGroup = function(thisData) {
		var targetURL = null;
		var metaDrillDownGroupId = thisData.drillDownGroupId;
		if ($.fn.ifvmIsEmpty(metaDrillDownGroupId)) {
			targetURL = "<ifv:action name='addDrillDownGroup' />";

			thisData.drillDownGroupId = $.ifvmGetRowID();
		} else {
			targetURL = "<ifv:action name='editDrillDownGroup' />";
		}

		thisData.drillDownGroupName = thisData.nodeName;
		thisData.tableId = $("#metaDrillDownGroupTreeView").data("tableId");

		$.ifvPostJSON(targetURL, thisData, function(resData) {
			getDrillDownGroupListRefresh(thisData.tableId, resData);
			$("#anlDrillDownGroupNamePop").data("ejDialog").close();
		});
	};

	var removeDrillDownGroup = function(thisData) {
		var targetURL = null;

		var nodeLevel = thisData.nodeLevel;
		if (nodeLevel > 0) {
			targetURL = "<ifv:action name='editDrillDownGroup' />";
		} else {
			targetURL = "<ifv:action name='removeDrillDownGroup' />";
		}

		if (confirm("<spring:message code='C00079' />")) {
			$.ifvPostJSON(targetURL, thisData, function(resData) {
				getDrillDownGroupListRefresh(thisData.tableId, resData);
			});
		}
	};

	$(document).ready(function() {
		$.ifvmLnbSetting("anlDrillDownGroup");

		createDrillDownGroupDetail();
		getMetaServiceList();
	});
</script>

<script id="anlDrillDownGroupContextTemplate" type="text/x-jquery-tmpl">
<ul id="anlDrillDownGroupContext" class="right_mou_list">
	<li id="createDrillDownGroup"><a><spring:message code="M02264" /></a></li>
	<li id="modifyDrillDownGroup"><a><spring:message code="M02265" /></a></li>
	<li id="removeDrillDownGroup"><a><spring:message code="M02266" /></a></li>
</ul>
</script>

<script id="anlDrillDownGroupTreeViewTemplate" type="text/x-jquery-tmpl">
<div data-nodeId="{{:nodeId}}" class="default-node-style">{{:nodeName}}</div>
</script>