<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

/**
 * 기념일 데이터 조회
 */
function initSdayData() {
    
    $('#sdayRid').val(ruleSetData.rulesetSday.rid);
    $('#cmrtnTypeCd').val(ruleSetData.rulesetSday.cmrtnTypeCd);
    $('#sdayComprOptrCd').val(ruleSetData.rulesetSday.sdayComprOptrCd);
    $('#dealDd').val(ruleSetData.rulesetSday.dealDd);
}

/**
 * 화면의 기념일 데이터를 전역변수에 등록
 */
function setSdayData() {
    ruleSetData.rulesetSday.rid = $('#sdayRid').val();
    ruleSetData.rulesetSday.cmrtnTypeCd = $('#cmrtnTypeCd').val();
    ruleSetData.rulesetSday.sdayComprOptrCd = $('#sdayComprOptrCd').val();
    ruleSetData.rulesetSday.dealDd = $('#dealDd').val();
}

/**
 * 달력 설정 
 */
function setValidCalendar() {
    
    var temp = $("#CommonListTemp").tmpl(getInitExtDay(true));
    $("#dealDd").append(temp);
}

/**
 * 시간 옵션 목록 조회 (시간 셀렉트박스 생성시 사용)
 */
function getInitExtDay(isEmptyRow) {
    var hour = [];
    if (isEmptyRow) {
        hour.push({code: '', name : ''});
    }
    for (var i = 1 ; i <= 31 ; i++ ) {
        hour.push({code: $.fn.ifvmStr_pad(i, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i, 2, '0', "LEFT")});
    }
    return hour ;
}

$(document).ready(function() {
    
    setValidCalendar();
    
    // 고객등급
    $.fn.ifvmSetSelectOptionCommCode("cmrtnTypeCd", "CUST_ANNI_CODE", null, null, false);
    
    //비교연산자
    $.fn.ifvmSetSelectOptionCommCode("sdayComprOptrCd", "ANNI_OPER_CODE", null, null, false);

    //기념일 validtaion 변경
    changeValidation_sday();

    $('#rulesetSdayInfo input').on('blur', function() {
        setSdayData();
    });

    $('#rulesetSdayInfo input').on('change', function() {
        setSdayData();
    });

    $('#rulesetSdayInfo select').on('blur', function() {
        setSdayData();
    });
    
    $('#cmrtnTypeCd').on('change', function() {
        var value = $(this).val();
        if (value == '') {
            $('#dealDd').val('21');
        }
    });
});

</script>

<script id="CommonListTemp" type="text/x-jquery-tmpl">
    <option value=${'${'}code}>${'${'}name}</option>
</script>

<ifvm:input type="hidden" id="rulesetTabContent" values="sDay"/>
<div id="rulesetSdayWrap">
    <ifvm:input type="hidden" id="sdayRid" names="sdayRid"/>

    <div class="well mg_bt0 underline form-horizontal" id="rulesetSdayInfo">
        <div class="row qt_border">
        
            <%-- 기념일 --%>
            <label class="col-xs-2 span control-label"><spring:message code='M02333'/></label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="cmrtnTypeCd" names="cmrtnTypeCd" disabled="disabled"/>
                </div>
            </div>
            
            <%-- 비교연산자 --%>
            <label class="col-xs-2 span control-label"><spring:message code='M02332'/></label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="sdayComprOptrCd" names="sdayComprOptrCd"/>
                </div>
            </div>
        </div>

        <div class="row qt_border">
        
            <%-- 거래일자 --%>
            <label class="col-xs-2 span control-label"><spring:message code='M02016'/></label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="dealDd" names="dealDd" disabled="disabled"/>
                </div>
            </div>
        </div>
    </div>
</div>