<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/js/kepler/diagram/css/diagramStyle.css" rel="stylesheet" type="text/css" media="screen,print" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/KPRNodeTree.jsp" />
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/kepler/common/include/analysisTools.jsp" />

<script type="text/javascript">

	var getDashboardId = function() {
		var dashBoardId;
		if($("#dashboardTitle").data("dashboardId") != null && $("#dashboardTitle").data("dashboardId") != ''){
			dashBoardId =  $("#dashboardTitle").data("dashboardId");
		}else{
			dashBoardId = $.ifvGetParam( "dashboardId" );
		}
		return dashBoardId;
	};

	var setDashboardDetail = function(dashboardId) {
		if ($.fn.ifvmIsNotEmpty(dashboardId)) {
			$.ifvSyncPostJSON("<ifv:action name='getDashboardDetail' />", {
				dashboardId : dashboardId
			}, function(resData) {
				var dashboardId = resData.dashboardId;
				$("#dashboardTitle").data("dashboardId", dashboardId);

				var folderId = resData.folderId;
				$("#dashboardTitle").data("folderId", folderId);

				var dashboardName = resData.dashboardName;
				if ($.fn.ifvmIsNotEmpty(dashboardName)) {
					var tempDashboardText = $("#dashboardTitle").text();
					$("#dashboardTitle").text(tempDashboardText + " | " + dashboardName);

					$("#dashboardTitle").data("dashboardName", dashboardName);
				}
				
				var layoutId = resData.layoutId;
				$("#dashboardTitle").data("layoutId", layoutId);

				var layoutHtml = resData.layoutHtml;
				setDashboardLayoutDetail(layoutHtml);

				var analysisList = resData.analysisList;
				if ($.fn.ifvmIsNotEmpty(analysisList)) {
					$.each(analysisList, function(dataIdx, dataObject) {
						setDashboardAnalysisDetailCreate({
							dashboardEmbedType : dataObject.dashboardEmbedType,
							dashboardSeq : dataObject.dashboardSeq,
							analysisId : dataObject.analysisId,
							analysisName : dataObject.analysisName
						});
					});
				}
			});
		} else {
			dashboardId = $.ifvmGetRowID();

			$.ifvSyncPostJSON("<ifv:action name='addDashboardDetail' />", {
				dashboardId : dashboardId
			}, function(resData) {
				$("#dashboardTitle").data("dashboardId", dashboardId);
			});
		}
	};

	var setDashboardLayout = function() {
		$.ifvSyncPostJSON("<ifv:action name='getDashboardLayoutList' />", {}, function(resData) {
			var layoutList = new Array();
			$.each(resData, function(dataIdx, dataObject) {
				var dashboardLayoutTemplate = $("#dashboardLayoutTemplate").tmpl(dataObject);
				dashboardLayoutTemplate.data("layoutHtml", dataObject.layoutHtml);

				layoutList.push(dashboardLayoutTemplate);
			});

			$("#layoutList").append(layoutList);
			$("#layoutList li").click(function(evt) {
				// 대시보드 레이아웃 설정 확인
				var layoutFlag = $("#dashboardArea").find("[id]").length === 0;
				var dashboardId = getDashboardId();
				var layoutId = $(this).attr("id");
				var layoutHtml = $(this).data("layoutHtml");

				// 설정된 레이아웃이 존재한다면, 기존 inst에 복사해놨던 분석 삭제 처리
				if (layoutFlag === false) {
					var currentLayoutId = $("#dashboardTitle").data("layoutId");

					if (layoutId !== currentLayoutId) {
						if (confirm("<spring:message code='M01519' />")) {
							$.ifvSyncPostJSON("<ifv:action name='removeDashboardAnalysisList' />", {
								dashboardId : dashboardId,
								layoutId : layoutId
							}, function(resData) {
								setDashboardLayoutDetail(layoutHtml);
							});
						}	
					}
				}
				// 설정된 레이아웃이 존재하지 않는다면, 레이아웃 설정.
				else {
					$.ifvSyncPostJSON("<ifv:action name='editDashboardDetail' />", {
						dashboardId : dashboardId,
						layoutId : layoutId
					}, function(resData) {
						setDashboardLayoutDetail(layoutHtml);
					});
				}
			});
		});
	};

	var setDashboardLayoutDetail = function(layoutHtml) {
		$("#dashboardArea").empty();
		$("#dashboardArea").append(layoutHtml);
		$(".icon_area").append($("#dashboardTitle").data("defaultSetupButton"));
		$(".icon_area").append($("#dashboardTitle").data("defaultDeleteButton"));

		$(".icon_area .fa-pencil-square-o").click(function(evt) {
			var analysisId = $(this).closest("[class^='dashboard_box_type']").find("[id^='content_chart_']").data("analysisId");

			if ($.fn.ifvmIsNotEmpty(analysisId)) {
				qtjs.href("<ifv:url name='analysisDetail' />" + "?analysisId=" + analysisId);
			}
		});

		$(".icon_area .fa-times").click(function(evt) {
			var _this = this;
			var analysisId = $(_this).closest("[class^='dashboard_box_type']").find(".chart_area").data("analysisId");

			if ($.fn.ifvmIsNotEmpty(analysisId)) {
				$.ifvSyncPostJSON("<ifv:action name='removeDashboardAnalysisDetail' />", {
					analysisId : analysisId
				}, function(resData) {
					$(_this).closest("[class^='dashboard_box_type']").find("[id^='content_chart_']").data("analysisId", null);
					$(_this).closest("[class^='dashboard_box_type']").find("[id^='content_chart_']").empty();
					$(_this).closest("[class^='dashboard_box_type']").find("[id^='content_chart_']").css({
						"background" : ""
					});
					$(_this).closest("[class^='dashboard_box_type']").find("[id^='tit_chart_']").text("");
				});
			}
		});
	};

	var setAnalytisTreeView = function() {
		$("#treeView").ifvmCreateKPRNodeTree({
			targetId : "treeView",
			reportFlag : "Y",
			allowDragAndDrop : true,
			allowDropChild : false,
			nodeDragStart : setAnalysisTreeViewNodeDragStart,
			nodeDropped : setAnalysisTreeViewNodeDropped,
			template : "#baseTreeTemplate"
		});
	};

	var setAnalysisTreeViewNodeDragStart = function(args) {
		var layoutFlag = $("#dashboardArea").find("[id]").length === 0;
		if (layoutFlag) {
			alert("<spring:message code='M01520' />");
			args.cancel = true;
			return false;
		}
	};

	var setAnalysisTreeViewNodeDropped = function(args) {
		var target = args.dropTarget;
		var targetArea = null;
		if (target.hasClass("chart_area")) {
			targetArea = target;
		} else if (target.next().hasClass("chart_area")) {
			targetArea = target.next();
		} else {
			args.cancel = true;
			return false;
		}

		var thisNode = args.droppedElementData;
		var thisNodeId = thisNode.id;

		var thisObject = null;
		var thisTreeData = this.getTreeData();
		$.each(thisTreeData, function(dataIdx, dataObject) {
			if (dataObject.nodeId === thisNodeId) {
				thisObject = dataObject;
				return false;
			}
		});

		var analysisFlag = false;
		if ($.fn.ifvmIsNotEmpty(thisObject)) {
			var targetAnalysisId = targetArea.data("analysisId");
			if (thisObject.nodeType === "R" && $.fn.ifvmIsEmpty(targetAnalysisId)) {
				analysisFlag = true;
			}
		}

		if (analysisFlag) {
			var tempNodeId = null;
			if (thisNodeId.startsWith("treeView_")) {
				tempNodeId = thisNodeId.substring("treeView_".length);
			} else {
				tempNodeId = thisNodeId;
			}

			var dashboardSeq = targetArea.attr("id").replace(/[^0-9]/gi, "");
			showDashboardAnalysisEmbedTypePop(dashboardSeq, tempNodeId);
		} else {
			args.cancel = true;
			return false;
		}
	};

	var showDashboardAnalysisEmbedTypePop = function(dashboardSeq, analysisId) {
		var dashboardEmbedTypePopId = "dashboardEmbedTypePop";
		var dashboardEmbedTypePop = $("#" + dashboardEmbedTypePopId);

		if ($.fn.ifvmIsEmpty(dashboardEmbedTypePop)) {
			dashboardEmbedTypePop = $("<div class='popup_container' />");
			dashboardEmbedTypePop.attr("id", dashboardEmbedTypePopId);
		}

		dashboardEmbedTypePop.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='dashboardEmbedTypePop' />",
			contentType : "ajax",
			title : "",
			width : "600px",
			beforeClose : function(args) {
				var dataFlag = dashboardEmbedTypePop.data("dataFlag");

				if ($.fn.ifvmIsNotEmpty(dataFlag) && dataFlag) {
					var dashboardEmbedType = dashboardEmbedTypePop.data("dashboardEmbedType");
					setDashboardAnalysisDetail(dashboardEmbedType, dashboardSeq, analysisId);
				}
			}
		});
	};

	var setDashboardAnalysisDetail = function(dashboardEmbedType, dashboardSeq, analysisId) {
		var dashboardId = getDashboardId();

		$.ifvSyncPostJSON("<ifv:action name='addDashboardAnalysisDetail' />", {
			dashboardId : dashboardId,
			dashboardEmbedType : dashboardEmbedType,
			dashboardSeq : dashboardSeq,
			analysisId : analysisId
		}, function(resData) {
			var analysisId = resData.analysisId;
			var analysisName = resData.analysisName;

			setDashboardAnalysisDetailCreate({
				dashboardEmbedType : dashboardEmbedType,
				dashboardSeq : dashboardSeq,
				analysisId : analysisId,
				analysisName : analysisName
			});
		});
	};

	var setDashboardAnalysisDetailCreate = function(dashboardAnalysisObject) {
		var targetId = "content_chart_" + dashboardAnalysisObject.dashboardSeq;
		var targetTitleId = "tit_chart_" + dashboardAnalysisObject.dashboardSeq;

		var targetObj = {
			targetId : targetId,
			analysisId : dashboardAnalysisObject.analysisId,
			analysisMasterFlag : "N",
			analysisTypeCode : dashboardAnalysisObject.dashboardEmbedType
		};

		$.fn.KPRAnalysisCreateReport(targetObj);
		$("#" + targetTitleId).text(dashboardAnalysisObject.analysisName);
		$("#" + targetId).data("analysisId", dashboardAnalysisObject.analysisId);
		$("#" + targetId).css({
			"background" : "#ffffff"
		});
	};

	var setDashboardButtonEvent = function() {
		$("#dashboardExit").click(function(evt) {
			setDashboardMoveLocation("LIST", "N");
		});

		$("#analysisNew").click(function(evt) {
			setDashboardMoveLocation("ANALYSIS", "N");
		});

		$("#dashboardNew").click(function(evt) {
			setDashboardMoveLocation("DASHBOARD", "N");
		});

		$("#dashboardSave").click(function(evt) {
			showDashboardSavePop(false);
		});

		$("#dashboardSaveAs").click(function(evt) {
			showDashboardSavePop(true);
		});

		$("#removeDashboard").click(function(evt) {
			setDashboardMoveLocation("LIST", "Y");
		});

		$("#dashboardPreview").click(function(evt) {
			showDashboardPreviewPop();
		});

		$("#dashboardPrompt").click(function(evt) {
			showDashboardPromptPop();
		});
	};

	var setDashboardMoveLocation = function(locationMoveType, dashboardMasterFlag) {
		if (confirm("<spring:message code='M01521' />")) {
			var dashboardId = getDashboardId();

			$.ifvProgressControl(true);
			$.ifvSyncPostJSON("<ifv:action name='removeDashboardDetail' />", {
				dashboardId : dashboardId,
				dashboardMasterFlag : dashboardMasterFlag
			}, function(resData) {
				$.ifvProgressControl(false);

				if (locationMoveType === "LIST") {
					qtjs.href("<ifv:url name='analysisList' />");
				} else if (locationMoveType === "ANALYSIS") {
					qtjs.href("<ifv:url name='analysisDetail' />");
				} else {
					qtjs.href("<ifv:url name='dashboardDetail' />");
				}
			});
		}
	};

	var showDashboardSavePop = function(saveAsFlag) {
		var layoutFlag = $("#dashboardArea").find("[id]").length === 0;

		if (layoutFlag === false) {
			var dashboardId = getDashboardId();

			var tagId = "dashboardSavePop";
			var dashboardSavePop = $("#" + tagId);
			var popupTitle = saveAsFlag ? "<spring:message code='M01524' />" : "<spring:message code='M01523' />";
			var dashboardName = saveAsFlag ? null : $("#dashboardTitle").data("dashboardName");
			var folderId = saveAsFlag ? null : $("#dashboardTitle").data("folderId");

			if ($.fn.ifvmIsEmpty(dashboardSavePop)) {
				dashboardSavePop = $("<div class='popup_container' />");
				dashboardSavePop.attr("id", tagId);
			}

			dashboardSavePop.data("dashboardId", dashboardId);
			dashboardSavePop.data("saveAsFlag", saveAsFlag);
			dashboardSavePop.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : "<ifv:url name='dashboardSavePop' />",
				contentType : "ajax",
				title : popupTitle,
				ajaxSuccess : function(args) {
					setDashboardSaveFolderTreeView(dashboardName, folderId);
				},
				beforeClose : function(args) {
					var executeFlag = dashboardSavePop.data("executeFlag");
					if ($.fn.ifvmIsNotEmpty(executeFlag) && executeFlag) {
						var dashboardId = getDashboardId();
						var dashboardData = dashboardSavePop.data("dashboardData");
						var saveAsFlag = dashboardSavePop.data("saveAsFlag");
						var targetUrl = saveAsFlag ? "<ifv:action name='editDashboardDetailSaveAs' />" : "<ifv:action name='editDashboardDetailSave' />";

						$.ifvProgressControl(true);
						$.ifvSyncPostJSON(targetUrl, {
							dashboardId : dashboardId,
							dashboardName : dashboardData.dashboardName,
							folderId : dashboardData.folderId
						}, function(resData) {
							alert("<spring:message code='C00094' />");

							$.ifvProgressControl(false);

							var dashboardId = resData.dashboardId;
							qtjs.href("<ifv:url name='dashboardDetail' />" + "?dashboardId=" + dashboardId);
						});
					}
				}
			});
		} else {
			alert("<spring:message code='M01522' />");
		}
	};

	var showDashboardPreviewPop = function() {
		var layoutFlag = $("#dashboardArea").find("[id]").length === 0;

		if (layoutFlag === false) {
			var tagId = "dashboardPreivewPop";
			var dashboardPreivewPop = $("#" + tagId);

			if ($.fn.ifvmIsEmpty(dashboardPreivewPop)) {
				dashboardPreivewPop = $("<div class='popup_container' />");
				dashboardPreivewPop.attr("id", tagId);
			}

			dashboardPreivewPop.ifvsfPopup({
				enableModal : true,
				enableResize : false,
				contentUrl : "<ifv:url name='dashboardPreviewPop' />",
				contentType : "ajax",
				width : "1000px",
				title : "<spring:message code='M01528' />",
				ajaxSuccess : function(args) {
					var dashboardId = getDashboardId();

					getDashboardPreviewDetail({
						dashboardId : dashboardId,
						dashboardPreviewPopId : tagId,
						analysisMasterFlag : "N"
					});
				}
			});
		} else {
			alert("<spring:message code='M01522' />");
		}
	};

	var showDashboardPromptPop = function() {
		var tagId = "dashboardPromptPop";
		var dashboardPromptPop = $("#" + tagId);
		var dashboardId = getDashboardId();

		if ($.fn.ifvmIsEmpty(dashboardPromptPop)) {
			dashboardPromptPop = $("<div class='popup_container' />");
			dashboardPromptPop.attr("id", tagId);
		}

		dashboardPromptPop.data("dashboardId", dashboardId);
		dashboardPromptPop.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='dashboardPromptPop' />",
			contentType : "ajax",
			title : "<spring:message code='M02434' />",
			ajaxSuccess : function(args) {
				setDashboardPromptDetail(tagId, dashboardId);
			}
		});
	};
	
	$(document).ready(function() {
		$.ifvmLnbSetting("analysisList");
		$("#dashboardTitle").data("defaultSetupButton", "<i class='fa fa-pencil-square-o pr5' style='cursor : pointer;'></i>");
		$("#dashboardTitle").data("defaultDeleteButton", "<i class='fa fa-times' style='cursor : pointer;'></i>");
		var dashboardId = $.ifvGetParam("dashboardId");

		setDashboardDetail(dashboardId);
		setDashboardLayout();
		setAnalytisTreeView();
		setDashboardButtonEvent();

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
	});

