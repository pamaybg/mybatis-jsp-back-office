<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>

.warning_box {
	padding: 15px 15px;
	color: red
}

</style>
<script>
var promotionSearchHelpPopup = null;
var maxPoint;
var ofrType = 'P';
var pntTxnDtlType = null; //포인트 거래 상세 유형
var txnDetailCd=null;
var chnlNo=null;
/**
 * input Select 공통코드 option 생성(상위객체 연동)
 * name : select box 객체명
 * groupCode : 그룹코드
 * selectCode : 초기선택코드
 * parName : 상위 select box 객체명
 * noBlank : 최상위 빈값 설정여부
 */
/* $.fn.ifvmSetSelectOptionCommCodeSync2 = function(name, groupCode, selectCode, parName, noBlank) {
	var _name = name;
	var _selectCode = $.fn.ifvmIsNotEmpty(selectCode) ? selectCode : "";
	var _noBlank = $.fn.ifvmIsNotEmpty(noBlank) ? noBlank : false;
	var _parName = $.fn.ifvmIsNotEmpty(parName) ? parName : null;
	var _commCodeList = [];

	//공통코드 목록 조회
	$.ifvSyncPostJSON(PAGE_CONTEXT_PATH + '/system/commcode/getCommCondLIst.do',{
        groupCode : groupCode
        , enableNA : true
    },function(result) {
    	if($.fn.ifvmIsNotEmpty(result.rows)) {
    		_commCodeList = result.rows;
    	}
    });

	//select 설정
	function setSelect() {
		if ($.fn.ifvmIsNotEmpty(_name)) {
			if ($.fn.ifvmIsNotEmpty(_parName)) {
				var _parValue = $("[name='" + _parName + "']").val();
				var _parCodeId = $("[name='" + _parName + "'] [value='"+_parValue+"']").attr("codeid");

				//초기화
				$("select[name='"+ _name +"']").empty();

		        if(!_noBlank) {
				    $("<option></option>")
				    .text("")
				    .attr("codeId", "")
				    .attr("value", "")
				    .appendTo("select[name='"+ _name +"']");
		        }

			    $.each(_commCodeList, function(index, code) {
			    	//par 코드 확인
			    	if (_parCodeId == code.parCodeId) {
			    		if(code.codeName === '160' || code.codeName === '260' || code.codeName === '261' || code.codeName === '262') {
						    var option =
						    	$("<option></option>")
						    	.text(code.markName)
						    	.attr("codeId", code.codeId)
						    	.attr("value", code.codeName)
						    	.attr("attrib01", code.attrib01)
						    ;
						    //selectCode 가 있을경우 기본 선택
						    if ( _selectCode == code.codeName) {
						    	option.attr("selected", "selected");
						    }
	
						    //noBlank 이며 selectcode가 없을때 첫번째 값 선택
						    if (index == 0 && _noBlank && _selectCode == "") {
						    	option.attr("selected", "selected");
						    }
	
						    option.appendTo("select[name='"+ _name +"']");
			    		}
			    	}
			    });
			}
		}
	}

	setSelect();

	//parName 객체 변경시
	$("[name='" + _parName + "']").on('change', function() {
		 setSelect();
    });
	
	//2018.11.30 hy.jun - parName 객체 option 목록 변경될 시
// 	$("[name='" + _parName + "']").bind('DOMSubtreeModified', function() {
// 		setSelect();
// 	});
}; */

