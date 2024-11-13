<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style type="text/css">
    #expectTargetCnt {
        text-align: right;
    }
</style>

<script>

function schedulingRunRepeat_pad(n, width, z) {
    z = z || '0';
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

//반복실행div 설정
function setSchedulingRunRepeatDiv() {
    if ($.fn.ifvmIsNotEmpty(campaignExecutionInfo)) {
        
        var data = campaignExecutionInfo;
        $("#schedulingRunRepeat #exeStartDate").val(data.exeStartDate);
        $("#schedulingRunRepeat #exeEndDate").val(data.exeEndDate);
        $('#schedulingRunRepeat :radio[name="repeatCycle"]:input[value=' + data.exeCycleTypeCode + ']').attr("checked", true);
        $('#schedulingRunRepeat :radio[name="selectMonth"]:input[value=' + data.exeMonthTypeCode + ']').attr("checked", true);
        
        //실행시간 
        if ($.fn.ifvmIsEmpty(data.exeHour) == false 
                && $.fn.ifvmIsEmpty(data.exeMinute) == false) {
            var exeTime = schedulingRunRepeat_pad(data.exeHour, 2, '0') + ':' + schedulingRunRepeat_pad(data.exeMinute, 2, '0');
            $("#schedulingRunRepeat #exeTime").val(exeTime);
        }
        
        //반복주기 매월 일 경우 매일선택 일로 변경
        if (data.exeCycleTypeCode == "M") {
            $("#chooseDailyArea").hide();
            $("#selectMonthArea").show();
        }
        
        $("#schedulingRunRepeat #exeDay").val(data.exeDay);
        $("input:checkbox[id='exeSunYn']").attr("checked", (data.exeSunYn == "1"));
        $("input:checkbox[id='exeMonYn']").attr("checked", (data.exeMonYn == "1"));
        $("input:checkbox[id='exeTueYn']").attr("checked", (data.exeTueYn == "1"));
        $("input:checkbox[id='exeWedYn']").attr("checked", (data.exeWedYn == "1"));
        $("input:checkbox[id='exeThuYn']").attr("checked", (data.exeThuYn == "1"));
        $("input:checkbox[id='exeFriYn']").attr("checked", (data.exeFriYn == "1"));
        $("input:checkbox[id='exeSatYn']").attr("checked", (data.exeSatYn == "1"));
        
        //분할옵션
        if ($.fn.ifvmIsNotEmpty(data.divSendTime)) {
        	var divSendTime = data.divSendTime.substring(0,2) + ":" + data.divSendTime.substring(2,4);
        	
        	$('#schedulingRunRepeat #divSendTime').val(divSendTime);
        }
        
        $('#schedulingRunRepeat #divSendCnt').val(data.divSendCnt);
        $('#schedulingRunRepeat #maxSendCnt').val(data.maxSendCnt);
    }
}

//달력
function setChannelCalendar() {
    var startDate = $("#schedulingRunRepeat #exeStartDate");
    var endDate = $("#schedulingRunRepeat #exeEndDate"); 
    
    var promStartDate = $("#promStartDt").val();
    var promEndDate = $("#promEndDt").val();
    
    //캠페인 정보
    var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
    
    if (isNotEmpty(promStartDate)) {
    	startDate.val(promStartDate.substring(0,10));
        endDate.val(promEndDate.substring(0,10));
    }
    else if ($.fn.ifvmIsNotEmpty(campaignExecutionInfo)) {
        startDate.val(campaignExecutionInfo.exeStartDate);
        endDate.val(campaignExecutionInfo.exeEndDate);
    }
    else if (isNotEmpty(campaignInfo)) {
        startDate.val(campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignStartDate);
        endDate.val(campaignInfo[0].addInfo.data.campaignDefaultInfo.campaignEndDate);
    }
    else {
        startDate.val($.ifvGetTodayDate());
        endDate.val($.ifvGetTodayDate());
    }
    startDate.ifvDateChecker({});
    endDate.ifvDateChecker({});

    $('#exeTime').timepicker({
        showMeridian: false,
        defaultTime: '00:00',
        showSeconds: false,
        minuteStep: 5,
        secondStep: 1,
    });
    
    $('#divSendTime').timepicker({
        showMeridian: false,
        defaultTime: '00:00',
        showSeconds: false,
        minuteStep: 5,
        secondStep: 1,
    });
}

/**
 * 시작일 종료일 체크
 */
function chkCalendarValidation() {
    var rtnFlag = true;
    var startDate = $("#schedulingRunRepeat #exeStartDate");
    var endDate = $("#schedulingRunRepeat #exeEndDate"); 
    startDate.removeClass('ifv_vali_wrong');
    if (startDate.val() > endDate.val()) {
        validFailMessage(startDate, '<spring:message code="C00043"/>');
        rtnFlag = false;
    }
    return rtnFlag;
}

//반복 실행 등록시 실행 목록 추출
function getSchedulingRunRepeatList() {
    var exeStartDate = $("#schedulingRunRepeat #exeStartDate").val(); //실행시작일
    var exeEndDate = $("#schedulingRunRepeat #exeEndDate").val();     //실행종료일
    
    //실행일자 체크 && check validation && 캠페인 기간 확인
    if (chkCalendarValidation() == true 
            && schedulingRunRepeatValidation.confirm()
            && checkPeriodCampaign(exeStartDate, exeEndDate, "R")
            && checkPeriodPromotion(exeStartDate, exeEndDate)) {
        executionInfoItemList = [];
        
        var exeHour = $('#exeTime').val().split(':', 2)[0];    //실행시간 
        var exeMinute = $('#exeTime').val().split(':', 2)[1];  //실행분  
        
        var exeCycleTypeCode = $("#schedulingRunRepeat :radio[name='repeatCycle']:checked").val(); //반복주기
        var exeMonthTypeCode = $("#schedulingRunRepeat :radio[name='selectMonth']:checked").val(); //매월선택
        
        //date 형변환
        var startDt = new Date(exeStartDate.split("-")[0], Number(exeStartDate.split("-")[1]) - 1, exeStartDate.split("-")[2]);
        var endDt = new Date(exeEndDate.split("-")[0], Number(exeEndDate.split("-")[1]) - 1, exeEndDate.split("-")[2]);   
        
        //차수 설정
        setSchedulingRunSeq();
        
        executionInfoItemList = [];
        
        //그리드 데이터 clear 후 데이터 재설정
        gridIdcampaignRunListGrid.clearGridData();
        gridIdcampaignRunListGrid.setGridParam({data: executionInfoItemList}).trigger("reloadGrid");

        //팝업 높이 맞추기
        initPopupHeight();
        
        $('#schedulingPopSaveBtn').trigger('click');
    }
}

function numberWithCommas(x) {
    if ($.fn.ifvmIsNotEmpty(x)) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    } else return 0;
}

