<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ifv" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="import_form_area pop_inner_wrap">
	<div class="form-horizontal">
		<div class="row">
			<div class="col-xs-6 pr5">
				<label class="title-box"><spring:message code="M02400" /></label>
				<div class="left-box">
					<div id="sourceSchemaList"></div>
				</div>
			</div>

			<div class="col-xs-6 pl5">
				<label class="title-box"><spring:message code="M02401" /></label>
				<div class="right-box">
					<div id="targetSchemaList"></div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="databaseUseSchemaAddConfirm" objCode="databaseUseSchemaAddConfirm_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00074" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="databaseUseSchemaAddCancel" objCode="databaseUseSchemaAddCancel_OBJ">
		<spring:message code="C00040" />
	</button>
</div>

<script type="text/javascript">
	var DATABASE_SCHEMA_CONFIG = {};

	$(document).ready(function() {
		$("#databaseUseSchemaAddConfirm").click(function(evt) {
			saveDatabaseSchemaList();
		});

		$("#databaseUseSchemaAddCancel").click(function(evt) {
			 
			//$("#" + DATABASE_SCHEMA_CONFIG.TAG_ID).data("ejDialog").close();
			databaseUseSchemaAddPop._destroy();
			
		});
	});

	var saveDatabaseSchemaList = function() {
		var targetTree = $("#targetSchemaList").data("ejTreeView");
		var targetTreeDataSource = targetTree.getTreeData();

		if ($.fn.ifvmIsNotEmpty(targetTreeDataSource) && targetTreeDataSource.length > 0) {
			$.ifvProgressControl(true);
			$.ifvPostJSON("<ifv:action name='saveDatabaseUseSchemaList' />", {
				databaseId : DATABASE_SCHEMA_CONFIG.DATABASE_ID,
				useSchemaList : targetTreeDataSource
			}, function(resObject) {
				$.ifvProgressControl(false);
				alert("<spring:message code='C00094' />");

				var tagId = DATABASE_SCHEMA_CONFIG.TAG_ID;
				delete DATABASE_SCHEMA_CONFIG;

				$("#" + tagId).data("ejDialog").close();
			})
		} else {
			alert("<spring:message code='M01522' />");
		}
	};

	var sourceSchemaListNodeDropped = function(args) {
		var target = args.dropTarget;
		var targetTree = null;
		var targetTreeData = null;
		var targetTreeDataSource = null;

		if (target.hasClass("right-box")) {
			targetTree = target.find("[id='targetSchemaList']");
			targetTreeData = targetTree.data("ejTreeView");
			targetTreeDataSource = targetTreeData.getTreeData();
		} else if (target.closest(".right-box").hasClass("right-box")) {
			target = target.closest(".right-box");
			targetTree = target.find("[id='targetSchemaList']");
			targetTreeData = targetTree.data("ejTreeView");
			targetTreeDataSource = targetTreeData.getTreeData();
		} else {
			args.cancel = true;
			return;
		}
		// target tree 데이터가 없을 경우 undefined 반환, 이 경우 아래 each로직에서 오류가 나기 때문에 fallback처리 - sjbaek 2020.03.23
		if (!targetTreeDataSource)
			targetTreeDataSource = []

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
				if (targetObject.nodeText === dataObject.nodeId) {
					appendFlag = false;
					return false;
				}
			});

			if (appendFlag) {
				var rId = $.ifvmGetRowID();
				var targetObject = {
					rId : rId,
					schemaName : dataObject.nodeText,
					nodeId : rId,
					nodeText : dataObject.nodeText
				};

				tempTargetTreeDataSource.push(targetObject);
			}
		});
		targetTreeDataSource = targetTreeDataSource.concat(tempTargetTreeDataSource);

		this.unselectAll();
		targetTreeData.dataSource(targetTreeDataSource);
		targetTreeData.refresh();
	};

	var targetSchemaListNodeSelect = function(args) {
		var currentElement = args.currentElement;
		var thisButton = currentElement.find("[btnid='minus']");
		var thisTree = this;
		var thisId = args.id;

		thisButton.click({
			thisTree : thisTree,
			thisId : thisId
		}, function(evt) {
			var thisTree = evt.data.thisTree;
			var thisId = evt.data.thisId;

			var allowMultiSelection = thisTree.model.allowMultiSelection;
			thisTree.model.allowMultiSelection = false;
			thisTree.removeNode(thisId);
			thisTree.model.allowMultiSelection = allowMultiSelection;
		});
	};

	var setDatabaseUseSchema = function(thisId, thisDatabaseId) {
		DATABASE_SCHEMA_CONFIG.TAG_ID = thisId;
		DATABASE_SCHEMA_CONFIG.DATABASE_ID = thisDatabaseId;

		$.ifvProgressControl(true);
		$.ifvPostJSON("<ifv:action name='getDatabaseUseSchema' />", {
			databaseId : thisDatabaseId
		}, function(resObject) {
			var sourceSchemaNameList = resObject.sourceSchemaNameList;
			var targetSchemaNameList = resObject.targetSchemaNameList;

			$("#sourceSchemaList").ifvsfTree({
				allowDragAndDrop : true,
				allowDragAndDropAcrossControl : true,
				allowDropChild : false,
				allowDropSibling : false,
				allowMultiSelection : true,
				fields : {
					id : "nodeId",
					text : "nodeText",
					dataSource : sourceSchemaNameList
				},
				template : "#baseFolderTreeTemplate",
				nodeDragStart: function(args) {
					document.body.style.cursor = "pointer"
				},
				nodeDragStop: function(args) {
					document.body.style.cursor = ""
				},
				nodeDropped : sourceSchemaListNodeDropped
			});

			$("#targetSchemaList").ifvsfTree({
				allowDragAndDrop : true,
				allowDragAndDropAcrossControl : true,
				allowDropChild : false,
				allowDropSibling : false,
				allowMultiSelection : true,
				fields : {
					id : "nodeId",
					text : "nodeText",
					dataSource : targetSchemaNameList
				},
				setBtn : {
					add : false,
					mod : false,
					del : true
				},
				template : "#baseFolderTreeTemplate",
				nodeSelect : targetSchemaListNodeSelect
			});

			$.ifvProgressControl(false);
		}, function(resObject) {
			$.ifvProgressControl(false);
		});
	};
</script>