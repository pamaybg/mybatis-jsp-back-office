<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var COLUMN_CONFIG = {};
	COLUMN_CONFIG.COLUMN_ID = null;
	COLUMN_CONFIG.ANL_GROUP_FUNC_TYPE = "ANL_GROUP_FUNC_TYPE";
	COLUMN_CONFIG.COMB_COL_TYPE_CD = "COMB_COL_TYPE_CD";
	COLUMN_CONFIG.ANL_CALC_FLD_OPRT_TYPE = "ANL_CALC_FLD_OPRT_TYPE";

	var getAnalysisColumnMeasureDetail = function(columnId) {
		COLUMN_CONFIG.COLUMN_ID = columnId;

		$.ifvPostJSON("<ifv:action name='getAnalysisColumnDetail' />", {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			columnId : COLUMN_CONFIG.COLUMN_ID,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG
		}, function(rst) {
			if ($.fn.ifvmIsNotEmpty(rst.columnDisplayName)) {
				$("#columnDisplayName").val(rst.columnDisplayName);
			}

			if ($.fn.ifvmIsNotEmpty(rst.combColumnTypeCode)) {
				$("#combColumnTypeCode").val(rst.combColumnTypeCode);
			}

			if ($.fn.ifvmIsNotEmpty(rst.groupFuncTypeCode)) {
				$("#groupFuncTypeCode").val(rst.groupFuncTypeCode);
			}

			if ($.fn.ifvmIsNotEmpty(rst.columnDisplayRealName)) {
				var displayText = $("#displayColumnRealName").text();
				displayText = displayText + "( " + '<spring:message code="M01916" />' + " : " + rst.columnDisplayRealName + " )";
				$("#displayColumnRealName").text(displayText);
			}

			$("#negativeFlag").prop("checked", "Y" === rst.negativeFlag ? true : false);
			$("#hideYn").prop("checked", "Y" === rst.hideYn ? true : false);
			$("#decimalPlaces").val($.fn.ifvmIsNotEmpty(rst.decimalPlaces) ? rst.decimalPlaces : 0);

			var calcFieldTypeCode = rst.calcFieldTypeCode;
			if ($.fn.ifvmIsNotEmpty(calcFieldTypeCode) && calcFieldTypeCode === "Y") {
				// 계산 필드 사용
				$("#calcFieldSettingArea").show();

				$("#calcFieldTypeCode[value='Y']").attr("checked", true);

				$("#oprtTypeCode").val(rst.operationTypeCode);
				$("#rightGroupFuncTypeCode").val(rst.rightGroupFuncTypeCode);
				$("#rightAtribGroupColumn").val(rst.rightAtribGroupColumnId);
			} else {
				// 계산 필드 미사용
				$("#calcFieldSettingArea").hide();

				$("#calcFieldTypeCode[value='N']").attr("checked", true);
			}
		});
	};

	var setAnalysisColumnSave = function() {
		$.ifvProgressControl(true);
		var targetObj = {
			analysisId : ANALYSIS_CONFIG.ANALYSIS_ID,
			columnId : COLUMN_CONFIG.COLUMN_ID,
			columnDisplayName : $("#columnDisplayName").val(),
			groupFuncTypeCode : $("#groupFuncTypeCode").val(),
			combColumnTypeCode : ANALYSIS_CONFIG.CHART_TYPE_CD === ANALYSIS_CONFIG.COMBINATION ? $("#combColumnTypeCode").val() : null,
			analysisMasterFlag : ANALYSIS_CONFIG.ANALYSIS_MST_FLAG,
			columnTypeCode : ANALYSIS_CONFIG.COL_TYPE_CD.MEASURE,
			negativeFlag : $("#negativeFlag").is(":checked") ? "Y" : "N",
			hideYn : $("#hideYn").is(":checked") ? "Y" : "N"
		};

		var decimalPlaces = $("#decimalPlaces").val();
		if ($.fn.ifvmIsNotEmpty(decimalPlaces) && /^[0-9]*$/.test(decimalPlaces)) {
			targetObj.decimalPlaces = decimalPlaces;
		} else {
			alert("소수 자리수는 숫자만 입력 가능합니다.");
			$.ifvProgressControl(false);
			return false;
		}

		var calcFieldTypeCode = $("#calcFieldTypeCode[value='Y']").is(":checked"); // Y가 true 라면 계산 필드 사용한다는 의미이므로
		if (calcFieldTypeCode === true) {
			calcFieldTypeCode = "Y";
			targetObj.operationTypeCode = $("#oprtTypeCode").val();
			targetObj.rightGroupFuncTypeCode = $("#rightGroupFuncTypeCode").val();
			targetObj.rightAtribGroupColumnId = $("#rightAtribGroupColumn").val();
		} else {
			calcFieldTypeCode = "N";
		}

		targetObj.calcFieldTypeCode = calcFieldTypeCode;

		$.ifvPostJSON("<ifv:action name='editAnalysisColumnDetail' />", targetObj, function(rst) {
			setColumnNodeTextUpdate(COLUMN_CONFIG.COLUMN_ID, $("#columnDisplayName").val());
			$.ifvProgressControl(false);

			delete COLUMN_CONFIG;

			$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_MEASURE_POP).data("ejDialog").close();
		}, function(rst) {
			$.ifvProgressControl(false);
			alert(rst.message);
		});
	};

	$(document).ready(function() {
		if (ANALYSIS_CONFIG.CHART_TYPE_CD !== ANALYSIS_CONFIG.COMBINATION) {
			$("#combColumnTypeDiv").hide();
		}

		// 1. Column Base 리스트 가져옴
		$.ifvSyncPostJSON("<ifv:action name='getCommCodeList'/>", {
			groupCode : COLUMN_CONFIG.ANL_GROUP_FUNC_TYPE,
			enableNA : false
		}, function(rst) {
			var tmpl = $("#analysisOptionTypeCodeTemplate").tmpl(rst.rows);
			$("#groupFuncTypeCode").append(tmpl);

			var tmpl = $("#analysisOptionTypeCodeTemplate").tmpl(rst.rows);
			$("#rightGroupFuncTypeCode").append(tmpl);
		});

		$.ifvSyncPostJSON("<ifv:action name='getCommCodeList'/>", {
			groupCode : COLUMN_CONFIG.COMB_COL_TYPE_CD,
			enableNA : false
		}, function(rst) {
			var tmpl = $("#analysisOptionTypeCodeTemplate").tmpl(rst.rows);
			$("#combColumnTypeCode").append(tmpl);
		});

		$.ifvSyncPostJSON("<ifv:action name='getCommCodeList'/>", {
			groupCode : COLUMN_CONFIG.ANL_CALC_FLD_OPRT_TYPE,
			enableNA : false
		}, function(rst) {
			var tmpl = $("#analysisOptionTypeCodeTemplate").tmpl(rst.rows);
			$("#oprtTypeCode").append(tmpl);
		});

		$.ifvSyncPostJSON("<ifv:action name='getAnalysisAtribGroupColumnList' />", {
			logicalCompId : ANALYSIS_CONFIG.LOGICAL_COMP_ID
		}, function(rst) {
			var tmpl = $("#analysisAtribGroupColumnMeasureTemplate").tmpl(rst);
			$("#rightAtribGroupColumn").append(tmpl);
		});

		$("#analysisColumnSaveBtn").click(function(evt) {
			setAnalysisColumnSave();
		});

		$("#analysisColumnCancelBtn").click(function(evt) {
			$("#" + ANALYSIS_CONFIG.POPUP_ID.ANALYSIS_COLUMN_MEASURE_POP).data("ejDialog").close();
		});

		$("input[name=calcFieldTypeCode]").change(function(evt) {
			var value = this.value;

			if (value === "Y") {
				$("#calcFieldSettingArea").show();
			} else {
				$("#calcFieldSettingArea").hide();

				// 계산필드 사용 안함으로 선택할 시, 계산필드 관련 내용을 초기화
				$("#oprtTypeCode").val($("#oprtTypeCode").children().eq(0).val());
				$("#rightGroupFuncTypeCode").val($("#rightGroupFuncTypeCode").children().eq(0).val());
				$("#rightAtribGroupColumn").val($("#rightAtribGroupColumn").children().eq(0).val());
			}
		});
	});
