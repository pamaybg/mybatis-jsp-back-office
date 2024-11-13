<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ifv" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var setAnalysisLabelFontDetail = function(chartLabelFontDetail) {
		var fontTypeCode = chartLabelFontDetail.fontTypeCode;
		$.fn.ifvmSetSelectOptionCommCode("fontTypeCode", "FONT_TYPE_CD", fontTypeCode, null, true);

		var fontStyleTypeCode = chartLabelFontDetail.fontStyleTypeCode;
		$.fn.ifvmSetSelectOptionCommCode("fontStyleTypeCode", "FONT_STYLE_TYPE_CD", fontStyleTypeCode, null, true);

		var fontColor = chartLabelFontDetail.fontColor;
		fontColor = $.fn.ifvmIsNotEmpty(fontColor) ? fontColor : "#000000";
		$("#fontColor").ifvsfColorPicker({
			value : fontColor,
			modelType : "palette"
		});

		var fontSize = chartLabelFontDetail.fontSize;
		if ($.fn.ifvmIsNotEmpty(fontSize)) {
			$("#fontSize").val(fontSize);
		}
	};

	var saveAnalysisChartLabelFontDetail = function(_this) {
		var popupObject = $(_this).closest(".popup_container");
		var chartLabelFontDetail = popupObject.data("chartLabelFontDetail");

		var fontTypeCode = $("#fontTypeCode").val();
		var fontStyleTypeCode = $("#fontStyleTypeCode").val();
		var fontColor = $("#fontColor").val();
		var fontSize = $("#fontSize").val();

		chartLabelFontDetail.fontTypeCode = fontTypeCode;
		chartLabelFontDetail.fontStyleTypeCode = fontStyleTypeCode;
		chartLabelFontDetail.fontColor = fontColor;
		chartLabelFontDetail.fontSize = fontSize;

		popupObject.data("chartLabelFontDetail", chartLabelFontDetail);
		popupObject.data("executeFlag", true);
		popupObject.data("ejDialog").close();
	};

	$(document).ready(function() {
		$("#analysisChartLabelFontConfirmBtn").click(function(evt) {
			saveAnalysisChartLabelFontDetail(this);
		});

		$("#analysisChartLabelFontCancelBtn").click(function(evt) {
			var popupObject = $(this).closest(".popup_container");
			popupObject.data("executeFlag", false);
			popupObject.data("ejDialog").close();
		});
	});
</script>

<div class="pop_inner_wrap">
	<div class="analysis_setup_prompt form-horizontal">
		<!-- 글꼴 -->
		<div class="row qt_border">
			<label class="col-xs-3 control-label text-right"><spring:message code="L00549" /></label>
			<div class="col-xs-9 control_content">
				<ifv:input type="select" id="fontTypeCode" names="fontTypeCode" />
			</div>
		</div>

		<!-- 스타일 -->
		<div class="row qt_border">
			<label class="col-xs-3 control-label text-right"><spring:message code="L00550" /></label>
			<div class="col-xs-9 control_content">
				<ifv:input type="select" id="fontStyleTypeCode" names="fontStyleTypeCode" />
			</div>
		</div>
		<div class="row qt_border">
			<!-- 색 -->
			<label class="col-xs-3 control-label text-right"><spring:message code="L00551" /></label>
			<div class="col-xs-3 control_content">
				<ifv:input type="text" id="fontColor" names="fontColor" />
			</div>
			<!-- 크기 -->
			<label class="col-xs-3 control-label text-right"><spring:message code="L00552" /></label>
			<div class="col-xs-3 control_content">
				<ifv:input type="text" id="fontSize" names="fontSize" valOpt="number" values="10" />
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisChartLabelFontConfirmBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisChartLabelFontCancelBtn">
		<spring:message code="C00040" />
	</button>
</div>