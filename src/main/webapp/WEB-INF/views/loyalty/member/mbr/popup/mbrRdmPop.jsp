<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>

</style>
<script>
var promotionSearchHelpPopup = null;
var maxPoint;
var ofrType = 'P';
var txnDetailCd=null;
var chnlNo=null;

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
    	/* if( parseInt($("#usePnt").val().replace(/,/g,""))< parseInt($("#pntAmt").val().replace(/,/g,""))) {
    		alert("가용포인트를 초과했습니다.");
    		return;
    	} */
    	$.ifvProgressControl(true);
    	
   
	    //validation 체크
	    var isRcpt = false;
	    if($('#vocPointPopInfo').is(':visible')) {
	   	 var mbrVocValidation = $("#vocPointPopInfo").ifvValidation();
	   	 if (!mbrVocValidation.confirm()) {
	   	 	$.ifvProgressControl(false);
	   	 	return false;
	   	 }
	   	if(!confirm('<spring:message code="차감하시겠습니까?"/>') == true) {
	   		$.ifvProgressControl(false);
	   		return false;
	   	 }
	    } 
	         var tgtData = $("#vocPointPopInfo").getSubmitData();
	     	tgtData.ridMbr = mbr_rid;
	     	tgtData.mbrNo = $('#mbrNo').val();
	     	tgtData.pntAmt = tgtData.pntAmt.replaceAll(",","");
	     	tgtData.pgmRid = pgmRid;
	     	tgtData.pgmNo = pgmNo;
	     	tgtData.pntTxnDtlType = txnDetailCd;
	     	tgtData.chnlNo = chnlNo;
	     	tgtData.vocDesc = $("#vocDesc").val();
	     
	     	//저장
	     	$.ifvSyncPostJSON('<ifvm:action name="addVocPntTxn"/>'
	     	, tgtData
	     	, function(result) {
	     		if (result.success) {
	     			alert('<spring:message code= "사용완료되었습니다."/>');
	     			mbrDetail();
	     			$.fn.ifvmPopupClose();
	     			mbrPointHistListGrid._doAjax();
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

    },
    commCodeSetting: function() {
    
    },
    close: function() {
    	$.fn.ifvmPopupClose();
    },
}

function commCodeInitSetting(){
	$.fn.ifvmSetSelectOptionCommCode('pntTxnType','PNT_TXN_TYPE', "200");

	$("#pntTxnType").val('200');
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
//chnlNm
	$("#chnlNm").val("CS(고객서비스)");
	chnlNo="CH0000519";

	$("#pntTxnDtlBtn").click(function(){
		txnDetailPopup();
		
	});

    $('#vocPointPopInfo #pntAmt').on('blur', function(data) {
        $(this).val($.fn.ifvmDecimalWithCommas($(this).val()));
    });
    
    
	//포인트 적립 가능여부 체크
    /* $.ifvSyncPostJSON('<ifvm:action name="getMbrPntAcrlUseYn"/>', {
    	mbrNo : $('#mbrNo').val()
    }, function(result) {
    	if(!result.pntAcrlYn) {
    		alert('포인트 차감이 불가능한 회원입니다.\n회원상세 포인트 차감가능여부를 확인해주세요.');
    		$('#mbrVocPopSaveBtn').attr('disabled', true);
    	} else {
    		$('#mbrVocPopSaveBtn').attr('disabled', false);
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
            <div class="col-xs-3 control_content">
                <ifvm:input type="select" id="pntTxnType" disabled="true" names="pntTxnType" dto="pntTxnType" required="true"/>
            </div>

			<!-- 포인트 거래상세유형 -->
			<%-- <ifvm:inputNew type="select" id="pntTxnType_2Cd" dto="pntTxnType_2Cd" required="true" label="M02129" labelClass="3" conClass="3" /> --%>
			
			<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="포인트 거래상세유형"/></label>
            <div class="col-xs-3 control_content">
            <div class="input-group">
                <ifvm:input type="text" id="pntTxnDtlType" disabled="true" names="pntTxnDtlType" dto="pntTxnDtlType" required="true"/>
            		<span class="input-group-addon" id="pntTxnDtlBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
					</div>
            </div>
		</div>
		<div class="row">
			<ifvm:inputNew type="text" id="chnlNm" dto="chnlNm" disabled="true" required="true" label="채널" nuc="true" labelClass="2" conClass="2"/>
			<!-- 프로모션 검색 -->
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
	
		<div class="row">
			<!-- VOC 사유 -->
			<ifvm:inputNew type="textarea" id="vocDesc" dto="vocDesc" disabled="false" required="true" label="사유" placeholder="(최대 500자 입력)" nuc="true" labelClass="2" conClass="9" rows="3" maxLength="500"/>
		</div>

		
		<ifvm:inputNew type="hidden" id="offerId" dto="offerId" />
		<ifvm:inputNew type="hidden" id="offerNo" dto="offerNo" />
		<ifvm:inputNew type="hidden" id="offerType" dto="offerType" />
		<ifvm:inputNew type="hidden" id="pntAccntDetailTypeCd" dto="pntAccntDetailTypeCd" />
</div>


</div>

<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="save"	text="사용" nuc="true" id="mbrVocPopSaveBtn" btnFunc="fn_mbrVocPop.save"  objCode="mbrVocPopSaveBtn_OBJ"/>
   <ifvm:inputNew type="button" btnType="close"	text="L00913" btnFunc="fn_mbrVocPop.close"  objCode="mbrVocPopClose_OBJ"/>
</div>
<div id="txnDetailPop" class="popup_container"></div>
<div id="chnlPop" class="popup_container"></div>
<!-- <div id="promotionSearchHelpPopup" class="popup_container"></div>
<div id="viewRcptFromB2C2" class="popup_container"></div>
<div id="channelSearchHelpPopup" class="popup_container"></div>
<div id="mbrSearchHelpPopup" class="popup_container"></div> -->