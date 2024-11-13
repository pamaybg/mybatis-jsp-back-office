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
var campaignDefaultInfo;
//dialog
var planPop;
//validation
var campaignInfoPopValidation;

//model 정의
function initModels(data) {
    var infoModel = function(data) {

    	
        //data set
        this.camDefaultInfo = data;
        //캠페인아이디
        this.camDefaultInfo.id = campaign.id;
        //기획자명
        this.camDefaultInfo.campaignPlannerName = $.ifvmGetUserInfo().empName;
        //기획자아이디
        this.camDefaultInfo.campaignPlanner = $.ifvmGetUserInfo().empId;
        //기획조직
        this.camDefaultInfo.planOrgCode = $.ifvmGetUserInfo().orgId;
        //기획자 Account Id
        this.camDefaultInfo.accountId = $.ifvmGetUserInfo().accountId;

        if (this.camDefaultInfo.fatigueExceptYn == null || this.camDefaultInfo.fatigueExceptYn == "false" || this.camDefaultInfo.fatigueExceptYn == "0") {
            this.camDefaultInfo.fatigueExceptYn = false;
        }
        else this.camDefaultInfo.fatigueExceptYn = true;

        /* if (this.camDefaultInfo.promYn == null || this.camDefaultInfo.promYn == "false" || this.camDefaultInfo.promYn == "0") {
            this.camDefaultInfo.promYn = false;
        }
        else this.camDefaultInfo.promYn = true; */
        this.camDefaultInfo.promYn = true;

        if (this.camDefaultInfo.prmsExceptYn == null || this.camDefaultInfo.prmsExceptYn == "false" || this.camDefaultInfo.prmsExceptYn == "0") {
            this.camDefaultInfo.prmsExceptYn = false;
        }
        else this.camDefaultInfo.prmsExceptYn = true;

        if (this.camDefaultInfo.eventYn == null || this.camDefaultInfo.eventYn == "false" || this.camDefaultInfo.eventYn == "0") {
            this.camDefaultInfo.eventYn = false;
        }
        else this.camDefaultInfo.eventYn = true;
        
        //대분류
        $('#pntAccntBigTypeCd').val(this.camDefaultInfo.pntAccntBigTypeCd);
        $('#pntAccntBigTypeCd').change();
      
        //중분류
        $('#pntAccntMidTypeCd').val(this.camDefaultInfo.pntAccntMidTypeCd);
        $('#pntAccntMidTypeCd').change();

        //소분류
        $('#pntAccntSmlTypeCd').val(this.camDefaultInfo.pntAccntSmlTypeCd);
        $('#pntAccntSmlTypeCd').change();

        //세분류
        $('#pntAccntDetailTypeCd').val(this.camDefaultInfo.pntAccntDetailTypeCd);

        campaignDefaultInfo = this;
    };

    //konckout bindings
    ko.applyBindings(new infoModel(data), document.getElementById("campaignDefaultInfoPop") );

    if ($.fn.ifvmIsEmpty(data.id)) {
        campaignDefaultInfo.camDefaultInfo.fatigueExceptYn = true;
		$('#fatigueExceptYn').prop('checked', true);
    }
    
}