function setExpectTargetCnt() {
    $.ifvPostJSON('<ifvm:action name="getTargetGroup"/>', {
            targetGroupId: tgtGroupId
        },
        function (result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                if (result.targetCount == "MSG_T0001") {
                    $.ifvErrorPop('<spring:message code="M01694"/>');
                } else {
                    $("#expectTargetCnt").val(numberWithCommas(result.targetCount));
                }
            }
        });
}

/**
 * 화면 설정
 */
function initSchedulingRunRepeat() {
	schedulingType = "REPEAT";

    schedulingRunRepeatValidation =  $("#schedulingRunRepeat").ifvValidation();

    //예상발송자수
    setExpectTargetCnt();

    //실행 일
    temp = $("#CommonListTemp").tmpl(getInitExtTime('D'));
    $("#schedulingRunRepeat #exeDay").append(temp);

    // 달력 설정
    setChannelCalendar();
    
    //반복실행div 설정
    setSchedulingRunRepeatDiv();

    //본사&매장 체크
    empTypeChk();
}

function addFormData() {
    var exeCycleTypeCode = $("#schedulingRunRepeat :radio[name='repeatCycle']:checked").val();
    var exeMonthTypeCode = $("#schedulingRunRepeat :radio[name='selectMonth']:checked").val();
    var exeSunYn = $("input:checkbox[id='exeSunYn']").is(":checked") ? "1" : "0";
    var exeMonYn = $("input:checkbox[id='exeMonYn']").is(":checked") ? "1" : "0";
    var exeTueYn = $("input:checkbox[id='exeTueYn']").is(":checked") ? "1" : "0";
    var exeWedYn = $("input:checkbox[id='exeWedYn']").is(":checked") ? "1" : "0";
    var exeThuYn = $("input:checkbox[id='exeThuYn']").is(":checked") ? "1" : "0";
    var exeFriYn = $("input:checkbox[id='exeFriYn']").is(":checked") ? "1" : "0";
    var exeSatYn = $("input:checkbox[id='exeSatYn']").is(":checked") ? "1" : "0";
    
    campaignExecutionInfo.exeStartDate = $("#schedulingRunRepeat #exeStartDate").val();
    campaignExecutionInfo.exeEndDate = $("#schedulingRunRepeat #exeEndDate").val();
    campaignExecutionInfo.exeCycleTypeCode = exeCycleTypeCode;
    campaignExecutionInfo.exeMonthTypeCode = exeMonthTypeCode;
    campaignExecutionInfo.exeDay = $("#schedulingRunRepeat #exeDay").val();
    campaignExecutionInfo.exeHour   = $('#exeTime').val().split(':', 2)[0];
    campaignExecutionInfo.exeMinute = $('#exeTime').val().split(':', 2)[1];
    campaignExecutionInfo.exeSunYn = exeSunYn;
    campaignExecutionInfo.exeMonYn = exeMonYn;
    campaignExecutionInfo.exeTueYn = exeTueYn;
    campaignExecutionInfo.exeWedYn = exeWedYn;
    campaignExecutionInfo.exeThuYn = exeThuYn;
    campaignExecutionInfo.exeFriYn = exeFriYn;
    campaignExecutionInfo.exeSatYn = exeSatYn;
    campaignExecutionInfo.divSendTime = $('#schedulingRunRepeat #divSendTime').val().replace(':', '');
    campaignExecutionInfo.divSendCnt = $('#schedulingRunRepeat #divSendCnt').val();
    campaignExecutionInfo.maxSendCnt = $('#schedulingRunRepeat #maxSendCnt').val();
}

