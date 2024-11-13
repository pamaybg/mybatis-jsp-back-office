<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var setDashboardSavePopButtonEvent = function() {
		$("#dashboardSaveConfirm").click(function() {
			setDashboardSaveFolder(this);
		});

		$("#dashboardSaveCancel").click(function() {
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("executeFlag", false);
			popupObject.data("ejDialog").close();
		});
	};

	var setDashboardSaveFolder = function(_this) {
		var dashboardName = $("#dashboardName").val();
		if ($.fn.ifvmIsEmpty(dashboardName)) {
			alert("<spring:message code='M01527' />");
			return;
		}

		var dashboardTreeView = $("#dashboardTreeView").data("ejTreeView");
		var selectNode = dashboardTreeView.getSelectedNode();

		var folderId = null;
		if ($.fn.ifvmIsNotEmpty(selectNode)) {
			var parentNode = dashboardTreeView.getParent(selectNode);

			if ($.fn.ifvmIsNotEmpty(parentNode)) {
				folderId = selectNode.attr("id");
				folderId = folderId.substring(("dashboardTreeView_").length);
			} else {
				alert("<spring:message code='M01685' />");
				return false;
			}
		} else {
			alert("<spring:message code='M01526' />");
			return false;
		}

		if (confirm("<spring:message code='M01633' />")) {
			var popupObject = $(_this).closest(".popup_container");

			var dashboardId = popupObject.data("dashboardId");
			var saveAsFlag = popupObject.data("saveAsFlag");

			$.ifvPostJSON("<ifv:action name='getDashboardNameCheck' />", {
				dashboardId : dashboardId,
				dashboardName : dashboardName,
				folderId : folderId
			}, function(resData) {
				var nameFlag = resData.nameFlag;
				if (nameFlag) {
					popupObject.data("executeFlag", true);
					popupObject.data("dashboardData", {
						dashboardName : dashboardName,
						folderId : folderId
					});
					popupObject.data("ejDialog").close();
				} else {
					alert("<spring:message code='M01525' />");
				}
			});
		}
	};

	var setDashboardSaveFolderTreeView = function(dashboardName, folderId) {
		if ($.fn.ifvmIsNotEmpty(dashboardName)) {
			$("#dashboardName").val(dashboardName);
		}

		$("#dashboardTreeMenu").ifvsfAccordion();
		$("#dashboardTreeView").ifvmCreateKPRNodeTree({
			targetId : "dashboardTreeView",
			reportFlag : "N",
			setBtn : {
				add : true,
				mod : true,
				del : true
			},
			ready : function(args) {
				if ($.fn.ifvmIsNotEmpty(folderId)) {
					var dashboardFolderTreeView = $("#dashboardTreeView");
					var dashboardFolderTreeViewData = dashboardFolderTreeView.data("ejTreeView");

					var targetFolderId = "#dashboardTreeView_" + folderId;
					while ($.fn.ifvmIsNotEmpty(targetFolderId)) {
						var targetParentNode = dashboardFolderTreeViewData.getParent($(targetFolderId));

						if ($.fn.ifvmIsNotEmpty(targetParentNode)) {
							targetFolderId = targetParentNode.attr("id");
							dashboardFolderTreeViewData.expandNode(targetFolderId);
						} else {
							targetFolderId = null;
							break;
						}
					}

					dashboardFolderTreeViewData.selectNode($("#dashboardTreeView_" + folderId));
				}
			}
		});
		$("#dashboardTreeView").ifvmKPRNodeTreeSetButton();
	};

	$(document).ready(function() {
		setDashboardSavePopButtonEvent();
	});
</script>

<div class="pop_inner_wrap">
	<div>
		<label><spring:message code="M01541" /></label>
		<ifv:input type="text" required="true" id="dashboardName" maxLength="100" />
	</div>

	<label><spring:message code="M01549" /></label>
	<div id="dashboardTreeMenu">
		<h3>
			<spring:message code="M01536" />
		</h3>
		<div id="dashboardTreeView"></div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="dashboardSaveConfirm">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="dashboardSaveCancel">
		<spring:message code="C00040" />
	</button>
</div>