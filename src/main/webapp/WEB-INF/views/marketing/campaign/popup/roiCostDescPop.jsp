<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
function roiCostDescPopInitData() {
	$("#costDescTextarea").val(costDesc);
}

$(function () {
	roiCostDescPopInitData();
	
    //비용상세 팝업 확인 클릭시
    $('#costDescPopConBtn').on('click', function(){
        costDescPopConBtn();
    });
    
    //비용상세 팝업 취소 클릭시
    $('#costDescPopCloseBtn').on('click', function(){
        costDescPopClose();
    });
});
</script>

<div id="dialogPopupWrap">
    <div class="pop_inner_wrap form-horizontal">
        <div>
            <ifvm:input type="textarea" id="costDescTextarea" names="costDescTextarea" maxLength="200" rows="5" />
        </div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="costDescPopConBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00804"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2 cancel" id="costDescPopCloseBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>