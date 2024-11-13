<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var campaignOffer;
var campaignOfferId = null;
var relDetailStatus = 'I';

/**
 * 팝업 초기화
 */
function initPopup() {

    cDialog.model.title = '<spring:message code="M02303"/>';
    $("#dialog_title").append('<spring:message code="M02303"/>');
    cDialog.model.width = "1024";
    cDialog.model.close = "closeBenefitsPop";

    setPopHeight();
}

/**
 * dialog close
 */
function closeBenefitsPop(args) {
	cDialog._destroy();
}

/**
 * 팝업 높이 설정
 */
function setPopHeight() {
    setTimeout(function() {
      //popup 높이 맞추기
        new ifvm.PopupHeight({
            popupDivId : 'dialog',
            contentsId : 'dialogPopupWrap'
        });
        cDialog.refresh();
    }, 100);
}

/**
 * 오퍼 상세화면 로드
 */
function loadOfferDtail(campaignOfferId) {

	   	$.fn.ifvmLoadUiSetting("benefitsDetailArea", '<ifvm:url name="MKTOfferDetailLoad"/>?id=' + campaignOfferId);

	   	setPopHeight();
    setTimeout(function() {
	   	$('#offerTabDiv .tab-list').css('width', '');
    }, 500);
}

/**
 * 등록된 오퍼 상세 정보 조회
 */
function getBenefitsInfo() {

	campaignOffer = {offerList: []};

	//캠페인 기본정보와 연결이 되어있는지 확인
	var campaignInfo = getNodesByNodeType(diagram.selectionList[0], "INFO");
	if (isNotEmpty(campaignInfo)) {
		//캠페인 ID
		campaign.id = campaignInfo[0].addInfo.actualTaskId;
	}
	else {
		alert('<spring:message code="C00148"/>');

		// close popup
		closeBenefitsPop();
		return false;
	}

    //node 유형설정
    diagram.selectionList[0].addInfo.taskType = "OFFER";

    //call 캠페인 오퍼 조회
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignOffer"/>', {
        campaignId: campaign.id
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
        	$.each(result.offerList, function(index, data){
                data.discountAmt = Math.ceil(data.discountAmt);
                campaignOfferId = data.offerId;
            });
        	campaignOffer = result;
        }
    });

	//오퍼 상세화면 로드
	loadOfferDtail(campaignOfferId);
}

/**
 * 오퍼 조회 팝업
 */
function searchOfferPopupOpen() {

	if(offerid == '' || offerid == null){
		$("#benefitsOfferListPop").ifvsfPopup({
	        enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="benefitsOfferListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M00794"/>',
	        width: 1024,
	        close : 'benefitsOfferListPopClose',
	    });
	}else{
		alert('오퍼를 삭제후 다시 진행하여 주시기 바랍니다.');
	}
}
function benefitsOfferListPopClose() {
	benefitsOfferListPop._destroy();
}

/**
 * 오퍼 저장
 */
