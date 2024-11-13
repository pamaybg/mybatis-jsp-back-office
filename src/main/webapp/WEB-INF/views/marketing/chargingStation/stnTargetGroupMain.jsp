<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
targetGroupMain = function() {
    this.saveBtnHide = false;
    
    var flag;
    try {flag = workflowFlag} catch(exception){ flag = false}
    
    if (flag) {
        this.saveBtnHide = true;
    }
}

//타겟그룹 목록 팝업 열기
targetGroupMain.prototype.targetGroupListPopupOpen = function() {
	$("#targetGroupListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="targetGroupListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01494"/>',
        width: 800,
        close : 'targetGroupMain.targetGroupListPopupClose'
    });
}

//팝업 닫기
targetGroupMain.prototype.targetGroupListPopupClose = function() {
    targetGroupListPopup._destroy();
}

//타겟그룹 선택시
targetGroupMain.prototype.targetGroupSelect = function() {
    var _this = this;
    
    _this.targetGroupListPopupClose();
    
    if ($.fn.ifvmIsNotEmpty(targetGroupListPopGrid.getCheckedList())) {
        var targetGroupId = targetGroupListPopGrid.getCheckedList()[0].targetGroupId;   //타겟그룹 아이디
        
      	//타겟그룹 상세화면 Load
        _this.targetGroupDetailLoad(targetGroupId);
    }
}

//타겟그룹 상세화면 Load
targetGroupMain.prototype.targetGroupDetailLoad = function(targetGroupId) {
    //main화면 숨김
    $("#targetGroupMain_top").hide();
    
  	//content 화면 보이기
    $("#targetGroupMain_con").show();
    
    //타겟그룹 상세화면 Load
    $.fn.ifvmLoadUiSetting("targetGroupMain_con", '<ifvm:url name="stnTargetGroupDetailLoad"/>' + '?targetGroupId=' + targetGroupId);
    
    //저장 버튼 추가
    var tmpl = $("#targetGroupMainSaveBtnTemp").tmpl();        
    $("#targetGroupDetailBtn_area").append(tmpl);
    
    //버튼 회색으로
    $("#targetGroupMain_con .btn").addClass("btn_gray");
    
    $("#targetGroupMainSaveBtn").on("click", function(){
	    targetGroupMain.campaignTargetGroupSave();
	});
    
    if (this.saveBtnHide) {
        $("#targetGroupMainSaveBtn").hide();
    }
}

//타겟그룹 목록화면 Load
targetGroupMain.prototype.targetGroupMainLoad = function() {
    //content 화면 숨기기
    $("#targetGroupMain_con").hide();
    $("#targetGroupMain_con").html("");
    
    //main화면 보이기
    $("#targetGroupMain_top").show();
    
}

//세그먼트 목록 열기
targetGroupMain.prototype.segmentListOpen = function() {
    var url = '<ifvm:url name="segmentList_KPR"/>';
    window.open(url, "_blank");  
}

//캠페인 타겟그룹 저장
targetGroupMain.prototype.campaignTargetGroupSave = function() {
    saveSegment();
}

var targetGroupMain;
$(document).ready(function() {
    targetGroupMain = new targetGroupMain();
    
	$("#targetGroupListPopupBtn").on("click", function(){
	    targetGroupMain.targetGroupListPopupOpen();
	});
	
	//2018.01.04 전화영 세그먼트 선택 버튼 제외
// 	$("#segmentListOpenBtn").on("click", function(){
// 	    targetGroupMain.segmentListOpen();
// 	});
});


</script>

<script id="targetGroupMainSaveBtnTemp" type="text/x-jquery-tmpl">
<button class="btn btn-sm btn_gray" id="targetGroupMainSaveBtn">    
	<i class="glyphicon glyphicon-check"></i>     
	<spring:message code="M00280"/>
	</button>  
</script>


<style>
html, body{background:#fff;}
</style>

<div id="targetGroupMain_wrap">
    <div id="targetGroupMain_top">
        <div class="page_btn_area">
            <div class="col-xs-12">
                <span><spring:message code="S00007"/></span>
            </div>
        </div>
    	<div class="user_main_area">
    		<div class="main_area main1" style="border-bottom:transparent">
    			<p class="user_txt user_tit"><spring:message code="S00010"/></p>
    			<p class="user_txt user_desc"><spring:message code="S00011"/></p>
    			<button class="user_btn_list" id="targetGroupListPopupBtn">
    				<spring:message code="S00012"/>
    			</button>
    		</div>
    		<!-- 2018.01.04 전화영 세그먼트 선택 버튼 제외 -->
<!--     		<div class="main_area main2"> -->
<%--     			<p class="user_txt user_tit"><spring:message code="M01690"/></p> --%>
<%--     			<p class="user_txt user_desc"><spring:message code="M01691"/></p> --%>
<!--     			<button class="user_btn_list" id="segmentListOpenBtn"> -->
<%--     				<spring:message code="M01469"/> --%>
<!--     			</button> -->
<!--     		</div> -->
    	</div>
    </div>
    <div class="well form-horizontal well_wrap pad0" id="targetGroupMain_con">
    </div>
</div>

<div id="targetGroupListPopup" class="popup_container"></div>