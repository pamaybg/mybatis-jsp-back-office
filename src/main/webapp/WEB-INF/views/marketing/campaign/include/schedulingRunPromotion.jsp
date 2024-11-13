<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//반복실행div 설정
function setschedulingRunPromotionDiv() {
    if ($.fn.ifvmIsNotEmpty(campaignExecutionInfo)) {
        var data = campaignExecutionInfo;
        $("#schedulingRunPromotion #exeStartDate").val(data.exeStartDate);
        $("#schedulingRunPromotion #exeEndDate").val(data.exeEndDate);
        $('#schedulingRunPromotion :radio[name="repeatCycle"]:input[value='+data.exeCycleTypeCode+']').attr("checked", true);
        $('#schedulingRunPromotion :radio[name="selectMonth"]:input[value='+data.exeMonthTypeCode+']').attr("checked", true);
        $("#schedulingRunPromotion #exeDay").val(data.exeDay);
        $("#schedulingRunPromotion #exeHour").val(data.exeHour);
        $("#schedulingRunPromotion #exeMinute").val(data.exeMinute);
        
        //반복주기 매월 일 경우 매일선택 일로 변경
        if (data.exeCycleTypeCode == "M") {
            $("#chooseDailyArea").hide();
            $("#selectMonthArea").show();
        }
        
        if (data.exeSunYn == "1") {
            $("input:checkbox[id='exeSunYn']").attr("checked", true);
        } else {
            $("input:checkbox[id='exeSunYn']").attr("checked", false);
        }
        if (data.exeMonYn == "1") {
            $("input:checkbox[id='exeMonYn']").attr("checked", true);
        } else {
            $("input:checkbox[id='exeMonYn']").attr("checked", false);
        }
        if (data.exeTueYn == "1") {
            $("input:checkbox[id='exeTueYn']").attr("checked", true);
        } else {
            $("input:checkbox[id='exeTueYn']").attr("checked", false);
        }
        if (data.exeWedYn == "1") {
            $("input:checkbox[id='exeWedYn']").attr("checked", true);
        } else {
            $("input:checkbox[id='exeWedYn']").attr("checked", false);
        }
        if (data.exeThuYn == "1") {
            $("input:checkbox[id='exeThuYn']").attr("checked", true);
        } else {
            $("input:checkbox[id='exeThuYn']").attr("checked", false);
        }
        if (data.exeFriYn == "1") {
            $("input:checkbox[id='exeFriYn']").attr("checked", true);
        } else {
            $("input:checkbox[id='exeFriYn']").attr("checked", false);
        }
        if (data.exeSatYn == "1") {
            $("input:checkbox[id='exeSatYn']").attr("checked", true);
        } else {
            $("input:checkbox[id='exeSatYn']").attr("checked", false);
        }
    }
}

//달력
function setChannelCalendar() {
    var startDate = $("#schedulingRunPromotion #exeStartDate");
    var endDate = $("#schedulingRunPromotion #exeEndDate"); 
    
    startDate.val($.ifvGetTodayDate());
    endDate.val($.ifvGetTodayDate());
    
    startDate.ifvDateChecker({});
    endDate.ifvDateChecker({});
}

/**
 * 시작일 종료일 체크
 */
function chkCalendarValidation() {
    var rtnFlag = true;
    var startDate = $("#schedulingRunPromotion #exeStartDate");
    var endDate = $("#schedulingRunPromotion #exeEndDate"); 
    startDate.removeClass('ifv_vali_wrong');
    if (startDate.val() > endDate.val()) {
        validFailMessage(startDate, '<spring:message code="C00043"/>');
        rtnFlag = false;
    }
    return rtnFlag;
}

