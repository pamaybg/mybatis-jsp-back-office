<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var paymentStandardInfoPopValidation;

function initPaymentStandardInfoPop() {
	//적립구분
	$.fn.ifvmSetSelectOptionCommCode("saveDiv", "LOY_ACRL_TYPE", null, null, true);
	//결제유형
	$.fn.ifvmSetSelectOptionCommCode("cardType", "LOY_CARD_TYPE", null, null, true);
	
	paymentStandardInfoPopValidation = $("#paymentStandardInfoPop").ifvValidation();
}

function initPaymentStandardInfoPopData(data) {
	$("#paymentStandardInfoPop #cardType").val(data.cardType);
	$("#paymentStandardInfoPop #saveDiv").val(data.acrlType);
	$("#paymentStandardInfoPop #amount").val(data.acrlAmt);
	
	/* if (data.allianCardYn == "Y") {
		$("input:checkbox[id='allianCardYn']").prop("checked", true);
	} */
}

$(document).ready(function() {
	initPaymentStandardInfoPop();
	
	//등록 클릭시
    $('#paymentStandardInfoPopSaveBtn').on('click', function() {
    	paymentStandardInfoPopupSave();
    });
    
    //닫기 클릭시
    $('#paymentStandardInfoPopCancelBtn').on('click', function() {
    	paymentStandardInfoPopupClose();
    });
});
</script>

<div id="paymentStandardInfoPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="paymentStandardInfoPop" >
		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>적립구분</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="select"  required="true" id="saveDiv" names="saveDiv" />
                </div>
            </div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>적립금액/적립률</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="number" className="text-right"  required="true" id="amount" names="amount" />
                </div>
            </div>
		</div>
	
		<div class="row qt_border">
            <!-- 결제수단 -->
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00358'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="cardType" names="cardType" />
            </div>
        </div>
        <%-- <div class="row qt_border">
            <!-- 제휴카드여부 -->
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00193'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="checkbox" id="allianCardYn" names="allianCardYn" />
            </div>
        </div> --%>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="paymentStandardInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00137"/>
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="paymentStandardInfoPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>