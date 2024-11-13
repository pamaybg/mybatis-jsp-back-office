<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="import_form_area pop_inner_wrap">
	<div class="form-horizontal">
		<div class="row qt_border">
			<div class="col-xs-6 pr5">
				<label class="title-box"><spring:message code="M02431" /></label>

				<div class="left-box">
					<div id="commonColumnList"></div>
				</div>
			</div>


			<div class="col-xs-6 pl5">
				<label class="title-box"><spring:message code="M02432" /></label>

				<div class="right-box">
					<div id="dashboardPromptList"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="dashboardPromptSaveBtn" objCode="dashboardPromptSaveBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00074" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="dashboardPromptCancelBtn" objCode="dashboardPromptCancelBtn_OBJ">
		<spring:message code="C00040" />
	</button>
</div>


<script type="text/javascript">
	var DASHBOARD_PROMPT_CONFIG = {};
	DASHBOARD_PROMPT_CONFIG.POP_ID = null;
	DASHBOARD_PROMPT_CONFIG.DASHBOARD_ID = null;
	
	$(document).ready(function() {
		$("#dashboardPromptSaveBtn").click(function(evt) {
			saveDashboardPromptList(this);
		});
		
		$("#dashboardPromptCancelBtn").click(function(evt) {
			var popupObject = $(this).closest(".popup_container");
			window[popupObject.attr('id')]._destroy();
		});
	});

	var setDashboardPromptDetail = function(tagId, dashboardId) {
		DASHBOARD_PROMPT_CONFIG.POP_ID = tagId;
		DASHBOARD_PROMPT_CONFIG.DASHBOARD_ID = dashboardId;

		$.ifvPostJSON("<ifv:action name='getDashboardCommonColumnList' />", {
			dashboardId : dashboardId
		}, function(resData) {
			$("#commonColumnList").ifvsfTree({
				allowDragAndDrop : true,
				allowDragAndDropAcrossControl : true,
				allowDropChild : false,
				allowDropSibling : false,
				allowMultiSelection : true,
				fields : {
					id : "nodeId",
					text : "nodeText",
					dataSource : resData
				},
				template : "#baseTreeTemplate",
				nodeDropped : commonColumnListNodeDropped
			});
		});

		$.ifvPostJSON("<ifv:action name='getDashboardPromptList' />", {
			dashboardId : dashboardId
		}, function(resData) {
			$("#dashboardPromptList").ifvsfTree({
				allowDragAndDrop : true,
				allowDragAndDropAcrossControl : true,
				allowDropChild : false,
				allowDropSibling : false,
				allowMultiSelection : false,
				fields : {
					id : "nodeId",
					text : "nodeText",
					dataSource : resData
				},
				template : "#dashboardPromptNodeTemplate",
				nodeClick : dashboardPromptNodeClick
			});
		});
	};

	var commonColumnListNodeDropped = function(args) {
		var target = args.dropTarget;
		var targetTree = null;
		var targetTreeData = null;
		var targetTreeDataSource = null;

		if (target.hasClass("right-box")) {
			targetTree = target.find("[id='dashboardPromptList']");
			targetTreeData = targetTree.data("ejTreeView");
			targetTreeDataSource = targetTreeData.getTreeData();
		} else if (target.closest(".right-box").hasClass("right-box")) {
			target = target.closest(".right-box");
			targetTree = target.find("[id='dashboardPromptList']");
			targetTreeData = targetTree.data("ejTreeView");
			targetTreeDataSource = targetTreeData.getTreeData();
		} else {
			args.cancel = true;
			return;
		}

		var thisTree = this.element;
		var thisTreeData = thisTree.data("ejTreeView");
		var thisTreeDataSource = thisTreeData.getTreeData();

		var thisDroppedElementData = args.droppedElementData;
		var appendFlag = true;

		var selectedNodeList = new Array();
		$.each(thisTreeDataSource, function(dataIdx, dataObject) {
			if (Boolean(dataObject.selected)) {
				selectedNodeList.push(dataObject);

				if (dataObject.nodeId === thisDroppedElementData.id) {
					appendFlag = false;
				}
			}
		});

		if (appendFlag) {
			var thisObject = {
				nodeId : thisDroppedElementData.id,
				nodeText : thisDroppedElementData.text
			};

			selectedNodeList.push(thisObject);
		}

		var tempTargetTreeDataSource = new Array();
		$.each(selectedNodeList, function(dataIdx, dataObject) {
			appendFlag = true;

			$.each(targetTreeDataSource, function(targetIdx, targetObject) {
				if (targetObject.columnId === dataObject.nodeId) {
					appendFlag = false;
					return false;
				}
			});

			if (appendFlag) {
				var rId = $.ifvmGetRowID();
				var targetObject = {
					nodeId : rId,
					nodeText : dataObject.nodeText,
					promptId : rId,
					columnId : dataObject.nodeId,
					displayName : dataObject.displayName,
					columnName : dataObject.columnName,
					promptTypeCode : "LIST_BOX"
				};

				tempTargetTreeDataSource.push(targetObject);
			}
		});
		targetTreeDataSource = targetTreeDataSource.concat(tempTargetTreeDataSource);

		this.unselectAll();
		targetTreeData.dataSource(targetTreeDataSource);
		targetTreeData.refresh();
	};

	var dashboardPromptNodeClick = function(args) {
		var thisElement = $(args.currentElement).closest("div[id]");
		var thisElementId = thisElement.attr("id");

		var thisEventElement = $(args.currentElement).closest("[id]");
		var thisEventElementId = thisEventElement.attr("id");

		if (thisEventElementId.endsWith("_set")) {
			if (!thisEventElement.hasTriggerEvent("click")) {
				thisEventElement.click({
					columnId : thisElementId
				}, function(evt) {
					evt.stopPropagation();

					var columnId = evt.data.columnId;
					showDashboardPromptDetailPop(columnId);
				});
			}
		} else if (thisEventElementId.endsWith("_del")) {
			if (!thisEventElement.hasTriggerEvent("click")) {
				thisEventElement.click({
					columnId : thisElementId
				}, function(evt) {
					evt.stopPropagation();

					var columnId = evt.data.columnId;

					var promptTreeView = $("#dashboardPromptList").data("ejTreeView");
					promptTreeView.removeNode(columnId);
				});
			}
		} else {
			args.cancel = true;
			return;
		}

		thisEventElement.trigger("click");
	};

	var showDashboardPromptDetailPop = function(columnId) {
		var tagId = "dashboardPromptDetailPop";
		var tempObject = $("#" + tagId);
		
		if ($.fn.ifvmIsEmpty(tempObject)) {
			tempObject = $("<div class='popup_container' />");
			tempObject.attr("id", tagId);
		}
		
		var promptTreeView = $("#dashboardPromptList").data("ejTreeView");
		var promptTreeViewDataSource = promptTreeView.getTreeData();
		var promptObject = new Object();
		
		$.each(promptTreeViewDataSource, function(thisIdx, thisObject) {
			if (thisObject.nodeId === columnId) {
				promptObject = thisObject;
				return false;
			}
		});
		
		tempObject.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='dashboardPromptDetailPop'/>",
			contentType : "ajax",
			title : "<spring:message code='M01612' />",
			width : "600px",
			beforeOpen : function(args) {
				setDashboardPromptDetail(promptObject);
			},
			beforeClose : function(args) {
				var dataFlag = tempObject.data("dataFlag");
				if ($.fn.ifvmIsNotEmpty(dataFlag) && dataFlag) {
					var promptObject = tempObject.data("promptObject");
					
					$.each(promptTreeViewDataSource, function(thisIdx, thisObject) {
						if (thisObject.nodeId === promptObject.nodeId) {
							thisObject = $.extend(thisObject, promptObject);
							return false;
						}
					});
					
					promptTreeView.dataSource(promptTreeViewDataSource);
					promptTreeView.refresh();
				}
			}
		});
	};
	
	var saveDashboardPromptList = function(_this) {
		var promptTreeView = $("#dashboardPromptList").data("ejTreeView");
		var promptTreeViewDataSource = promptTreeView.getTreeData();
		
		var message = "";
		var saveFlag = true;
		$.each(promptTreeViewDataSource, function(dataIdx, dataObject) {
			dataObject.seq = dataIdx + 1;
			var promptTypeCode = dataObject.promptTypeCode;
			
			if (promptTypeCode !== "LIST_BOX") {
				var promptValue1CodeName = dataObject.promptValue1CodeName;
				var promptValue2CodeName = dataObject.promptValue2CodeName;
				var promptValue3CodeName = dataObject.promptValue3CodeName;
				
				if (promptTypeCode === "DATE" && $.fn.ifvmIsEmpty(promptValue3CodeName)) {
					message += dataObject.nodeText + " <spring:message code='M02433' />\n";
					saveFlag = false;
				}
				
				if (promptTypeCode === "DATE_BETWEEN" && ($.fn.ifvmIsEmpty(promptValue1CodeName) || $.fn.ifvmIsEmpty(promptValue2CodeName))) {
					message += dataObject.nodeText + " <spring:message code='M02433' />\n";
					saveFlag = false;
				}
			}
		});
		
		if (saveFlag && confirm( "<spring:message code='M01632' />" )) {
			$.ifvPostJSON("<ifv:action name='saveDashboardPrompt' />", {
				dashboardId : DASHBOARD_PROMPT_CONFIG.DASHBOARD_ID,
				promptList : promptTreeViewDataSource
			}, function(resData) {
				alert( "<spring:message code='C00094' />" );

				var popupObject = $(_this).closest(".popup_container");
				window[popupObject.attr('id')]._destroy();
			});
		} else {
			alert(message);
		}
	};
</script>

<script id="dashboardPromptNodeTemplate" type="text/x-jquery-tmpl">
<div id="{{:nodeId}}" class="tree_wrap anlNodeClass">
	<ul>
		<li style="position: relative;">
			<div style="float: left;width: calc(100% - 40px); text-overflow: ellipsis; overflow: hidden; white-space: nowrap;">{{:nodeText}}</div>
			<div style="float: right;">
				<button id="{{:nodeId}}_set" style="margin-right:3px;"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>
				<button id="{{:nodeId}}_del" style="margin-right:5px;"><i class="fa fa-times" aria-hidden="true"></i></button>
			</div>
		</li>
	</ul>
</div>
</script>