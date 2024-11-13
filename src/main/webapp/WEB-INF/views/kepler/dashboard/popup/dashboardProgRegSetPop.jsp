<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="pop_inner_wrap">
	<div class="form-horizontal">
		<label><spring:message code="M01791" /></label>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="dashboardLayoutView">
		<spring:message code="M01535" />
	</button>

	<button class="btn btn-sm btn_gray" id="dashboardListView">
		<spring:message code="M02435" />
	</button>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$("#dashboardLayoutView").click(function() {
			setDashboardProgRegi(this, "LAYOUT_VIEW");
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("ejDialog").close();
		});

		$("#dashboardListView").click(function() {
			setDashboardProgRegi(this, "LIST_VIEW");
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("ejDialog").close();
		});
	});
	
	var setDashboardProgRegi = function(_this, dashboardType) {
		var popupObject = $(_this).closest(".popup_container");
		var dashboardData = popupObject.data("dashboardData");
		
		var userInfo = $.ifvmGetUserInfo();
		var progUrl = '<ifv:url name="progDetail"/>';
 		progUrl += "?acId=" + userInfo.id;
		progUrl += "&dashboardId=" + dashboardData.analysisId;		// 대시보드 아이디  :: 프로그램 ID로 사용됨 + 프로그램 경로를 설정함
		progUrl += "&dashboardNm=" + encodeURIComponent(dashboardData.analysisName);	// 대시보드 명	:: 프로그램 제목으로 사용됨
		progUrl += "&dashboardType=" + dashboardType; 

		qtjs.href(progUrl);
	};
</script>