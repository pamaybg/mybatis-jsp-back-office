<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
/* 일시적으로 숨김 처리 함 */
.temporarilyHide { display: none; }
</style>

<script>

//model
var scoringDefaultInfo;
//validation
var scoringInfoPopValidation;

/**
 * 기본정보 데이터 세팅
 */
function initModels(data) {
    var infoModel = function(data) {

        //data set
        this.scrDefaultInfo = data;
        //캠페인아이디
        this.scrDefaultInfo.id = scoring.id;
        //기획자명
        this.scrDefaultInfo.scrPlnerName = $.ifvmGetUserInfo().empName;
        //기획자아이디
        this.scrDefaultInfo.scrPlner = $.ifvmGetUserInfo().empId;
        //기획조직
        this.scrDefaultInfo.scrPlanOrgCd = $.ifvmGetUserInfo().orgId;
        //기획자 Account Id
        this.scrDefaultInfo.accountId = $.ifvmGetUserInfo().accountId;

        scoringDefaultInfo = this;
    };

    //konckout bindings
    ko.applyBindings(new infoModel(data), document.getElementById("scoringDefaultInfoPop") );

    if ($.fn.ifvmIsEmpty(data.id)) {
        scoringDefaultInfo.scrDefaultInfo.fatiChkYn = "1";
		$('#fatiChkYn').prop('checked', true);
    }
}

/**
 * scoring 기본정보 저장
 */
function saveScoringDefaultInfo() {

    //달력 binding 안되는 현상 발생 값을 찾아 넣어준다.

    scoringDefaultInfo.scrDefaultInfo.scrStartDd = $("#scrStartDd").val();
    scoringDefaultInfo.scrDefaultInfo.scrEndDd = $("#scrEndDd").val();
    scoringDefaultInfo.scrDefaultInfo.scrStatusCd = $("#scrStatusCd").val();

    scoringDefaultInfo.scrDefaultInfo.type = strType;

    //check validation
    if (chkCalendarValidation() == true
            && scoringInfoPopValidation.confirm()) {


        $.ifvSyncPostJSON('<ifvm:action name="saveScoringDefaultInfo"/>', scoringDefaultInfo.scrDefaultInfo, function(result) {

            scoringDefaultInfo = {};

            //set scoring ID
            scoring.id = result.message;

            //set actual task ID
            diagram._selectedObject.actualTaskId = result.message;

            //set campaign ID
            diagram._selectedObject.scoringId = result.message;

            //set old campaign ID
            diagram._selectedObject.oldScoringId = result.message;

            //save workflow
            saveWorkflow();

            //alert('<spring:message code="M00152" />');

            //close popup
            closeScoringInfoPop();
        });
    }
}

/**
 * scroing 기본정보 팝업 설정
 */
function scoringDefaultInfoInit() {
    pageSetUp();

    //스코어링 유형 (SCR_TYPE_CD)
    $.fn.ifvmSetSelectOptionCommCode("scrTypeCd", "LOY_SCR_TYPE");

    //스코어링 상태 (SCR_STATUS_CD)
    $.fn.ifvmSetSelectOptionCommCode("scrStatusCd", "MKT_CAM_STAT", "W");

    //팝업설정
    cDialog.model.title = '<spring:message code="L02209"/>';
    $("#dialog_title").append('<spring:message code="L02209"/>');
    cDialog.model.width = "660";
    cDialog.model.close = "closeScoringInfoPop";

    //validation
    scoringInfoPopValidation = $("#scoringDefaultInfoPop").ifvValidation();
}

//달력
function setChannelCalendar() {
    var startDate = $("#scrStartDd");
    var endDate = $("#scrEndDd");

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
    var startDate = $("#scrStartDd");
    var endDate = $("#scrEndDd");
    startDate.removeClass('ifv_vali_wrong');
    if (startDate.val() > endDate.val()) {
        validFailMessage(startDate, '<spring:message code="C00043"/>');
        rtnFlag = false;
    }
    return rtnFlag;
}

/**
 * scoring 기본정보 팝업 데이터 세팅
 */
function scoringDefaultInfoInitData() {
    scoringDefaultInfo = {
    		scrDefaultInfo : {}
    };

    //set task type
    diagram._selectedObject.taskType = "INFO";

    //scoring ID
    var id = diagram._selectedObject.actualTaskId;
    if($.fn.ifvmIsNotEmpty(id)) {
	    $.ifvSyncPostJSON('<ifvm:action name="getScoringDefaultInfo"/>', {
	        id: id
	    },
	    function(result) {
	        if ($.fn.ifvmIsNotEmpty(result)){
	            scoringDefaultInfo.scrDefaultInfo = result;
	            $("#scrStartDd").val(result.scrStartDd);
	            $("#scrEndDd").val(result.scrEndDd);
	        }
	    });
    }

    initModels(scoringDefaultInfo.scrDefaultInfo);
}