</script>

<div class="page-title">
	<h1>
		<spring:message code="M01545" />
		&gt;
		<spring:message code="M01532" />
	</h1>
</div>
<div>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span id="dashboardTitle"> <spring:message code="M01532" />
		</span>
	</div>

	<div class="col-xs-5 searchbtn_r">
		<button id="dashboardExit" class="btn btn-sm" objCode="dashboardExit_OBJ">
			<spring:message code="M01717" />
		</button>
	</div>
</div>
</div>
<!-- 툴바 -->
<div class="dashboard-header">
	<div class="dashboard-Toolbar">
		<div id="toolbarEvents" class="analysis_tool">
			<ul class="analysis_ico_tool" id="analysisToolBar">
				<li id="analysisNew" title="<spring:message code='M01533' />"><i class="fa fa-pie-chart"></i></li>

				<li id="dashboardNew" title="<spring:message code='M01534' />"><i class="fa fa-tachometer"></i></li>

				<li title="<spring:message code='M01535' />"><i class="fa fa-th"></i>
					<ul id="layoutList" class="tool_box layout_box"></ul></li>

				<li id="dashboardSave" title="<spring:message code='M00573' />"><i class="fa fa-floppy-o"></i></li>

				<li id="dashboardSaveAs" title="<spring:message code='M01428' />"><i class="fa fa-files-o"></i></li>

				<li id="removeDashboard" title="<spring:message code='M00165' />"><i class="fa fa-trash-o"></i></li>

				<li id="dashboardPreview" title="<spring:message code='M00392' />"><i class="fa fa-eye"></i></li>

				<li id="dashboardPrompt" title="<spring:message code='M02434' />"><i class="e-icon e-filter-settings"></i></li>
			</ul>
		</div>
	</div>
</div>

<div class="analysis_wrap clear_wrap">
	<div class="analysis_tree">
		<div id="ansList">
			<h3 class="acdn_title">
				<spring:message code="M01536" />
			</h3>

			<div id="treeView" class="left_tree_view" style="height: 700px;"></div>
		</div>
	</div>

	<div class="dashboard_wrap chart_wrap">
		<p class="dashboard_detail">
			<spring:message code="M01537" />
			&nbsp;&nbsp;
			<spring:message code="M01684" />
		</p>
		
		<div class="dashboard_area" id="dashboardArea">
			<p class="txt_dashboard">
				<spring:message code="M01538" />
			</p>
		</div>
	</div>
</div>

<script id="dashboardLayoutTemplate" type="text/x-jquery-tmpl">
	<li id="\${layoutId}"><img src="\${layoutImage}" /></li>
</script>