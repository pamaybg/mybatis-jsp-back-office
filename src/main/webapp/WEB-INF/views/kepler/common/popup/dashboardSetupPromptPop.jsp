<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />

<div class="pop_inner_wrap">
	<div id="dashboardPromptValueList" class="grid_bd0 con_size"></div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="dashboardSetupPromptConfirmBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00038" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="dashboardSetupPromptCancelBtn">
		<spring:message code="C00040" />
	</button>
</div>

<script type="text/javascript">
	var dashboardPromptValueList = null;
	var setDashboardSetupPromptValueList = function(promptData) {
		var columnId = promptData.columnId;

		var gridOptions = {
			radio : true,
			tempId : "ifvGridOriginTemplete",
			url : "<ifv:action name='getCommonColumnValueList' />",
			serializeGridData : function(data) {
				data.columnId = columnId;
				data.pagingFlag = true;
			},
			colNames : [
				"<spring:message code='M01233' />"
			],
			colModel : [
				{name : "colValue", index : "colValue", width : "200px", align : "center", resizable : false}
			],
			sortname : "1",
			sortorder : "desc"
		};
		
		dashboardPromptValueList = $("#dashboardPromptValueList").ifvGrid({
			jqGridOption : gridOptions
		});
	};
	
	var setDashboardSetupPromptValueData = function(_this) {
		var dashboardPromptValueCheckedList = dashboardPromptValueList.getCheckedList();
		
		if ($.fn.ifvmIsNotEmpty(dashboardPromptValueCheckedList)) {
			var popupObject = $(_this).closest(".popup_container");
			popupObject.data("dataFlag", true);
			popupObject.data("promptValue", dashboardPromptValueCheckedList[0]["colValue"]);
			popupObject.data("ejDialog").close();
		} else {
			alert( "<spring:message code='M00004' />" );
		}
	};

	$(document).ready(function() {
		$("#dashboardSetupPromptConfirmBtn").click(function() {
			setDashboardSetupPromptValueData(this);
		});

		$("#dashboardSetupPromptCancelBtn").click(function() {
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("dataFlag", false);

			popupObject.data("ejDialog").close();
		});
	});
</script>