/**
 * 지수 기본 정보 팝업 close
 */
function closeScoringInfoPop(args) {
    scoringDefaultInfo = {};
    //konckout bindings stop
    ko.virtualElements.allowedBindings.stopBinding = true;

    //dialog 파괴
    cDialog._destroy();
}

//트리거 데이터 유형 팝업 열기
function intactTypePopupOpen() {
    $("#intactTypePopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="intactTypePop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02313"/>',
        width: 700,
        close : 'intactTypePopupClose'
    });
}

//트리거 데이터 유형 팝업 닫기
function intactTypePopupClose() {
    intactTypePopup._destroy();
}

//트리거 데이터 유형 선택
function selectIntactType() {
	var rowId = gridIdintactTypePopGrid.getGridParam("selrow");
	var rowData = gridIdintactTypePopGrid.getRowData(rowId);

	if ($.fn.ifvmIsNotEmpty(rowId)) {
		//캠페인기본정보에 해당 유형 값 설정
		scoringDefaultInfo.scrDefaultInfo.ridIntactType = rowData.rid;
		$("#intactType2CodeName").val(rowData.intactType_2CdNm);

		//팝업 닫기
        intactTypePopupClose();
	}
}

$(function () {

    //달력 설정
    setChannelCalendar();

    //scroing 기본정보 팝업 설정
    scoringDefaultInfoInit();

    //scoring 기본정보 데이터 세팅
    scoringDefaultInfoInitData();

    //저장 클릭시
    $('#scoringInfoPopSaveBtn').on('click', function(){
        saveScoringDefaultInfo();
    });

    //취소 클릭시
    $('#scoringInfoPopCancelBtn').on('click', function(){
        closeScoringInfoPop();
    });

    //이벤트유형 팝업 버튼
    $('#intactTypePopupBtn').on('click', function(){
        intactTypePopupOpen();
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
        <div class="form-horizontal" id="scoringDefaultInfoPop">
            <div class="row qt_border">

                <%-- 지수명 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02202"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="text" id="scrNm" names="scrNm" maxLength="50" required="true" dataBind="value: scrDefaultInfo.scrNm" />
                </div>
            </div>
            <div class="row qt_border">

                <%-- 시작일 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02205"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="date" id="scrStartDd" names="scrStartDd" required="true"  />
                </div>

                <%-- 종료일 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02206"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="date" id="scrEndDd" names="scrEndDd" required="true"  />
                </div>
            </div>
            <div class="row qt_border">

                <%-- 유형 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02203"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="scrTypeCd" names="scrTypeCd" required="true" dataBind="value: scrDefaultInfo.scrTypeCd" />
                </div>
                
                <%-- 트리거 데이터 유형 --%>
                <!--
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02210"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="type" names="type" dataBind="value: scrDefaultInfo.campaignTypeCode" />
                </div>
                -->
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L02254"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="text" id="intactType2CodeName" names="intactType2CodeName" required="true" readonly="true" dataBind="value: scrDefaultInfo.ridIntactTypeMarkName" />
                        <span class="input-group-addon" id="intactTypePopupBtn">
                            <a><i class="fa fa-search"></i></a>
                        </span>
                    </div>
                </div>
            </div>
            <div class="row qt_border">

                <%-- 비고 --%>
                <label class="col-xs-2 control-label"><spring:message code="M00600"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="textarea" id="scrDesc" names="scrDesc" maxLength="250" dataBind="value: scrDefaultInfo.scrDesc" rows="3" />
                </div>
            </div>
            <div class="row qt_border">

                <%-- 상태 --%>
                <label class="col-xs-2 control-label"><spring:message code="M00595"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="scrStatusCd" names="scrStatusCd" disabled="true" dataBind="value: scrDefaultInfo.scrStatusCd" />
                </div>

                <%-- 승인 상태 --%>
                <%--
                <label class="col-xs-2 control-label"><spring:message code="M01333"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="hidden" id="elecAprvStatusCd" names="elecAprvStatusCd" />
                    <ifvm:input type="text" id="elecAprvStatusCdMarkName" names="elecAprvStatusCdMarkName"
                        disabled="true" dataBind="value: scrDefaultInfo.elecAprvStatusCdMarkName" />
                </div>
                --%>
                
                <%-- 관리번호 --%>
                <label class="col-xs-2 control-label"><spring:message code="L02201"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="dispNo" names="dispNo" maxLength="50" readonly="true" dataBind="value: scrDefaultInfo.dispNo" />
                </div>
            </div>
            <%-- <div class="row qt_border"> --%>

                <%-- 마케팅 플랜 --%>
                <%--
                <ifvm:input type="hidden" id="planNm" names="planNm" readonly="true" dataBind="value: scrDefaultInfo.planNm"/>
                <ifvm:input type="hidden" id="planId" names="planId" dataBind="value: scrDefaultInfo.planId" />
                <label class="col-xs-2 control-label"><spring:message code="M02290"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="text" id="planNm" names="planNm" readonly="true" dataBind="value: scrDefaultInfo.planNm" />
                        <ifvm:input type="hidden" id="planId" names="planId" dataBind="value: scrDefaultInfo.planId" />
                        <span class="input-group-addon" id="planListPopupBtn">
                            <a><i class="fa fa-search"></i></a>
                        </span>
                    </div>
                </div>
                 --%>
<!-- 
                <%-- 조직 --%>
                <label class="col-xs-2 control-label"><spring:message code="M02455"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="camScopeTypeCd" names="camScopeTypeCd" dataBind="value: scrDefaultInfo.camScopeTypeCd" />
                </div>
            </div>
<!-- 
            <div class="row qt_border">
                <%-- 상위 캠페인 코드 PAR_CAM_ID --%>
                <label class="col-xs-2 control-label"><spring:message code="M02741"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="hidden" id="parCampaignId" names="parCampaignId" readonly="true" dataBind="value: scrDefaultInfo.parCampaignId" />
                        <ifvm:input type="text" id="parDispNo" names="parDispNo" readonly="true" dataBind="value: scrDefaultInfo.parDispNo" />
                        <span class="input-group-addon" id="parCamPopupBtn">
                            <a><i class="fa fa-search"></i></a>
                        </span>
                    </div>
                </div>

                <%-- 연관 이벤트 코드 B2C_REF_KEY --%>
                <label class="col-xs-2 control-label"><spring:message code="M02742"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="b2cRefKey" names="b2cRefKey" maxLength="50" dataBind="value: scrDefaultInfo.b2cRefKey" />
                </div>
            </div>
            <ifvm:input type="select" id="planGroupCd" names="planGroupCd" dataBind="value: scrDefaultInfo.planGroupCd" className="temporarilyHide"/>
            <%-- <div class="row qt_border"> --%>
                <%-- 기획 그룹 --%>
                <%--
                <label class="col-xs-2 control-label"><spring:message code="M02309"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="planGroupCd" names="planGroupCd" dataBind="value: scrDefaultInfo.planGroupCd" />
                </div>
            </div>
             --%>
            <div class="row qt_border">

                <%-- 프로모션 --%>
                <label class="col-xs-2 control-label"><spring:message code="M02486"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="promYn" names="promYn" dataBind="checked: scrDefaultInfo.promYn" />
                </div>

                <%-- 생성자 --%>
                <label class="col-xs-2 control-label"><spring:message code="L00042"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="campaignPlannerName" names="campaignPlannerName" readonly="true" dataBind="value: scrDefaultInfo.campaignPlannerName" />
                </div>
            </div>
            <div class="row">

                <%-- 피로도 미적용 --%>
                <label class="col-xs-2 control-label"><spring:message code="M02732"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="fatiChkYn" names="fatiChkYn" dataBind="checked: scrDefaultInfo.fatiChkYn" />
                </div>

                <%-- 트리거 데이터 유형 --%>
                <label class="col-xs-2 control-label"><spring:message code="M02456"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="text" id="intactType2CodeName" names="intactType2CodeName" readonly="true" dataBind="value: scrDefaultInfo.intactType2CodeName" />
                        <span class="input-group-addon" id="intactTypePopupBtn">
                            <a><i class="fa fa-search"></i></a>
                        </span>
                    </div>
                </div>
			</div>
			<div class="row">

                <%-- 퍼미션 미적용 --%>
                <label class="col-xs-2 control-label"><spring:message code="M02310"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="prmsExceptYn" names="prmsExceptYn" dataBind="checked: scrDefaultInfo.prmsExceptYn" />
                </div>

                <%-- 이벤트 여부 --%>
                <label class="col-xs-2 control-label"><spring:message code="Q02897"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="eventYn" names="eventYn" dataBind="checked: scrDefaultInfo.eventYn" />
                </div>
            </div>
-->
        </div>
    </div>
    <div class="pop_btn_area">
        <%-- 저장 --%>
        <button class="btn btn-sm btn_gray" id="scoringInfoPopSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <%-- 닫기 --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="scoringInfoPopCancelBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>

<div id="programPop" class="popup_container"></div>
<div id="intactTypePopup" class="popup_container"></div>