var fn_mbrVocPop = {

    getDaisoPoint: function() {
    	$.ifvSyncPostJSON('<ifvm:action name="getPontBalanceB2c"/>', {
    	    rid : mbr_rid
    	}, function(result) {
    	    if (result.p_UsePnt == '') $('#vocPointPopInfo #usePnt').val("0");
    	    else $('#vocPointPopInfo #usePnt').val($.fn.ifvmDecimalWithCommas(result.p_UsePnt));
    	});
    },
    save: function() {
		
    	$.ifvProgressControl(true);
    	
   
	    //validation 체크
	    var isRcpt = false;
	    if($('#vocPointPopInfo').is(':visible')) {
	   	 var mbrVocValidation = $("#vocPointPopInfo").ifvValidation();
	   	 if (!mbrVocValidation.confirm()) {
	   	 	$.ifvProgressControl(false);
	   	 	return false;
	   	 }
	   	 if(!confirm('<spring:message code="적립하시겠습니까?"/>') == true) {
	   		$.ifvProgressControl(false);
	   		return false;
	   	 }
	    } 
	    /* if($('#rcptAftrRgstDetailForm').is(':visible')) {
	   	 isRcpt = true;
	   	 
	   	 var rcptAftrRgstValidation = $("#rcptAftrRgstDetailForm").ifvValidation();
	   	 if (!rcptAftrRgstValidation.confirm()) {
	   	 	$.ifvProgressControl(false);
	   	 	return false;
	   	 }
	    }  */
	     
	     // validation 체크
	//      var mbrVocValidation = $("#vocPointPopInfo").ifvValidation();
	//   if (mbrVocValidation.confirm()) {
	         var tgtData = $("#vocPointPopInfo").getSubmitData();
	     	tgtData.ridMbr = mbr_rid;
	     	tgtData.mbrNo = $('#mbrNo').val();
	     	tgtData.pntAmt = tgtData.pntAmt.replaceAll(",","");
	     	tgtData.pgmRid = pgmRid;
	     	tgtData.pgmNo = pgmNo;
	     	tgtData.pntTxnDtlType = txnDetailCd;
	     	tgtData.chnlNo = chnlNo;
	     	tgtData.vocDesc = $("#vocDesc").val();
	     	/* if(isRcpt) {
	     		tgtData.rcptData = $("#rcptAftrRgstDetailForm").getSubmitData(); //영수증 관련 데이터
	     		tgtData.isRcpt = isRcpt; //영수증을 이용한 적립 여부
	     	} */
	     
	     	//포인트 거래유형이 [적립]이면서, 금액이 1,000포인트를 넘으면 메시지 창 표시
	//      	if (tgtData.pntTxnType_1Cd == '100' && Number(tgtData.pntAmt) > 1000) {
	//      		$.ifvProgressControl(false);
	//   		alert('<spring:message code="L02317"/>');
	//   		alert('입력한 적립 포인트가 1,000 초과입니다. 1,000 초과는 [포인트 수동일괄등록] 화면에서 등록하시면 됩니다.');
	// 	 	return ;
	//      	}
	     
	     	//저장
	     	$.ifvSyncPostJSON('<ifvm:action name="addVocPntTxn"/>'
	     	, tgtData
	     	, function(result) {
	     		if (result.success) {
	     			alert('<spring:message code="적립되었습니다."/>');
	     			mbrDetail();
	     			mbrPointHistListGrid._doAjax();
	     			//getPointTxnListListSearch('A');
	     			/* acrlUseSetting('A'); //적립사용조회
	     			$(".datepicker").val(""); */
	     			$.fn.ifvmPopupClose();
	     			
	     			$.ifvProgressControl(false);
	     		}
	     	}, function(result) {
	     		if($.fn.ifvmIsNotEmpty(result.message)) {
		     		alert(result.message);
	     		} else {
	     			alert('에러가 발생하였습니다. 관리자에게 문의해주세요.');
	     		}
	     		
	     		$.ifvProgressControl(false);
	     	});
//     	} else {
//     		$.ifvProgressControl(false);
//     	}
    },
    commCodeSetting: function() {
		/* $.ifvGetCommCodeList('select', 'pntTxnType_1Cd', '<ifvm:action name="getCommCodeList2"/>', 'PNT_TXN_TYPE', null, false, false, true);
		$.ifvGetCommCodeList('select', 'pntTxnType_2Cd', '<ifvm:action name="getCommCodeList2"/>', 'PNT_TXN_DTL_TYPE', null, false, false, true); */
		
		//포인트 거래유형
	   /*  $.fn.ifvmSetSelectOptionCommCode("pntTxnType_1Cd", "PNT_TXN_TYPE", null, null, true);

	    //포인트 거래상세유형
	    $.fn.ifvmSetSelectOptionCommCodeSync("pntTxnType_2Cd", "PNT_TXN_DTL_TYPE", null, 'pntTxnType_1Cd', true);
	    //거래상세유형 VOC만 출력 (160 or 161)
    	$('#pntTxnType_2Cd option').each(function(i, e) {
    		if(!($(e).val() === '160' || $(e).val() === '161' || $(e).val() === '162')) {
    			$(e).remove();
    		}
    	}); */
    },
    close: function() {
    	$.fn.ifvmPopupClose();
    },
}