//반복 실행 등록시 실행 목록 추출
function getschedulingRunPromotionList() {
    var exeStartDate = $("#schedulingRunPromotion #exeStartDate").val(); //실행시작일
    var exeEndDate = $("#schedulingRunPromotion #exeEndDate").val();     //실행종료일
    
    //실행일자 체크 && check validation && 캠페인 기간 확인
    if (chkCalendarValidation() == true 
            && schedulingRunPromotionValidation.confirm()
            && checkPeriodCampaign(exeStartDate, exeEndDate, "R")) {
        executionInfoItemList = [];
        
        var exeHour = $("#schedulingRunPromotion #exeHour").val();     //실행시간
        var exeMinute = $("#schedulingRunPromotion #exeMinute").val(); //실행분
        
        var exeCycleTypeCode = $("#schedulingRunPromotion :radio[name='repeatCycle']:checked").val(); //반복주기
        var exeMonthTypeCode = $("#schedulingRunPromotion :radio[name='selectMonth']:checked").val(); //매월선택
        
        //date 형변환
        var startDt = new Date(exeStartDate.split("-")[0], Number(exeStartDate.split("-")[1]) - 1, exeStartDate.split("-")[2]);
        var endDt = new Date(exeEndDate.split("-")[0], Number(exeEndDate.split("-")[1]) - 1, exeEndDate.split("-")[2]);   
        
        //반복주기 분기
        //매일
        if (exeCycleTypeCode == "D") {
            var date = new Date(exeStartDate.split("-")[0], Number(exeStartDate.split("-")[1]) - 1, exeStartDate.split("-")[2]);
            date.setDate(date.getDate() - 1);
            for (var i = 0; date.setDate(date.getDate() + 1) <= endDt; i++) {
                if ($("input:checkbox[id='exe" + date.format("ddd") + "Yn']").is(":checked")) {
                    var exeDate = getDateJoin(date.format("yyyy-mm-dd"), exeHour, exeMinute);
                    
                    var data = {
                               exeSeq: executionInfoItemList.length + 1,
                               exeDate: exeDate,
                               exeTargetAmt: null,
                               exeInfoDesc: '',
                               exeInfoStatusCode: "W", //상태: 작업중
                               exeInfoStatusCodeName: '<spring:message code="M00910"/>'
                    };
                    
                    executionInfoItemList.push(data);
                }
            }
        }
        //매월
        else if (exeCycleTypeCode == "M") {
            var yearDiff = endDt .getYear() - startDt .getYear();
            var monthDiff = endDt .getMonth() - startDt .getMonth();
            var monthCnt = (yearDiff * 12) + monthDiff + 1;
            for (var m = 0; m < monthCnt; m++) {
                var exeDay = $("#schedulingRunPromotion #exeDay").val();    //실행일
                //매월 선택 분기
                if (exeMonthTypeCode == "MD") {
                    //일
                    var date = new Date(startDt.format('yyyy'), Number(startDt.format('mm')) + m - 1, exeDay);
                    if (date >= startDt && date <= endDt) {
                        var exeDate = getDateJoin(date.format("yyyy-mm-dd"), exeHour, exeMinute);
                        var data = {
                                exeSeq: executionInfoItemList.length + 1,
                                exeDate: exeDate,
                                exeTargetAmt: null,
                                exeInfoDesc: '',
                                exeInfoStatusCode: "W", //상태: 작업중
                                exeInfoStatusCodeName: '<spring:message code="M00910"/>'
                        };
                        
                        executionInfoItemList.push(data);
                    }
                }
                //매월 말일
                else if (exeMonthTypeCode == "ML") {
                    var date = new Date(startDt.format('yyyy'), Number(startDt.format('mm')) + m, 00);
                    //말일이 종료일보다 작을경우
                    if (date <= endDt) {
                        var exeDate = getDateJoin(date.format("yyyy-mm-dd"), exeHour, exeMinute);
                        var data = {
                                exeSeq: executionInfoItemList.length + 1,
                                exeDate: exeDate,
                                exeTargetAmt: null,
                                exeInfoDesc: '',
                                exeInfoStatusCode: "W", //상태: 작업중
                                exeInfoStatusCodeName: '<spring:message code="M00910"/>'
                        };
                        
                        executionInfoItemList.push(data);
                    }
                }
            }
        }
        
        //차수 설정
        setSchedulingRunSeq();
        
        //그리드 데이터 clear 후 데이터 재설정
        gridIdcampaignRunListGrid.clearGridData();
        gridIdcampaignRunListGrid.setGridParam({data:executionInfoItemList}).trigger("reloadGrid");
        
        //popup 높이 맞추기
        new ifvm.PopupHeight({
            popupDivId : 'dialog',
            contentsId : 'dialogPopupWrap'
        });
    }
}

/**
 * 화면 설정
 */
function initschedulingRunPromotion() {

    schedulingRunPromotionValidation =  $("#schedulingRunPromotion").ifvValidation();

    //반복실행div 설정
    setschedulingRunPromotionDiv();

    //실행 일
    temp = $("#CommonListTemp").tmpl(getInitExtTime('D'));
    $("#schedulingRunPromotion #exeStartDay").append(temp);
    
  //실행 일
    temp = $("#CommonListTemp").tmpl(getInitExtTime('D'));
    $("#schedulingRunPromotion #exeEndDay").append(temp);

    // 달력 설정
    setChannelCalendar();
}

