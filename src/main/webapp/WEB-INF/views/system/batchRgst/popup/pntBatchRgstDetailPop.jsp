<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<% request.setCharacterEncoding("EUC-KR");%>
<div id ="uploadForm">
	<div class="form-horizontal underline top_well"  >
		<div class="row qt_border">
		
		<div class="row">
		<div class="col-xs-14">
				<ifvm:inputNew type="select" id="uploadTypeCd" dto="uploadTypeCd" names ="uploadTypeCd" label="L01669" labelClass="2" conClass="2" required="true" disabled="true"/>
				<ifvm:inputNew type="select" id="custTypeCd" dto="custTypeCd" names ="custTypeCd" label="고객유형" labelClass="2" conClass="2" required="true"/>
			</div>
		</div>
		<div class="row">
			<ifvm:inputNew type="select" id="pntTxnType" dto="pntTxnType" names ="pntTxnType" label="거래유형" labelClass="2" conClass="2" required="true" />
				<%-- <ifvm:inputNew type="text" disabled="true" id="pntTxnDtlType" dto="pntTxnDtlType" names ="pntTxnDtlType" label="거래상세유형" labelClass="2" required="true" conClass="2"  />
				<span class="input-group-addon" style="padding: 6px;" id="btnTxnDetailPop"> <a><i class="fa fa-search"></i></a>
				</span> --%>
		<ifvm:inputNew type="search" id="pntTxnDtlType|pntTxnDtlTypeBtn" dto="pntTxnDtlType" names="pntTxnDtlType" label="거래상세 유형" labelClass="2" conClass="2" required="true"/>
				
		</div>
			<div class="row" id="ofrRow">
				<!-- 프로모션 캠페인 -->
				<ifvm:inputNew type="text" id="ofrNm" dto="ofrNm" disabled="true" required="true" label="오퍼" nuc="true" labelClass="2" conClass="3"/>
				<!-- 프로모션 검색 -->
				<ifvm:inputNew type="button" btnType="search" objCode="pntBatchRgstDetailOfrSearch_OBJ" text="오퍼 검색" nuc="true" id="searchCampaignBtn" btnFunc="fnSearchCampaign" labelClass="2" conClass="5"/>
			</div>
			
			<div class="row">
				<!-- 채널 -->
				<ifvm:inputNew type="text" id="chnlNm" dto="chnlNm" disabled="true" required="true"  label="채널" nuc="true" labelClass="2" conClass="3"/>
				<ifvm:inputNew type="button" btnType="search" text="채널 검색" nuc="true" objCode="pntBatchRgstDetailChnlSearch_OBJ" id="searchCampaignBtn" btnFunc="chnlPopup" labelClass="2" conClass="5" />
			</div>
<!-- 			<div class="row"> -->
				<!-- 프로모션 캠페인 -->
<%-- 				<ifvm:inputNew type="text" id="pgmNm" dto="pgmNm" disabled="true" required="true"  label="프로그램" nuc="true" labelClass="2" conClass="3"/> --%>
				<!-- 프로모션 검색 -->
<%-- 				<ifvm:inputNew type="button" btnType="search" text="프로그램 검색" nuc="true" id="searchCampaignBtn" btnFunc="pgmPopup" labelClass="2" conClass="5"/> --%>
<!-- 			</div> -->
			<%-- 
			<div class="row">
					<ifvm:inputNew type="text" id="chnlNm" dto="chnlNm" disabled="true" label="채널" nuc="true" labelClass="2" conClass="3"/>
									<ifvm:inputNew type="button" btnType="search" text="채널 검색" nuc="true" id="searchCampaignBtn" btnFunc="chnlPopup" labelClass="2" conClass="5"/>
					
			</div> --%>
			
			