//캠페인기본정보 저장
function saveCampaignDefaultInfo() {
    //달력 binding 안되는 현상 발생 값을 찾아 넣어준다.

    campaignDefaultInfo.camDefaultInfo.campaignStartDate = $("#campaignStartDate").val();
    campaignDefaultInfo.camDefaultInfo.campaignEndDate = $("#campaignEndDate").val();
    campaignDefaultInfo.camDefaultInfo.campaignStatusCode = $("#campaignStatusCode").val();

    campaignDefaultInfo.camDefaultInfo.parCampaignId = $("#parCampaignId").val();
    campaignDefaultInfo.camDefaultInfo.b2cRefKey = $("#b2cRefKey").val();

    campaignDefaultInfo.camDefaultInfo.type = strType;
    
    campaignDefaultInfo.camDefaultInfo.pntAccntBigTypeCd = $('#pntAccntBigTypeCd').val();
    campaignDefaultInfo.camDefaultInfo.pntAccntMidTypeCd = $('#pntAccntMidTypeCd').val();
    campaignDefaultInfo.camDefaultInfo.pntAccntSmlTypeCd = $('#pntAccntSmlTypeCd').val();
    campaignDefaultInfo.camDefaultInfo.pntAccntDetailTypeCd = $('#pntAccntDetailTypeCd').val();
    campaignDefaultInfo.camDefaultInfo.pntAccntCustDispTxt = $('#pntAccntCustDispTxt').val();
    
    campaignDefaultInfo.camDefaultInfo.pntAccntCodeVal = $('#pntAccntCodeVal').val();

    //check validation
    if (chkCalendarValidation() == true
            && campaignInfoPopValidation.confirm()) {


        $.ifvSyncPostJSON('<ifvm:action name="saveCampaignDefaultInfo"/>', campaignDefaultInfo.camDefaultInfo, function(result) {

            campaignDefaultInfo = {};

            //set campaign ID
            campaign.id = result.message;

            //set actual task ID
            diagram._selectedObject.actualTaskId = result.message;

            //set campaign ID
            diagram._selectedObject.campaignId = result.message;

            //set old campaign ID
            diagram._selectedObject.oldCampaignId = result.message;

            //save workflow
            saveWorkflow();

            //alert('<spring:message code="M00152" />');

            //close popup
            closeCampaignInfoPop();
        });
    }
}

//캠페인기본정보 팝업 설정
function campaignDefaultInfoInit() {
    pageSetUp(); 

    //채널
    $.fn.ifvmSetSelectOptionCommCode("channelTypeCode", "MKT_CAM_CHNL_TYPE_CD");

    //캠페인 유형
    $.fn.ifvmSetSelectOptionCommCode("campaignTypeCode", "MKT_CAM_TYPE_CD");

    //캠페인상태
    $.fn.ifvmSetSelectOptionCommCode("campaignStatusCode", "MKT_CAM_STAT", "W");

    //조직
    $.fn.ifvmSetSelectOptionCommCode("camScopeTypeCd", "CAM_SCOPE_TYPE_CD", null, null, true);

    //기획그룹
    $.fn.ifvmSetSelectOptionCommCode("planGroupCd", "PLAN_GROUP_CD", null, null, true);

    //대분류
    $.fn.ifvmSetSelectOptionCommCode("pntAccntBigTypeCd", "PNT_TXN_TYPE", null, null, true);

    //중분류
    $.fn.ifvmSetSelectOptionCommCodeSync("pntAccntMidTypeCd", "PNT_TXN_DTL_TYPE", null, 'pntAccntBigTypeCd', true);

    //소분류
    $.fn.ifvmSetSelectOptionCommCodeSync("pntAccntSmlTypeCd", "DA_PNT_ACCNT_SML_TYPE", null, 'pntAccntMidTypeCd', true);

    //세분류
    $.fn.ifvmSetSelectOptionCommCodeSync("pntAccntDetailTypeCd", "DA_PNT_ACCNT_DETAIL_TYPE", null, 'pntAccntSmlTypeCd', true);

    //if (strType == 'LOY') {
        $('#campaignTypeCode').attr('disabled', true);
        $('#campaignTypeCode').val('PROMOTION');
		/* $('#promYn').prop('checked', true); */
    //}

    //팝업설정
    cDialog.model.title = '프로모션 기본 정보';
    $("#dialog_title").append('프로모션 기본 정보');
    cDialog.model.width = "660";
    cDialog.model.close = "closeCampaignInfoPop";

    //validation
    campaignInfoPopValidation = $("#campaignDefaultInfoPop").ifvValidation();
}

//달력
function setChannelCalendar() {
    var startDate = $("#campaignStartDate");
    var endDate = $("#campaignEndDate");

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
    var startDate = $("#campaignStartDate");
    var endDate = $("#campaignEndDate");
    startDate.removeClass('ifv_vali_wrong');
    if (startDate.val() > endDate.val()) {
        validFailMessage(startDate, '<spring:message code="C00043"/>');
        rtnFlag = false;
    }
    return rtnFlag;
}

