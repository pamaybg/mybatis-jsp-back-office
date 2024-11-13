<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var detail = false;
var campaignRoiGoalData = {};

/**
 * Init
 */
function initGoalRoiDtlPop() {
    cDialog.model.title = '<spring:message code="M00823"/>';
    $("#dialog_title").append('<spring:message code="M00823"/>');
    cDialog.model.width = "600";
    cDialog.model.close = "closeCampaignTargetingPop";

    setTimeout(function() {
        cDialog.refresh();
    }, 1000);
}

/**
 * 탭 초기화
 */
function initTab() {

    //탭 설정
    $('#goalRoiTabArea').DrawTab({
    	item: [
    		{label: '<spring:message code="M02793"/>', href: '<ifvm:url name="goalTabMain"/>'}, //목표
    		{label: '<spring:message code="M02769"/>', href: '<ifvm:url name="roiTabMain"/>'},	//ROI상세
    	]
    });
}

/**
 * Roi & Goal 데이터 조회
 */
function getRoiGoalData() {

	//캠페인 기본정보와 연결이 되어있는지 확인
	var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
	if (isNotEmpty(campaignInfo)) {
		//캠페인 ID
		campaign.id = campaignInfo[0].addInfo.actualTaskId;

		campaignRoiGoalData.camId = campaign.id;
	}
	else {
		alert('<spring:message code="C00148"/>');

		// close popup
		closeRoiGoalPop();
		return false;
	}

    $.ifvSyncPostJSON('<ifvm:action name="getCampaignRoiGoalDtl"/>', {
        camId: campaign.id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            campaignRoiGoalData = result;
			detail = true;
        }
    });
}

/**
 * 캠페인 ROI 분석 정산 저장
 */
function saveCampaignRoiGoal() {

    var rtnValue = false;

    campaignRoiGoalData.kpiCalDayValUnit = 'M';

    // 수정
	if (detail == true) {

	    $.ifvSyncPostJSON('<ifvm:action name="editCampaignRoiGoalDtl"/>',
		campaignRoiGoalData,
	    function(result) {
	        if ($.fn.ifvmIsNotEmpty(result)) {
	            rtnValue = result.success;
	        }
	    });
	}
    // 등록
	else {
	    $.ifvSyncPostJSON('<ifvm:action name="addCampaignRoiGoalDtl"/>',
		campaignRoiGoalData,
	    function(result) {
	        if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
		            rtnValue = result.success;
	            }
	        }
	    });
	}
    return rtnValue;
}

/**
 * 분석에 필요한 실행 아이템 목록 팝업 오픈
 */
function campaignExeItemPopOpen() {
    $("#campaignExeItemPop").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="roiCamExeListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01327"/>',
        width: 700,
        close : 'campaignExeItemPopClose'
    });
}
function campaignExeItemPopClose() {
    campaignExeItemPop._destroy();
}

/**
 * 분석 추가
 */
function addCampaignRoiGoalCalcRslt(_camExeSeqRid) {

    //저장
    var saveResult = saveCampaignRoiGoal();

    if (saveResult == true) {
	    campaignRoiGoalData.camExeSeqRid = _camExeSeqRid;

        //분석
        $.ifvSyncPostJSON('<ifvm:action name="addCampaignRoiGoalCalcRslt"/>',
    	campaignRoiGoalData,
        function(result) {
            if ($.fn.ifvmIsNotEmpty(result)) {
                if (result.success == true) {
                    alert('<spring:message code="C00094"/>');
                }
            }
        });
    }
}

/**
 *
 */
function closeRoiGoalPop() {
    cDialog._destroy();
}

$(document).ready(function() {

    // 팝업 설정 초기화
    initGoalRoiDtlPop();

    // ROI & Goal 데이터 조회
    getRoiGoalData();

    setTimeout(function() {

	    // 탭 초기화
        initTab();
    }, 100);

    //저장 버튼
    $('#saveCampaignRoiGoalBtn').on('click', function() {
        var result = saveCampaignRoiGoal();
        if (result == true) {
            alert('<spring:message code="C00094"/>');
            closeRoiGoalPop();
        }
    });

    //분석 버튼
    $('#campaignExeItemPopOpenBtn').on('click', function() {
        campaignExeItemPopOpen();
    });

});

</script>

<script id="commCodeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id="campaignRoiGoalPop">
    <div class="pop_inner_wrap">
		<div class="form-horizontal underline top_well clearfix">
			<div id="goalRoiTabArea"></div>
		</div>
	</div>
    <div class="pop_btn_area">

        <%-- 저장 --%>
        <button class="btn btn-sm btn_lightGray2" id="saveCampaignRoiGoalBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="L01462"/>
        </button>

        <%-- 분석 --%>
        <button class="btn btn-sm btn_lightGray2" id="campaignExeItemPopOpenBtn">
            <spring:message code="M02770"/>
        </button>
    </div>
</div>

<div id="campaignExeItemPop" class="popup_container"></div>