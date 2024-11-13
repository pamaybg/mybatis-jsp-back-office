<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function initSelectData() {

    // Cost :: 혜택비용
    $.fn.ifvmSetSelectOptionCommCodeNoSync("costOfrBaseType", "CROI_COST_BASE_TYPE", null, null, false);
    $.fn.ifvmSetSelectOptionCommCodeNoSync("costOfrValPer", "CROI_COST_VAL_PER", null, null, false);

    // Cost :: 운영비용
    $.fn.ifvmSetSelectOptionCommCodeNoSync("costChnlBaseType", "CROI_COST_BASE_TYPE", null, null, false);

    // Benefit :: 산정방식
    $.fn.ifvmSetSelectOptionCommCodeNoSync("bnftCalcType", "CROI_BNFT_CALC_TYPE", null, null, false);
    $('#bnftCalcType').on('change', function() {
        var value = $(this).val();
        if (value == 'BV' || value == 'BW' || value == 'BJ') {
	        $('#bnftValPerAdd').parent().prev().html('<spring:message code="M02788"/>');
        }
        else {
	        $('#bnftValPerAdd').parent().prev().html('');
        }
    });

    // Benefit :: 대상자
    $.fn.ifvmSetSelectOptionCommCodeNoSync("bnftCalcTgtType", "CROI_BNFT_CALC_TGT_TYPE", null, null, false);
    $.fn.ifvmSetSelectOptionCommCodeNoSync("bnftCalcCompareType", "CROI_BNFT_CALC_COMPARE_TYPE", null, null, false);

    // Benefit :: 산정기간
    $.fn.ifvmSetSelectOptionCommCodeNoSync("bnftCalcDayType", "CROI_BNFT_CALC_DAY_TYPE", null, null, false);
    $.fn.ifvmSetSelectOptionCommCodeNoSync("bnftCalcDayInc", "CROI_CAL_DAY_INC", null, null, false);

}

/**
 * ROI 데이터를 화면에 보여준다
 */
function initRoiData() {
	$('#costOfrBaseType').val(campaignRoiGoalData.costOfrBaseType);
	$('#costOfrValPer').val(campaignRoiGoalData.costOfrValPer);
	$('#costChnlBaseType').val(campaignRoiGoalData.costChnlBaseType);
	$('#bnftCalcType').val(campaignRoiGoalData.bnftCalcType);
	$('#bnftCalcType').change();
	$('#bnftCalcTgtType').val(campaignRoiGoalData.bnftCalcTgtType);
	$('#bnftCalcCompareType').val(campaignRoiGoalData.bnftCalcCompareType);
	$('#bnftCalcDayType').val(campaignRoiGoalData.bnftCalcDayType);
	$('#bnftCalcDayInc').val(campaignRoiGoalData.bnftCalcDayInc);

	$('#costOfrVal').val(campaignRoiGoalData.costOfrVal);
	$('#costChnlVal').val(campaignRoiGoalData.costChnlVal);
	$('#costEtcVal').val(campaignRoiGoalData.costEtcVal);
	$('#bnftValPerAdd').val(campaignRoiGoalData.bnftValPerAdd);
	$('#bnftBnftVal').val(campaignRoiGoalData.bnftBnftVal);
	$('#bnftCalcDayVal').val(campaignRoiGoalData.bnftCalcDayVal);
	$('#costDesc').val(campaignRoiGoalData.costDesc);
}

$(document).ready(function() {

    initSelectData();
    initRoiData();

    //항목 내용 변수에 저장
    $('#campaignRoiArea select').on('blur', function() {
        var key = $(this).attr('id');
        var value = $(this).val();
        campaignRoiGoalData[key] = value;
    });
    $('#campaignRoiArea input').on('blur', function() {
        var key = $(this).attr('id');
        var value = $(this).val();
        campaignRoiGoalData[key] = value;
    });
    $('#campaignRoiArea textarea').on('blur', function() {
        var key = $(this).attr('id');
        var value = $(this).val();
        campaignRoiGoalData[key] = value;
    });
});

</script>

