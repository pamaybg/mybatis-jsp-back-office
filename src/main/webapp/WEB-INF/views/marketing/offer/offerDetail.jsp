<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>
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

var offerData = {
     useDeskList: [],   // 사용처 목록
     gradeList: [],     // 등급차감
     productList: [],   // 할인,교환 대상상품
     expDividList: [],  // 재원분담
     childOfferList: [],  // 하위오퍼
     coupnDtl: {},
};

var refKeyPopup;
var coupnTmpDtlPop;

/**
 * 상세 페이지 체크
 */
function setOfferDetail() {
    $("#discountAmount").val(0);
    if (offerid != "null") {

        // 오퍼 정보 조회
        $.ifvSyncPostJSON('<ifvm:action name="getDetailOffer"/>', {
            id : offerid
        }, function(result) {
            setDetail(result);

            offerData = result;

            // 사용처
            if ($.fn.ifvmIsEmpty(result.useDeskList)) {
                offerData.useDeskList = [];
            }

            // 할인/교환상품
            if ($.fn.ifvmIsEmpty(result.productList)) {
                offerData.productList = [];
            }

            // 등급차감
            if ($.fn.ifvmIsEmpty(result.gradeList)) {
                offerData.gradeList = [];
            }

            // 재원분담
            if ($.fn.ifvmIsEmpty(result.expDividList)) {
                offerData.expDividList = [];
            }

            // 하위오퍼
            if ($.fn.ifvmIsEmpty(result.childOfferList)) {
                offerData.childOfferList = [];
            }
        });
        detail = true;
    }
}

/**
 * 상세 내용을 화면에 등록
 */
function setDetail(result) {

    $("#offerNo").val(result.offerNo);           	// 오퍼번호
    $("#offerName").val(result.offerName);       	// 오퍼명
    $("#offerTypeCd").val(result.offerTypeCd);   	// 오퍼유형
    $("#offerTypeCd").change();
    $("#offerSubTypeCd").val(result.offerSubTypeCd);// 오퍼상세유형
    $("#discountType").val(result.discountType); 	// 할인유형
    $("#discountAmount").val(result.discountAmt);	// 할인금액(율)
    $("#description").val(result.description);   	// 설명
    $("#createDate").val(result.createDate);     	// 등록일자

    $("#offerEcnrsDivCd").val(result.offerEcnrsDivCd);    // 오퍼재원 구분 코드
    $("#refKey").val(result.refKey);                      // 참조키
    $("#refKeyNm").val(result.refKeyNm);                  // 참조키
    $("#coupnApvTypeCd").val(result.coupnApvTypeCd);      // 쿠폰승인유형코드
    $("#coupnIssTypeCd").val(result.coupnIssTypeCd);      // 쿠폰발급유형코드
    $("#offerUseDeskDivCd").val(result.offerUseDeskDivCd);// 오퍼 사용처 구분코드
    $("#dcProdTypeCd").val(result.dcProdTypeCd);          // 할인상품유형코드

    $("#selfTotAmt").val(result.selfTotAmt);	// 총해택금액

    if ($.fn.ifvmIsNotEmpty(result.coupnDtl)) {
    	$("#ridCoupn").val(result.coupnDtl.rid);
    	$("#coupnNm").val(result.coupnDtl.coupnNm);
    }

    $("#settlUsePosblYn").prop("checked", (result.settlUsePosblYn == "1")); // 결제시사용가능여부
    $("#coupnTrnsfrYn").prop("checked", (result.coupnTrnsfrYn == "1"));	    // 쿠폰양도가능여부
    $("#lowstSettlAmt").val(result.lowstSettlAmt);        // 최저결제금액

    $("#selfTotAmt").val(result.selfTotAmt);        // 총해택금액

    $("#pntValidPeroidType").val(result.pntValidPeroidType);        // 포인트 유효 기간 타입
    $("#pntValidPeroidVal").val(result.pntValidPeroidVal);          // 포인트 유효 기간 값


    $("#pntTrnsfrYn").prop("checked", (result.pntTrnsfrYn == "1")); // 포인트 양도 가능 여부

    $("#offerSeqNo").val(result.offerSeqNo);					//차감 순서

    if($("#pntValidPeroidType").val()=='NO_EXTNC') {
    	$("#pntValidPeroidVal").attr("disabled",true);
    }

    /* 접속 계정을 체크를 하나?  */
    if (result.conId != null) {
        conCheck = false;
        $.fn.ifvmAllDisabled("dataForm");
        $.fn.ifvmAllDisabled("selectForm");
        $.fn.ifvmAllDisabled("coupnForm");
        $.fn.ifvmAllDisabled("headForm");
    }
}

