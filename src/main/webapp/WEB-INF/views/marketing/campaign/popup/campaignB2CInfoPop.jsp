<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
/* 일시적으로 숨김 처리 함 */
.temporarilyHide { display: none; }
</style>

<script>

//model
var campaignB2CInfo;
//dialog
var planPop;
//validation
var campaignB2CInfoPopValidation;

//model 정의
function initModels(data) {
    var infoModel = function(data) {

        //data set
        this.camDefaultInfo = data;
        //캠페인아이디
        this.camDefaultInfo.ridCam = campaign.id;
        //기획자 Account Id
        this.camDefaultInfo.accountId = $.ifvmGetUserInfo().accountId;
        
        campaignB2CInfo = this;
    };
    
    //konckout bindings
    ko.applyBindings(new infoModel(data), document.getElementById("campaignB2CInfoPop") );
}

//캠페인기본정보 저장
function saveCampaignB2CInfo() {

    //달력 binding 안되는 현상 발생 값을 찾아 넣어준다.
    campaignB2CInfo.camDefaultInfo.eventStartDate = $("#eventStartDate").val() + " " + $("#eventStartTime").val() + ":00:00";
    campaignB2CInfo.camDefaultInfo.eventEndDate = $("#eventEndDate").val() + " " + $("#eventEndTime").val() + ":00:00";
    campaignB2CInfo.camDefaultInfo.winDate = $("#winDate").val();
    
    campaignB2CInfo.camDefaultInfo.rid = $("#rid").val();
    
    campaignB2CInfo.camDefaultInfo.apply1tierFlg = $("input:checkbox[id='apply1tierFlg']").is(":checked") ? "1" : "0";
    campaignB2CInfo.camDefaultInfo.apply2tierFlg = $("input:checkbox[id='apply2tierFlg']").is(":checked") ? "1" : "0";
    campaignB2CInfo.camDefaultInfo.apply3tierFlg = $("input:checkbox[id='apply3tierFlg']").is(":checked") ? "1" : "0";
    campaignB2CInfo.camDefaultInfo.privacyCheckFlg = $("input:checkbox[id='privacyCheckFlg']").is(":checked") ? "1" : "0";
    campaignB2CInfo.camDefaultInfo.targetEventFlg = $("input:checkbox[id='targetEventFlg']").is(":checked") ? "1" : "0";
    campaignB2CInfo.camDefaultInfo.chnlCardFlg = $("input:checkbox[id='chnlCardFlg']").is(":checked") ? "1" : "0";
    campaignB2CInfo.camDefaultInfo.applyPeriodCd = $('input:radio[name="applyPeriodCd"]:checked').val();
    
    //check validation
    if (chkCalendarValidation() == true && campaignB2CInfoPopValidation.confirm()) {

         $.ifvSyncPostJSON('<ifvm:action name="saveCampaignB2CInfo"/>', campaignB2CInfo.camDefaultInfo, function(result) {
            alert('<spring:message code="M00152" />');
            //close popup
            closeCampaignB2CInfoPop();
        });
	}
}

//캠페인기본정보 팝업 설정
function campaignB2CInfoInit() {
    pageSetUp();

    //이벤트 시작 시간
    $.fn.ifvmSetSelectOptionCommCode("eventStartTime", "IF_MNT_SMS_ST_END_TIME", null, null, true);
    
    //이벤트 종료 시간
    $.fn.ifvmSetSelectOptionCommCode("eventEndTime", "IF_MNT_SMS_ST_END_TIME", null, null, true);    
    
    //응모채널
    $.fn.ifvmSetSelectOptionCommCode("applyChnlCd", "EVENT_CHNL_TYPE", null, null, true);

    //이벤트 유형
    $.fn.ifvmSetSelectOptionCommCode("eventTypeCd", "EVENT_TYPE", null, null, true);
    
    //팝업설정
    cDialog.model.title = '<spring:message code="E00017"/>';
    $("#dialog_title").append('<spring:message code="E00017"/>');
    cDialog.model.width = "750";
    cDialog.model.close = "closeCampaignB2CInfoPop";

    //validation
    campaignB2CInfoPopValidation = $("#campaignB2CInfoPop").ifvValidation();
}

//달력
function setChannelCalendar() {
    var startDate = $("#eventStartDate");
    var endDate = $("#eventEndDate");
    var winDate = $("#winDate");

    startDate.val($.ifvGetTodayDate());
    endDate.val($.ifvGetTodayDate());
    winDate.val($.ifvGetTodayDate());

    startDate.ifvDateChecker({});
    endDate.ifvDateChecker({});
    winDate.ifvDateChecker({});
}

/**
 * 시작일 종료일 체크
 */
