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
<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/couponDetail.css"/>
<script src="${pageContext.request.contextPath}/resources/bootstrap/js/plugin/bootstrap-timepicker/bootstrap-timepicker.js"></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.iframe-transport.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.fileupload.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.fileupload-ui.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/fileupload/jquery.fileupload-fp.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/jquery.multiFilestyle.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/lib/MultiUploader.js'></script>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/lib/SimpleUploader.js'></script>
<script>

var offerTab ;  // 오퍼 상세 탭

var offerid = '<%= cleanXss(request.getParameter("id")) %>';
var detail = false;  //수정 페이지 체크 true일 시 수정, false일 시 신규 생성 페이지
var valcheck = false;
var validation;
var isValid;
var sysdate = new Date();
var formNewPop;

var obj = {};
var dataId = "";
var conCheck = true; //캠페인과 연결 유무 체크

var loyOfferData = {
     expDividList: [],  	// 재원분담
     relCampaignList: [],	// 관련캠페인
     pntDtlList: [],		// 포인트
     coupnDtl: {},
};

/**
 * 상세 페이지 체크
 */
function setOfferDetail() {
	
    if ($.fn.ifvmIsNotEmpty(offerid)) {

        // 오퍼 정보 조회
        $.ifvSyncPostJSON('<ifvm:action name="getLoyOfferDetail"/>', {
            id : offerid
        }, function(result) {
            setDetail(result);

            loyOfferData = result;

            // 재원분담
            if ($.fn.ifvmIsEmpty(result.expDividList)) {
                loyOfferData.expDividList = [];
            }

            //관련캠페인
            if ($.fn.ifvmIsEmpty(result.relCampaignList)) {
				loyOfferData.relCampaignList = [];
			}

			// 포인트
			if ($.fn.ifvmIsEmpty(result.pntDtlList)) {
				loyOfferData.pntDtlList = [];
			}

			$('#offerSubTypeCd').val(result.offerSubTypeCd);

        });
        detail = true;
    }
}

/**
 * 상세 내용을 화면에 등록
 */
function setDetail(result) {
    $("#offerDetailForm").dataSetting(result);

    //오퍼 상세유형 설정
    $('#offerTypeCd').change();

    $('#offerSubTypeCd').val(result.offerSubTypeCd);

    /* 접속 계정을 체크를 하나?  */
    if (result.conId != null) {
        conCheck = false;
        $.fn.ifvmAllDisabled("dataForm");
        $.fn.ifvmAllDisabled("headForm");
    }
}

/**
 * 화면에 입력된 데이터 가져오기
 */
function getOfferDataFromView() {
	var tgtData = $("#offerDetailForm").getSubmitData();
	tgtData.id = offerid;

	tgtData.type = 'LOY';

	$.extend(loyOfferData, tgtData);

    return loyOfferData;
}

/**
 * 오퍼 저장
 */
function editOffer() {
    var obj = getOfferDataFromView();

    // 오퍼 저장
    $.ifvSyncPostJSON('<ifvm:action name="saveLoyOffer"/>'
    , obj
    , function(result) {
        alert('<spring:message code="M00429"/>');

        // url에 의한 분기
        if ($.fn.ifvmGetUrl().match("loyOfferDetail")) {
            qtjs.href('<ifvm:url name="loyOfferListNew"/>');
        }
        else {
            obj.id = result.message;

            // 혜택 목록추가
            addNewBenefitsOffer(obj);

            // 팝업 닫기
            benefitsOfferListPopClose();
        }
    });
}

/**
 * 저장
 */
function saveOffer() {
    isValid = validation.confirm();
    if (conCheck) { // 권한체크인가?
        if (isValid == true) {
			editOffer();
        }
    }
}

/**
 * 탭 설정
 */
function initTab() {

    /* 탭 */
    offerTab = $('#offerTabDiv').DrawTab({
        item: [
            {label: '<spring:message code="M02282"/>', href: '/loyalty/offer/include/loyOfferExpDivid'},	//재원분담
            {label: '<spring:message code="L00239"/>', href: '/loyalty/offer/include/loyOfferPntDtl'},	//포인트
            {label: '<spring:message code="L00243"/>', href: '/loyalty/offer/include/loyOfferRelCampaign'},	//관계캠페인
        ]
    });
}

$(document).ready(function() {
	

    $.ifvmLnbSetting('loyOfferListNew');

    if (offerid == 'null') {
        offerid = null;
    }
    $("#initCouponnum").hide();

    $("#createDate").val(sysdate.getFullYear() + "-" + (sysdate.getMonth() + 1) + "-" + sysdate.getDate());

    // 탭 설정
    initTab();

});

