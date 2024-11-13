<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>
 
<script type="text/javascript">

var gradeListPopup;

function initGradeDtlPopData(data) {

    $("#gradeDtlPopWrap #rid").val(data.rid);
    $("#gradeDtlPopWrap #tierNm").val(data.tierNm);
    $("#gradeDtlPopWrap #gradeCd").val(data.gradeCd);
    $("#gradeDtlPopWrap #ridTier").val(data.ridTier);
    $("#gradeDtlPopWrap #stblAmt").val(data.stblAmt);
}

/**
 * 등급목록 팝업 호출
 */
function gradeListPopupOpen() {
    
    gradeListPopup = $("#gradeListPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="gradeListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M01980'/>",
        width: 500,
        close : 'gradeListPopClose'
    });
}

/**
 * 등급 목록 팝업 닫기
 */
function gradeListPopClose() {
    gradeListPopup.ejDialog('destroy');
}

/**
 * 등급을 선택 함. 
 */
function selectGrade() {
    
    var selectedGradeData = {};
    
    var len = gradeGrid.getRadioSelectedRowId().length;
    
    if (len > 0) {
        selectedGradeData = gradeGrid.getCheckedGridData()[0];
    }
    else {
        alert("<spring:message code='L00262'/>");
    }

    $('#gradeDtlPopWrap #tierNm').val(selectedGradeData.tierNm);
    $('#gradeDtlPopWrap #gradeCd').val(selectedGradeData.tierCd);
    $('#gradeDtlPopWrap #ridTier').val(selectedGradeData.ridTier);
    
    gradeListPopClose();
}

$(document).ready(function() {

    // 유형
    $.fn.ifvmSetSelectOptionCommCode("type", "OFFER_STBL_TYPE_CD", null, null, true);
    
    // 등급 목록 호출
    $('#gradeListPopupBtn').on('click', function() {
        gradeListPopupOpen();
    });

    // 저장
    $('#gradeAddBtn').on('click', function() {
        gradeAdd();
    });

    // 취소 
    $('#gradeDtlPopCloseBtn').on('click', function() {
        gradeDtlPopClose();
    });

    $("#stblAmt").keyup(function (event) {
   		if($("#discountAmount").val() > 2147483647) {
   			$("#discountAmount").val("2147483647");
   		}
	});
});

</script>

<div id="gradeDtlPopWrap">
    <div class="pop_inner_wrap form-horizontal" id="gradeDtlPop" >
    
        <ifvm:input type="hidden" id="rid" names="rid" />
        
        <div class="row qt_border">
            
            <%-- 유형 M02281 --%>
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='M00180'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="type" names="type" />
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 등급 --%>
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00324'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="tierNm" names="tierNm" />
                    <ifvm:input type="hidden" id="gradeCd" names="gradeCd" />
                    <ifvm:input type="hidden" id="ridTier" names="ridTier" />
                    <span class="input-group-addon" id="gradeListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 차감 포인트/스템프 --%>
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='M02284'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="number" required="true" id="stblAmt" names="stblAmt"/>
            </div>
        </div>
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="gradeAddBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="gradeDtlPopCloseBtn">
            <spring:message code="M00284"/>
        </button>
    </div>
</div>

<div id="gradeListPopup"></div>