</script>

<div class="pop_inner_wrap">
	<div class="analysis_setup_prompt form-horizontal temp_title_underline">
		<label class="radio-inline"> <ifv:input type="radio" names="calcFieldTypeCode" values="N" checked="true" id="calcFieldTypeCode" /> <spring:message code="M01902" />
		</label> <label class="radio-inline"> <ifv:input type="radio" names="calcFieldTypeCode" values="Y" id="calcFieldTypeCode" /> <spring:message code="M01903" />
		</label>
	</div>

	<div>
		<div class="temp_title_bb">
			<spring:message code="M01454" />
		</div>

		<div class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border">
				<label class="col-xs-4 control-label text-right"> <spring:message code="M01231" />
				</label>
				<div class="col-xs-8 control_content">
					<ifv:input type="text" id="columnDisplayName" names="columnDisplayNames" />
				</div>
			</div>
		</div>

		<div class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border">
				<label class="col-xs-4 control-label text-right"> 음수 표시 </label>
				<div class="col-xs-2 control_content">
					<span class="icheckbox"> <label> <input type="checkbox" id="negativeFlag" name="negativeFlag" value="Y">
					</label>
					</span>
				</div>

				<label class="col-xs-2 control-label text-right"> 소수 자리수 </label>
				<ifv:inputNew type="text" id="decimalPlaces" names="decimalPlaces" conClass="4" maxLength="1" minNum="0" values="0" />
			</div>
		</div>

		<div class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border" id="analysisGroupFunc">
				<label class="col-xs-4 control-label text-right"> <spring:message code="M01624" />
				</label>
				<div class="col-xs-8 control_content">
					<ifv:input type="select" id="groupFuncTypeCode" names="groupFuncTypeCode" />
				</div>
			</div>
		</div>

		<div class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border" id="combColumnTypeDiv">
				<label class="col-xs-4 control-label text-right"> <spring:message code="M01625" />
				</label>
				<div class="col-xs-8 control_content">
					<ifv:input type="select" id="combColumnTypeCode" names="combColumnTypeCode" />
				</div>
			</div>
		</div>
	</div>

	<div id="calcFieldSettingArea">
		<div class="temp_title_bb" id="displayColumnRealName">
			<spring:message code="M01904" />
		</div>

		<div class="analysis_setup_prompt form-horizontal">
			<div class="row qt_border">
				<div class="col-xs-2 control_content">
					<ifv:input type="select" id="oprtTypeCode" names="oprtTypeCode" />
				</div>
				<div class="col-xs-3 control_content">
					<ifv:input type="select" id="rightGroupFuncTypeCode" names="rightGroupFuncTypeCode" />
				</div>
				<div class="col-xs-7 control_content">
					<ifv:input type="select" id="rightAtribGroupColumn" names="rightAtribGroupColumn" />
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="analysisColumnSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00039" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="analysisColumnCancelBtn">
		<spring:message code="C00040" />
	</button>
</div>

<script id="analysisCalculateFieldTemplate" type="text/x-jquery-tmpl">
	<div class="col-xs-2">
		<ifv:input type="select" id="oprtTypeCode" names="oprtTypeCode" />
	</div>
	<div class="col-xs-3">
		<ifv:input type="select" id="rightGroupFuncTypeCode" names="rightGroupFuncTypeCode" />
	</div>
	<div class="col-xs-7">
		<ifv:input type="select" id="rightAtribGroupColumn" names="rightAtribGroupColumn" />
	</div>
</script>

<script id="analysisGroupFuncTemplate" type="text/x-jquery-tmpl">
	<div class="col-xs-4">
		<spring:message code="M01624" />
	</div>
	<div class="col-xs-8">
		<ifv:input type="select" id="groupFuncTypeCode" names="groupFuncTypeCode" />
	</div>
</script>

<script id="analysisAtribGroupColumnMeasureTemplate" type="text/x-jquery-tmpl">
	{{if columnTypeCode == "MEASURE"}}
    	<option value="${'${'}atribGroupColumnId}">${'${'}displayName}</option>
	{{/if}}
</script>