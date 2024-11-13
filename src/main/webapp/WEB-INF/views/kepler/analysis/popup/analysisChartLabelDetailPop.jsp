<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style type="text/css">
.analysisAxisTitleArea .input-group-btn button {
	background-color: #eee !important;
	border: 1px solid #ccc !important;
	color: #999999 !important;
	margin: 0px 0px 0px -1px !important;
	padding: 0px !important;
	height: 22px;
}
</style>

<script type="text/javascript">
	function setAnalysisChartSettingDetail(analysisId) {
		var type;
		$.ifvSyncPostJSON('<ifv:action name="getAnalysisChartLabelDetail" />',{
			analysisId : analysisId
		}, function(resData) {
			var chartTypeCode = resData.chartTypeCode;
			chartTypeCode = chartTypeCode.replace("_3D", "");
			resData.chartTypeCode = chartTypeCode;

			if (chartTypeCode.indexOf("PIE") > -1 || chartTypeCode.indexOf("DOUGHNUT") > -1) {
				$("#axisTitleAreaDiv").remove();

				var analysisDataDisplayTemplate = $("#analysisDataDisplayTemplate").tmpl();
				$("#analysisChartLabelArea").append(analysisDataDisplayTemplate);

				$.fn.ifvmSetSelectOptionCommCode("dataDisplayTypeCode", "ANL_CHART_DISPLAY_TYPE", resData.displayTypeCode, null, true);
				$.fn.ifvmSetSelectOptionCommCode("dataUnitTypeCode", "ANL_CHART_DISPLAY_LABEL_CD", resData.leftLabelTypeCode, null, true);
			} else {
				var analysisAxisTitleTemplate = $("#analysisAxisTitleTemplate").tmpl(resData);
				$("#analysisAxisTitleArea").append(analysisAxisTitleTemplate);

				var analysisChartLabelTemplate = $("#analysisChartLabelTemplate").tmpl(resData);
				$("#analysisChartLabelArea").append(analysisChartLabelTemplate);

				$("#horizontalName").val(resData.horizontalName);
				$("#leftVerticalName").val(resData.leftVerticalName);

				$.fn.ifvmSetSelectOptionCommCode("leftChartLabelTypeCode", "ANL_CHART_DISPLAY_LABEL_CD", resData.leftLabelTypeCode, null, true);
				if (chartTypeCode === "COMBINATION") {
					$.fn.ifvmSetSelectOptionCommCode("rightChartLabelTypeCode", "ANL_CHART_DISPLAY_LABEL_CD", resData.rightLabelTypeCode, null, true);

					$("#rightVerticalName").val(resData.rightVerticalName);
				}
			}

			var legendPositionTypeCode = $.fn.ifvmIsNotEmpty(resData.legendPositionTypeCode) ? resData.legendPositionTypeCode : "BOTTOM";
			$("#chartLegendPositionTypeCode").val(legendPositionTypeCode);

			$(".fontSetting").click(function(evt) {
				type = $(this).attr("labeltype");
				
				if(type != null && type != ''){
					showAnalysisLabelFontDetailPop(type);
					type = null;
				}else{
				}
			});

			var chartLabelFontList = resData.chartLabelFontList;
			if ($.fn.ifvmIsNotEmpty(chartLabelFontList)) {
				$.each(chartLabelFontList, function(dataIdx, dataObject) {
					var chartLabelTypeCode = dataObject.chartLabelTypeCode;

					$("[labeltype='" + chartLabelTypeCode + "']").data("chartLabelFontDetail", dataObject);
				});
			} 
		});
	};

	var showAnalysisLabelFontDetailPop = function(labelType) {
		var analysisLabelFontDetailPopId = "analysisLabelFontDetailPop";
		var analysisLabelFontDetailPop = $("#" + analysisLabelFontDetailPopId);

		if ($.fn.ifvmIsEmpty(analysisLabelFontDetailPop)) {
			analysisLabelFontDetailPop = $("<div class='popup_container' />");
			analysisLabelFontDetailPop.attr("id", analysisLabelFontDetailPopId);
		}

		var chartLabelFontDetail = $("[labeltype='" + labelType + "']").data("chartLabelFontDetail");
		chartLabelFontDetail = $.fn.ifvmIsNotEmpty(chartLabelFontDetail) ? chartLabelFontDetail : new Object();
		analysisLabelFontDetailPop.data("chartLabelFontDetail", chartLabelFontDetail);

		analysisLabelFontDetailPop.ifvsfPopup({
			enableModal : true,
			enableResize : false,
			contentUrl : "<ifv:url name='analysisChartLabelFontDetailPop' />",
			contentType : "ajax",
			title : "<spring:message code='L00549' />",
			width : "400px",
			async : true,
			ajaxSuccess : function(args) {
				setAnalysisLabelFontDetail(chartLabelFontDetail);
			},
			beforeClose : function(args) {
				var executeFlag = analysisLabelFontDetailPop.data("executeFlag");
				if ($.fn.ifvmIsNotEmpty(executeFlag) && executeFlag) {
					var chartLabelFontDetail = analysisLabelFontDetailPop.data("chartLabelFontDetail");
					$("[labeltype='" + labelType + "']").data("chartLabelFontDetail", chartLabelFontDetail);
				}
			}
		});
	};

	var saveAnalysisChartLabelDetail = function(_this) {
		if (confirm("<spring:message code='M01635' />")) {
			var targetObject = new Object();
			targetObject.analysisId = ANALYSIS_CONFIG.ANALYSIS_ID;
			targetObject.analysisMasterFlag = ANALYSIS_CONFIG.ANALYSIS_MST_FLAG;
			targetObject.chartLegendPositionTypeCode = $("#chartLegendPositionTypeCode").val();
			targetObject.horizontalName = $("#horizontalName").val();
			targetObject.leftVerticalName = $("#leftVerticalName").val();
			targetObject.rightVerticalName = $("#rightVerticalName").val();
			targetObject.leftChartLabelTypeCode = $("#leftChartLabelTypeCode").val();
			targetObject.rightChartLabelTypeCode = $("#rightChartLabelTypeCode").val();
			targetObject.dataDisplayTypeCode = $("#dataDisplayTypeCode").val();
			targetObject.dataUnitTypeCode = $("#dataUnitTypeCode").val();

			var chartLabelFontList = new Array();
			var analysisChartLabelFontList = $("[labeltype]");
			$.each(analysisChartLabelFontList, function(dataIdx, dataObject) {
				var chartLabelFontDetail = $(dataObject).data("chartLabelFontDetail");
				if ($.fn.ifvmIsNotEmpty(chartLabelFontDetail)) {
					var chartLabelTypeCode = $(dataObject).attr("labeltype");
					chartLabelFontDetail.chartLabelTypeCode = chartLabelTypeCode;

					chartLabelFontList.push(chartLabelFontDetail);
				}
			});

			targetObject.chartLabelFontList = chartLabelFontList;

			var popupObject = $(_this).closest(".popup_container");

			$.ifvProgressControl(true);
			$.ifvPostJSON("<ifv:action name='editAnalysisChartLabelDetail' />", targetObject, function(resData) {
				alert("<spring:message code='C00094' />");
				$.ifvProgressControl(false);

				window[popupObject.attr('id')]._destroy();
			});
		}
	};

	$(document).ready(function() {
		$.fn.ifvmSetSelectOptionCommCode("chartLegendPositionTypeCode", "ANL_LEGEND_POS_CD", null, null, true);
		
		$("#analysisChartLabelConfirmBtn").click(function(evt) {
			saveAnalysisChartLabelDetail(this);
		});

		$("#analysisChartLabelCancelBtn").click(function(evt) {
			var popupObject = $(this).closest(".popup_container");
			window[popupObject.attr('id')]._destroy();
		});
	});