/**
 * 화면에 입력된 데이터 가져오기
 */
function getOfferDataFromView() {

    offerData.id = offerid;
    offerData.type = 'MKT';
    offerData.offerNo = $("#offerNo").val();                // 오퍼번호
    offerData.offerName = $("#offerName").val();            // 오퍼명
    offerData.offerTypeCd = $("#offerTypeCd").val();        // 오퍼유형
    offerData.offerSubTypeCd = $("#offerSubTypeCd").val();  // 오퍼유형상세
    offerData.offerSubTypeNm = $("#offerSubTypeCd option:selected").text();  // 오퍼유형상세명
    offerData.discountType = $("#discountType").val();      // 할인유형
    offerData.discountAmt   = $("#discountAmount").val();   // 할인금액(율)
    offerData.description = $("#description").val();        // 설명
    offerData.commStatus = $("#commStatus").val();          // 상태 (기본 = 활성)

    offerData.offerEcnrsDivCd = $("#offerEcnrsDivCd").val();     // 오퍼재원 구분 코드
    offerData.offerEcnrsDivNm = $("#offerEcnrsDivCd option:selected").text();  // 오퍼재원 구분명
    offerData.refKey = $("#refKey").val();                       // 참조키
    offerData.coupnApvTypeCd = $("#coupnApvTypeCd").val();       // 쿠폰승인유형코드
    offerData.coupnIssTypeCd = $("#coupnIssTypeCd").val();       // 쿠폰발급유형코드
    offerData.offerUseDeskDivCd = $("#offerUseDeskDivCd").val(); // 오퍼 사용처 구분코드
    offerData.offerUseDeskDivNm = $("#offerUseDeskDivCd option:selected").text();  // 오퍼 사용처 구분명
    offerData.dcProdTypeCd = $("#dcProdTypeCd").val();           // 할인상품유형코드
    offerData.settlUsePosblYn = $("#settlUsePosblYn").is(":checked") == true ? "1" : "0"; // 결제시사용가능여부
    offerData.coupnTrnsfrYn = $("#coupnTrnsfrYn").is(":checked") == true ? "1" : "0"; 	  // 쿠폰양도가능여부
    offerData.lowstSettlAmt = $("#lowstSettlAmt").val();         // 최저결제금액

    offerData.offerDivCd = $("#offerDivCd").val();           //오퍼등록유형코드(C:캠페인,T:오퍼관리)

    offerData.selfTotAmt = $("#selfTotAmt").val();	// 총해택금액

    offerData.pntValidPeroidType = $("#pntValidPeroidType").val();	// 포인트 유효기간 타입
    offerData.pntValidPeroidVal = $("#pntValidPeroidVal").val();	// 포인트 유효기간 값
    offerData.pntTrnsfrYn = $("#pntTrnsfrYn").val();				// 포인트 양도 여부

    offerData.pntTrnsfrYn = $("#pntTrnsfrYn").is(":checked") == true ? "1" : "0";

    offerData.offerSeqNo = $("#offerSeqNo").val();  //차감 순서

    return offerData;
}

/**
 * 오퍼 수정
 */
