<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var expDividListPopup;
var selectedObj = null;

/**
 * 수정시 화면에 값 불러오기
 */
function initExpDividDtlPopData(data) {

    $("#expDividDtlPopWrap").dataSetting(data);

    /*
    $("#expDividDtlPopWrap #rid").val(data.rid);

    $("#expDividDtlPopWrap #dividorTypeCd").val(data.dividorTypeCd);
    $("#expDividDtlPopWrap #dividor").val(data.dividor);
    $("#expDividDtlPopWrap #ridDividorChnl").val(data.ridDividorChnl);
    $("#expDividDtlPopWrap #dividVal").val(data.dividVal);
    $("#expDividDtlPopWrap #settleTypeCd").val(data.settleTypeCd);
    $("#expDividDtlPopWrap #dividDesc").val(data.dividDesc);
     */
    //changeDividorTypeCd();
}

/**
 * 재원분담처 목록 팝업 열기
 */
function expDividListPopupOpen() {
    expDividListPopup = $("#expDividListPopup").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="expDividListPopNew"/>',
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
    if ($.fn.ifvmIsNotEmpty(selectedObj)) {

        $("#dividor").val(selectedObj.chnlNm);
        $("#ridDividorChnl").val(selectedObj.rid);

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
        <ifvm:inputNew type="hidden" id="rid" dto="rid" names="rid" />
        <ifvm:inputNew type="hidden" id="dividUnit" dto="dividUnit" names="dividUnit" values="RATE"/>
        <div class="row qt_border" id="prodArea">
            <%-- 구분 --%>
            <ifvm:inputNew type="select" id="dividorTypeCd" dto="dividorTypeCd" names="dividorTypeCd" label="M00690" labelClass="3" conClass="9"/>
        </div>
		<div class="row qt_border" id="prodArea">
            <%-- 분담처 --%>
            <ifvm:inputNew type="search" id="dividor|dividorSearch"
	        	hidId="ridDividorChnl" hidDto="ridDividorChnl" btnFunc="expDividListPopupOpen"
	        	dto="dividor" names="dividor" label="M02288" labelClass="3" conClass="9" />
		</div>
        <div class="row qt_border">
            <%-- 분담율 --%>
            <ifvm:inputNew type="text" id="dividVal" dto="dividVal" label="M02289" labelClass="3" conClass="9" valiItem="number" />
        </div>
        <div class="row qt_border">
            <%-- 기준 --%>
            <ifvm:inputNew type="select" id="settleTypeCd" dto="settleTypeCd" names="settleTypeCd" label="M00921" labelClass="3" conClass="9"/>
        </div>
        <div class="row qt_border">
            <%-- 비고 --%>
            <ifvm:inputNew type="text" id="dividDesc" dto="dividDesc" label="L01024" labelClass="3" conClass="9" maxLength="200" />
        </div>
	</div>
	<div class="pop_btn_area">
		<ifvm:inputNew type="button" btnFunc="expDividAdd" text="M01855" />
		<ifvm:inputNew type="button" btnFunc="expDividDtlPopClose" text="M00441" />
	</div>
</div>
<div id="expDividListPopup"></div>
