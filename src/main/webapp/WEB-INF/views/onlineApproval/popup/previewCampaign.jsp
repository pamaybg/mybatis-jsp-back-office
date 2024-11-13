<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>


<script>

var camId = '<%= cleanXss(request.getParameter("id")) %>';

function getPreviewCampaign() {
    
    console.log(camId)
    
    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignDefaultInfo"/>', {
        id: camId
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            $('#campaignName').val(result.campaignName);
            $('#campaignStartDate').val(result.campaignStartDate);
            $('#campaignEndDate').val(result.campaignEndDate);
            $('#campaignTypeCode').val(result.campaignTypeCode);
            $('#description').val(result.description);
            $('#campaignStatusCode').val(result.campaignStatusCode);
            $('#campaignApprovalStatusCodeName').val(result.campaignApprovalStatusCodeName);
            $('#camScopeTypeCd').val(result.camScopeTypeCd);
            $('#dispNo').val(result.dispNo);
            $('#campaignPlannerName').val(result.campaignPlannerName);
            $('#intactType2CodeName').val(result.intactType2CodeName);
            
            $('#promYn').prop('checked', (result.promYn == '1'));
            $('#fatigueExceptYn').prop('checked', (result.fatigueExceptYn == '1'));
        }
    });
}

$(document).ready(function() {

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

    getPreviewCampaign();
    
    $('#previewCampaignWrap input').prop('disabled', true);
    $('#previewCampaignWrap select').prop('disabled', true);
    $('#previewCampaignWrap textarea').prop('disabled', true);
    
    //상세화면으로 이동
    $('#campaignWorkflowBtn').on('click', function() {
        var url = '<ifvm:url name="campaignWorkFlow"/>?type=MKT&id=' + camId;
        window.open(url, '_blank');
    });

    //닫기 버튼
    $('#previewCampaignPopCloseBtn').on('click', function() {
        popupClose();
    });
});

</script>

<div class="pop_inner_wrap">
    <div class="form-horizontal" id="previewCampaignWrap">
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
        <div class="row qt_border">

            <%-- 상태 --%>
            <label class="col-xs-2 control-label"><spring:message code="M00595"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="campaignStatusCode" names="campaignStatusCode" disabled="true" dataBind="value: camDefaultInfo.campaignStatusCode" />
            </div>

            <%-- 승인 상태 --%>
            <label class="col-xs-2 control-label"><spring:message code="M01333"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="hidden" id="campaignApprovalStatusCode" names="campaignApprovalStatusCode" />
                <ifvm:input type="text" id="campaignApprovalStatusCodeName" names="campaignApprovalStatusCodeName"
                    disabled="true" dataBind="value: camDefaultInfo.campaignApprovalStatusCodeName" />
            </div>
        </div>
        <div class="row qt_border">

            <%-- 마케팅 플랜 --%>
            <ifvm:input type="hidden" id="planNm" names="planNm" readonly="true" dataBind="value: camDefaultInfo.planNm"/>
            <ifvm:input type="hidden" id="planId" names="planId" dataBind="value: camDefaultInfo.planId" />

            <%-- 조직 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02455"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="select" id="camScopeTypeCd" names="camScopeTypeCd" dataBind="value: camDefaultInfo.camScopeTypeCd" />
            </div>

            <%-- 캠페인 코드 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02311"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="dispNo" names="dispNo" maxLength="50" readonly="true" dataBind="value: camDefaultInfo.dispNo" />
            </div>
        </div>
        <div class="row qt_border">

            <%-- 기획 그룹 --%>
            <ifvm:input type="hidden" id="planGroupCd" names="planGroupCd" dataBind="value: camDefaultInfo.planGroupCd" className="temporarilyHide"/>
        </div>
        <div class="row qt_border">

            <%-- 프로모션 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02486"/></label>
            <div class="col-xs-4 control-label text-left">
                <ifvm:input type="checkbox" id="promYn" names="promYn" dataBind="checked: camDefaultInfo.promYn" />
            </div>

            <%-- 생성자 --%>
            <label class="col-xs-2 control-label"><spring:message code="L00042"/></label>
            <div class="col-xs-4 control_content">
                <ifvm:input type="text" id="campaignPlannerName" names="campaignPlannerName" readonly="true" dataBind="value: camDefaultInfo.campaignPlannerName" />
            </div>
        </div>

        <div class="row">

            <%-- 피로도 제외 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02487"/></label>
            <div class="col-xs-4 control-label text-left">
                <ifvm:input type="checkbox" id="fatigueExceptYn" names="fatigueExceptYn" dataBind="checked: camDefaultInfo.fatigueExceptYn" />
            </div>

            <%-- 트리거 데이터 유형 --%>
            <label class="col-xs-2 control-label"><spring:message code="M02456"/></label>
            <div class="col-xs-4 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="intactType2CodeName" names="intactType2CodeName" readonly="true" dataBind="value: camDefaultInfo.intactType2CodeName" />
                    <span class="input-group-addon" id="intactTypePopupBtn" style="cursor: not-allowed;">
                        <a><i class="fa fa-search"></i></a>
                    </span>
                </div>
            </div>
            
        </div>
    </div>
</div>
<div class="pop_btn_area">

    <%-- 이동 --%>
    <button class="btn btn-sm btn_gray" id="campaignWorkflowBtn">
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="M00582"/>
    </button>

    <%-- 닫기 --%>
    <button class="btn btn-sm btn_gray" id="previewCampaignPopCloseBtn">
        <i class="glyphicon glyphicon-check"></i>
        <spring:message code="L00913"/>
    </button>
</div>

<div id="campaignDtlLoad"></div>