function editOffer() {
    var obj = getOfferDataFromView();



    // 오퍼 수정
    $.ifvSyncPostJSON('<ifvm:action name="editOffer"/>', obj,
    function(result) {
        alert('<spring:message code="M00429"/>');

        // url에 의한 분기
        if ($.fn.ifvmGetUrl().match("offerDetail")) {
            qtjs.href('<ifvm:url name="MKTOfferListNew"/>');
        }
        else {
        	obj.offerTypeCd = $("#offerTypeCd option:selected").text();	//오퍼유형
        	offerData.discountType = $("#discountType option:selected").text(); // 할인유형

            // 혜택 목록추가
            editBenefitsOffer(obj);
            // 팝업 닫기
            benefitsOfferListPopClose();
        }
    });
}

/**
 * 오퍼 등록
 */
function addOffer() {

    var obj = getOfferDataFromView();

    // 오퍼 등록
     $.ifvSyncPostJSON('<ifvm:action name="setOffer"/>', obj,
        function(result) {
        alert('<spring:message code="M00430"/>');
        // url에 의한 분기
        if ($.fn.ifvmGetUrl().match("offerDetail")) {
            qtjs.href('<ifvm:url name="MKTOfferListNew"/>');
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
            // 수정
            if (detail == true) {
                editOffer();
            }
            // 등록
            else {
                addOffer();
            }
        }
    }
}

/**
 * 참조값 팝업 호출
 */
function refKeyPopupOpen() {

    $("#refKeyPopupDiv").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="productListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00300'/>",
        width: '600',
        close : 'productListPopupClose'
    });
}

function productListPopupClose() {
	refKeyPopupDiv._destroy();
}

/**
 * 제품 선택시
 */
function productListPopupSelect() {

    if ($.fn.ifvmIsNotEmpty(productListPopGrid.getCheckedList())) {
        var selData = productListPopGrid.getCheckedList()[0];
        $("#refKey").val(selData.rid);
        $("#refKeyNm").val(selData.prodNm);

        //close popup
        productListPopupClose();
    }
    else {
        alert("<spring:message code='L00301'/>");
        return false;
    }
}


/**
 * 탭 설정
 */
function initTab() {

    /* 탭 */
    offerTab = $('#offerTabDiv').DrawTab({
        item: [
            {label: '<spring:message code="M02275"/>', href: '/marketing/offer/include/useDeskTab'},
            {label: '<spring:message code="M02280"/>', href: '/marketing/offer/include/productTab'},
            /* {label: '<spring:message code="M02281"/>', href: '/marketing/offer/include/gradeTab'}, */
            {label: '<spring:message code="M02282"/>', href: '/marketing/offer/include/expDividTab'},
            {label: '<spring:message code="E00003"/>', href: '/marketing/offer/include/childOfferTab'},
        ]
    });
}

/**
 * 쿠폰 템플릿 팝업 호출
 */
function coupnTmpPopupOpen() {

    $("#coupnTmpDtlPop").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="coupnTmpDtlPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00300'/>",
        width: '800',
        close : 'coupnTmpPopupClose'
    });
}
function coupnTmpPopupClose() {
    coupnTmpDtlPop._destroy();
}