<script id="commCodeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="form-horizontal underline top_well clearfix" id="campaignRoiArea">

	<%-- Cost --%>
	<div class="page_btn_area">
		<div class="col-xs-12">
			<span><spring:message code="M02782"/></span>
		</div>
	</div>
	<div class="row">

		<%-- 혜택비용 --%>
		<ifvm:inputNew type="select" label="M02783" labelClass="2" conClass="4" id="costOfrBaseType" names="costOfrBaseType"/>
		<div class="col-xs-2">
			<ifvm:inputNew type="text" maxLength="10" conClass="10" className="text-right" id="costOfrVal" names="costOfrVal"/>
			<div class="col-xs-2">
				<span class="add_text"><spring:message code="C00123"/></span>
			</div>
		</div>
		<ifvm:inputNew type="select" conClass="2" id="costOfrValPer" names="costOfrValPer"/>
	</div>
	<div class="row">

		<%-- 운영비용 --%>
		<ifvm:inputNew type="select" label="M02784" labelClass="2" conClass="4" id="costChnlBaseType" names="costChnlBaseType"/>
		<div class="col-xs-2">
			<ifvm:inputNew type="text" maxLength="10" conClass="10" className="text-right" id="costChnlVal" names="costChnlVal"/>
			<div class="col-xs-2">
				<span class="add_text"><spring:message code="C00123"/></span>
			</div>
		</div>
	</div>
	<div class="row">

		<%-- 기타비용 --%>
		<div class="col-xs-6">
			<ifvm:inputNew type="text" label="M02785" maxLength="10" labelClass="4" conClass="8" className="text-right" id="costEtcVal"/>
		</div>
		<div class="col-xs-6">
			<span class="add_text"><spring:message code="C00123"/></span>
		</div>
	</div>
	<div class="row">

		<%-- 비고 --%>
		<div class="col-xs-12">
			<ifvm:inputNew type="textarea" label="M02777" labelClass="2" conClass="9" rows="5" id="costDesc"/>
		</div>
	</div>

	<%-- Benefit --%>
	<div class="page_btn_area">
		<div class="col-xs-12">
			<span><spring:message code="M02786"/></span>
		</div>
	</div>
	<div class="row">

		<%-- 산정방식 --%>
		<ifvm:inputNew type="select" label="M02787" labelClass="2" conClass="3" id="bnftCalcType" names="bnftCalcType"/>
		<div class="col-xs-6">
			<!-- 인당 -->
			<ifvm:inputNew type="text" label="M02788" maxLength="10" labelClass="6" conClass="6" id="bnftValPerAdd" className="text-right"/>
		</div>
	</div>
	<div class="row">

		<%-- 대상자 --%>
		<div class="col-xs-6">
			<ifvm:inputNew type="select" label="M02789" labelClass="4" conClass="6" id="bnftCalcTgtType" names="bnftCalcTgtType"/>
		</div>

		<%-- 비교유형 --%>
		<div class="col-xs-6">
			<ifvm:inputNew type="select" label="M02790" labelClass="4" conClass="6" id="bnftCalcCompareType" names="bnftCalcCompareType"/>
		</div>
	</div>
	<div class="row">

		<%-- 산정기간 --%>
		<ifvm:inputNew type="select" label="M02791" labelClass="2" conClass="3" id="bnftCalcDayType" names="bnftCalcDayType"/>
		<div class="col-xs-3">
			<ifvm:inputNew type="select" conClass="9" id="bnftCalcDayInc" names="bnftCalcDayInc"/>
			<div class="col-xs-3">
				<span class="add_text"><spring:message code="M02820"/></span>
			</div>
		</div>
		<div class="col-xs-3">
			<ifvm:inputNew type="text" maxLength="10" conClass="4" className="text-right" id="bnftCalcDayVal"/>
			<div class="col-xs-8">
				<span class="add_text"><spring:message code="M02821"/></span>
			</div>
		</div>
	</div>
	<div class="row">

		<%-- 공헌이익 --%>
		<div class="col-xs-4">
			<ifvm:inputNew type="text" maxLength="10" label="M02792" labelClass="6" conClass="6" className="text-right" id="bnftBnftVal"/>
		</div>
		<div class="col-xs-8">
			<span class="add_text"><spring:message code="M02786"/></span>
		</div>
	</div>
</div>