<!-- 			<div class="col-xs-12"> -->
<%-- 				<ifvm:inputNew type="date" id="pntApplyDt" dto="pntApplyDt" label="L02379" labelClass="2" conClass="3" required="true" /> --%>
<!-- 			</div> -->

			<div class="col-xs-12">
				<ifvm:inputNew type="text" id="fileName" dto="fileName " label="L01700" labelClass="2" conClass="8" disabled="true"  required="true"/>
				<ifvm:inputNew type="button" text="L01671" objCode="pntBatchRgstDetailFileSearch_OBJ"  id="fileSearchBtn" btnFunc="fileSearchFn"/>
			</div>

		</div>
	
	<!-- 캠페인정보 -->
	<%-- <div class="row">
	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="M01355" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        	<ifvm:inputNew type="button" text="L02381"  id="camSearchBtn" btnFunc="camSearchFn"/>
	        </div>
	    </div>
	    
	    <div class="col-xs-12">
			<ifvm:inputNew type="text" id="camNo" dto="camNo " label="L01670" labelClass="2" conClass="3" disabled="true"  required="true"/>
			<ifvm:inputNew type="text" id="camNm" dto="camNm " conClass="7" disabled="true"  required="true"/>
			<ifvm:inputNew type="hidden" id="ridCam" dto="ridCam " required="true"/>
		</div>
	    <div class="col-xs-12">
			<ifvm:inputNew type="text" id="offerNo" dto="offerNo" label="L01670" labelClass="2" conClass="3" disabled="true"  required="true"/>
			<ifvm:inputNew type="text" id="offerNm" dto="offerNm" conClass="7" disabled="true"  required="true"/>
			<ifvm:inputNew type="hidden" id="ridOffer" dto="ridOffer" required="true"/>
		</div>
	    <div class="col-xs-12">
			<ifvm:inputNew type="text" id="offerTypeCd" dto="offerTypeCd" label="L01670" labelClass="2" conClass="3" disabled="true"  required="true"/>
			<ifvm:inputNew type="text" id="accntCd" dto="accntCd" label="L01670" labelClass="3" conClass="4" disabled="true"  required="true"/>
		</div>
	</div>
	
	<!-- 포인트지급계정유형 -->
	<div class="row">
	    <div class="page_btn_area" >
	        <div class="col-xs-7">
	            <span><spring:message code="L02380" /></span>
	        </div>
	        <div class="col-xs-5 searchbtn_r">
	        </div>
	    </div>
	    
		<div class="col-xs-12">
			<ifvm:inputNew type="text" id="offerTypeCd" dto="offerTypeCd" label="L01670" labelClass="2" conClass="3" disabled="true"  required="true"/>
			<ifvm:inputNew type="text" id="accntCd" dto="accntCd" label="L01670" labelClass="3" conClass="4" disabled="true"  required="true"/>
		</div>
		<div class="col-xs-12">
			<ifvm:inputNew type="text" id="offerTypeCd" dto="offerTypeCd" label="L01670" labelClass="2" conClass="3" disabled="true"  required="true"/>
			<ifvm:inputNew type="text" id="accntCd" dto="accntCd" label="L01670" labelClass="3" conClass="4" disabled="true"  required="true"/>
		</div>
	    <div class="col-xs-12">
			<ifvm:inputNew type="text" id="noticeText" dto="noticeText " label="L01670" labelClass="2" conClass="10" required="true" />
			<ifvm:inputNew type="textarea" id="noticeText" dto="noticeText " label="L01670" labelClass="2" conClass="10" disabled="true"  required="true" rows="3"/>
		</div>
	</div> --%>
	
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="upload" text="M00137" id="uploadBtn" btnFunc="fnUpload" objCode="pntBatchRgstDetailPopUpload_OBJ"/>
	<ifvm:inputNew type="button" btnType="cancel" text="I00404" btnFunc="fnClose" objCode="pntBatchRgstDetailPopClose_OBJ"/>
</div>

<div id="pgmPop" class="popup_container"></div>
<div id="txnDetailPop" class="popup_container"></div>
<div id="chnlPop" class="popup_container"></div>

<script>
var uploadValid;
var txnDetailCd=null; // '거래상세 유형'에서 선택한 거래상세유형 codeName값
var dispNo;
var camId;
var pgmRid='5EB7A4631F4C42BA8D6E60A08EDD78F5';
var chnlRid=null;
var offerRid='null';
var ofrType = 'P';

function chnlPopup() {
	$("#chnlPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrPgmChnlListPop"/>',
        contentType: "ajax",
        title: '채널 조회',
        width: 1200,
        close : 'chnlClosePop'
    });
}

function commCodeSetting(){
	$.fn.ifvmSetSelectOptionCommCode('uploadTypeCd', 'OFFER_TYPE_CD', null , null, true);
	$.fn.ifvmSetSelectOptionCommCode('pntTxnType','PNT_TXN_TYPE', null , null , true);
	$.fn.ifvmSetSelectOptionCommCode('pntTxnDtlType', 'PNT_TXN_DTL_TYPE', null , null, true);
	$.fn.ifvmSetSelectOptionCommCode('custTypeCd', 'LOY_CUST_TYPE_CD', null , null, true);
	
	$("#custTypeCd option[value='D']").remove();
	$("#custTypeCd option[value='O']").remove();
	$("#custTypeCd option[value='X']").remove();
}

function fileSearchFn(){

}

function fnSearchCampaign() {
	// 거래상세유형 선택 여부 확인
	if(txnDetailCd == null || txnDetailCd == '') {
		alert('거래상세 유형을 먼저 선택해주세요.');
		return;
	}
	
	var offerType = $("#offerType").val();
	$("#promotionSearchHelpPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ofrPopVocChk"/>?offerType='+offerType+'&&txnDetailCd='+txnDetailCd,   /* 노출 프로모션 캠페인 제한 -> 지급계정 중분류 'CS' */
        contentType: "ajax",
        title: '오퍼 조회',
        width: 1200,
        close : 'promotionSearchHelpPopupClose'
    });
}

