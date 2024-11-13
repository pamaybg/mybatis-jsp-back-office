<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="pop_inner_wrap" id="analysisChartLabelDetail">
	<div class="analysis_setup_prompt form-horizontal">
		<div class="row qt_border">
			<label class="col-xs-2 control-label text-right">Column 합계 설정</label>
			<div class="col-xs-10 control_content">
				<ifv:input type="select" id="colTotalTypeCode" names="colTotalTypeCode" />
			</div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-2 control-label text-right">Row 합계 설정</label>
			<div class="col-xs-10 control_content">
				<ifv:input type="select" id="rowTotalTypeCode" names="rowTotalTypeCode" />
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisTableDetailConfirm" objCode="analysisTableDetailConfirm_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisTableDetailCancel" objCode="analysisTableDetailCancel_OBJ">
		<spring:message code="C00040" />
	</button>
</div>

<script type="text/javascript">
	var analysisConfigAnalysisId;
	function setAnalysisTableDetail(analysisId){
		analysisConfigAnalysisId = analysisId
		$.ifvPostJSON("<ifv:action name='getAnalysisTableDetail' />", {
			analysisId : analysisConfigAnalysisId
		}, function(resData) {
			$("#colTotalTypeCode").ifvmSetSelectOptionCommCode("colTotalTypeCode", "ANL_TOT_TYPE_CD", resData.colTotalTypeCode, null, false);
			$("#rowTotalTypeCode").ifvmSetSelectOptionCommCode("rowTotalTypeCode", "ANL_TOT_TYPE_CD", resData.rowTotalTypeCode, null, false);
		})
	}


	$(document).ready(function() {

		$("#analysisTableDetailConfirm").click(function(evt) {
			var _this = this;

			$.ifvPostJSON("<ifv:action name='editAnalysisTableDetail' />", {
				analysisId : analysisConfigAnalysisId,
				colTotalTypeCode : $("#colTotalTypeCode").val(),
				rowTotalTypeCode : $("#rowTotalTypeCode").val()
			}, function(resData) {
				$(_this).closest(".popup_container").data("ejDialog").close();
			});
		});

		$("#analysisTableDetailCancel").click(function(evt) {
			$(this).closest(".popup_container").data("ejDialog").close();
		});
	});
</script>