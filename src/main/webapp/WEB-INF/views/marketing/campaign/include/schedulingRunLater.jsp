<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
#schedulingRunLater .control-label.label_txt_s {text-align: left; padding : 5px; width : 35px;}
#schedulingRunLater .control-label.label_txt_ss {text-align: left; padding : 5px; width : 20px;}
</style>

<script>

var bfCampaign = {
    bfCamId : null,
    campaignTypeCode : null,
    campaignDate : null,
    campaignStartDate : null, 
    campaignEndDate : null, 
    campaignStatusCodeName : null,
    campaignName : null,
    lastExeDate: null, 
};

var bfCamId;    // 선행캠페인 ID

/**
 * 달력 설정
 */
function setChannelCalendar() {
    var exeDdDate = $('#schedulingRunLater #exeDd');
    
    exeDdDate.val($.ifvGetTodayDate());
    exeDdDate.ifvDateChecker({});
}

function schedulingRunLater_LPAD(str, n, fillStr) {
    var rtnStr = String(str);
    if (rtnStr.length < n) {
        for (var i = 0; i < (n - rtnStr.length); i++) {
            rtnStr = String(fillStr) + String(rtnStr);
        }
    }
    return rtnStr;
}

/**
 * 후행 실행 등록 버튼 
 */
function schedulingRunLaterAdd() {

    // 선행캠페인 실행일자가 존재하지 않아 후행캠페인 일정을 등록 할 수 없음. 
    if ($.fn.ifvmIsEmpty(bfCampaign.lastExeDate)) {
        alert('<spring:message code="M02395"/>');
        return;
    }
    
    // 후행 실행은 한건만 등록 가능 
    if (gridIdcampaignRunListGrid.getRowData().length >= 1) {
        alert('<spring:message code="M02211"/>');
        return ;
    }
    
    if (schedulingRunLaterValidation.confirm() == true) {

        //실행일자
        var exeDate;
        var exeDt;
        var exeDay;
        var exeHour; 
        var exeMnut;
        
        var typeCd = $('input[name=exeCyclTypeCd]:checked').val();
        
        // 선행 캠페인 실행 완료 후 
        if (typeCd == 'A') {
            exeDay  = $('#exeCyclTypeCd_A_div #exeDay').val();
            exeHour = $('#exeCyclTypeCd_A_div #exeHour').val();
            exeMnut = $('#exeCyclTypeCd_A_div #exeMnut').val();
            
            var camStartDate = new Date(bfCampaign.lastExeDate);
            
            var addDate     = camStartDate.getDate()    + Number(exeDay);
            var addHours    = camStartDate.getHours()   + Number(exeHour);
            var addMinutes  = camStartDate.getMinutes() + Number(exeMnut);
            
            camStartDate.setDate(addDate);
            camStartDate.setHours(addHours);
            camStartDate.setMinutes(addMinutes);
            
            exeDate = camStartDate.getFullYear() + '-' + (camStartDate.getMonth() + 1) + '-' + camStartDate.getDate();
            exeDate = exeDate + ' ' + schedulingRunLater_LPAD(camStartDate.getHours(), 2, '0') +':'+ schedulingRunLater_LPAD(camStartDate.getMinutes(), 2, '0')
            
        }
        else if (typeCd == 'S') {
            exeDt   = $('#exeCyclTypeCd_S_div #exeDt').val();
            exeHour = $('#exeCyclTypeCd_S_div #exeHour').val();
            exeMnut = $('#exeCyclTypeCd_S_div #exeMnut').val();
            
            exeDate = getDateJoin($("#exeCyclTypeCd_S_div #exeDd").val(), $("#exeCyclTypeCd_S_div #exeHour").val(), $("#exeCyclTypeCd_S_div #exeMnut").val());
        }
        
        //소수점값  내림 설정
        var digits = Math.pow(10, 0);
        var num = Math.floor(getExeTargetAmt() * digits) / digits;
        var exeTargetAmt = num;
        
        var data = {
                exeSeq: executionInfoItemList.length + 1,
                exeDate: exeDate,
                exeTargetAmt: null,
                exeInfoDesc: '',
                exeInfoStatusCode: "W", //상태: 작업중
                exeInfoStatusCodeName: '<spring:message code="M00910"/>'
        };
     
        executionInfoItemList.push(data);

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

function addFormData() {
    
    campaignExecutionInfo.exeCycleTypeCode = $('#schedulingRunLater input[name=exeCyclTypeCd]:checked').val();

    if (campaignExecutionInfo.exeCycleTypeCode == 'A') {
        campaignExecutionInfo.exeDay    = $("#schedulingRunLater #exeDay").val();
        campaignExecutionInfo.exeHour   = $("#schedulingRunLater #exeHour").val();
        campaignExecutionInfo.exeMinute = $("#schedulingRunLater #exeMnut").val();
    }
    else if (campaignExecutionInfo.exeCycleTypeCode == 'S') {
        campaignExecutionInfo.exeDd     = $("#schedulingRunLater #exeDd").val();
        campaignExecutionInfo.exeHour   = $("#schedulingRunLater #exeHour option:selected").val();
        campaignExecutionInfo.exeMinute = $("#schedulingRunLater #exeMnut option:selected").val();        
    }
}

function initSchedulingRunLater() {

    //달력 설정
    setChannelCalendar();
    
    //validaion
    schedulingRunLaterValidation =  $("#schedulingRunLater").ifvValidation();

    //실행 시
    var temp = $("#CommonListTemp").tmpl(getInitExtTime('H'));
    $("#schedulingRunLater #exeHour").append(temp);
    
    //실행 분
    temp = $("#CommonListTemp").tmpl(getInitExtTime('M'));
    $("#schedulingRunLater #exeMnut").append(temp);
    
    //선행 캠페인 실행일자 보여주기
    $('#bfCamStartDate').html(bfCampaign.lastExeDate);
    
    // 캠페인 실행 타입 관련 input 모두 disabled 
    $('#exeCyclTypeCd_A_div input').prop('disabled', true);
    $('#exeCyclTypeCd_A_div input').removeAttr('required');
    
    $('#exeCyclTypeCd_S_div input').prop('disabled', true);
    $('#exeCyclTypeCd_S_div select').prop('disabled', true);
    $('#exeCyclTypeCd_S_div input').removeAttr('required');
    
    // 데이터를 화면에 출력 
    if ($.fn.ifvmIsEmpty(campaignExecutionInfo) == false) {
        var data = campaignExecutionInfo;
        
        $('input[name=exeCyclTypeCd][value=' + data.exeCycleTypeCode + ']').prop('checked', true);
        changeExeCyclTypeCd();
        
        if (data.exeCycleTypeCode == 'A') {
            $("#schedulingRunLater #exeDay").val(data.exeDay); 
            $("#schedulingRunLater #exeHour").val(data.exeHour);
            $("#schedulingRunLater #exeMnut").val(data.exeMinute);
        }
        else if (data.exeCycleTypeCode == 'S') {
            $("#schedulingRunLater #exeDd").val(data.exeDd);
            $("#schedulingRunLater #exeHour option[value=" + data.exeHour   + "]").prop('selected', true);
            $("#schedulingRunLater #exeMnut option[value=" + data.exeMinute + "]").prop('selected', true);
        }
    }

    // 선행캠페인 실행일자가 존재하지 않아 후행캠페인 일정을 등록 할 수 없음. 
    if ($.fn.ifvmIsEmpty(bfCampaign.lastExeDate)) {
        $('input[name=exeCyclTypeCd]').prop('checked', false);
        $('input[name=exeCyclTypeCd]').prop('disabled', true);
        changeExeCyclTypeCd();
        alert('<spring:message code="M02395"/>');
    }
}

/**
 * 선행 캠페인 조회
 */
function schedulingRunLater_getMultiStage() {
    
    var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
    
    $.ifvSyncPostJSON('<ifvm:action name="getMultiStage"/>', {
        camId : campaignInfo[0].addInfo.actualTaskId
    }, function(result) {
        
        // 선행 캠페인 정보
        var camInfo = result.campaignInfo;
        
        console.log(camInfo)
        
        if ($.fn.ifvmIsEmpty(result) == false 
                && $.fn.ifvmIsEmpty(result.campaignInfo) == false) {

            if ($.fn.ifvmIsEmpty(camInfo) == false) {
                bfCampaign.bfCamId                = camInfo.id;
                bfCampaign.campaignTypeCode       = camInfo.campaignTypeCode;
                bfCampaign.campaignDate           = camInfo.campaignStartDate + ' ~ ' + camInfo.campaignEndDate;
                bfCampaign.campaignStatusCodeName = camInfo.campaignStatusCodeName;
                bfCampaign.campaignName           = camInfo.campaignName;
                
                $.ifvSyncPostJSON('<ifvm:action name="getCampaignLastExeDate"/>', {
                    campaignId : bfCampaign.bfCamId
                }, function(getResult) {
                    bfCampaign.lastExeDate = getResult.exeDate;
                });
            }
        }
        // 선행 캠페인 없음. 
        else {
            alert('<spring:message code="M02394"/>');
            $('[name=exeCyclTypeCd]').prop('disabled', true);
        }
    });
}

function changeExeCyclTypeCd() {

    var len = $('input[name=exeCyclTypeCd]').length;
    for (var i = 0 ; i < len ; i++) {
        var typeCd = $('input[name=exeCyclTypeCd]:eq(' + i + ')').val();
        if ($('input[name=exeCyclTypeCd]:eq(' + i + ')').is(':checked') == true) {
            $('#exeCyclTypeCd_' + typeCd + '_div input').prop('disabled', false);
            $('#exeCyclTypeCd_' + typeCd + '_div select').prop('disabled', false);
            $('#exeCyclTypeCd_' + typeCd + '_div input').attr('required', true);
        }
        else {
            $('#exeCyclTypeCd_' + typeCd + '_div input').prop('disabled', true);
            $('#exeCyclTypeCd_' + typeCd + '_div select').prop('disabled', true);
            $('#exeCyclTypeCd_' + typeCd + '_div input').removeAttr('required');
        }
    }
}

$(document).ready(function() {
    
    bfCamId = null;

    // 선행 캠페인 조회
    schedulingRunLater_getMultiStage();
    
    // 화면설정
    initSchedulingRunLater();

    // 선행캠페인 실행 타입 선택시
    $('input[name=exeCyclTypeCd]').on('change', function() {
        changeExeCyclTypeCd();
    });

    //후행실행 - 등록 버튼
    $('#schedulingRunLaterAddBtn').on('click', function() {
        schedulingRunLaterAdd();
    });

    //팝업 높이 맞추기
    initPopupHeight();
});

</script>
<div id="schedulingRunLater" class="schedulingPopConditionArea">
    <header class="temp_title_bb">
        <spring:message code="M02385"/>
        <button class="btn_pop_white pop_top_btn" id="schedulingRunLaterAddBtn">
            <img src="<ifvm:image name='ico_input'/>" alt="" />
            <spring:message code="M00767"/>
        </button>
    </header>
    <div class="form-horizontal">
        <div class="row qt_border">
        
            <%-- 선행 캠페인 실행일자 --%>
            <label class="col-xs-4 control-label label_txt"><span class="asterisk">*</span><spring:message code="M02386"/></label>
            <label class="col-xs-5 control-label label_txt" id="bfCamStartDate"></label>
            <ifvm:input type="hidden" id="bfCamId" />
        </div>
        <div class="row qt_border">
        
            <%-- 선행캠페인 실행 완료 후 --%>
            <div class="col-xs-12">
                <label class="radio-inline">
                    <ifvm:input type="radio" names="exeCyclTypeCd" id="exeCyclTypeCd_A" values="A" />
                    <spring:message code="M02387"/>
                </label>
            </div>
        </div>    
        <div class="row qt_border" id="exeCyclTypeCd_A_div">
        
            <label class="col-xs-1 control-label label_txt_ss">+</label>
            <div class="col-xs-1">
                <ifvm:input type="number" required="true" id="exeDay" className="text-right"/>
            </div>
            <label class="col-xs-1 control-label label_txt_s"><spring:message code="M00895"/></label>
            
            <label class="col-xs-1 control-label label_txt_ss">+</label>
            <div class="col-xs-1">
                <ifvm:input type="number" required="true" id="exeHour" className="text-right"/>
            </div>
            <label class="col-xs-1 control-label label_txt_s"><spring:message code="C00134"/></label>
            
            <label class="col-xs-1 control-label label_txt_ss">+</label>
            <div class="col-xs-1">
                <ifvm:input type="number" required="true" id="exeMnut" className="text-right"/>
            </div>
            <label class="col-xs-1 control-label label_txt_s"><spring:message code="C00136"/></label>
        </div>
        <div class="row qt_border" >
        
            <%-- 선행 캠페인 실행 완료 후 특정 일자 --%>
            <div class="col-xs-12">
                <label class="radio-inline">
                    <ifvm:input type="radio" names="exeCyclTypeCd" id="exeCyclTypeCd_S" values="S" />
                    <spring:message code="M02388"/>
                </label>
            </div>
        </div>    
        <div class="row qt_border" id="exeCyclTypeCd_S_div">
            <div class="col-xs-3">
                <ifvm:input type="date" required="true" id="exeDd" />
            </div>
            <label class="col-xs-2 control-label label_txt_ss">&nbsp;</label>
            
            <div class="col-xs-1">
                <ifvm:input type="select" required="true" id="exeHour" className="text-right"/>
            </div>
            <label class="col-xs-2 control-label label_txt_s"><spring:message code="M02389"/></label>
            
            <div class="col-xs-1">
                <ifvm:input type="select" required="true" id="exeMnut" className="text-right"/>
            </div>
            <label class="col-xs-2 control-label label_txt_s"><spring:message code="C00136"/></label>
            
        </div>
    </div>
</div>