$(document).ready(function() {

    $.ifvmLnbSetting('offerListNew');
    $("#initCouponnum").hide();

    $("#createDate").val(sysdate.getFullYear() + "-" + (sysdate.getMonth() + 1) + "-" + sysdate.getDate());

    // 저장버튼 클릭 > 저장
    $("#btnoffersave").click(function() {
        saveOffer();
    });

    // 저장버튼 클릭 > 저장
    $("#refKeyPopupBtn").click(function() {
        refKeyPopupOpen();
    });

    // 쿠폰 템플릿 상세 버튼
    $("#coupnTmpPopupBtn").click(function() {
        coupnTmpPopupOpen();
    });

    // 탭 설정
    initTab();

	$("#discountAmount").keyup(function (event) {
   		if($("#discountAmount").val() > 2147483647) {
   			$("#discountAmount").val("2147483647");
   		}
	});

	//오퍼 유형 변경시
	$('#offerTypeCd').on('change', function() {
		//할인이 아닌 경우 데이터 초기화
		if ($('#offerTypeCd').val() != 'DC') {
			$("#selectForm select").val('');
			$("#selectForm input").val('');
			$("#selectForm input[type=checkbox]").removeAttr('checked');
		}
		setSelectForm();
	})

	//유효기간 변경시

	$('#pntValidPeroidType').on('change', function() {
		//할인이 아닌 경우 데이터 초기화
		if ($('#pntValidPeroidType').val() == 'NO_EXTNC') {
			$("#pntValidPeroidVal").attr("disabled",true);
			$("#pntValidPeroidVal").val("");

		}else{
			$("#pntValidPeroidVal").attr("disabled",false);
		}
		setSelectForm();
	})


	$("#discountAmount").onlyNumber();
	$("#lowstSettlAmt").onlyNumber();
	$("#selfTotAmt").onlyNumber();
	$("#pntValidPeroidVal").onlyNumber();
	$("#offerSeqNo").onlyNumber();

});

/**
 * 할인오퍼 상세 영역 할인인 경우에만 활성화
 */
function setSelectForm() {
	//할인일 경우 모두 활성화
	if ($('#offerTypeCd').val() == 'DC') {
		$("#selectForm select").removeAttr('disabled');
		$("#selectForm input").removeAttr('disabled');
		$("#selectForm textarea").removeAttr('disabled');
		$("#selectForm button").show();
	}
	//할인오퍼상세 화면 비활성화
	else {
        $.fn.ifvmAllDisabled("selectForm");
	}

	//셀프오퍼일 경우에만 활성화
	if ($('#offerTypeCd').val() == 'SELF_OFFER') {
		$("#selfDesignForm select").removeAttr('disabled');
		$("#selfDesignForm input").removeAttr('disabled');
	}
	//셀프오퍼일 화면 비활성화
	else {
        $.fn.ifvmAllDisabled("selfDesignForm");
        $('#selfTotAmt').val('');
	}
}