function benefitsPopSave() {
	var saveResult = false;
	//var dateNm = $("#aplyStartDd").val().replaceAll('-','');
	//var dateNm2 = $("#aplyEndDd").val().replaceAll('-','');
	//var dateCheck = parseInt(dateNm2) - parseInt(dateNm);
	var dateCheck = 1;

	/* isValid = validation.confirm(); */
    isValid = $("#dataForm").ifvValidation().confirm();

    if(dateCheck < 0){
    	alert('<spring:message code="D10160"/>');
    }else{
    if (conCheck && isValid) {
        var obj = getOfferDataFromView();
        obj.offerDivCd = 'C';

        console.log("저장 >>> ")
        console.log(obj)

    	// 오퍼 저장
    	//if (strType == 'LOY') {
    	    $.ifvSyncPostJSON('<ifvm:action name="saveLoyOffer"/>'
    	    , obj
    	    , function(result) {
		    	saveResult = result.success;

   	    		// 수정
   	    		if (detail == true) {
    		    	relDetailStatus = 'U';
   	    		}
   	    		else {
    		    	campaignOffer = {offerList:[]};
    		    	campaignOffer.offerList[0] = {};
        			campaignOffer.offerList[0].id = null;

    		    	relDetailStatus = 'I';
    		    	if ($.fn.ifvmIsNotEmpty(result)) {
    			    	saveResult = result.success;
    			    	campaignOffer.offerList[0].offerId = result.message;
    		    	}
   	    		}
    	    },function(result){
    	    	alert(result.message);
    	    });
    	//}
    	/* else {
    		// 수정
    		if (detail == true) {
    		    $.ifvSyncPostJSON('<ifvm:action name="editOffer"/>', obj
        		, function(result) {
    		    	relDetailStatus = 'U';
    		    	saveResult = result.success;
    		    });
    		}
    		// 등록
    		else {
    			obj.childOfferList.forEach(function(data) {
    				data.rid = '';
    			})

    		    $.ifvSyncPostJSON('<ifvm:action name="setOffer"/>'
    		    , obj
    			, function(result) {
    		    	campaignOffer = {offerList:[]};
    		    	campaignOffer.offerList[0] = {};
        			campaignOffer.offerList[0].id = null;

    		    	relDetailStatus = 'I';
    		    	if ($.fn.ifvmIsNotEmpty(result)) {
    			    	saveResult = result.success;
    			    	campaignOffer.offerList[0].offerId = result.message;
    		    	}
    		    });
    		}
    	} */

    	if (saveResult == true) {

    		// 관계 저장
    		campaignOffer.campaignId = campaign.id;
    		campaignOffer.dataStatus = relDetailStatus;

    		diagram._selectedObject.data.campaignOffer = campaignOffer;
    		diagram._selectedObject.taskDataStatus = campaignOffer.dataStatus;

    		if (campaignOffer.offerList[0].id == 'null') {
    			campaignOffer.offerList[0].id = null;
    		}
    		campaignOffer.offerList[0].campaignId = campaign.id;
    		campaignOffer.offerList[0].dataStatus = relDetailStatus;

    		//call 캠페인 오퍼 저장
    	    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignOfferRel"/>', campaignOffer,
    	    function(result) {

    	    	//set actual task ID
    	    	diagram._selectedObject.actualTaskId = campaign.id;

    	    	//set campaign ID
    	    	diagram._selectedObject.campaignId = campaign.id;

    	    	//set old campaign ID
    	    	diagram._selectedObject.oldCampaignId = campaign.id;

    	    	//save workflow
    	        saveWorkflow();

    	    	//close popup
    	    	closeBenefitsPop();
    	    });
    	}
    }
    }
}

/**
 * 오퍼 불러오기 팝업에서 선택 버튼 클릭했을때
 */
function benefitsOfferListPopSelect() {
	var len = benefitsOfferListPopGrid.getCheckedGridData().length;

	if (len > 0) {

	   /* if (strType == 'LOY') { */

	        // 오퍼 정보 조회
	        $.ifvSyncPostJSON('<ifvm:action name="getLoyOfferDetail"/>', {
	            id : benefitsOfferListPopGrid.getCheckedGridData()[0].id
	        }, function(result) {
	            delete result.id;
	            result.offerNo = loyOfferData.offerNo;

	            setDetail(result);

	            loyOfferData = {};
	            loyOfferData = result;

	            // 재원분담, 관련캠페인, 포인트
	            if ($.fn.ifvmIsEmpty(result.expDividList)) loyOfferData.expDividList = [];
	            if ($.fn.ifvmIsEmpty(result.relCampaignList)) loyOfferData.relCampaignList = [];
				if ($.fn.ifvmIsEmpty(result.pntDtlList)) loyOfferData.pntDtlList = [];
	        });
	   // }
	    /*  else {
	        // 오퍼 정보 조회
	        $.ifvSyncPostJSON('<ifvm:action name="getDetailOffer"/>', {
	            id : benefitsOfferListPopGrid.getCheckedGridData()[0].id
	        }, function(result) {
	            delete result.id;
	            result.offerNo = offerData.offerNo;
	            offerData = result;
	            setDetail(result);

	            // 사용처, 할인/교환상품, 등급차감, 재원분담
	            if ($.fn.ifvmIsEmpty(result.useDeskList)) offerData.useDeskList = [];
	            if ($.fn.ifvmIsEmpty(result.productList)) offerData.productList = [];
	            if ($.fn.ifvmIsEmpty(result.gradeList)) offerData.gradeList = [];
	            if ($.fn.ifvmIsEmpty(result.expDividList)) offerData.expDividList = [];
	            if ($.fn.ifvmIsEmpty(result.childOfferList)) offerData.childOfferList = [];
	        });
	    } */

        benefitsOfferListPopClose();

      	//탭 초기화
        offerTab.reloadCurrentTab();
	}
}

