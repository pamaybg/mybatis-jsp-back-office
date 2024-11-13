<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

/**
 * 고객정보 데이터 조회
 */
function initMbrData() {
    
    $('#mbrRid').val(ruleSetData.rulesetMbr.rid);
    $('#custTypeCd').val(ruleSetData.rulesetMbr.custTypeCd);
    $('#custGradeCd').val(ruleSetData.rulesetMbr.custGradeCd);
    $('#sexCd').val(ruleSetData.rulesetMbr.sexCd);
    $('#vipDivCd').val(ruleSetData.rulesetMbr.vipDivCd);
    $('#totAvlPoint').val(ruleSetData.rulesetMbr.totAvlPoint);
    $('#avlpntComprOptrCd').val(ruleSetData.rulesetMbr.avlpntComprOptrCd);
}

/**
 * 고객정보 데이터를 전역변수에 등록
 */
function setMbrData() {
    ruleSetData.rulesetMbr.rid = $('#mbrRid').val();
    ruleSetData.rulesetMbr.custTypeCd = $('#custTypeCd').val();
    ruleSetData.rulesetMbr.custGradeCd = $('#custGradeCd').val();
    ruleSetData.rulesetMbr.sexCd = $('#sexCd').val();
    ruleSetData.rulesetMbr.vipDivCd = $('#vipDivCd').val();
    ruleSetData.rulesetMbr.totAvlPoint = $('#totAvlPoint').val();
    ruleSetData.rulesetMbr.avlpntComprOptrCd = $('#avlpntComprOptrCd').val();
}

$(document).ready(function() {
    
    // 고객유형
    $.fn.ifvmSetSelectOptionCommCode("custTypeCd", "MEMBER_TYPE", null, null, false);
    
    // 고객등급
    $.fn.ifvmSetSelectOptionCommCode("custGradeCd", "CUST_TIER_CODE", null, null, false);
    
    // 성별
    $.fn.ifvmSetSelectOptionCommCode("sexCd", "MEMBER_SEX", null, null, false);
    
    // VIP등급
    $.fn.ifvmSetSelectOptionCommCode("vipDivCd", "CUST_VIP_CODE", null, null, false);
    
    //비교연산자
    $.fn.ifvmSetSelectOptionCommCode("avlpntComprOptrCd", "POINT_OPER_CODE", null, null, false);
    
    // 화면에 데이터 출력 
    changeValidation_mbr();
    
    $('#rulesetMbrInfo input').on('blur', function() {
        setMbrData();
    });

    $('#rulesetMbrInfo select').on('blur', function() {
        setMbrData();
    });
});

</script>

<ifvm:input type="hidden" id="rulesetTabContent" values="mbr"/>
<div id="rulesetMbrWrap">
    <ifvm:input type="hidden" id="mbrRid" names="mbrRid"/>

    <div class="well mg_bt0 underline form-horizontal" id="rulesetMbrInfo">
        <div class="row qt_border">
        
            <%-- 고객유형 --%>
            <label class="col-xs-2 span control-label"><spring:message code='M02328'/></label>
            <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="custTypeCd" names="custTypeCd"/>
                </div>
            </div>
            
            <label class="col-xs-1 span control-label"></label>
            <div class="col-xs-2 control_content"></div>
            
            <%-- 고객등급 --%>
            <label class="col-xs-1 span control-label"><spring:message code='M02329'/></label>
            <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="custGradeCd" names="custGradeCd"/>
                </div>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 성별 --%>
            <label class="col-xs-2 span control-label"><spring:message code='L00341'/></label>
            <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="sexCd" names="sexCd"/>
                </div>
            </div>
            
            <label class="col-xs-1 span control-label"></label>
            <div class="col-xs-2 control_content"></div>
            
            <%-- VIP구분 --%>
            <label class="col-xs-1 span control-label"><spring:message code='M02330'/></label>
            <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="vipDivCd" names="vipDivCd"/>
                </div>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 총 가용포인트 --%>
            <label class="col-xs-2 span control-label"><spring:message code='M02331'/></label>
            <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="number" className="text-right" id="totAvlPoint" names="totAvlPoint"/>
                </div>
            </div>
            
            <%-- 비교연산자 --%>
            <label class="col-xs-1 span control-label"><spring:message code='M02332'/></label>
            <div class="col-xs-2 control_content">
                <div class="input-group">
                    <ifvm:input type="select" id="avlpntComprOptrCd" names="avlpntComprOptrCd"/>
                </div>
            </div>
            
            <label class="col-xs-1 span control-label"></label>
            <div class="col-xs-2 control_content"></div>
        </div>
    </div>
</div>