//캠페인기본정보 팝업 데이터 설정
function campaignDefaultInfoInitData() {
    campaignDefaultInfo = {camDefaultInfo: {}};

    //set task type
    diagram._selectedObject.taskType = "INFO";

    //캠페인 ID
    var id = diagram._selectedObject.actualTaskId;

    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignDefaultInfo"/>', {
        id: id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)){
            campaignDefaultInfo.camDefaultInfo = result;
            $("#campaignStartDate").val(result.campaignStartDate);
            $("#campaignEndDate").val(result.campaignEndDate);
        }
    });
    initModels(campaignDefaultInfo.camDefaultInfo);
}

// dialog close
function closeCampaignInfoPop(args) {
    campaignDefaultInfo = {};
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
		campaignDefaultInfo.camDefaultInfo.ridIntactType = rowData.rid;
		$("#intactType2CodeName").val(rowData.intactType_2CdNm);

		//팝업 닫기
        intactTypePopupClose();
	}
}
/**
 * 마케팅 플랜 팝업열기
 */
function planListPopOpen() {
    planPop = $("#planPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="planListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02290"/>',
        width: 700,
        close : 'planPopupClose'
    });
}
/**
 * 마케팅 플랜 팝업 닫기
 */
function planPopupClose() {
    planPop.ejDialog('destroy');
}

/**
 * 상위 캠페인 코드 팝업 열기
 */
function parCamPopupOpen() {
    $("#parCamPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="parCamListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02290"/>',
        width: 700,
        close : 'parCamPopupClose'
    });
}
function parCamPopupClose() {
    parCamPopup._destroy();
}

$(function () {

    //달력 설정
    setChannelCalendar();

    //캠페인기본정보 폼 설정
    campaignDefaultInfoInit();

    //캠페인기본정보 데이터
    campaignDefaultInfoInitData();

    //저장 클릭시
    $('#campaignInfoPopSaveBtn').on('click', function(){
        saveCampaignDefaultInfo();
    });

    //draft 완료 클릭시
    $('#campaignInfoPopDramftSaveBtn').on('click', function(){
        saveCampaignDefaultInfo();
    });

    //취소 클릭시
    $('#campaignInfoPopCancelBtn').on('click', function(){
        closeCampaignInfoPop();
    });

    //이벤트유형 팝업 버튼
    $('#intactTypePopupBtn').on('click', function(){
        intactTypePopupOpen();
    });

    //마케팅 플랜 팝업 버튼
    $('#planListPopupBtn').on('click', function(){
        planListPopOpen();
    });

    //상위 캠페인 코드 팝업 버튼
    $('#parCamPopupBtn').on('click', function() {
        parCamPopupOpen();
    });

//     setTimeout(function() {
//         //popup 높이 맞추기
//         new ifvm.PopupHeight({
//             popupDivId : 'dialog',
//             contentsId : 'dialogPopupWrap'
//         });

//         cDialog.refresh();
//     }, 500);
});
</script>

