<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var goalValidation;

function initSelectData() {

    // KPI상세 :: 캠페인 대상자
    $.fn.ifvmSetSelectOptionCommCodeNoSync("kpiTgtType", "CROI_KPI_TARGET", null, null, false);

    // KPI상세 :: 비교대상
    $.fn.ifvmSetSelectOptionCommCodeNoSync("kpiCompareType", "CROI_KPI_COMPARE_TYPE", null, null, false);

    // KPI상세 :: 목표KPI  kpiGoalText
    //$.fn.ifvmSetSelectOptionCommCodeNoSync("kpiGoalType", "CROI_KPI_CAL_DAY_TYPE", null, null, false);

    $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
          groupCode: 'CROI_KPI_CAL_DAY_TYPE'
        , enableNA: true
    }, function(result) {
       	var temp = $("#kpiCommCodeTemp").tmpl(result.rows);
       	$("#kpiGoalType").append(temp);
    });

    // KPI상세 :: 측정대상
    $.fn.ifvmSetSelectOptionCommCodeNoSync("kpiCalDayType", "CROI_CAL_DAY_TYPE", null, null, false);
    $.fn.ifvmSetSelectOptionCommCodeNoSync("kpiCalDayInc", "CROI_CAL_DAY_INC", null, null, false);

    var monthArry = [];
    for (var i = 0 ; i <= 12 ; i++) {
        monthArry.push({codeName: i, markName: i});
    }
    var temp = $("#commCodeTemp").tmpl(monthArry);
    $("#kpiCalDayVal").append(temp);

    $.fn.ifvmSetSelectOptionCommCodeNoSync("kpiCalDayValUnit", "CROI_CAL_DAY_UNIT", null, null, false);
    $('#kpiCalDayValUnit option[value=M]').prop('selected', true);
    $('#kpiCalDayValUnit').attr('disabled', 'disabled');
    campaignRoiGoalData.kpiCalDayValUnit = 'M';

    // 반응율 :: 측정대상자
    $.fn.ifvmSetSelectOptionCommCodeNoSync("respTgtType", "CROI_RESP_TGT_TYPE", null, null, false);

    // 반응율 :: 반응유형
    $.fn.ifvmSetSelectOptionCommCodeNoSync("respType", "CROI_RESP_TYPE", null, null, false);

    // 반응율 :: 측정기간
    $.fn.ifvmSetSelectOptionCommCodeNoSync("respCalDayType", "CROI_CAL_DAY_TYPE", null, null, false);
    $.fn.ifvmSetSelectOptionCommCodeNoSync("respCalDayInc", "CROI_CAL_DAY_INC", null, null, false);
    $.fn.ifvmSetSelectOptionCommCodeNoSync("respCalDayValUnit", "CROI_CAL_DAY_UNIT", null, null, false);

//     $('#respCalDayValUnit').on('change', function() {
//         if ($('#respCalDayValUnit').val() == 'M') {
//             $.fn.ifvmSetSelectOptionCommCode("respCalDayVal", "CROI_MONTH", null, null, false);
//         }
//         else {
//             $.fn.ifvmSetSelectOptionCommCode("respCalDayVal", "CROI_DATE", null, null, false);
//         }
//     })
}

/**
 * 목표 데이터를 화면에 보여준다
 */
function initGoleData() {
	$('#kpiTgtType').val(campaignRoiGoalData.kpiTgtType);
	$('#kpiCompareType').val(campaignRoiGoalData.kpiCompareType);
	$('#kpiGoalType').val(campaignRoiGoalData.kpiGoalType);
	$('#kpiCalDayType').val(campaignRoiGoalData.kpiCalDayType);
	$('#kpiCalDayInc').val(campaignRoiGoalData.kpiCalDayInc);
	$('#kpiCalDayVal').val(campaignRoiGoalData.kpiCalDayVal);
	$('#kpiCalDayValUnit').val(campaignRoiGoalData.kpiCalDayValUnit);
	$('#respTgtType').val(campaignRoiGoalData.respTgtType);
	$('#respType').val(campaignRoiGoalData.respType);
	$('#respCalDayType').val(campaignRoiGoalData.respCalDayType);
	$('#respCalDayInc').val(campaignRoiGoalData.respCalDayInc);
	$('#respCalDayValUnit').val(campaignRoiGoalData.respCalDayValUnit);
	$('#respCalDayValUnit').change();
	$('#respCalDayVal').val(campaignRoiGoalData.respCalDayVal);
	$('#kpiRespDesc').val(campaignRoiGoalData.kpiRespDesc);
	$('#kpiGoalVal').val(campaignRoiGoalData.kpiGoalVal);
}