function addFormData() {
    
    var exeCycleTypeCode = $("#schedulingRunPromotion :radio[name='repeatCycle']:checked").val();
    var exeMonthTypeCode = $("#schedulingRunPromotion :radio[name='selectMonth']:checked").val();
    var exeSunYn = $("input:checkbox[id='exeSunYn']").is(":checked") ? "1" : "0";
    var exeMonYn = $("input:checkbox[id='exeMonYn']").is(":checked") ? "1" : "0";
    var exeTueYn = $("input:checkbox[id='exeTueYn']").is(":checked") ? "1" : "0";
    var exeWedYn = $("input:checkbox[id='exeWedYn']").is(":checked") ? "1" : "0";
    var exeThuYn = $("input:checkbox[id='exeThuYn']").is(":checked") ? "1" : "0";
    var exeFriYn = $("input:checkbox[id='exeFriYn']").is(":checked") ? "1" : "0";
    var exeSatYn = $("input:checkbox[id='exeSatYn']").is(":checked") ? "1" : "0";
    
    campaignExecutionInfo.exeStartDate = $("#schedulingRunPromotion #exeStartDate").val();
    campaignExecutionInfo.exeEndDate = $("#schedulingRunPromotion #exeEndDate").val();
    campaignExecutionInfo.exeCycleTypeCode = exeCycleTypeCode;
    campaignExecutionInfo.exeMonthTypeCode = exeMonthTypeCode;
    campaignExecutionInfo.exeDay = $("#schedulingRunPromotion #exeDay").val();
    campaignExecutionInfo.exeHour = $("#schedulingRunPromotion #exeHour").val();
    campaignExecutionInfo.exeMinute = $("#schedulingRunPromotion #exeMinute").val();
    campaignExecutionInfo.exeSunYn = exeSunYn;
    campaignExecutionInfo.exeMonYn = exeMonYn;
    campaignExecutionInfo.exeTueYn = exeTueYn;
    campaignExecutionInfo.exeWedYn = exeWedYn;
    campaignExecutionInfo.exeThuYn = exeThuYn;
    campaignExecutionInfo.exeFriYn = exeFriYn;
    campaignExecutionInfo.exeSatYn = exeSatYn;
    
}

$(document).ready(function() {
    
    initschedulingRunPromotion();

    //반복 실행-등록 버튼
    $('#schedulingRunPromotionAddBtn').on('click', function() {
        getschedulingRunPromotionList();
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
    
    $('input[type=radio][name=repeatCycle]').change(function() {
        if (this.value == 'A') {
        	$("#exeDayArea").find("input, select").prop("disabled", true);
        }
        else if (this.value == 'M') {
        	$("#exeDayArea").find("input, select").prop("disabled", false);
        }
    });

    setTimeout(function() {
        cDialog.refresh();
    }, 1000);
});

</script>

<div id="schedulingRunPromotion" class="schedulingPopConditionArea">
    <header class="temp_title_bb">
        <spring:message code="M00909"/>
        <button class="btn_pop_white pop_top_btn" id="schedulingRunPromotionAddBtn">
            <img src="<ifvm:image name='ico_input'/>" alt="" />
            <spring:message code="M00767"/>
        </button>
    </header>
    <div class="form-horizontal">
        <div class="row half_bottom" style="display:none;">
            <!-- 실행일자 -->
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00877"/></label>
            <div class="col-xs-10">
                <div class="col-xs-5 pd0 cal_frt">
                    <ifvm:input type="date" required="true" id="exeStartDate" />
                </div>
                <div class="col-xs-1 swung_dash text-center">~</div>
                <div class="col-xs-5 pd0 cal_scd">
                    <ifvm:input type="date" required="true" id="exeEndDate" />
                </div>
            </div>
        </div>
        <div class="row half_bottom"><!-- 반복주기 -->
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00893"/></label>
            <div class="col-xs-10">
				<label class="radio-inline">
                    <ifvm:input type="radio" names="repeatCycle" id="monthlyRadio" values="A" checked="checked" />
                    <spring:message code="M02485"/>
                </label>
                <label class="radio-inline">
                    <ifvm:input type="radio" names="repeatCycle" id="monthlyRadio" values="M" checked="checked" />
                    <spring:message code="M00902"/>
                </label>
            </div>
        </div>
        <div id="exeDayArea">
	        <div class="row half_bottom"><!-- 시작일 -->
	            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00153"/></label>
	            <div class="col-xs-10">
	                <div class="col-xs-1">
	                    <label class="radio-inline pull-left">
	                        <ifvm:input type="radio" names="exeStartDayCd" id="exeStartDayCd" checked="checked" values="MD" />
	                        <spring:message code="M00905"/>
	                    </label>
	                </div>
	                <div class="col-xs-2">
	                    <ifvm:input type="select" id="exeStartDay" />    
	                </div>
	                <%-- <label class="radio-inline pull-left radio_padding_left">
	                    <ifvm:input type="radio" names="exeStartDayCd" id="exeStartDayCd" values="ML"/>
	                    <spring:message code="M00906"/>
	                </label> --%>
	            </div>
	        </div>
			<div class="row half_bottom"><!-- 종료일 -->
	            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00154"/></label>
	            <div class="col-xs-10">
	                <div class="col-xs-1">
	                    <label class="radio-inline pull-left">
	                        <ifvm:input type="radio" names="exeEndDayCd" id="exeEndDayCd" checked="checked" values="MD" />
	                        <spring:message code="M00905"/>
	                    </label>
	                </div>
	                <div class="col-xs-2">
	                    <ifvm:input type="select" id="exeEndDay" />    
	                </div>
	                <label class="radio-inline pull-left radio_padding_left">
	                    <ifvm:input type="radio" names="exeEndDayCd" id="exeEndDayCd" values="ML"/>
	                    <spring:message code="M00906"/>
	                </label>
	            </div>
	        </div>
        </div>
    </div>
</div>