/*로딩 시 세팅해주는 부분.
* 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
*/
$(function() {

    // 오퍼 타입 코드
    $.fn.ifvmSetSelectOptionCommCode("offerTypeCd", "OFFER_TYPE_CD", null, null, true);

    //포인트쿠폰 삭제
    $('#offerTypeCd').children("[value='PNT_COUPON']").remove();

    // 오퍼 타입 코드
    $.fn.ifvmSetSelectOptionCommCodeSync("offerSubTypeCd", "OFFER_SUB_TYPE_CD", null, "offerTypeCd", false);

  	//오퍼비용구분
	$.fn.ifvmSetSelectOptionCommCode("offerCostDivCd", "MKT_OFFER_COST_GBN", null, null, true);

  	//오퍼상태
	$.fn.ifvmSetSelectOptionCommCode("offerStatusCd", "COMM_STATUS", "1", null, true);

    // 상세 페이지
    setOfferDetail();

    validation = $("#dataForm").ifvValidation();

    setTimeout(function() {
    }, 500);
});

</script>

<script id="offerCommCodeTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="offerTypeDetailTemplate" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        {title}

        <div class="filter_area">
            <div class="left">
                {searchBox}
            </div>
        </div>

        <div class="grid_con">
            {grid}
        </div>
        <div class="page">
            <div class="total_area">{total}</div>
        <div>
    </div>
</script>

<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
.offer_description{height:100px;}

.bootstrap-timepicker-widget table td input {width: 30px;}
.time_slash {width: 20px; text-align: center; line-height: 30px; float: left;}
.time_picker {width: 100px; float: left;}
.offer_detail_add {display: none;}
.depth_detail {color: #3198c8;}
</style>

<div class="page-title">
    <h1>
        <spring:message code="M00308"/>&gt;  <spring:message code="M00274"/>
    </h1>
</div>
<div>
	<div class="page_btn_area" id="headForm">
	    <div class="col-xs-7">
	        <span><spring:message code="M02312"/></span>
	    </div>
	    <div class="col-xs-5 searchbtn_r">
	        <%-- 저장버튼 --%>
	        <ifvm:inputNew type="button" btnFunc="saveOffer" text="M00573" id="btnoffersave"/>
	    </div>
	</div>
	
	<div id="offerDetailForm">
		<ifvm:inputNew type="hidden" id="offerDivCd" dto="offerDivCd" values="T"/>
	
		<div class="well form-horizontal underline top_well" id="dataForm" >
		    <div class="row qt_border">
		        <div class="page_btn_area">
		            <div class="col-xs-2">
		                <%-- 필수영역 --%>
		                <span><spring:message code="M00327"/></span>
		            </div>
		        </div>
		    </div>
		    <div class="row  qt_border">
		        <%-- 오퍼번호 --%>
		        <ifvm:inputNew type="text" id="offerNo" dto="offerNo" label="M00313" labelClass="1" conClass="4" disabled="true"/>
		        <%-- 오퍼유형 --%>
		        <ifvm:inputNew type="select" id="offerTypeCd" dto="offerTypeCd" names="offerTypeCd" label="M00332" labelClass="2" conClass="4" required="true"/>
		    </div>
		    <div class="row  qt_border">
				<%-- 오퍼명 --%>
				<ifvm:inputNew type="text" id="offerNm" dto="offerNm" label="M00314" labelClass="1" conClass="4" required="true" maxLength="30" />
		        <%-- 오퍼유형상세 --%>
				<ifvm:inputNew type="select" id="offerSubTypeCd" dto="offerSubTypeCd" names="offerSubTypeCd" label="M01896" labelClass="2" conClass="4" />
		    </div>
		    <div class="row  qt_border">
		        <%-- 오퍼비용구분 --%>
		        <ifvm:inputNew type="select" id="offerCostDivCd" dto="offerCostDivCd" names="offerCostDivCd" label="M00331" labelClass="1" conClass="4" />
		        <%-- 상태 --%>
		        <ifvm:inputNew type="select" id="offerStatusCd" dto="offerStatusCd" names="offerStatusCd" label="M02510" labelClass="2" conClass="4" required="true"/>
		    </div>
		</div>
	</div>
</div>
<div id="offerTabDiv" style="margin-top: 20px"></div>

<div id="beaconCouponListPopup" class="popup_container"></div>
<div id="formNewPop" class="popup_container"></div>
