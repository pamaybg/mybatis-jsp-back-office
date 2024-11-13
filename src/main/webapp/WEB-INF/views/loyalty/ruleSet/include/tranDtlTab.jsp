<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var tranValidation = true;

/**
 * 거래정보 데이터 조회
 */
function initTranData() {

    if ($.fn.ifvmIsNotEmpty(ruleSetData) 
            && $.fn.ifvmIsNotEmpty(ruleSetData.rulesetTran)) {
        $('#tranRid').val(ruleSetData.rulesetTran.rid);
        
        //충전금액
        $('#chargAmt').val(ruleSetData.rulesetTran.chargAmt);
        $('#chargComprOptrCd').val(ruleSetData.rulesetTran.chargComprOptrCd);

        //거래요일
        $('#dealDowCd').val(ruleSetData.rulesetTran.dealDowCd);
        
        //거래회차
        $('#dealCnt').val(ruleSetData.rulesetTran.dealCnt);
        $('#dealComprOptrCd').val(ruleSetData.rulesetTran.dealComprOptrCd);

        //거래시간
        $('#dealStartDt').val(ruleSetData.rulesetTran.dealStartDt);
        $('#dealEndDt').val(ruleSetData.rulesetTran.dealEndDt);
        
        //기준일자
        $('#baseDdCd').val(ruleSetData.rulesetTran.baseDdCd);
        
        //적용일수
        $('#aplyDaycnt').val(ruleSetData.rulesetTran.aplyDaycnt);
        $('#aplyDaycntOptrCd').val(ruleSetData.rulesetTran.aplyDaycntOptrCd);
    }
}

/**
 * 거래정보 데이터를 전역변수에 등록 
 */
function setTranData() {
    ruleSetData.rulesetTran.rid = $('#tranRid').val();
    ruleSetData.rulesetTran.chargAmt = $('#chargAmt').val();
    ruleSetData.rulesetTran.chargComprOptrCd = $('#chargComprOptrCd').val();
    ruleSetData.rulesetTran.dealDowCd = $('#dealDowCd').val();
    ruleSetData.rulesetTran.dealCnt = $('#dealCnt').val();
    ruleSetData.rulesetTran.dealComprOptrCd = $('#dealComprOptrCd').val();
    ruleSetData.rulesetTran.baseDdCd = $('#baseDdCd').val();
    ruleSetData.rulesetTran.aplyDaycnt = $('#aplyDaycnt').val();
    ruleSetData.rulesetTran.aplyDaycntOptrCd = $('#aplyDaycntOptrCd').val();
    ruleSetData.rulesetTran.dealStartDt = $('#dealStartDt').val();
    ruleSetData.rulesetTran.dealEndDt = $('#dealEndDt').val();
}

/**
 * 달력 설정 
 * 
 * 1. 거래시간 시작일
 * 2. 거래시간 종료일
 * 
 * @returns
 */
function tranDtlTab_setCalendar() {

    var temp = $("#CommonListTemp").tmpl(getInitExtHour(true));
    $("#dealStartDt").append(temp);

    var temp = $("#CommonListTemp").tmpl(getInitExtHour(true));
    $("#dealEndDt").append(temp);
}

/**
 * 시간 옵션 목록 조회 (시간 셀렉트박스 생성시 사용)
 */
function getInitExtHour(isEmptyRow) {
    var hour = [];
    if (isEmptyRow) {
        hour.push({code: '', name : ''});
    }
    for (var i = 1 ; i <= 24 ; i++ ) {
        hour.push({code: $.fn.ifvmStr_pad(i, 2, '0', "LEFT"), name: $.fn.ifvmStr_pad(i, 2, '0', "LEFT")});
    }
    return hour ;
}