function commCodeInitSetting(){
	$.fn.ifvmSetSelectOptionCommCode('pntTxnType','PNT_TXN_TYPE', "100");
	$("#pntTxnType").val('100');
	$("#usePnt").val($("#avlPoint").val());
	$("#offerType").val('P');
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

/**
 * 프로모션 선택 시 변경 이벤트
 */
/* function chgEvntVal_PntAccntDetailTypeCd() {
    if($('#vocPointPopInfo #pntAccntDetailTypeCd').val() === '160020A01') { //구매 영수증 사후 적립
    	$('#rcptAftrRgstDetailForm').show();
    	
    	$('#vocPointPopInfo #vocDesc').val('영수증 사후적립은 CS 사유를 처리요청 시 자동으로 생성합니다.');
    	$('#vocPointPopInfo #vocDesc').attr('disabled', true);
    	$('#vocPointPopInfo #vocDesc').attr('required', false);
    } else {
    	$('#rcptAftrRgstDetailForm').hide();
    	
    	$('#vocPointPopInfo #vocDesc').val('');
    	$('#vocPointPopInfo #vocDesc').attr('disabled', false);
    	$('#vocPointPopInfo #vocDesc').attr('required', true);
    }
} */

/**
 * 영수증 보기 팝업 open
 */
/* function viewRcptFromB2CFn2(obj) {
   	var ss_num = obj.inputRcptNo;
   	var sale_day = obj.inputSalesDt;
   	var shop_cod = obj.chnlNo;
   	
   	$("#viewRcptFromB2C2").ifvsfPopup({
   		enableModal : true,
           enableResize: false,
           contentUrl: '<ifvm:url name="viewRcptFromB2C"/>?ss_num='+ss_num+'&sale_day='+sale_day+'&shop_cod='+shop_cod,
           contentType: "ajax",
           title: '영수증 보기',
           width: 440,
           close : 'viewRcptFromB2C2Close'
	});
}

/**
 * 영수증 보기 팝업 close
 */
/* function viewRcptFromB2C2Close() {
	viewRcptFromB2C2._destroy();
} 
 */
/**
 * 채널 검색 팝업 open
 */
function channelSearchFn() {
   	$("#channelSearchHelpPopup").ifvsfPopup({
   		enableModal : true,
           enableResize: false,
           contentUrl: '<ifvm:url name="channelSearchHelpRcptAftr"/>',
           contentType: "ajax",
           title: '가맹점 조회',
           width: 900,
           close : 'channelSearchHelpPopupClose'
	});
}
 

function channelSearchHelpPopupClose() {
	channelSearchHelpPopup._destroy();
} 


/**
 * 채널 검색 팝업 close
 */
/* function mbrSearchHelpPopupClose() {
	mbrSearchHelpPopup._destroy();
} */

/**
 * 포인트 1회 적립제한금액 안내문구 세팅
 */
/* function setCsPntAcrlLimitNotice() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'CS_PNT_ACRL_LIMIT'
	},function(result){
		if(result.rows.length != 1) {
			alert('공통코드 CS_PNT_ACRL_LIMIT 는 1개만 등록되어있어야 합니다.');
		} else {
			var attrib01 = result.rows[0].attrib01;
			$('.warning_box').text('※ 포인트 적립시 ' + $.fn.ifvmDecimalWithCommas(attrib01) + ' 포인트 초과는 처리되지 않습니다.');
		}
	});
} */


function fnSearchOfr() {
	// 거래상세유형 선택 여부 확인
	if(txnDetailCd == null || txnDetailCd == '') {
		alert('포인트 거래상세유형을 먼저 선택해주세요.');
		return;
	}

	var offerType = $("#offerType").val();
	$("#ofrPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ofrPopPnt"/>?offerType='+offerType+'&&txnDetailCd='+txnDetailCd, 
        contentType: "ajax",
        title: '오퍼 조회',
        width: 1200,
        close : 'ofrClosePop'
    });
}

