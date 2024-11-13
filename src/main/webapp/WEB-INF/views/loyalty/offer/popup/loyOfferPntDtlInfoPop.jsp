<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var loyOfferPntDtlInfoPopValidation;

/*
 * SelectBox 월 채우기 (1-24. 2년치)
 */
$.fn.ifvmSetSelectBoxMonth2 = function(id) {
	var dt = new Date();

	for (var i=0; i <= 60; i++) {
		if(i>=13 && i!=24 && i!=60) continue;	//1~12 , 24 , 60
	    var option =
	    	$("<option></option>")
	    	.text(i)
	    	.attr("value", i)
	    ;

	    if (i == dt.getMonth()) {
	    	option.selected = true;
	    }

		$("#" + id).append(option)
	}
}

function initLoyOfferPntDtlInfoPop() {
	//채널유형
	$.fn.ifvmSetSelectOptionCommCode("validStartdtBasCd", "LOY_VALID_STARTDT_BAS_CD", null, null, true);

	//월 설정
	$.fn.ifvmSetSelectBoxMonth2("validEndDtnum");

	loyOfferPntDtlInfoPopValidation = $("#loyOfferPntDtlInfoPop").ifvValidation();
}

function initLoyOfferPntDtlInfoPopData(data) {
	$("#validStartdtBasCd").val(data.validStartdtBasCd);
	$("#validStartDtnum").val(data.validStartDtnum);
	$("#validEndDtnum").val(data.validEndDtnum);
	$("#rdmSeq").val(data.rdmSeq);
}

$(document).ready(function() {
	initLoyOfferPntDtlInfoPop();

	/**
	 * 2018.12.06 hy.jun
	 * 다이소 포인트차감순서 1 고정
	 */
	$('#rdmSeq').val(1);

	//등록 클릭시
    $('#loyOfferPntDtlInfoPopSaveBtn').on('click', function(){
    	loyOfferPntDtlInfoPopupSave();
    });

    //닫기 클릭시
    $('#loyOfferPntDtlInfoPopCancelBtn').on('click', function(){
    	loyOfferPntDtlInfoPopupClose();
    });

    //상품 목록 팝업
    $('#loyBrandListPopupBtn').on('click', function(){
    	loyBrandListPopupOpen();
    });

    //카테고리 목록 팝업
    $('#loyChannelListPopupBtn').on('click', function(){
    	loyChannelListPopupOpen();
    });

});
</script>

<div id="loyOfferPntDtlInfoPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="loyOfferPntDtlInfoPop" >
		<div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00264'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="validStartdtBasCd" names="validStartdtBasCd" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00265'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" valiItem ='number' maxLength="15" required="true" id="validStartDtnum" names="validStartDtnum" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00266'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="validEndDtnum" names="validEndDtnum" />
            </div>
        </div>
        <div class="row qt_border" style="display:none;">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00267'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="number" valiItem ='number' maxLength="15" required="true" id="rdmSeq" names="rdmSeq" />
            </div>
        </div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="loyOfferPntDtlInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        저장
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="loyOfferPntDtlInfoPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>