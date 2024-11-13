<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var loyOfferExpDividInfoPopValidation;

function initLoyOfferExpDividInfoPop() {
	//채널유형
	$.fn.ifvmSetSelectOptionCommCode("settleTypeCd", "LOY_SETTLE_TYPE_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCodeSync("settleDtlTypeCd", "LOY_SETTLE_DTL_TYPE_CD", null, "settleTypeCd", true);
	$.fn.ifvmSetSelectOptionCommCode("dividorTypeCd", "LOY_SHCHN_TYPE_CD", null, null, true);
	
	//number input box 설정
	$.fn.ifvmNumberOnlyWithDecimal("dividVal");
	
	loyOfferExpDividInfoPopValidation = $("#loyOfferExpDividInfoPop").ifvValidation();
}

function initLoyOfferExpDividInfoPopData(data) {
	$("#settleTypeCd").val(data.settleTypeCd);
	$("#settleTypeCd").change();
	$("#settleDtlTypeCd").val(data.settleDtlTypeCd);
	$("#dividorTypeCd").val(data.dividorTypeCd);
	$("#ridDividorChnl").val(data.ridDividorChnl);
	$("#dividor").val(data.dividor);
	$("#dividVal").val(data.dividVal);
}

//채널 목록 팝업 열기
function loyChannelListPopupOpen() {
    $("#loyChannelListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyChannelListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00251'/>",
        width: '600px',
        close : 'loyChannelListPopupClose'
    });
}

//채널 목록 팝업 선택
function loyChannelListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(loyChannelListPopGrid.getCheckedList())) {
		var selData = loyChannelListPopGrid.getCheckedList()[0];
		$("#ridDividorChnl").val(selData.rid);
		$("#dividor").val(selData.chnlNm);
		
		//close popup
		loyChannelListPopupClose();
	} else {
		alert("<spring:message code='L00252'/>");
		
		return false;
	}
}

//채널 목록 팝업 닫기
function loyChannelListPopupClose() {
	loyChannelListPopup._destroy();
}

$(document).ready(function() {
	initLoyOfferExpDividInfoPop();
	
	//등록 클릭시
    $('#loyOfferExpDividInfoPopSaveBtn').on('click', function(){
    	loyOfferExpDividInfoPopupSave();
    });
    
    //닫기 클릭시
    $('#loyOfferExpDividInfoPopCancelBtn').on('click', function(){
    	loyOfferExpDividInfoPopupClose();
    });
    
    //채널 목록 팝업
    $('#loyChannelListPopupBtn').on('click', function(){
    	loyChannelListPopupOpen();
    });
    
});
</script>

<div id="loyOfferExpDividInfoPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="loyOfferExpDividInfoPop" >
		<div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00253'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="settleTypeCd" names="settleTypeCd" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00254'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" id="settleDtlTypeCd" names="settleDtlTypeCd" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00255'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="dividorTypeCd" names="dividorTypeCd" />
            </div>
        </div>
		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00256'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="dividor" names="dividor" />
                    <ifvm:input type="hidden" readonly="true" required="true" id="ridDividorChnl" names="ridDividorChnl" />
                    <span class="input-group-addon" id="loyChannelListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
		</div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00257'/></label>
            <div class="col-xs-9 control_content">
            	<ifvm:input type="text" maxLength="15" required="true" id="dividVal" />
            </div>
        </div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="loyOfferExpDividInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M01855"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="loyOfferExpDividInfoPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>
<div id="loyBrandListPopup"></div>
<div id="loyChannelListPopup"></div>