</script>

<div class="pop_inner_wrap" id="analysisChartLabelDetail">
	<%-- 축 제목 --%>
	<div id="axisTitleAreaDiv">
		<div class="temp_title_bb">
			<spring:message code="L00544" />
		</div>
		<div id="analysisAxisTitleArea" class="analysisAxisTitleArea analysis_setup_prompt form-horizontal"></div>
	</div>

	<%-- 레이블 --%>
	<div id="chartLabelDetailDiv">
		<div class="temp_title_bb">
			<spring:message code="C00059" />
		</div>
		<div id="analysisChartLabelArea" class="analysis_setup_prompt form-horizontal"></div>
	</div>

	<%-- 범례 위치 설정 --%>
	<div class="temp_title_bb">
		<spring:message code="L00542" />
	</div>
	<div id="chartLegendPositionDiv" class="analysis_setup_prompt form-horizontal">
		<div class="row qt_border">
			<label class="col-xs-3 control-label text-right"><spring:message code="L00543" /></label>
			<div class="col-xs-9 control_content">
				<ifv:input type="select" id="chartLegendPositionTypeCode" names="chartLegendPositionTypeCode" />
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisChartLabelConfirmBtn" objCode="analysisChartLabelConfirmBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisChartLabelCancelBtn" objCode="analysisChartLabelCancelBtn_OBJ">
		<spring:message code="C00040" />
	</button>