function ofrClosePop() {
	ofrPop._destroy();
}

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

function chnlClosePop() {
	chnlPop._destroy();
}
 
$(document).ready(function() {
	commCodeInitSetting();

	$("#pntTxnDtlBtn").click(function(){
		txnDetailPopup();
		
	});
	//포인트 1회 적립제한금액 안내문구 세팅
	//setCsPntAcrlLimitNotice();
	//권한별 포인트 셋팅
	//setCsPntAcrlLimitNotice();
	
    //공통코드 조회
    //fn_mbrVocPop.commCodeSetting();

    //다이소 포인트 조회
    //fn_mbrVocPop.getDaisoPoint();

    $('#vocPointPopInfo #pntAmt').on('blur', function(data) {
        $(this).val($.fn.ifvmDecimalWithCommas($(this).val()));
    });
    
    
	//포인트 적립 가능여부 체크
    $.ifvSyncPostJSON('<ifvm:action name="getMbrPntAcrlUseYn"/>', {
    	mbrNo : $('#mbrNo').val()
    }, function(result) {
    	if(!result.pntAcrlYn) {
    		alert('포인트 적립이 불가능한 회원입니다.\n회원상세 포인트 적립가능여부를 확인해주세요.');
    		$('#mbrVocPopSaveBtn').attr('disabled', true);
    	} else {
    		$('#mbrVocPopSaveBtn').attr('disabled', false);
    	}
	});
	
     /*$('#pntTxnType_1Cd').change(function(){
		if($('#pntTxnType_1Cd').val() == '100'){
    	   $('#pntTxnType_2Cd option').each(function(i, e) {
   				if(!($(e).val() === '160' || $(e).val() === '161' || $(e).val() === '162')) {
   					$(e).remove();
   				}
   			});
       	}
    }); */
});

</script>

<div class="form-horizontal underline top_well clearfix" id="vocPointPopInfo">
<!-- 	<div class="form-horizontal top_well underline"> -->

		<div class="row">
			<!-- 포인트 거래유형 -->
			<%-- <ifvm:inputNew type="select" id="pntTxnType_1Cd" dto="pntTxnType_1Cd" required="true" label="M02128" labelClass="3" conClass="3" /> --%>

			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="포인트 거래유형"/></label>
            <div class="col-xs-2 control_content">
                <ifvm:input type="select" id="pntTxnType" disabled="true" names="pntTxnType" dto="pntTxnType" required="true"/>
            </div>

			<!-- 포인트 거래상세유형 -->
			<%-- <ifvm:inputNew type="select" id="pntTxnType_2Cd" dto="pntTxnType_2Cd" required="true" label="M02129" labelClass="3" conClass="3" /> --%>
			
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="포인트 거래상세유형"/></label>
            <div class="col-xs-2 control_content">
            <div class="input-group">
                <ifvm:input type="text" id="pntTxnDtlType" disabled="true" names="pntTxnDtlType" dto="pntTxnDtlType" required="true"/>
            		<span class="input-group-addon" id="pntTxnDtlBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
					</div>
            </div>
		</div>
		<div class="row">
			<!-- 프로모션 캠페인 -->
			<ifvm:inputNew type="text" id="ofrNm" dto="ofrNm" disabled="true" required="true" label="오퍼" nuc="true" labelClass="2" conClass="2"/>
			<!-- 오퍼 검색 -->
			<div class="control_content col-xs-2">
				<ifvm:inputNew type="button" btnType="search" text="오퍼 검색" nuc="true" id="searchCampaignBtn" btnFunc="fnSearchOfr" objCode="vocsearchCampaignBtn_OBJ"/>
			</div>
			
			<!-- 프로모션 캠페인 -->
			
			<ifvm:inputNew type="text" id="chnlNm" dto="chnlNm" disabled="true" required="true" label="채널" nuc="true" labelClass="1" conClass="2"/>
			<!-- 채널 검색 -->
			<div class="control_content col-xs-1">
				<ifvm:inputNew type="button" btnType="search" text="채널 검색" nuc="true" id="searchCampaignBtn" btnFunc="chnlPopup" objCode="vocsearchChnlBtn_OBJ"/>
			</div>
		</div>
		<div class="row">
			<!-- 처리 포인트 -->
			<ifvm:inputNew type="text" id="pntAmt" dto="pntAmt" disabled="false" required="true" label="처리 포인트" labelClass="2" conClass="3" className="text-right"/>
			<!-- 다이소 포인트 -->
			<ifvm:inputNew type="text" id="usePnt" dto="usePnt" disabled="true" label="가용 포인트" nuc="true" labelClass="2" conClass="3" className="text-right"/>

		</div>