function empTypeChk(){
    if(empType != 'H'){
        // $('#repeatCycleArea').hide();
        // $('#chooseDailyArea').hide();
        // $('#selectMonthArea').hide();
        // $('#exeTimeArea').hide();
        $('#sendTimeArea').hide();
    }
}

$(document).ready(function() {
    
    initSchedulingRunRepeat();

    //반복 실행-등록 버튼
    $('#schedulingRunRepeatAddBtn').on('click', function() {
        getSchedulingRunRepeatList();
    });

    //반복 실행 - 매일 선택시
    $('#everydayRadio').on('click', function() {
        $("#chooseDailyArea").show();
        $("#selectMonthArea").hide();
    });

    //반복 실행 - 매월 선택시
    $('#monthlyRadio').on('click', function() {
        $("#chooseDailyArea").hide();
        $("#selectMonthArea").show();
    });

    setTimeout(function() {
        cDialog.refresh();
    }, 1000);
});

</script>

<div id="schedulingRunRepeat" class="schedulingPopConditionArea">
    <header class="temp_title_bb">
        <spring:message code="M00909"/>
        <%-- <button class="btn_pop_white pop_top_btn" id="schedulingRunRepeatAddBtn">
            <img src="<ifvm:image name='ico_input'/>" alt="" />
            <spring:message code="M00767"/>
        </button> --%>
    </header>
    <div class="form-horizontal" id="schedulingRunArea">
        <div class="row half_bottom" id="exeDateArea">
        
            <%-- 실행일자 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00877"/></label>
            <div class="col-xs-10 control_content">
                <div class="col-xs-5 pd0 cal_frt">
                    <ifvm:input type="date" required="true" id="exeStartDate" />
                </div>
                <div class="col-xs-1 swung_dash text-center">~</div>
                <div class="col-xs-5 pd0 cal_scd">
                    <ifvm:input type="date" required="true" id="exeEndDate" />
                </div>
            </div>
        </div>
        <div class="row half_bottom" id="repeatCycleArea">
        
            <%-- 반복주기 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00893"/></label>
            <div class="col-xs-10 control_content">
                <label class="radio-inline">
                    <ifvm:input  type="radio" names="repeatCycle" checked="checked" id="everydayRadio" values="D" />
                    <spring:message code="M00894"/>
                </label>
                <label class="radio-inline">
                    <ifvm:input type="radio" names="repeatCycle" id="monthlyRadio" values="M" />
                    <spring:message code="M00902"/>
                </label>
            </div>
        </div>
        <div id="chooseDailyArea" class="row half_bottom">
            
            <%-- 매일 선택 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00903"/></label>
            <div class="col-xs-10 control_content">
                <label class="checkbox-inline">
                    <ifvm:input type="checkbox" checked="checked" id="exeSunYn" />
                    <spring:message code="M00895"/>
                </label>
                <label class="checkbox-inline">
                    <ifvm:input type="checkbox" checked="checked" id="exeMonYn" />
                    <spring:message code="M00896"/>
                </label>
                <label class="checkbox-inline">
                    <ifvm:input type="checkbox" checked="checked" id="exeTueYn" />
                    <spring:message code="M00897"/>
                </label>
                <label class="checkbox-inline">
                    <ifvm:input type="checkbox" checked="checked" id="exeWedYn" />
                    <spring:message code="M00898"/>
                </label>
                <label class="checkbox-inline">
                    <ifvm:input type="checkbox" checked="checked" id="exeThuYn" />
                    <spring:message code="M00899"/>
                </label>
                <label class="checkbox-inline">
                    <ifvm:input type="checkbox" checked="checked" id="exeFriYn" />
                    <spring:message code="M00900"/>
                </label>
                <label class="checkbox-inline">
                    <ifvm:input type="checkbox" checked="checked" id="exeSatYn" />
                    <spring:message code="M00901"/>
                </label>
            </div>
        </div>
        <div id="selectMonthArea" class="row half_bottom">
        
            <%-- 매월 선택 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00904"/></label>
            <div class="col-xs-10 control_content">
                <div class="col-xs-1">
                    <label class="radio-inline pull-left">
                        <ifvm:input type="radio" names="selectMonth" id="exeMonthTypeCode" checked="checked" values="MD" />
                        <spring:message code="M00905"/>
                    </label>
                </div>
                <div class="col-xs-2">
                    <ifvm:input type="select" id="exeDay" />    
                </div>
                <label class="radio-inline pull-left radio_padding_left">
                    <ifvm:input type="radio" names="selectMonth" id="exeMonthTypeCode" values="ML"/>
                    <spring:message code="M00906"/>
                </label>
            </div>
        </div>
        <div class="row half_bottom" id="exeTimeArea">
        
            <%-- 실행 시간 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00907"/></label>
            
            <div class="col-xs-3">
                <div class="col-xs-9 control_content" style="padding:0px">
                    <ifvm:inputNew type="time" id="exeTime" />
                </div>
            </div>
        </div>
        <div class="row half_bottom" id="targetCntArea">

            <%-- 예상 발송자 수 --%>
            <label class="col-xs-2 control-label"><spring:message code="M03098"/></label>
            <div class="col-xs-3">
                <div class="col-xs-9 control_content" style="padding:0px;">
                    <ifvm:inputNew type="text" id="expectTargetCnt" disabled="true"/>
                </div>
                <label class="col-xs-1 control-label"><spring:message code="M01196"/></label>
            </div>
        </div>
        <div class="row half_bottom" id="sendTimeArea" style="display: none;">
        
            <%-- 분할 옵션 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02468"/></label>
            <div class="col-xs-3">

                <%-- 분할전송시간간격 --%>
                <div class="col-xs-9 control_content" style="padding:0px;">
                    <ifvm:inputNew type="time" id="divSendTime" />
                </div>
                <label class="col-xs-3 control-label"><spring:message code="M02489"/></label>
            </div>
            <div class="col-xs-3">

                <%-- 1회당 n건씩 --%>
                <label class="col-xs-4 control-label"><spring:message code="M02490"/></label>
                <div class="col-xs-6 control_content" style="padding:0px;">
                    <ifvm:inputNew type="number" id="divSendCnt" />
                </div>
                <label class="col-xs-2 control-label"><spring:message code="L02029"/></label>

            </div>
            <div class="col-xs-3">

                <%-- 최대 m건 --%>
                <label class="col-xs-4 control-label"><spring:message code="M02491"/></label>
                <div class="col-xs-6 control_content" style="padding:0px;">
                    <ifvm:inputNew type="number" id="maxSendCnt" />
                </div>
                <label class="col-xs-2 control-label"><spring:message code="L02029"/></label>
            </div>
        </div>
    </div>
</div>