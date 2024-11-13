<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>
 
<script type="text/javascript">

var childOfferListPopup;

function initChildOfferDtlPopData(data) {

    $("#childOfferDtlPopWrap #rid").val(data.rid);
    $("#childOfferDtlPopWrap #childOfferId").val(data.childOfferId);		//하위오퍼 아이디
    
    $("#childOfferDtlPopWrap #offerNm").val(data.offerNm);					//오퍼명
    $("#childOfferDtlPopWrap #offerNo").val(data.offerNo);					//오퍼번호
    $("#childOfferDtlPopWrap #offerTypeCd").val(data.offerTypeCd);			//오퍼유형
    $("#childOfferDtlPopWrap #offerSubTypeCd").val(data.offerSubTypeCd);	//오퍼유형상세
    $("#childOfferDtlPopWrap #selfMinAmt").val(data.selfMinAmt);			//최소 혜택 범위
    $("#childOfferDtlPopWrap #selfMaxAmt").val(data.selfMaxAmt);			//최대 혜택 범위
    $("#childOfferDtlPopWrap #selfUnitCd").val(data.selfUnitCd);			//단위
    $("#childOfferDtlPopWrap #selfGiftAmt").val(data.selfGiftAmt);			//사은품금액
    $("#childOfferDtlPopWrap #selfValueRate").val(data.selfValueRate);		//가치 비율
}

/**
 * 하위오퍼 목록 팝업 호출
 */
function childOfferListPopupOpen() {
    
	childOfferListPopup = $("#childOfferListPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="childOfferListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='E00016'/>",
        width: 500,
        close : 'childOfferListPopClose'
    });
}

/**
 * 하위오퍼 목록 팝업 닫기
 */
function childOfferListPopClose() {
	childOfferListPopup.ejDialog('destroy');
}

/**
 * 하위오퍼를 선택 함. 
 */
function selectChildOffer() {
    
    var selectedChildOffereData = {};
    
    var len = childOfferGrid.getRadioSelectedRowId().length;
    
    if (len > 0) {
        selectedChildOfferData = childOfferGrid.getCheckedGridData()[0];
    }
    else {
        alert("<spring:message code='L00262'/>");
    }
    
    $("#childOfferDtlPopWrap #rid").val(selectedChildOfferData.rid);						//아이디
    $("#childOfferDtlPopWrap #childOfferId").val(selectedChildOfferData.childOfferId);		//하위오퍼 아이디

    $('#childOfferDtlPopWrap #offerNm').val(selectedChildOfferData.offerNm);

    $("#childOfferDtlPopWrap #offerNo").val(selectedChildOfferData.offerNo);				//오퍼번호
    $("#childOfferDtlPopWrap #offerTypeCd").val(selectedChildOfferData.offerTypeCd);		//오퍼유형
    $("#childOfferDtlPopWrap #offerSubTypeCd").val(selectedChildOfferData.offerSubTypeCd);	//오퍼유형상세
    $("#childOfferDtlPopWrap #selfMinAmt").val(selectedChildOfferData.selfMinAmt);			//최소 혜택 범위
    $("#childOfferDtlPopWrap #selfMaxAmt").val(selectedChildOfferData.selfMaxAmt);			//최대 혜택 범위
    
    childOfferListPopClose();
}

$(document).ready(function() {

    // 유형
    $.fn.ifvmSetSelectOptionCommCode("selfUnitCd", "SELF_OFFER_UNIT_CD", null, null, true);
    
    // 하위오퍼 목록 호출
    $('#childOfferListPopupBtn').on('click', function() {
    	childOfferListPopupOpen();
    });

    // 저장
    $('#childOfferAddBtn').on('click', function() {
    	childOfferAdd();
    });

    // 취소 
    $('#childOfferDtlPopCloseBtn').on('click', function() {
    	childOfferDtlPopClose();
    });

});

</script>

<div id="childOfferDtlPopWrap">
    <div class="pop_inner_wrap form-horizontal" id="childOfferDtlPop" >
    
        <ifvm:input type="hidden" id="rid" names="rid" />
        
        <div class="row qt_border">
            <%-- 오퍼 E00011 --%>
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='E00011'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="offerNm" names="offerNm" />
                    <ifvm:input type="hidden" id="childOfferId" 	names="childOfferId" />
                    <ifvm:input type="hidden" id="offerNo" 			names="offerNo" />
                    <ifvm:input type="hidden" id="offerTypeCd" 		names="offerTypeCd" />
                    <ifvm:input type="hidden" id="offerSubTypeCd" 	names="offerSubTypeCd" />
                    <span class="input-group-addon" id="childOfferListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
        </div>
        
        <div class="row qt_border">
            <%-- 혜택범위 --%>
            <label class="col-xs-3 control-label"><spring:message code='E00008'/></label>
            <div class="col-xs-3 control_content">
                <ifvm:input type="number" id="selfMinAmt" names="selfMinAmt"/>
            </div>
            <div class="col-xs-1 control_content">~</div>            
            <div class="col-xs-3 control_content">
                <ifvm:input type="number" id="selfMaxAmt" names="selfMaxAmt"/>
            </div>            
        </div>
        
        <div class="row qt_border">
            <%-- 단위 E00013 --%>
            <label class="col-xs-3 control-label"><spring:message code='E00013'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" id="selfUnitCd" names="selfUnitCd" />
            </div>
        </div>
        
        <div class="row qt_border">
            <%-- 사은품금액 --%>
            <label class="col-xs-3 control-label"><spring:message code='E00014'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="number" id="selfGiftAmt" names="selfGiftAmt"/>
            </div>
        </div>
        
     	<div class="row qt_border">
            <%-- 가치 비율 --%>
            <label class="col-xs-3 control-label"></span><spring:message code='E00015'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="number" id="selfValueRate" names="selfValueRate"/>
            </div>
        </div>
                
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="childOfferAddBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="childOfferDtlPopCloseBtn">
            <spring:message code="M00284"/>
        </button>
    </div>
</div>

<div id="childOfferListPopup"></div>