$(document).ready(function() {

    initSelectData();
   	initGoleData();

    //항목 내용 저장
    $('#campaignGoalArea select').on('blur', function() {
        var key = $(this).attr('id');
        var value = $(this).val();
        if (goalValidation.confirm()) {
	        campaignRoiGoalData[key] = value;
        }
    });
    $('#campaignGoalArea input').on('blur', function() {
        var key = $(this).attr('id');
        var value = $(this).val();
        if (goalValidation.confirm()) {
	        campaignRoiGoalData[key] = value;
        }
    });
    $('#campaignGoalArea textarea').on('blur', function() {
        var key = $(this).attr('id');
        var value = $(this).val();
        if (goalValidation.confirm()) {
	        campaignRoiGoalData[key] = value;
        }
    });

    $('#respType').on('change', function() {

        var value = $(this).val();
		if (value == 'RRO' || value == 'RRS' || value == 'RRL' || value == 'RRA' ) {
		    $('#respCalDayValUnit').removeAttr('disabled');
		}
		else {
		    $('#respCalDayValUnit option[value=M]').prop('selected', true);
		    $('#respCalDayValUnit').attr('disabled', 'disabled');
		    campaignRoiGoalData.respCalDayValUnit = 'M';
		}
    });

    // 목표KPI 변경시 목표치의 단위 변경
    $('#kpiGoalType').on('change', function() {
        $('#kpiGoalText').val($('#kpiGoalType option:selected').data('attrib01'))
    });
    goalValidation = $("#campaignGoalArea").ifvValidation();
})

</script>

<script id="commCodeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}" data-attrib01="${'${'}attrib01}">${'${'}markName}</option>
</script>

<script id="kpiCommCodeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}" data-attrib01="${'${'}attrib01}">${'${'}markName}</option>
</script>

<div class="form-horizontal underline top_well clearfix" id="campaignGoalArea">

	<%-- KPI상세 --%>
    <div class="page_btn_area">
        <div class="col-xs-12">
            <span><spring:message code="M02771"/></span>
        </div>
    </div>
    <div class="row">

    	<%-- KPI대상자 --%>
    	<div class="col-xs-6">
        	<ifvm:inputNew type="select" label="M02772" labelClass="4" conClass="8" id="kpiTgtType" names="kpiTgtType"/>
       	</div>
    	<div class="col-xs-6"><span class="add_text"><spring:message code="M02816"/></span></div>
    </div>
    <div class="row">

    	<%-- 비교대상 --%>
    	<div class="col-xs-6">
	        <ifvm:inputNew type="select" label="M02773" labelClass="4" conClass="8" id="kpiCompareType" names="kpiCompareType"/>
		</div>
		<div class="col-xs-6"><span class="add_text"><spring:message code="M02817"/></span></div>
    </div>
    <div class="row">

    	<%-- 목표 KPI --%>
		<div class="col-xs-6">
	        <ifvm:inputNew type="select" label="M02774" labelClass="4" conClass="8" id="kpiGoalType" names="kpiGoalType"/>
		</div>
		<div class="col-xs-6"><span class="add_text"><spring:message code="M02815"/></span></div>
    </div>
    <div class="row">

		<%-- 목표치 --%>
 		<div class="col-xs-6">
	        <ifvm:inputNew type="text" maxLength="10" label="M02775" labelClass="4" conClass="2" values="20" id="kpiGoalVal"/>
	        <ifvm:inputNew type="text" maxLength="10" conClass="6" nuc="true"  readonly="true" values="" id="kpiGoalText" />
		</div>
		<div class="col-xs-6">
			<span class="add_text"><spring:message code="L00181"/></span>
		</div>
    </div>
    <div class="row">

    	<%-- 측정기간 --%>
        <ifvm:inputNew type="select" label="M02776" labelClass="2" conClass="4" id="kpiCalDayType" names="kpiCalDayType"/>
        <ifvm:inputNew type="select" conClass="2" id="kpiCalDayInc" names="kpiCalDayInc"/>
        <ifvm:inputNew type="select" conClass="2" id="kpiCalDayVal" names="kpiCalDayVal"/>
        <ifvm:inputNew type="select" conClass="2" id="kpiCalDayValUnit" names="kpiCalDayValUnit"/>
    </div>
    <div class="row">

    	<%-- 비고 --%>
        <ifvm:inputNew type="textarea" label="M02777" labelClass="2" conClass="10" rows="5" id="kpiRespDesc"/>
    </div>

	<%-- 반응율 --%>
    <div class="page_btn_area">
        <div class="col-xs-12">
            <span><spring:message code="M02778"/></span>
        </div>
    </div>
    <div class="row">

    	<%-- 측정대상자 --%>
        <ifvm:inputNew type="select" label="M02779" labelClass="2" conClass="4" id="respTgtType" names="respTgtType"/>
    </div>
    <div class="row">

    	<%-- 반응유형 --%>
        <ifvm:inputNew type="select" label="M02780" labelClass="2" conClass="4" id="respType" names="respType"/>
    </div>
    <div class="row">

    	<%-- 측정기간 --%>
        <ifvm:inputNew type="select" label="M02781" labelClass="2" conClass="4" id="respCalDayType" names="respCalDayType"/>
        <ifvm:inputNew type="select" conClass="2" id="respCalDayInc" names="respCalDayInc"/>

        <div class="col-xs-2">
        	<div class="col-xs-1"></div>
        	<div class="col-xs-2"><span class="add_text">+</span></div>
        	<div class="col-xs-9">
        		<ifvm:inputNew type="number" conClass="12" id="respCalDayVal" names="respCalDayVal" maxLength="3"/>
        	</div>
        </div>
        <ifvm:inputNew type="select" conClass="2" id="respCalDayValUnit" names="respCalDayValUnit"/>
    </div>
</div>