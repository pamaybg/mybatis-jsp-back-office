<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
targetImportMain = function() {
    this.saveBtnHide = false;
    
    var flag;
    try {flag = workflowFlag} catch(exception){ flag = false}
    
    if (flag) {
        this.saveBtnHide = true;
    }
}

//타겟그룹 목록 팝업 열기
targetImportMain.prototype.targetImportListPopupOpen = function() {
	$("#targetImportListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="targetImportListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01494"/>',
        width: 800,
        close : 'targetImportMain.targetImportListPopupClose'
    });
}

//팝업 닫기
targetImportMain.prototype.targetImportListPopupClose = function() {
    targetImportListPopup._destroy();
}

//타겟그룹 선택시
targetImportMain.prototype.targetImportSelect = function() {
    var _this = this;
    
    _this.targetImportListPopupClose();
    
    if ($.fn.ifvmIsNotEmpty(targetImportListPopGrid.getCheckedList())) {
        var targetGroupId = targetImportListPopGrid.getCheckedList()[0].targetGroupId;   //타겟그룹 아이디
        
      	//타겟그룹 상세화면 Load
        _this.targetImportDetailLoad(targetGroupId);
    }
}

//타겟그룹 상세화면 Load
targetImportMain.prototype.targetImportDetailLoad = function(targetGroupId) {
    
    //main화면 숨김
    $("#targetImportMain_top").hide();
    
  	//content 화면 보이기
    $("#targetImportMain_con").show();
    
    //타겟그룹 상세화면 Load
    $.fn.ifvmLoadUiSetting("targetImportMain_con", '<ifvm:url name="targetImportDetailLoad"/>' + '?targetGroupId=' + targetGroupId);
    
    //저장 버튼 추가
    var tmpl = $("#targetImportMainSaveBtnTemp").tmpl();        
    $("#targetImportDetailBtn_area").append(tmpl);
    
    //버튼 회색으로
    $("#targetImportMain_con .btn").addClass("btn_gray");
    
    $("#targetImportMainSaveBtn").on("click", function(){
	    targetImportMain.campaignTargetGroupSave();
	});
    
    if (this.saveBtnHide) {
        $("#saveTargetGroupImportBtn").hide();
        $("#targetGroupListBtn").hide();
    }
}

//타겟그룹 목록화면 Load
targetImportMain.prototype.targetImportMainLoad = function() {
    //content 화면 숨기기
    $("#targetImportMain_con").hide();
    $("#targetImportMain_con").html("");
    
    //main화면 보이기
    $("#targetImportMain_top").show();
    
}

//캠페인 타겟그룹 저장
targetImportMain.prototype.campaignTargetGroupSave = function() {
	saveCampaignTarget();
}

var targetImportMain;
$(document).ready(function() {
    targetImportMain = new targetImportMain();
    
	$("#targetImportListPopupBtn").on("click", function(){
	    targetImportMain.targetImportListPopupOpen();
	});
	
    //Import 버튼
    $("#targetImportOpenBtn").on("click", function() {
    	targetImportMain.targetImportDetailLoad('');
    });
});


</script>

<script id="targetImportMainSaveBtnTemp" type="text/x-jquery-tmpl">
<button class="btn btn-sm btn_gray" id="targetImportMainSaveBtn">    
	<i class="glyphicon glyphicon-check"></i>     
	<spring:message code="M00280"/>
</button>
</script>


<style>
html, body{background:#fff;}
</style>

<div id="targetImportMain_wrap">
    <div id="targetImportMain_top">
        <div class="page_btn_area">
            <div class="col-xs-12">
                <span><spring:message code="M01494"/></span>
            </div>
        </div>
    	<div class="user_main_area">
    		<div class="main_area main1">
    			<p class="user_txt user_tit"><spring:message code="M02444"/></p>
            	<p class="user_txt user_desc"><spring:message code="M02446"/></p>
    			<button class="user_btn_list" id="targetImportListPopupBtn">
    				<spring:message code="M01693"/>
    			</button>
    		</div>
        <div class="main_area main2">
            <p class="user_txt user_tit"><spring:message code="M02445"/></p>
            <p class="user_txt user_desc"><spring:message code="M02447"/></p>
            <button class="user_btn_list" id="targetImportOpenBtn">
                <spring:message code="M02436"/>
            </button>
        </div>
    	</div>
    </div>
    <div class="well form-horizontal well_wrap pad0" id="targetImportMain_con">
    </div>
</div>

<div id="targetImportListPopup" class="popup_container"></div>