</div>

<script id="analysisAxisTitleTemplate" type="text/x-jquery-tmpl">
	<%-- 가로축 단위 설정 가능 (세로축 단위 비활성화) --%>
	<%-- {{if chartTypeCode === "BAR" || chartTypeCode === "STACKINGBAR" || chartTypeCode === "STACKINGBAR100"}} --%>
    <div class="row qt_border">
        <label class="col-xs-3 control-label text-right">
			{{if chartTypeCode === "BAR" || chartTypeCode === "STACKINGBAR" || chartTypeCode === "STACKINGBAR100"}}
				<spring:message code="L00548" />
			{{else}}
				<spring:message code="L00545" />
			{{/if}}
        </label>
        <div class="col-xs-9 control_content">
            <div class="input-group">
                <ifv:input type="text" id="horizontalName" />
                <span class="input-group-btn">
                    <button class="btn btn-default fontSetting" type="button" id="horizontalName" labeltype="H">Go!</button>
                </span>
            </div><!-- /input-group -->
        </div>
    </div>

	<%-- {{else}} --%>
    	<%-- 세로축 단위 설정 가능 (가로축 단위 비활성화) --%>
    	<div class="row qt_border">
    	    <label class="col-xs-3 control-label text-right">
	            {{if chartTypeCode === "BAR" || chartTypeCode === "STACKINGBAR" || chartTypeCode === "STACKINGBAR100"}}
                	<spring:message code="L00545" />
            	{{else}}
                	{{if chartTypeCode === "COMBINATION"}}
                    	<spring:message code="L00546" />
                	{{else}}
                    	<spring:message code="L00548" />
                	{{/if}}
	            {{/if}}
        	</label>
        	<div class="col-xs-9 control_content">
            	<div class="input-group">
                	<ifv:input type="text" id="leftVerticalName" />
                	<span class="input-group-btn">
                    	<button class="btn btn-default fontSetting" type="button" id="leftVerticalNameBtn" labeltype="V1">Go!</button>
                	</span>
            	</div><!-- /input-group -->
        	</div>
    	</div>
	<%-- {{/if}} --%>

    {{if chartTypeCode == "COMBINATION"}}
        <div class="row qt_border">
            <label class="col-xs-3 control-label text-right"><spring:message code="L00547" /></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifv:input type="text" id="rightVerticalName" />
                    <span class="input-group-btn">
                        <button class="btn btn-default fontSetting" type="button" id="rightVerticalNameBtn" labeltype="V2">Go!</button>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>
    {{/if}}
</script>

<script id="analysisChartLabelTemplate" type="text/x-jquery-tmpl">
	<div class="row qt_border">
		{{if chartTypeCode != "COMBINATION"}}
			<label class="col-xs-3 control-label text-right"><spring:message code="M01720" /></label>
		{{else}}
			<label class="col-xs-3 control-label text-right"><spring:message code="M01721" /></label>
		{{/if}}

		<div class="col-xs-9 control_content">
			<ifv:input type="select" id="leftChartLabelTypeCode" names="leftChartLabelTypeCode" />
		</div>
	</div>
	{{if chartTypeCode == "COMBINATION"}}
		<div class="row qt_border">
			<label class="col-xs-3 control-label text-right"><spring:message code="M01722" /></label>

			<div class="col-xs-9 control_content">
				<ifv:input type="select" id="rightChartLabelTypeCode" names="rightChartLabelTypeCode" />
			</div>
		</div>
	{{/if}}
</script>

<script id="analysisDataDisplayTemplate" type="text/x-jquery-tmpl">
	<div class="row qt_border">
		<label class="col-xs-3 control-label text-right"><spring:message code="M01723" /></label>

		<div class="col-xs-9 control_content">
			<ifv:input type="select" id="dataDisplayTypeCode" names="dataDisplayTypeCode" />
		</div>
	</div>
	<div class="row qt_border">
		<label class="col-xs-3 control-label text-right"><spring:message code="M01724" /></label>

		<div class="col-xs-9 control_content">
			<ifv:input type="select" id="dataUnitTypeCode" names="dataUnitTypeCode" />
		</div>
	</div>
</script>