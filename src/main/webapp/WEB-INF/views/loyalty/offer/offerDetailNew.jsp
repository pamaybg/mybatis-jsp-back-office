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

            $('#aplyStartDd').val(result.aplyStartDd);
            $('#aplyEndDd').val(result.aplyEndDd);
            $('#selfTotAmt').change();
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
    $('#offerSubTypeCd').change();
    
    offerCheck();
    
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

	tgtData.type = 'MKT';
	tgtData.camId = diagram._selectedObject.campaignId;        
	
	tgtData.selfTotAmt = tgtData.selfTotAmt.replaceAll(',',''); 

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

/**
*	달력설정
*/
function setChannelCalendar() {
	var startDate = $('#aplyStartDd');
	var endDate = $('#aplyEndDd');
	//오늘날짜
	startDate.val($.ifvGetTodayDate());
	//오늘부터 한달 뒤
	endDate.val($.ifvGetNewDate('m', +1).newDateS);
	
	//설정
	startDate.ifvDateChecker({
	 maxDate : endDate
	});
	
	endDate.ifvDateChecker({
	 minDate : startDate
	});
}

/*로딩 시 세팅해주는 부분.
* 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
*/
$(document).ready(function() {
    $.ifvmLnbSetting('loyOfferListNew');

    if (offerid == 'null') {
        offerid = null;
    }
    $("#initCouponnum").hide();
    
	//달력 설정
	setChannelCalendar();
	$('#aplyStartDd').val('');
	$('#aplyEndDd').val('');
	
    //오퍼 유형
    $.fn.ifvmSetSelectOptionCommCode("offerTypeCd", "OFFER_TYPE_CD", null, null, true);
    
    // 오퍼 타입 코드
    //$.fn.ifvmSetSelectOptionCommCodeSync("offerSubTypeCd", "OFFER_SUB_TYPE_CD", null, "offerTypeCd", false);
    $.fn.ifvmSetSelectOptionCommCode("offerSubTypeCd", "OFFER_SUB_TYPE_CD", null, null, true);

  	//오퍼비용구분
	$.fn.ifvmSetSelectOptionCommCode("offerCostDivCd", "MKT_OFFER_COST_GBN", null, null, true);

  	//오퍼상태
	$.fn.ifvmSetSelectOptionCommCode("offerStatusCd", "COMM_STATUS", '1', null, true);
    
    $("#createDate").val(sysdate.getFullYear() + "-" + (sysdate.getMonth() + 1) + "-" + sysdate.getDate());

    // 탭 설정
    initTab();
    setThousandSeparator();
    
    //초기값 세팅
    disableCheck();
	offerCheck();
	offerTypeCheck();
	
    // 상세 페이지
    setOfferDetail();
    
    validation = $("#dataForm").ifvValidation();
    
    
    $("input:radio[name=offerAplyDdTypeCd]").click(function(){
    	disableCheck();
    	offerCheck();
    	checkRadio();
    });

    $('#offerSubTypeCd').change(function(){
    	disableCheck();
    	offerCheck();
    	offerTypeCheck();
    });
    
});


function disableCheck(){
	var radioCheck = $("input:radio[name=offerAplyDdTypeCd]:checked").val();
	if(radioCheck == 'TERM'){
		$('#offerAplyDay').attr('disabled',true);
		$('#aplyStartDd').attr('disabled',false);
		$('#aplyEndDd').attr('disabled',false);
	}else{
		$('#offerAplyDay').attr('disabled',false);
		$('#aplyStartDd').attr('disabled',true);
		$('#aplyEndDd').attr('disabled',true);
	}
}

function offerCheck(){
	var offerSubTypeCd = $("#offerSubTypeCd").val();
	var offerTypeCd = $("#offerTypeCd").val();
	
    if($.fn.ifvmIsEmpty(offerTypeCd)){
        offerTypeCd = 'POINT'
    }
	if($.fn.ifvmIsEmpty(offerSubTypeCd) && offerTypeCd == 'POINT'){
		$('#offerAplyDay').attr('disabled',true);
		$('#aplyStartDd').attr('disabled',true);
		$('#aplyEndDd').attr('disabled',true);
		$('#selfTotAmt').attr('disabled',true);
		$('#offerNotiOne').attr('disabled',true);
		$('#offerNotiTwo').attr('disabled',true);
		$('#offerNotiThree').attr('disabled',true);
		$('#offerNotiOne').attr('required',false);
		$('#selfTotAmt').attr('required',false);
	} else if (offerSubTypeCd == 'PNT') {
		$('#offerAplyDay').attr('disabled',true);
		$('#aplyStartDd').attr('disabled',true);
		$('#aplyEndDd').attr('disabled',true);
		$('#offerNotiOne').attr('required',true);
		$('#selfTotAmt').attr('required',true);
		$('#selfTotAmt').attr('disabled',false);
		$('#offerNotiOne').attr('disabled',true);
		$('#offerNotiTwo').attr('disabled',true);
		$('#offerNotiThree').attr('disabled',true);
	} else if (offerSubTypeCd == 'PNT_COUPON') {
		$('#offerNotiOne').attr('required',true);
		$('#selfTotAmt').attr('required',true);
		$('#selfTotAmt').attr('disabled',false);
		$('#offerNotiOne').attr('disabled',false);
		$('#offerNotiTwo').attr('disabled',false);
		$('#offerNotiThree').attr('disabled',false);
	}
}

