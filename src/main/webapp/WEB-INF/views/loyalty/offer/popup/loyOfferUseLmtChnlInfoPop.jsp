<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var loyOfferUseLmtChnlInfoPopValidation;

function initLoyOfferUseLmtChnlInfoPop() {
	//채널유형
	$.fn.ifvmSetSelectOptionCommCode("usePsblChnlRange", "LOY_CHNL_TYPE_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCodeSync("usePsblChnlSubRange", "LOY_CHNL_SUB_TYPE_CD", null, "usePsblChnlRange", true);
	
	loyOfferUseLmtChnlInfoPopValidation = $("#loyOfferUseLmtChnlInfoPop").ifvValidation();
}

function initLoyOfferUseLmtChnlInfoPopData(data) {
	$("#usePsblChnlRange").val(data.usePsblChnlRange);
	$("#usePsblChnlRange").change();
	$("#usePsblChnlSubRange").val(data.usePsblChnlSubRange);
	$("#ridChnl").val(data.ridChnl);
	$("#chnlNo").val(data.chnlNo);
	$("#chnlNm").val(data.chnlNm);
}

//채널 유형
function getChnlType() {
	var data = {
			chnlTypeCd: $("#usePsblChnlRange").val(),
			chnlTypeSubCd: $("#usePsblChnlSubRange").val()
	}
	
	return data;
}

//채널 목록 팝업 열기
function loyChannelListPopupOpen() {
    $("#loyChannelListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyChannelListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00283'/>",
        width: '600px',
        close : 'loyChannelListPopupClose'
    });
}

//채널 목록 팝업 선택
function loyChannelListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(loyChannelListPopGrid.getCheckedList())) {
		var selData = loyChannelListPopGrid.getCheckedList()[0];
		$("#chnlNm").val(selData.chnlNm);	//채널명
		$("#chnlNo").val(selData.chnlNo);	//채널코드
		$("#ridChnl").val(selData.rid);	//rid
		
		//close popup
		loyChannelListPopupClose();
	} else {
		alert("<spring:message code='L00284'/>");
		
		return false;
	}
}

//채널 목록 팝업 닫기
function loyChannelListPopupClose() {
	loyChannelListPopup._destroy();
}

$(document).ready(function() {
	initLoyOfferUseLmtChnlInfoPop();
	
	//등록 클릭시
    $('#loyOfferUseLmtChnlInfoPopSaveBtn').on('click', function(){
    	loyOfferUseLmtChnlInfoPopupSave();
    });
    
    //닫기 클릭시
    $('#loyOfferUseLmtChnlInfoPopCancelBtn').on('click', function(){
    	loyOfferUseLmtChnlInfoPopupClose();
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

<div id="loyOfferUseLmtChnlInfoPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="loyOfferUseLmtChnlInfoPop" >
		<div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00285'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="usePsblChnlRange" names="usePsblChnlRange" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00286'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="usePsblChnlSubRange" names="usePsblChnlSubRange" />
            </div>
        </div>
		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00287'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="chnlNo" names="chnlNo" />
                    <ifvm:input type="hidden" readonly="true" required="true" id="ridChnl" names="ridChnl" />
                    <span class="input-group-addon" id="loyChannelListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
		</div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00288'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" readonly="true" required="true" id="chnlNm" names="chnlNm" />
            </div>
        </div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="loyOfferUseLmtChnlInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M01855"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="loyOfferUseLmtChnlInfoPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>
<div id="loyChannelListPopup"></div>