<!-- 		<div class="row">
			<div class="warning_box"></div>
		</div> -->
		<div class="row">
			<!-- VOC 사유 -->
			<ifvm:inputNew type="textarea" placeholder="(최대 500자 입력)" id="vocDesc" dto="vocDesc" disabled="false" required="true" label="사유" nuc="true" labelClass="2" conClass="9" rows="3" maxLength="500"/>
		</div>

		
		<ifvm:inputNew type="hidden" id="offerId" dto="offerId" />
		<ifvm:inputNew type="hidden" id="offerNo" dto="offerNo" />
		<ifvm:inputNew type="hidden" id="offerType" dto="offerType" />
		<ifvm:inputNew type="hidden" id="pntAccntDetailTypeCd" dto="pntAccntDetailTypeCd" />
<!-- 	</div> -->
</div>

<%-- div class="form-horizontal underline top_well clearfix" style="display:none;" id="rcptAftrRgstDetailForm">
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>영수증 검색</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" text="영수증 검색" btnType="search" id="callGetReceiptDetailBtn" btnFunc="callGetReceiptDetail" nuc="true" objCode="callGetReceiptDetailBtn_OBJ"/>
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-12">
			<ifvm:inputNew type="text" id="inputRcptNo" dto="inputRcptNo" label="영수증 번호" labelClass="2" conClass="4" nuc="true" required="true" desc="영수증 바코드의 하단 번호를 입력해주세요."/>
			<ifvm:inputNew type="text" id="inputSalesDt" dto="inputSalesDt" label="판매일자(8자리)" labelClass="2" conClass="4" nuc="true" required="true" placeholder="예시)20180901"/>
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-12">
			<ifvm:inputNew type="search" id="chnlNm|channelSearchHelpBtn" names="chnlNm" disabled="false" btnFunc="channelSearchFn" dto="chnlNm"
					searchBlurEvent="channelSearchHelpBlur" searchEnterEvent="channelSearchHelpEnter" label="결제 가맹점" labelClass="2" conClass="4" nuc="true" required="true"/>
			<ifvm:inputNew type="text" id="camNm" dto="camNm" label="프로모션 캠페인" labelClass="2" conClass="4" disabled="true" nuc="true" required="true"/>
		</div>
	</div>
	
<!-- 	<div class="page_btn_area"> -->
<!-- 		<div class="col-xs-7"> -->
<!-- 			<span>회원정보</span> -->
<!-- 		</div> -->
<!-- 		<div class="col-xs-5 searchbtn_r"> -->
			<ifvm:inputNew type="button" text="회원 검색" btnType="search" id="mbrSearchHelpBnt" btnFunc="mbrSearchHelpFn" nuc="true"/>
<!-- 		</div> -->
<!-- 	</div> -->
<!-- 	<div class="row qt_border"> -->
<!-- 		<div class="col-xs-12"> -->
			<ifvm:inputNew type="text" id="mbrNo" dto="mbrNo" label="회원번호" labelClass="2" conClass="4" disabled="true" nuc="true"/>
			<ifvm:inputNew type="text" id="custNm" dto="custNm" label="회원명" labelClass="2" conClass="4" disabled="true" nuc="true"/>
<!-- 		</div> -->
<!-- 		<div class="col-xs-12"> -->
			<ifvm:inputNew type="text" id="mbrStatCdNm" dto="mbrStatCdNm" label="회원상태" labelClass="2" conClass="4" disabled="true" nuc="true"/>
			<ifvm:inputNew type="singleCheckbox" id="mbrLockYn" dto="mbrLockYn" label="휴면여부" values="Y" labelClass="2" conClass="4" checked="false" disabled="true" nuc="true"/>
