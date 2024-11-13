<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
 
<script type="text/javascript">

var prvBnfDtlValidation ;

/**
 * 혜택수량 데이터 조회
 */
function initPrvBnfDtl(data) {

    $("#prvBnfDtlPopWrap #rid").val(data.rid);
    $("#prvBnfDtlPopWrap #acrlType").val(data.acrlType);
    $("#prvBnfDtlPopWrap #acrlAmt").val(data.acrlAmt);
}

$(document).ready(function() {

    //보상유형
    $.fn.ifvmSetSelectOptionCommCode("acrlType", "OBJECT_OPER_CODE", null, null, true);
    
    //저장
    $('#prvBnfAddBtn').on('click', function() {
        addPrvBnfDtl();
    });

    //닫기
    $('#prvBnfDtlPopClose').on('click', function() {
        prvBnfDtlPopupClose();
    });

});

</script>

<div id="prvBnfDtlPopWrap">
    <div class="pop_inner_wrap form-horizontal" id="prvBnfDtlPop" >
    
        <ifvm:input type="hidden" id="rid" names="rid" />
        
        <div class="row qt_border">
        
            <%-- 보상유형 --%>
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='M02338'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" id="acrlType" names="acrlType" />
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- 금액(률) --%>
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='M02339'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="number" required="true" id="acrlAmt" names="acrlAmt" />
            </div>
        </div>
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="prvBnfAddBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="prvBnfDtlPopClose">
            <spring:message code="M00284"/>
        </button>
    </div>
</div>

<div id="prvBnfListPopup"></div>