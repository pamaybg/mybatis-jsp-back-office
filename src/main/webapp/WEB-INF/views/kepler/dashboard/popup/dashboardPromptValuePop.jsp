<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="pop_inner_wrap">
	<div class="form-horizontal">
		<div class="row">
			<div class="col-xs-12">
				<div class="temp-title">
					<label class="radio-inline">
						<ifv:input type="radio" names="enableDateFunc" values="false" checked="true" id="enableDateFunc" />
						<spring:message code="M01726" />
					</label>
					<label class="radio-inline">
						<ifv:input type="radio" names="enableDateFunc" values="true" id="enableDateFunc" />
						<spring:message code="M01727" />
					</label>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
				<div id="dashboardPromptValueList" class="grid_bd0 con_size"></div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="dashboardPromptValueSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00038" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="dashboardPromptValueCancelBtn">
		<spring:message code="C00040" />
	</button>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("input[name='enableDateFunc']").change(function(evt) {
			var popupObject = $(this).closest(".popup_container");
			var popupId = popupObject.attr("id");

			var enableFlag = this.value === "true";
			setDashboardPromptValueList(popupId, enableFlag);
		});
		
		$("#dashboardPromptValueSaveBtn").click(function(evt) {
			setDashboardPromptValueData(this);
		});
		
		$("#dashboardPromptValueCancelBtn").click(function(evt) {
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("dataFlag", false);

			popupObject.data("ejDialog").close();
		});
	});

	var dashboardPromptValueList = null;
	var setDashboardPromptValueList = function(popupId, enableFlag) {
		var columnId = $("#" + popupId).data("columnId");

		var gridOptions = {
			radio : true,
			tempId : "ifvGridOriginTemplete"
		};

		if (enableFlag) {
			gridOptions.url = "<ifv:action name='getCommonDateCodeList' />";
			gridOptions.colNames = [
				"<spring:message code='M01206' />",
				"<spring:message code='M01233' />",
				"<spring:message code='M01725' />"
			];
			gridOptions.colModel = [
				{name : "codeName", index : "codeName", resizable : false, align : "center"},
				{name : "markName", index : "markName", resizable : false, align : "center"},
				{name : "funcValue", resizable : false, align : "center"}
			];
			gridOptions.sortname = "seq";
			gridOptions.sortorder = "asc";
		} else {
			gridOptions.url = "<ifv:action name='getCommonColumnValueList' />";
			gridOptions.serializeGridData = function(data) {
				data.columnId = columnId;
				data.pagingFlag = true;
			};
			gridOptions.colNames = [
				"<spring:message code='M01233' />"
			];
			gridOptions.colModel = [
				{name : "colValue", index : "colValue", width : "200px", align : "center", resizable : false}
			];
			gridOptions.sortname = "1";
			gridOptions.sortorder = "asc";
		}

		dashboardPromptValueList = $("#dashboardPromptValueList").ifvGrid({
			jqGridOption : gridOptions
		});
	};
	
	var setDashboardPromptValueData = function(_this) {
		var dashboardPromptValueCheckedList = dashboardPromptValueList.getCheckedList();
		
		if ($.fn.ifvmIsNotEmpty(dashboardPromptValueList)) {
			var popupObject = $(_this).closest(".popup_container");
			popupObject.data("dataFlag", true);
			
			var resObject = new Object();
			if ($.fn.ifvmIsNotEmpty(dashboardPromptValueCheckedList[0]["colValue"])) {
				resObject.codeName = dashboardPromptValueCheckedList[0]["colValue"];
				resObject.markName = dashboardPromptValueCheckedList[0]["colValue"];
			} else {
				resObject.codeName = dashboardPromptValueCheckedList[0]["codeName"];
				resObject.markName = dashboardPromptValueCheckedList[0]["markName"];
			}
			
			popupObject.data("promptValue", resObject);
			popupObject.data("ejDialog").close();
		} else {
			alert( "<spring:message code='M00004' />" );
		}
	};
</script>