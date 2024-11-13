<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var promBasicValidation;

//Init
function ruleSetPopInit() {
    cDialog.model.title = "<spring:message code='M02454'/>";
    $("#dialog_title").append("<spring:message code='M02454'/>");
    cDialog.model.close = "closeRuleSetPop";

    setTimeout(function() {
        cDialog.refresh();
    }, 1000);
}

//dialog close
function closeRuleSetPop(args) {
    cDialog._destroy();
}

//Init Data
function ruleSetPopInitData() {
  	//프로모션 정보 로드 셋팅
    loadRuleSetMainCon();
}

//프로모션 메인 로드
function loadRuleSetMainCon() {
    
  	//프로모션 메인 로드 셋팅
    $.fn.ifvmLoadUiSetting("ruleSetContents",'<ifvm:url name="loadRuleSetMain"/>?id=' + campaign.id);
    $("#ruleSetSaveBtn").hide();
} 

//ruleSet Pop 저장
function ruleSetPopSave() {
    
    //ruleSet 저장
    $("#ruleSetSaveBtn").trigger("click");

} 

//취소
function ruleSetPopCancel() {
	closeRuleSetPop();
}

$(function () {
	ruleSetPopInit();
	ruleSetPopInitData();
	
	//저장 클릭시
    $('#ruleSetPopSaveBtn').on('click', function(){
    	ruleSetPopSave();
    });
	   
    //취소 클릭시
    $('#ruleSetPopCancelBtn').on('click', function(){
    	ruleSetPopCancel();
    });
    
});
</script>


<div id="dialogPopupWrap">
    <input type="hidden" id="chnlType" value="">
    <input type="checkbox" id="fatigueExcept" style="visibility:hidden">
    
    <div class="pop_inner_wrap form-horizontal" style="">
        <div class="row popup_contents_height" id="ruleSetContents" style="height: 560px;overflow-x:hidden;"></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="ruleSetPopSaveBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00280"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2 cancel" id="ruleSetPopCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>