function promotionSearchHelpPopupClose() {
	promotionSearchHelpPopup._destroy();
}

function txnDetailPopup() {
	$("#txnDetailPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="txnDetailPop"/>',
        contentType: "ajax",
        title: '거래 상세 유형 조회',
        width: 1200,
        close : 'txnDetailClosePop'
    });
}

function txnDetailClosePop() {
	txnDetailPop._destroy();
}

function chnlPopup() {
	$("#chnlPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="chnlPop"/>',
        contentType: "ajax",
        title: '프로모션 캠페인 목록 조회',
        width: 1200,
        close : 'chnlClosePop'
    });
}

function chnlClosePop() {
	chnlPop._destroy();
}

// function pgmPopup() {
// 	$("#pgmPop").ifvsfPopup({
// 		enableModal : true,
//         enableResize: false,
//         contentUrl: '<ifvm:url name="pgmPopup"/>',
//         contentType: "ajax",
//         title: '프로그램 조회',
//         width: 1200,
//         close : 'pgmClosePop'
//     });
// }

function pgmClosePop() {
	pgmPop._destroy();
}


$(document).ready(function() {
	commCodeSetting();
	
	//업로드유형 : 포인트 고정
	$('#uploadTypeCd').val('POINT');

	$("#pntTxnDtlTypeBtn").click(function(){
	  	 txnDetailPopup();
    });

	$('#pntTxnType').change(function(){
		if($("#pntTxnType").val()=='200') {
			$("#ofrRow").hide();
			$("#pntTxnDtlType").val("");
			txnDetailCd=null;
			$("#ofrNm").prop("required",false);
		}
		else if($("#pntTxnType").val()=='100') {
			$("#ofrRow").show();
			$("#pntTxnDtlType").val("");
			txnDetailCd=null;
			$("#ofrNm").prop("required",true);
		}
	});
	
	// 	setCalendar();

	$('#offerType').change(function(){
		$('#camNm').val('');
	});
});

function fileSearchFn() {
	fnExcelUpload({
		url: '<ifvm:action name="uploadExcelPnt"/>',
		fileName: $("#fileName").val(),
		data: {
			uploadTypeCd :$("#uploadTypeCd").val(),
			procTypeCd :$("#pntTxnType").val(),
			procDtlTypeCd :txnDetailCd,
			offerType :$("#pntTxnType").val(),
			ridCam :$('#ridCam').val(),
			ridOffer :$('#ridOffer').val(),
			ofrRid : offerRid,
			pgmRid : pgmRid,
			custTypeCd : $("#custTypeCd").val()
			/* dispNo : dispNo, */
		},
	}
	, function (result) {
		alert(result.message);
		
		if(result.success){
// 			batchRegistList.requestData();
// 			upldItemList.requestData();
			batchRegistListSearchFn();
			fnClose();
		}
	
		$.ifvProgressControl(false);
	}
	, function (){
		// File 선택 후 동작 할 액션을 정의 한다.
		$('#fileName').val(fnExcelUpload.fileName);
	});
}

function fnUpload(){
	uploadValid = $("#uploadForm").ifvValidation();
	if (uploadValid.confirm() == true) {
		if( fnExcelUpload['upload'] ) {
			var _obj = {	
				url: '<ifvm:action name="uploadExcelPnt"/>',
				fileName: $("#fileName").val(),
				data: {	
					uploadTypeCd :$("#uploadTypeCd").val(),
					procTypeCd :$("#pntTxnType").val(),
					procDtlTypeCd :txnDetailCd,
					offerType :$("#pntTxnType").val(),
// 					pntApplyDt :$('#pntApplyDt').val(),
					ridCam :$('#ridCam').val(),
					ridOffer :$('#ridOffer').val(),
					/* dispNo : dispNo, */
					ofrRid : offerRid,
					pgmRid : pgmRid,
					custTypeCd : $("#custTypeCd").val()
				},
			};
			
			fnExcelUpload.data.formData ={	
					param : JSON.stringify(_obj)
			}
			
			fnExcelUpload.upload();
			$.ifvProgressControl(false);
			fnClose();
		} else {
			
		}
	}
}

function fnClose() {
	fileUploadPop.close();
}

/**
 * 캠페인 검색
 */
function camSearchFn() {
	
}

function setCalendar() {
	var pntApplyDt = $('#pntApplyDt');
	//오늘날짜
	pntApplyDt.val($.ifvGetTodayDate());
	//설정
	pntApplyDt.ifvDateChecker({
		minDate : $.ifvGetTodayDate()
	});
}



</script>