<div id="dialogPopupWrap">
    <div class="pop_inner_wrap">
        <div class="form-horizontal" id="campaignDefaultInfoPop">
            <div class="row qt_border">

                <%-- 캠페인명 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00592"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="text" id="campaignName" names="campaignName" maxLength="50" required="true" dataBind="value: camDefaultInfo.campaignName" />
                </div>
            </div>
            <div class="row qt_border">

                <%-- 시작일 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00593"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="date" id="campaignStartDate" names="campaignStartDate" required="true"  />
                </div>

                <%-- 종료일 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00594"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="date" id="campaignEndDate" names="campaignEndDate" required="true"  />
                </div>
            </div>
            <div class="row qt_border">

                <%-- 유형 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00755"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="campaignTypeCode" names="campaignTypeCode" required="true" dataBind="value: camDefaultInfo.campaignTypeCode" />
                </div>

            </div>
            <div class="row qt_border">

                <%-- 비고 --%>
                <label class="col-xs-2 control-label"><spring:message code="M00600"/></label>
                <div class="col-xs-10 control_content">
                    <ifvm:input type="textarea" id="description" names="description" maxLength="250" dataBind="value: camDefaultInfo.description" rows="3" />
                </div>
            </div>
            <div class="row">

                <%-- 상태 --%>
                <label class="col-xs-2 control-label"><spring:message code="M00595"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="campaignStatusCode" names="campaignStatusCode" disabled="true" dataBind="value: camDefaultInfo.campaignStatusCode" />
                </div>

				<%-- 캠페인 코드 --%>
                <label class="col-xs-2 control-label"><spring:message code="M02311"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="dispNo" names="dispNo" maxLength="50" readonly="true" dataBind="value: camDefaultInfo.dispNo" />
                </div>

                <%-- 승인 상태 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M01333"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="hidden" id="campaignApprovalStatusCode" names="campaignApprovalStatusCode" />
                    <ifvm:input type="text" id="campaignApprovalStatusCodeName" names="campaignApprovalStatusCodeName"
                        disabled="true" dataBind="value: camDefaultInfo.campaignApprovalStatusCodeName" />
                </div> --%>
            </div>
            <div class="row">
                <%-- 안내문구 --%>
                <label class="col-xs-2 control-label"><span class="asterisk" style="color:black;">*</span>안내문구</label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="pntAccntCustDispTxt" names="pntAccntCustDispTxt" maxLength="16" dataBind="value: camDefaultInfo.pntAccntCustDispTxt" />
                </div>
                <span class="detail_txt">※사용자에게 노출될 문구를 입력하세요. (최대 16글자)</span>
			</div>
            <%-- 마케팅 플랜 --%>
            <ifvm:input type="hidden" id="planNm" names="planNm" readonly="true" dataBind="value: camDefaultInfo.planNm"/>
            <ifvm:input type="hidden" id="planId" names="planId" dataBind="value: camDefaultInfo.planId" />
            <!-- <div class="row qt_border"> -->

                <%--
                <label class="col-xs-2 control-label"><spring:message code="M02290"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="text" id="planNm" names="planNm" readonly="true" dataBind="value: camDefaultInfo.planNm" />
                        <ifvm:input type="hidden" id="planId" names="planId" dataBind="value: camDefaultInfo.planId" />
                        <span class="input-group-addon" id="planListPopupBtn">
                            <a><i class="fa fa-search"></i></a>
                        </span>
                    </div>
                </div>
                 --%>

                <%-- 조직 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M02455"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="camScopeTypeCd" names="camScopeTypeCd" dataBind="value: camDefaultInfo.camScopeTypeCd" />
                </div> --%>

                <%-- 캠페인 코드 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M02311"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="dispNo" names="dispNo" maxLength="50" readonly="true" dataBind="value: camDefaultInfo.dispNo" />
                </div> --%>
            <!-- </div> -->
            <!-- <div class="row qt_border"> -->

                <%-- 상위 캠페인 코드 PAR_CAM_ID --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M02741"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="hidden" id="parCampaignId" names="parCampaignId" readonly="true" dataBind="value: camDefaultInfo.parCampaignId" />
                        <ifvm:input type="text" id="parDispNo" names="parDispNo" readonly="true" dataBind="value: camDefaultInfo.parDispNo" />
                        <span class="input-group-addon" id="parCamPopupBtn">
                            <a><i class="fa fa-search"></i></a>
                        </span>
                    </div>
                </div> --%>

                <%-- 연관 이벤트 코드 B2C_REF_KEY --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M02742"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="b2cRefKey" names="b2cRefKey" maxLength="50" dataBind="value: camDefaultInfo.b2cRefKey" />
                </div> --%>
            <!-- </div> -->
            <%-- <ifvm:input type="select" id="planGroupCd" names="planGroupCd" dataBind="value: camDefaultInfo.planGroupCd" className="temporarilyHide"/> --%>
			<!--
            <div class="row qt_border">
			 -->
                <%-- 기획 그룹 --%>
                <%--
                <label class="col-xs-2 control-label"><spring:message code="M02309"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="planGroupCd" names="planGroupCd" dataBind="value: camDefaultInfo.planGroupCd" />
                </div>
            </div>
             --%>
            <!-- <div class="row qt_border"> -->

                <%-- 프로모션 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M02486"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="promYn" names="promYn" dataBind="checked: camDefaultInfo.promYn" />
                </div> --%>

                <%-- 생성자 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="L00042"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="campaignPlannerName" names="campaignPlannerName" readonly="true" dataBind="value: camDefaultInfo.campaignPlannerName" />
                </div> --%>
            <!-- </div> -->
            <!-- <div class="row"> -->

                <%-- 피로도 미적용 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M02732"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="fatigueExceptYn" names="fatigueExceptYn" dataBind="checked: camDefaultInfo.fatigueExceptYn" />
                </div> --%>

                <%-- 트리거 데이터 유형 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M02456"/></label>
                <div class="col-xs-4 control_content">
                    <div class="input-group">
                        <ifvm:input type="text" id="intactType2CodeName" names="intactType2CodeName" readonly="true" dataBind="value: camDefaultInfo.intactType2CodeName" />
                        <span class="input-group-addon" id="intactTypePopupBtn">
                            <a><i class="fa fa-search"></i></a>
                        </span>
                    </div>
                </div> --%>
			<!-- </div> -->
			<!-- <div class="row"> -->

                <%-- 퍼미션 미적용 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="M02310"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="prmsExceptYn" names="prmsExceptYn" dataBind="checked: camDefaultInfo.prmsExceptYn" />
                </div> --%>

                <%-- 이벤트 여부 --%>
                <%-- <label class="col-xs-2 control-label"><spring:message code="Q02897"/></label>
                <div class="col-xs-4 control-label text-left">
                    <ifvm:input type="checkbox" id="eventYn" names="eventYn" dataBind="checked: camDefaultInfo.eventYn" />
                </div> --%>
            <!-- </div> -->

			            
			<div class="page_btn_area">
				<div class="col-xs-12">
					<span>포인트 지급 유형</span>
				</div>
			</div>
			<!-- 
			<div class="row">
                <%-- 회계계정코드 --%>
                <label class="col-xs-2 control-label">회계계정코드</label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="pntAccntCodeVal" names="pntAccntCodeVal" maxLength="15" dataBind="value: camDefaultInfo.pntAccntCodeVal" />
                </div>
			</div>
			-->
			<div class="row">
                <%-- 대분류 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span>대분류</label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="pntAccntBigTypeCd" names="pntAccntBigTypeCd" required="true" dataBind="value: camDefaultInfo.pntAccntBigTypeCd" />
                </div>
                <%-- 중분류 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span>중분류</label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="pntAccntMidTypeCd" names="pntAccntMidTypeCd" required="true" dataBind="value: camDefaultInfo.pntAccntMidTypeCd" />
                </div>
			</div>
			<div class="row">
                <%-- 소분류 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span>소분류</label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="pntAccntSmlTypeCd" names="pntAccntSmlTypeCd" required="true" dataBind="value: camDefaultInfo.pntAccntSmlTypeCd" />
                </div>
                <%-- 세분류 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span>세분류</label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="select" id="pntAccntDetailTypeCd" names="pntAccntDetailTypeCd" required="true" dataBind="value: camDefaultInfo.pntAccntDetailTypeCd" />
                </div>
			</div>
			<!--
			<div class="row">
                <%-- 안내문구 --%>
                <label class="col-xs-2 control-label"><span class="asterisk">*</span>안내문구</label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="pntAccntCustDispTxt" names="pntAccntCustDispTxt" maxLength="16" required="true" dataBind="value: camDefaultInfo.pntAccntCustDispTxt" />
                </div>
                <span class="detail_txt">※사용자에게 노출될 문구를 입력하세요. (최대 16글자)</span>
			</div>
			-->
			<div class="row">
                <%-- 생성자 --%>
                <label class="col-xs-2 control-label"><spring:message code="L00042"/></label>
                <div class="col-xs-4 control_content">
                    <ifvm:input type="text" id="campaignPlannerName" names="campaignPlannerName" readonly="true" dataBind="value: camDefaultInfo.campaignPlannerName" />
                </div>
                <%-- 생성일시 --%>
                <label class="col-xs-2 control-label"><spring:message code="L00753"/></label>
                <div class="col-xs-4 control_content">
                	<ifvm:input type="text" id="createDate" names="createDate" maxLength="50" readonly="true" dataBind="value: camDefaultInfo.createDate" disabled="true"/>
                </div>
			</div>
        </div>
    </div>
    <div class="pop_btn_area">
        <%-- 저장 --%>
        <button class="btn btn-sm btn_gray" id="campaignInfoPopSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>
        <%-- 닫기 --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="campaignInfoPopCancelBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>

<div id="programPop" class="popup_container"></div>
<div id="intactTypePopup" class="popup_container"></div>
<div id="planPopup" class="popup_container"></div>
<div id="parCamPopup" class="popup_container"></div>