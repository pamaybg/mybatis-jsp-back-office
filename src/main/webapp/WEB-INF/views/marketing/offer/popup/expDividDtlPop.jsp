<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var expDividListPopup;

/**
 * 수정시 화면에 값 불러오기
 */
function initExpDividDtlPopData(data) {

    $("#expDividDtlPopWrap #rid").val(data.rid);
    
    $("#expDividDtlPopWrap #dividorTypeCd").val(data.dividorTypeCd);
    $("#expDividDtlPopWrap #dividor").val(data.dividor);
    $("#expDividDtlPopWrap #ridDividorChnl").val(data.ridDividorChnl);
    $("#expDividDtlPopWrap #dividVal").val(data.dividVal);
    $("#expDividDtlPopWrap #settleTypeCd").val(data.settleTypeCd);
    $("#expDividDtlPopWrap #dividDesc").val(data.dividDesc);
    
    //changeDividorTypeCd();
}

/**
 * 재원분담처 목록 팝업 열기
 */
function expDividListPopupOpen() {
    expDividListPopup = $("#expDividListPopup").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="expDividListPop"/>',
        contentType : "ajax",
        title : "<spring:message code='M02428'/>",
        width : 600,
        close : 'expDividListPopupClose'
    });
}
function expDividListPopupClose() {
    expDividListPopup.ejDialog('destroy');
}
/**
 * 재원분담처 목록 팝업 선택
 */
function expDividListPopupSelect() {
    if ($.fn.ifvmIsNotEmpty(expDividListPopGrid.getCheckedList())) {
        
        var selData = expDividListPopGrid.getCheckedList()[0];
        $("#dividor").val(selData.chnlNm); 
        $("#ridDividorChnl").val(selData.rid);
        
        //close popup
        expDividListPopupClose();
    }
    else {
        alert("<spring:message code='L00301'/>");
        return false;
    }
}

$(document).ready(function() {

    // 구분
    $.fn.ifvmSetSelectOptionCommCode("dividorTypeCd", "LOY_SHCHN_TYPE_CD", null, null, true);

    // 기준
    $.fn.ifvmSetSelectOptionCommCode("settleTypeCd", "LOY_SETTLE_TYPE_CD", null, null, true);
    
    // 분담처 검색
    $('#expDividListPopupBtn').on('click', function() {
        expDividListPopupOpen();
    });
    
    // 저장
    $('#expDividDtlPopSaveBtn').on('click', function() {
        expDividAdd();
    });

    // 취소
    $('#expDividDtlPopCancelBtn').on('click', function() {
        expDividDtlPopClose();
    });
    
    // 구분변경시
    $('#dividorTypeCd').on('change', function() {
        //changeDividorTypeCd();
    });
    
    //changeDividorTypeCd();
    $("#dividVal").onlyPercent();
});

/**
 * 구분변경시 
 *  - 구분이 '자사'(MYCOM), '사용자전체'(ALL) 인 경우 분담처 입력이 불필요하다.   
 */
function changeDividorTypeCd() {
    
    var selectDividorTypeCd = $('#dividorTypeCd').val();
    
    if (selectDividorTypeCd == 'ALL' || selectDividorTypeCd == 'MYCOM') {
        
        $('#dividVal').val();
        $('#dividVal').prop('readonly', true);

        $('#settleTypeCd').val();
        $('#settleTypeCd').prop('disabled', true);
        
        $('#dividDesc').val();
        $('#dividDesc').prop('readonly', true);
        
        $('#expDividDtlPop span.asterisk').hide();
    }
    else {
        $('#dividVal').prop('readonly', false);
        $('#settleTypeCd').prop('disabled', false);
        $('#dividDesc').prop('readonly', false);
        
        $('#expDividDtlPop span.asterisk').show();
    }
}

</script>

<div id="expDividDtlPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="expDividDtlPop" >
        <ifvm:input type="hidden" id="rid" names="rid" />
        <ifvm:input type="hidden" id="dividUnit" names="dividUnit" values="RATE"/>
        
        <div class="row qt_border" id="prodArea">

            <%-- 구분 --%>
            <label class="col-xs-3 control-label"><spring:message code='M00690'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="dividorTypeCd" names="dividorTypeCd" />
            </div>
        </div>
        
		<div class="row qt_border" id="prodArea">
        
            <%-- 분담처 --%>
			<label class="col-xs-3 control-label"><spring:message code='M02288'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="dividor" names="dividor" />
                    <ifvm:input type="hidden" readonly="true" id="ridDividorChnl" names="ridDividorChnl" />
                    <span class="input-group-addon" id="expDividListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
		</div>
        
        <div class="row qt_border">
        
            <%-- 분담율 --%>
            <label class="col-xs-3 control-label"><spring:message code='M02289'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="number" id="dividVal" names="dividVal"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 기준 --%>
            <label class="col-xs-3 control-label"><spring:message code='M00921'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" id="settleTypeCd" names="settleTypeCd" />
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 비고 --%>
            <label class="col-xs-3 control-label"><spring:message code='L01024'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" id="dividDesc" names="dividDesc" maxLength="200"/>
            </div>
        </div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="expDividDtlPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M01855"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="expDividDtlPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>
<div id="expDividListPopup"></div>