/*로딩 시 세팅해주는 부분.
* 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
*/
$(function() {

    // 오퍼 타입 코드
    $.fn.ifvmSetSelectOptionCommCode("offerTypeCd", "OFFER_TYPE_CD", null, null, true);

    // 오퍼 타입 코드
    $.fn.ifvmSetSelectOptionCommCodeSync("offerSubTypeCd", "OFFER_SUB_TYPE_CD", null, "offerTypeCd", false);

    // 할인 유형 코드
    $.fn.ifvmSetSelectOptionCommCode("discountType", "OFFER_DISCOUNT_TYPE_CD", null, null, false);

    // 재원
    $.fn.ifvmSetSelectOptionCommCode("offerEcnrsDivCd", "OFFER_ECNRS_DIV_CD", null, null, true);

    // 사용처
    $.fn.ifvmSetSelectOptionCommCode("offerUseDeskDivCd", "OFFER_USE_DESK_DIV_CD", null, null, true);

    // 할인상품
    $.fn.ifvmSetSelectOptionCommCode("dcProdTypeCd", "DC_PROD_TYPE_CD", null, null, false);

    // 승인
    $.fn.ifvmSetSelectOptionCommCode("coupnApvTypeCd", "COUPN_APV_TYPE_CD", null, null, true);

    // 발급
    $.fn.ifvmSetSelectOptionCommCode("coupnIssTypeCd", "COUPN_ISS_TYPE_CD", null, null, true);


    // 유효기간
    $.fn.ifvmSetSelectOptionCommCode("pntValidPeroidType", "VALID_PERIOD_TYPE", null, null, true);

    // 상세 페이지
    setOfferDetail();

	//할인오퍼상세 영역 초기화
	setSelectForm();

    validation = $("#dataForm").ifvValidation();

    setTimeout(function() {
    	gridIduseDeskGrid.resize();
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
        <spring:message code="M00308"/> &gt;  <spring:message code="M00274"/>
    </h1>
</div>

<div class="page_btn_area" id="headForm">
	<ifvm:input type="hidden" id="offerDivCd" values="T"/>

    <div class="col-xs-7">
        <span><spring:message code="M02312"/></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <%-- 저장버튼 --%>
        <button class="btn btn-sm" id="btnoffersave">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00573"/>
        </button>
    </div>
</div>

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

        <%-- 상태 --%>
        <ifvm:input type="hidden" id="commStatus" values="1"/>

        <%-- 오퍼번호 --%>
        <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00313"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" disabled="true" id="offerNo"/>
        </div>

        <%-- 오퍼유형 --%>
        <label class="col-xs-2 control-label"><spring:message code="M00332"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="offerTypeCd" names="offerTypeCd"/>
        </div>
    </div>

    <div class="row  qt_border">

		<%-- 오퍼명 --%>
        <label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="M00314"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" required="true" id="offerName" maxLength="30"/>
        </div>
        <%-- 오퍼유형상세 --%>
        <label class="col-xs-2 control-label"><spring:message code="M01896"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="offerSubTypeCd" names="offerSubTypeCd"/>
        </div>
    </div>


    <div class="row qt_border">
        <%-- 설명 --%>
        <label class="col-xs-1 control-label"><spring:message code="M00324"/></label>
        <div class="col-xs-10 control_content">
            <ifvm:input type="textarea" className="offer_description" id="description" maxLength="200"/>
        </div>
    </div>
    <div class="row qt_border">

        <%-- 참조값 --%>
        <label class="col-xs-1 control-label"><spring:message code="M02274"/></label>
        <div class="col-xs-4 control_content">
            <div class="input-group">
                <ifvm:input type="text" readonly="true" id="refKeyNm" />
                <ifvm:input type="hidden" id="refKey" names="refKey" />
                <span class="input-group-addon" id="refKeyPopupBtn">
                    <a><i class="fa fa-search"></i></a>
                </span>
            </div>
        </div>

        <%-- 등록일자 --%>
        <label class="col-xs-2 control-label"><spring:message code="M00222"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" disabled="true" id="createDate"/>
        </div>
    </div>
    <div class="row qt_border">

        <%-- 재원 --%>
        <label class="col-xs-1 control-label"><spring:message code="M02276"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="offerEcnrsDivCd" names="offerEcnrsDivCd"/>
        </div>

        <%-- 사용처 --%>
        <label class="col-xs-2 control-label"><spring:message code="M02275"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="offerUseDeskDivCd" names="offerUseDeskDivCd"/>
        </div>
    </div>


    <div class="row qt_border">


 	<%-- 유효기간 --%>
	   	<label class="col-xs-1 control-label">포인트 유효 기간</label>
	    <div class="col-xs-2 control_content">
	    	<ifvm:input type="select" id="pntValidPeroidType" names="pntValidPeroidType"/>
	    </div>

	   <div class="col-xs-2 control_content">
	    	<ifvm:input type="text" id="pntValidPeroidVal" names="pntValidPeroidVal"/>
	    </div>


        <%-- 포인트 양도 가능여부 --%>
	    <label class="col-xs-2 control-label"> 포인트 양도 가능여부 </label>
	    <div class="col-xs-2 control_content">
	        <label class="checkbox-inline">
	            <ifvm:input type="checkbox" id="pntTrnsfrYn"/>
	        </label>
	    </div>

    </div>
    <div class="row qt_border">
    	<label class="col-xs-1 control-label">차감 순서</label>
    	 <div class="col-xs-4 control_content">
			<ifvm:input type="text"  className="text-right" id="offerSeqNo" names="offerSeqNo"/>
		</div>
    </div>


</div>

<div class="well form-horizontal underline" id="selectForm" >

    <div class="row qt_border">
        <div class="page_btn_area">
            <div class="col-xs-2">
                <%-- 필수영역 --%>
                <span><spring:message code="M02273"/></span>
            </div>
        </div>
    </div>
    <div class="row qt_border">

        <%-- 할인 유형 --%>
        <label class="col-xs-1 control-label"><spring:message code="M02271"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="discountType" names="discountType"/>
        </div>

        <%-- 할인 금액(율) --%>
        <label class="col-xs-2 control-label"><spring:message code="M02272"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="number" id="discountAmount" maxLength="15"/>
        </div>
    </div>
    <div class="row qt_border">

        <%-- 할인 상품 --%>
        <label class="col-xs-1 control-label"><spring:message code="M02270"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="dcProdTypeCd" names="dcProdTypeCd"/>
        </div>
        <%-- 최저 충전 금액 --%>
        <label class="col-xs-2 control-label"><spring:message code="M02278"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="lowstSettlAmt" maxLength="32"/>
        </div>

    </div>
    <div class="row qt_border">

        <label class="col-xs-1 control-label"></label>
        <div class="col-xs-4 control_content"></div>

        <%-- 충전 결제시 사용가능 --%>
        <label class="col-xs-2 control-label"><spring:message code="M02718"/></label>
        <div class="col-xs-4 control_content">
            <label class="checkbox-inline">
                <ifvm:input type="checkbox" id="settlUsePosblYn"/>
            </label>
        </div>


    </div>
</div>

<div class="well form-horizontal underline" id="coupnForm" >

    <%-- 쿠폰 상세 --%>
    <div class="row qt_border">
        <div class="page_btn_area">
            <div class="col-xs-2">
                <span><spring:message code="M02279"/></span>
            </div>
        </div>
    </div>
    <div class="row qt_border">

        <%-- 승인 --%>
        <label class="col-xs-1 control-label"><spring:message code="M00748"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="coupnApvTypeCd" names="coupnApvTypeCd"/>
        </div>

        <%-- 발급 --%>
        <label class="col-xs-2 control-label"><spring:message code="M01927"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="coupnIssTypeCd" names="coupnIssTypeCd"/>
        </div>
    </div>
    <div class="row qt_border">
        <label class="col-xs-1 control-label"><spring:message code="M02378"/></label>
        <div class="col-xs-4 control_content">
            <div class="input-group">
                <ifvm:input type="text" readonly="true" id="coupnNm" />
                <ifvm:input type="hidden" id="ridCoupn" />
                <span class="input-group-addon" id="coupnTmpPopupBtn">
                    <a><i class="fa fa-search"></i></a>
                </span>
            </div>
        </div>

        <%-- 양도 가능 --%>
        <label class="col-xs-2 control-label">양도가능</label>
        <div class="col-xs-4 control_content">
            <label class="checkbox-inline">
                <ifvm:input type="checkbox" id="coupnTrnsfrYn"/>
            </label>
        </div>
    </div>
</div>

<div class="well form-horizontal underline" id="selfDesignForm" >

    <%-- 셀프 디자인 상세 --%>
    <div class="row qt_border">
        <div class="page_btn_area">
            <div class="col-xs-2">
                <span><spring:message code="E00001"/></span>
            </div>
        </div>
    </div>

    <div class="row qt_border">

        <%-- 총 혜택 금액 --%>
        <label class="col-xs-1 control-label"><spring:message code="E00002"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="selfTotAmt" maxLength="11" required="false" valiItem="number" />
        </div>
    </div>

</div>

<div id="offerTabDiv" style="margin-top: 20px"></div>
<div id="refKeyPopupDiv" class="popup_container"></div>

<div id="beaconCouponListPopup" class="popup_container"></div>
<div id="coupnTmpDtlPop" class="popup_container"></div>
<div id="formNewPop" class="popup_container"></div>