/**
 * 오퍼 삭제
 */
function benefitsPopRemove() {

	if(confirm('오퍼를 삭제하시겠습니까?') == true){
		// 관계 저장
		campaignOffer.campaignId = campaign.id;
		campaignOffer.dataStatus = 'D';

		diagram._selectedObject.data.campaignOffer = campaignOffer;
		diagram._selectedObject.taskDataStatus = 'D';

		if (campaignOffer.offerList[0].id == 'null') {
			campaignOffer.offerList[0].id = null;
		}
		campaignOffer.offerList[0].campaignId = campaign.id;
		campaignOffer.offerList[0].dataStatus = 'D';

		//call 캠페인 오퍼 저장
	    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignOfferRel"/>', campaignOffer,
	    function(result) {

	    	//set actual task ID
	    	diagram._selectedObject.actualTaskId = campaign.id;

	    	//set campaign ID
	    	diagram._selectedObject.campaignId = campaign.id;

	    	//set old campaign ID
	    	diagram._selectedObject.oldCampaignId = campaign.id;

	    	//save workflow
	        saveWorkflow();

	    	//close popup
	    	closeBenefitsPop();
    });
	}else{
		return;
	}
}

$(document).ready(function() {

	//팝업 초기화
	initPopup();

	//등록된 오퍼 가져오기
	getBenefitsInfo();

	$('#btnoffersave').hide();


	//오퍼 선택 클릭시
	$('#searchOfferBtn').on('click', function() {
		searchOfferPopupOpen();
	});

	//저장 클릭시
	$('#benefitsSaveBtn').on('click', function() {
		benefitsPopSave();
	});

	//삭제 클릭시
	$('#benefitsRemoveBtn').on('click', function() {
		benefitsPopRemove();
		$('#offerSubTypeCd').change();
	});

	//취소 클릭시
	$('#benefitsCancelBtn').on('click', function() {
		closeBenefitsPop();
	});
});

</script>


<div id="dialogPopupWrap">
    <div class="pop_inner_wrap form-horizontal">
        <div class="row qt_border group_box_bg">

			<%-- 오퍼 선택 --%>
            <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M02710"/></label>
            <div class="col-xs-2">
                <button class="btn_Load" id="searchOfferBtn">
                    <img src="<ifvm:image name='ico_search'/>" alt="" />
                    <spring:message code="M00613"/>
                </button>
            </div>
        </div>
        <div class="row group_box_bg group_box_line popup_contents_height" id="benefitsDetailArea"></div>
    </div>
    <div class="pop_btn_area">

    	<%-- 저장버튼 --%>
        <button class="btn btn-sm btn_gray" id="benefitsSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button>

		<%-- 삭제버튼 --%>
	    <button class="btn btn-sm btn_lightGray2" id='benefitsRemoveBtn'>
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="L00029"/>
	    </button>

	    <%-- 취소버튼 --%>
        <button class="btn btn-sm btn_lightGray2 cancel" id="benefitsCancelBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>
<div id="benefitsOfferListPop" class="popup_container"></div>