function checkRadio(){
	var radioCheck = $("input:radio[name=offerAplyDdTypeCd]:checked").val();
	
	if(radioCheck == 'TERM'){
		$('#offerAplyDay').val('');
		setChannelCalendar();
	}else{
		$('#aplyStartDd').val('');
		$('#aplyEndDd').val('');
	}
}


function offerTypeCheck(){
	var offerSubTypeCd = $("#offerSubTypeCd").val();
	var offerTypeCd = $("#offerTypeCd").val();
	
	if($.fn.ifvmIsEmpty(offerTypeCd)){
        offerTypeCd = 'POINT'
    }
	
	if($.fn.ifvmIsEmpty(offerSubTypeCd) && offerTypeCd == 'POINT'){
		$('#offerAplyDay').val('');
		$('#aplyStartDd').val('');
		$('#aplyEndDd').val('');
		$('#selfTotAmt').val('');
		$('#offerNotiOne').val('');
		$('#offerNotiTwo').val('');
		$('#offerNotiThree').val('');
	}else if(offerSubTypeCd == 'PNT_COUPON'){
		setChannelCalendar();
	}
}

function getNumber(obj){
    var num01;
    var num02;
    num01 = obj.value;
    num02 = num01.replace(/\D/g,""); //숫자가 아닌것을 제거, 
                                     //즉 [0-9]를 제외한 문자 제거; /[^0-9]/g 와 같은 표현
    num01 = setComma(num02); //콤마 찍기
    obj.value =  num01;
}

function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환         
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }         
    return n;
}

//천단위 구분자 설정
function setThousandSeparator() {
   //천단위 구분자 넣을 요소 아이디 배열
   var targets = ['selfTotAmt'];
   
   $.each(targets, function(i,e) {
      $('#'+e).on('change', function() {
         getNumber(this);
      });
      $('#'+e).on('keyup', function() {
         getNumber(this);
      });
   });
}

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
	        <ifvm:inputNew type="select" id="offerTypeCd" dto="offerTypeCd" names="offerTypeCd" label="M00332" labelClass="2" conClass="4" required="true" />
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
	     	<%-- 상태 --%>
	        <%-- <ifvm:inputNew type="select" id="offerStatusCd" dto="offerStatusCd" names="offerStatusCd" label="M02510" labelClass="2" conClass="4" required="true"/> --%>
	    </div>
	    <!-- 
	    <div class="row qt_border">
	    	<%-- 유효일자  --%>
	    	<label class="control-label col-xs-1">
	    		유효일자&nbsp;
	    		<ifvm:input type="radio" names="offerAplyDdTypeCd" id="offerAplyDdTypeCd" dto="offerAplyDdTypeCd" values="TERM" checked = "checked"/>
	    	</label>
	    	<%-- 유효일자 --%>
            <ifvm:inputNew type="date" id="aplyStartDd" dto="aplyStartDd" labelClass="0" conClass="2" disabled="false"/>
			<ifvm:inputNew type="date" id="aplyEndDd" dto="aplyEndDd" labelClass="0" conClass="2" disabled="false"/>            
	    	<%-- 쿠폰유의사항 1  --%>
	    	<ifvm:inputNew type="text" id="offerNotiOne" dto="offerNotiOne" label="M02898" labelClass="2" conClass="4" required="true" maxLength="30"/>
	    </div>
	    <!-- 
	    <div class="row qt_border">
	    	<label class="control-label col-xs-1">
	    		실행일기준&nbsp;
	    		<ifvm:input type="radio" names="offerAplyDdTypeCd" id="offerAplyDdTypeCd" dto="offerAplyDdTypeCd" values="DAY" />
	    	</label>
	    	<%-- 실행일 기준  --%>
	    	<ifvm:inputNew type="number" id="offerAplyDay" dto="offerAplyDay" labelClass="0" conClass="4" maxLength="2" disabled="true" className="text-right" />
	    	<%-- 쿠폰유의사항 2  --%>
	    	<ifvm:inputNew type="text" id="offerNotiTwo" dto="offerNotiTwo" label="M02899" labelClass="2" conClass="4" maxLength="30" />
	    </div>
	    <div class="row qt_border">
	    	<%-- 혜택 포인트  --%>
	    	<ifvm:inputNew type="text" id="selfTotAmt" dto="selfTotAmt" label="M02901" labelClass="1" conClass="4" required="true" maxLength="50" values = "0" className="text-right"/>
	    	<%-- 쿠폰유의사항 3  --%>
	    	<ifvm:inputNew type="text" id="offerNotiThree" dto="offerNotiThree" label="M02900" labelClass="2" conClass="4" maxLength="30" />
	    	
	    	<ifvm:inputNew type="hidden" id="ridCoupon" dto="ridCoupon"/>
	    </div>
	    -->
	    <div class="row qt_border">
	    	<%-- 혜택 포인트  --%>
	    	<ifvm:inputNew type="text" id="selfTotAmt" dto="selfTotAmt" label="M02901" labelClass="1" conClass="4" required="true" maxLength="50" values = "0" className="text-right"/>
	    </div>
	</div>
</div>

<div id="offerTabDiv" style="margin-top: 20px"></div>

<div id="beaconCouponListPopup" class="popup_container"></div>
<div id="formNewPop" class="popup_container"></div>