function chkCalendarValidation() {
    var rtnFlag = true;
    var startDate = $("#eventStartDate");
    var endDate = $("#eventEndDate");
    startDate.removeClass('ifv_vali_wrong');
    if (startDate.val() > endDate.val()) {
        validFailMessage(startDate, '<spring:message code="C00043"/>');
        rtnFlag = false;
    }
    return rtnFlag;
}

//캠페인기본정보 팝업 데이터 설정
function campaignB2CInfoInitData() {
    campaignB2CInfo = {camDefaultInfo: {}};

    //set task type
    diagram._selectedObject.taskType = "B2C";

    //캠페인 ID
    var id = diagram._selectedObject.campaignId;
    
    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignB2CInfo"/>', {
        ridCam: id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)){
            campaignB2CInfo.camDefaultInfo = result;
            $("#eventStartDate").val(result.eventStartDate);
            $("#eventEndDate").val(result.eventEndDate);
            $("#winDate").val(result.winDate);
            $("#rid").val(result.rid);
            
            $('input[name=applyPeriodCd][value=' + result.applyPeriodCd + ']').prop('checked', true);
            
            $("input:checkbox[id='apply1tierFlg']").attr("checked", (result.apply1tierFlg == "1"));
            $("input:checkbox[id='apply2tierFlg']").attr("checked", (result.apply2tierFlg == "1"));
            $("input:checkbox[id='apply3tierFlg']").attr("checked", (result.apply3tierFlg == "1"));
            $("input:checkbox[id='privacyCheckFlg']").attr("checked", (result.privacyCheckFlg == "1"));
            $("input:checkbox[id='targetEventFlg']").attr("checked", (result.targetEventFlg == "1"));
            $("input:checkbox[id='chnlCardFlg']").attr("checked", (result.chnlCardFlg == "1"));
        }
    });

    initModels(campaignB2CInfo.camDefaultInfo);
}

// dialog close
function closeCampaignB2CInfoPop(args) {
    campaignB2CInfo = {};
    //konckout bindings stop
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}

$(function () {

    //달력 설정
    setChannelCalendar();

    //캠페인기본정보 폼 설정
    campaignB2CInfoInit();

    //캠페인기본정보 데이터
    campaignB2CInfoInitData();

    //저장 클릭시
    $('#campaignB2CInfoPopSaveBtn').on('click', function(){
        saveCampaignB2CInfo();
    });

    //취소 클릭시
    $('#campaignB2CInfoPopCancelBtn').on('click', function(){
        closeCampaignB2CInfoPop();
    });

    setTimeout(function() {
        //popup 높이 맞추기
        new ifvm.PopupHeight({
            popupDivId : 'dialog',
            contentsId : 'dialogPopupWrap'
        });

        cDialog.refresh();
    }, 500);
});
</script>