<!-- 		</div> -->
<!-- 	</div> -->
	
	<div class="page_btn_area">
		<span>영수증 정보 조회 결과</span>
	</div>
<!-- 	<div class="row qt_border"> -->
<!-- 		<div class="col-xs-12"> -->
			<ifvm:inputNew type="textarea" id="srchRsltMsg" dto="srchRsltMsg" label="조회결과" labelClass="2" conClass="10" disabled="true" nuc="true" rows="4"/>
<!-- 		</div> -->
<!-- 	</div> -->
	<div class="row qt_border">
		<div class="col-xs-12">
			<ifvm:inputNew type="text" id="txnDate" dto="txnDate" label="판매일자" labelClass="2" conClass="4" disabled="true" nuc="true"/>
			<ifvm:inputNew type="text" id="txnTime" dto="txnTime" label="판매시간" labelClass="2" conClass="4" disabled="true" nuc="true"/>
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-12">
			<ifvm:inputNew type="text" id="chnlNo" dto="chnlNo" label="매장코드" labelClass="2" conClass="4" disabled="true" nuc="true"/>
			<ifvm:inputNew type="text" id="chnlNm" dto="chnlNm" label="매장명" labelClass="2" conClass="4" disabled="true" nuc="true"/>
		</div>
	</div>
	<div class="row qt_border">
		<div class="col-xs-12">
			<ifvm:inputNew type="text" id="salesTotal" dto="salesTotal" label="판매금액" labelClass="2" conClass="4" disabled="true" nuc="true"/>
			<ifvm:inputNew type="text" id="payAmt" dto="payAmt" label="결제금액" labelClass="2" conClass="4" disabled="true" nuc="true"/>
		</div>
	</div>
</div> --%>
<!-- <div class="pop_btn_area"> -->
<%-- 	<ifvm:inputNew type="button" 					text="기 적립영수증 조회" 	id="viewRcptFromB2CBtn2" btnFunc="viewRcptFromB2CFn2" nuc="true" disabled="true"/> --%>
<%-- 	<ifvm:inputNew type="button" 					text="적립요청" 			id="reqAcrlBnt" btnFunc="reqAcrlFn" nuc="true"/> --%>
<%-- 	<ifvm:inputNew type="button" btnType="cancel" 	text="I00404" btnFunc="rcptAftrRgstDetailPopClose" /> --%>
<!-- </div> -->

	<%-- <ifvm:inputNew type="hidden" id="shop_cod" 	dto="shop_cod" />
	<ifvm:inputNew type="hidden" id="posNum" 	dto="posNum" />
	<ifvm:inputNew type="hidden" id="ridMbr" 	dto="ridMbr" />
	<ifvm:inputNew type="hidden" id="ridChnl" 	dto="ridChnl" />
	<ifvm:inputNew type="hidden" id="ridCam" 	dto="ridCam" />
	<ifvm:inputNew type="hidden" id="dispNo" 	dto="dispNo" />
	<ifvm:inputNew type="hidden" id="offerNo" 	dto="offerNo" />
	<ifvm:inputNew type="hidden" id="offerType" dto="offerType" /> --%>

</div>

<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="save"	text="적립" nuc="true" id="mbrVocPopSaveBtn" btnFunc="fn_mbrVocPop.save"  objCode="mbrVocPopSaveBtn_OBJ"/>
   <ifvm:inputNew type="button" btnType="close"	text="L00913" btnFunc="fn_mbrVocPop.close"  objCode="mbrVocPopClose_OBJ"/>
</div>
<div id="txnDetailPop" class="popup_container"></div>
<div id="ofrPop" class="popup_container"></div>
<div id="chnlPop" class="popup_container"></div>
<!-- <div id="promotionSearchHelpPopup" class="popup_container"></div>
<div id="viewRcptFromB2C2" class="popup_container"></div>
<div id="channelSearchHelpPopup" class="popup_container"></div>
<div id="mbrSearchHelpPopup" class="popup_container"></div> -->