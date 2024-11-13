<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var setDashboardEmbedType = function(_this, dashboardEmbedType) {
		var popupObject = $(_this).closest(".popup_container");
		popupObject.data("dataFlag", true);
		popupObject.data("dashboardEmbedType", dashboardEmbedType);
		popupObject.data("ejDialog").close();
	};

	$(document).ready(function() {
		$("#analysisTypeTable").click(function(evt) {
			setDashboardEmbedType(this, "TABLE");
		});
		$("#analysisTypeChart").click(function(evt) {
			setDashboardEmbedType(this, "CHART");
		});
	});
</script>

<div class="pop_inner_wrap">
	<div class="form-horizontal">
		<label><spring:message code="M01539" /></label>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisTypeTable">
		<spring:message code="M01175" />
	</button>
	<button class="btn btn-sm btn_gray" id="analysisTypeChart">
		<spring:message code="M01540" />
	</button>
</div>