<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
        <div class="form-horizontal" id="campaignB2CInfoPop">
        	<ifvm:input type="hidden" id="rid" names="rid" />
        	
            <div class="row qt_border">

                <%-- 디스플레이명 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="E00018"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="text" id="eventDesc" names="eventDesc" maxLength="50" required="true" dataBind="value: camDefaultInfo.eventDesc" />
                </div>
            </div>
            <div class="row qt_border">

                <%-- 시작일 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00593"/></label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="date" id="eventStartDate" names="eventStartDate" required="true"  />
                </div>
                <div class="col-xs-1 control_content">
                    <ifvm:input type="select" id="eventStartTime" names="eventStartTime" required="true" dataBind="value: camDefaultInfo.eventStartTime" />
                </div>                

                <%-- 종료일 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00594"/></label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="date" id="eventEndDate" names="eventEndDate" required="true"  />
                </div>
                <div class="col-xs-1 control_content">
                    <ifvm:input type="select" id="eventEndTime" names="eventEndTime" required="true" dataBind="value: camDefaultInfo.eventEndTime" />
                </div>                 
            </div>
            <div class="row qt_border">
            
                <%-- 당첨자발표 --%>
                <label class="col-xs-2 control-label"><spring:message code="E00019"/></label>
                <div class="col-xs-3 control_content">
                    <ifvm:input type="date" id="winDate" names="winDate" />
                </div>
                <div class="col-xs-1 control_content"></div>

                <%-- 응모채널 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="E00020"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="applyChnlCd" names="applyChnlCd" required="true" dataBind="value: camDefaultInfo.applyChnlCd" />
                </div>

            </div>
            <div class="row qt_border">
            
                <%-- 이벤트유형 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="E00021"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="eventTypeCd" names="eventTypeCd" required="true" dataBind="value: camDefaultInfo.eventTypeCd" />
                </div>

            </div>     
            <div class="row qt_border">
            
                <%-- 응모가능등급 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="E00022"/></label>
                <%-- MEM --%>
                <div class="col-xs-1 control_content text_auto">
                    <ifvm:input type="checkbox" id="apply1tierFlg" checked="true"/>
                </div>
                <div class="col-xs-1 control_content text-left">MEM</div>
                <%-- VIP --%>
                <div class="col-xs-1 control_content text_auto">
                    <ifvm:input type="checkbox" id="apply2tierFlg" />
                </div>
                <div class="col-xs-1 control_content text-left">VIP</div>
                <%-- SVIP --%>
                <div class="col-xs-1 control_content text_auto">
                    <ifvm:input type="checkbox" id="apply3tierFlg" />
                </div>
                <div class="col-xs-1 control_content text-left">SVIP</div>                                

            </div>       
            <div class="row qt_border">
            
                <%-- 선착순 --%>
                <label class="col-xs-2 control-label"><spring:message code="E00023"/></label>
                <div class="col-xs-1 control_content">
                    <ifvm:input type="number" id="limitCnt" names="limitCnt" maxLength="4" dataBind="value: camDefaultInfo.limitCnt" />
                </div>       
                <div class="col-xs-1 control_content"><spring:message code="E00034"/></div>                         

            </div>
			<div class="row qt_border">
				<%-- 1인 응모횟수 --%>
				<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="E00024"/></label>
				<div class="col-xs-7 control_content">
					<div class="col-xs-1">
						<input type="number" id="applyCnt" name="applyCnt" required="ture" maxlength="3" data-bind="value: camDefaultInfo.applyCnt">
					</div>
					
				  	<div class="col-xs-1 control_content text_auto"><spring:message code="E00025"/> /</div>
				  	
						<div class="col-xs-2 control_content">
							<input type="number" id="applyPeriod" name="applyPeriod" maxlength="3" data-bind="value: camDefaultInfo.applyPeriod">
						</div>
				  
						<div class="col-xs-3">
							<label class="radio-inline">
								<ifvm:input type="radio" names="applyPeriodCd" id="exeCyclTypeCd_E01" values="E01" checked="true"/>
								<spring:message code="E00026"/>
							</label>
							<label class="radio-inline" style="margin-left: 3px">
								<ifvm:input type="radio" names="applyPeriodCd" id="exeCyclTypeCd_E02" values="E02" />
								<spring:message code="E00027"/>
							</label>
						</div>
						
						<div class="col-xs-1 control_content text_auto">/ <spring:message code="E00028"/></div>
						<div class="col-xs-2 control_content">
							<input type="number" id="totApplyCnt" name="totApplyCnt" required="" maxlength="3" data-bind="value: camDefaultInfo.totApplyCnt">
						</div>
					  
					  <div class="col-xs-1 control_content"><spring:message code="E00025"/></div>
				</div>
			</div>  
				
            <div class="row qt_border">
            
				<%-- 개인정보 확인 --%>
				<label class="col-xs-2 control-label"><spring:message code="E00029"/></label>
				<div class="col-xs-4 control-label text-left">
					<input type="checkbox" id="privacyCheckFlg">
				</div>
			
                <%-- 응모시 차감포인트 --%>
                <label class="col-xs-2 control-label"><spring:message code="E00030"/></label>
                <div class="col-xs-2 control_content">
                    <ifvm:input type="number" id="applyRdmPnt" names="applyRdmPnt" maxLength="4" dataBind="value: camDefaultInfo.applyRdmPnt" />
                </div>       
                <div class="col-xs-1 control_content"><spring:message code="E00035"/></div>  
            </div>     
            <div class="row qt_border">

                <%-- 대상자이벤트여부 --%>
                <label class="col-xs-2 control-label"><spring:message code="E00031"/></label>
                <div class="col-xs-2 control-label text-left">
                    <ifvm:input type="checkbox" id="targetEventFlg"/>
                </div>      
                
                <%-- 제휴카드보유여부 --%>
                <label class="col-xs-2 control-label"><spring:message code="E00032"/></label>
                <div class="col-xs-2 control-label text-left">
                    <ifvm:input type="checkbox" id="chnlCardFlg"/>
                </div>                  
            </div>                                                   
            <div class="row qt_border">

                <%-- 비고 --%>
                <label class="col-xs-2 control-label"><spring:message code="M00600"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="textarea" id="comments" names="comments" maxLength="250" dataBind="value: camDefaultInfo.comments" rows="3" />
                </div>
            </div>
        </div>
    </div>
    <div class="pop_btn_area">
        <%-- 저장 --%>
        <button class="btn btn-sm btn_gray" id="campaignB2CInfoPopSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <%-- 닫기 --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="campaignB2CInfoPopCancelBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>

<div id="programPop" class="popup_container"></div>
<div id="intactTypePopup" class="popup_container"></div>
<div id="planPopup" class="popup_container"></div>
<div id="parCamPopup" class="popup_container"></div>