$(document).ready(function() {

    //충전금액비교연산자
    $.fn.ifvmSetSelectOptionCommCode("chargComprOptrCd", "POINT_OPER_CODE", null, null, false);
    
    //거래요일
    $.fn.ifvmSetSelectOptionCommCode("dealDowCd", "TRAN_DAY_CODE", null, null, false);
    
    //거래회차비교연산자
    $.fn.ifvmSetSelectOptionCommCode("dealComprOptrCd", "POINT_OPER_CODE", null, null, false);
    
    //적용일수비교연산자
    $.fn.ifvmSetSelectOptionCommCode("aplyDaycntOptrCd", "POINT_OPER_CODE", null, null, false);
    
    //기준일자
    $.fn.ifvmSetSelectOptionCommCode("baseDdCd", "DAY_TYPE_CODE", null, null, false);
    
    //달력 설정
    tranDtlTab_setCalendar();
    
    //화면에 데이터 출력
    changeValidation_tran();

    $('#rulesetTranInfo input').on('blur', function() {
        setTranData();
    });
    $('#rulesetTranInfo select').on('blur', function() {
        setTranData();
    });
});

</script>

<script id="CommonListTemp" type="text/x-jquery-tmpl">
    <option value=${'${'}code}>${'${'}name}</option>
</script>

<ifvm:input type="hidden" id="rulesetTabContent" values="tran"/>
<div id="rulesetTranWrap">
    <ifvm:input type="hidden" id="tranRid" names="tranRid"/>

    <div class="well mg_bt0 underline form-horizontal" id="rulesetTranInfo" >
        <div class="row qt_border">
        
            <%-- 충전금액 --%>
            <label class="col-xs-2 span control-label"><spring:message code='L00967'/></label>
            <div class="col-xs-3">
                <div class="col-xs-6 control_content">
                    <div class="input-group">
                        <ifvm:input type="number" className="text-right" id="chargAmt" names="chargAmt"/>
                    </div>
                </div>
                <div class="col-xs-6 control_content">
                    <div class="input-group">
                        <ifvm:input type="select" id="chargComprOptrCd" names="chargComprOptrCd"/>
                    </div>
                </div>
            </div>
            
            <%-- 거래요일 --%>
            <label class="col-xs-2 span control-label"><spring:message code='M02334'/></label>
            <div class="col-xs-3">
                <div class="col-xs-6 control_content">
                    <div class="input-group">
                        <ifvm:input type="select" id="dealDowCd" names="dealDowCd"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 거래회차 --%>
            <label class="col-xs-2 span control-label"><spring:message code='M02335'/></label>
            <div class="col-xs-3">
                <div class="col-xs-6 control_content">
                    <div class="input-group">
                        <ifvm:input type="number" className="text-right" id="dealCnt" names="dealCnt"/>
                    </div>
                </div>
                <div class="col-xs-6 control_content">
                    <div class="input-group">
                        <ifvm:input type="select" id="dealComprOptrCd" names="dealComprOptrCd"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 거래시간 --%>
            <label class="col-xs-2 span control-label"><spring:message code='M02017'/></label>
            <div class="col-xs-3 control_content" style="padding: 0px">
                <div class="col-xs-3 time_content">
                    <ifvm:inputNew type="select" id="dealStartDt"/>
                </div>
                <label class="col-xs-1 span control-label"> ~ </label>
                <div class="col-xs-3 time_content">
                    <ifvm:inputNew type="select" id="dealEndDt"/>
                </div>
            </div>
            
        </div>
        <div class="row qt_border">
        
            <%-- 기준일자 --%>
            <label class="col-xs-2 span control-label"><spring:message code='M02336'/></label>
            <div class="col-xs-3 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="baseDdCd" names="baseDdCd"/>
                </div>
            </div>

            <%-- 적용일수 --%>            
            <label class="col-xs-2 span control-label"><spring:message code='M02337'/></label>
            <div class="col-xs-3">
                <div class="col-xs-6 control_content">
                    <div class="input-group">
                        <ifvm:input type="number" className="text-right" id="aplyDaycnt" names="aplyDaycnt"/>
                    </div>
                </div>
                <div class="col-xs-6 control_content">
                    <div class="input-group">
                        <ifvm:input type="select" id="aplyDaycntOptrCd" names="aplyDaycntOptrCd"/>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>