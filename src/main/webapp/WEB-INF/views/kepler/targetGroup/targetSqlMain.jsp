<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var extrYn = "";
targetSqlMain = function() {
    this.saveBtnHide = false;
    
    var flag;
    try {flag = workflowFlag} catch(exception){ flag = false}
    
    if (flag) {
        this.saveBtnHide = true;
    }
}

//타겟그룹 목록 팝업 열기
targetSqlMain.prototype.targetSqlListPopupOpen = function() {
	$("#targetSqlListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="targetSqlListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M02853" />',
        width: 680,
        close : 'targetSqlMain.targetSqlListPopupClose'
    });
}

//팝업 닫기
targetSqlMain.prototype.targetSqlListPopupClose = function() {
    targetSqlListPopup._destroy();
}

//타겟그룹 선택시
targetSqlMain.prototype.targetSqlSelect = function() {
    var _this = this;
    
    _this.targetSqlListPopupClose();
    
    if ($.fn.ifvmIsNotEmpty(targetSqlListPopGrid.getCheckedList())) {
        var targetGroupId = targetSqlListPopGrid.getCheckedList()[0].targetGroupId;   //타겟그룹 아이디
        extrYn = targetSqlListPopGrid.getCheckedList()[0].extrYn;   //카페24
        
      	//타겟그룹 상세화면 Load
        _this.targetSqlDetailLoad(targetGroupId);
    }
}

//타겟그룹 상세화면 Load
targetSqlMain.prototype.targetSqlDetailLoad = function(targetGroupId) {
	if (targetGroupId != null && targetGroupId != "") {
	    $.ifvSyncPostJSON('<ifvm:action name="getTargetCafe24YnFlag"/>', {
	        targetGroupId: targetGroupId
	    },
	    function(resultExtr) {
	    	extrYn = resultExtr.extrYn;
	    });
	}
    //main화면 숨김
    $("#targetSqlMain_top").hide();
    
  	//content 화면 보이기
    $("#targetSqlMain_con").show();
    //타겟그룹 상세화면 Load
    if (targetGroupId != null && targetGroupId != "") {
	    if(extrYn=="Y"){
	    	$.fn.ifvmLoadUiSetting("targetSqlMain_con", '<ifvm:url name="targetCafe24DetailLoad"/>' + '?targetGroupId=' + targetGroupId);
	    	extrYn=""
	    }else{
	   	    $.fn.ifvmLoadUiSetting("targetSqlMain_con", '<ifvm:url name="targetSqlDetailLoad"/>' + '?targetGroupId=' + targetGroupId);
	    }
    } else {
	    if(extrYn){
	    	$.fn.ifvmLoadUiSetting("targetSqlMain_con", '<ifvm:url name="targetCafe24DetailLoad"/>' + '?targetGroupId=' + targetGroupId);
	    }else{
	   	    $.fn.ifvmLoadUiSetting("targetSqlMain_con", '<ifvm:url name="targetSqlDetailLoad"/>' + '?targetGroupId=' + targetGroupId);
	    }
    }
    //저장 버튼 추가
    var tmpl = $("#targetSqlMainSaveBtnTemp").tmpl();        
    $("#targetSqlDetailBtn_area").append(tmpl);
    
    //버튼 회색으로
    $("#targetSqlMain_con .btn").addClass("btn_gray");
    
    $("#targetSqlDtlSaveBtn").hide();
    
    $("#targetSqlMainSaveBtn").on("click", function(){
	    targetSqlMain.campaignTargetGroupSave();
	});
    //목록 이벤트 삭제
    $('#targetGroupListBtn').off();
    //목록 재정의
    $('#targetGroupListBtn').on("click", function(){
    	targetSqlMain.targetSqlMainLoad();
    });
    
    if (this.saveBtnHide) {
        $("#targetSqlMainSaveBtn").hide();
    }
}

//타겟그룹 목록화면 Load
targetSqlMain.prototype.targetSqlMainLoad = function() {
    //content 화면 숨기기
    $("#targetSqlMain_con").hide();
    $("#targetSqlMain_con").html("");
    
    //main화면 보이기
    $("#targetSqlMain_top").show();
    
}

//캠페인 타겟그룹 저장
targetSqlMain.prototype.campaignTargetGroupSave = function() {
	saveCampaignTarget();
}

var targetSqlMain;
$(document).ready(function() {
	
	targetSqlMain = new targetSqlMain();

    //타겟SQL 목록 호출
    $('#targetSqlListOpenBtn').on('click', function() {
    	targetSqlMain.targetSqlListPopupOpen();
    });

    //타겟SQL 신규화면 호출
    $('#targetSqlNewPageOpenBtn').on('click', function() {
    	targetSqlMain.targetSqlDetailLoad('');
    });
});

</script>

<script id="targetSqlMainSaveBtnTemp" type="text/x-jquery-tmpl">
<button class="btn btn-sm btn_gray" id="targetSqlMainSaveBtn">    
	<i class="glyphicon glyphicon-check"></i>     
	<spring:message code="M00280"/>
</button>
</script>

<div id="targetSqlMain_wrap">
	<div id="targetSqlMain_top">
	    <div class="page_btn_area">
	        <div class="col-xs-12">
	            <span><spring:message code="M01494"/></span>
	        </div>
	    </div>
	    <div class="user_main_area">
	        <div class="main_area main1">
	            <p class="user_txt user_tit"><spring:message code="M02854"/></p>
	            <p class="user_txt user_desc"><spring:message code="M02851"/></p>
	            <button class="user_btn_list" id="targetSqlListOpenBtn" objCode="targetSqlListOpenBtn_OBJ">
	                <spring:message code="M02853"/>
	            </button>
	        </div>
	        <div class="main_area main2">
	            <p class="user_txt user_tit"><span><spring:message code="M02856"/></span></p>
	            <p class="user_txt user_desc"><spring:message code="M02852"/></p>
	            <button class="user_btn_list" id="targetSqlNewPageOpenBtn" objCode="targetSqlNewPageOpenBtn_OBJ">
	                <spring:message code="M02850"/>
	            </button>
	        </div>
	    </div>
	</div>
    <div class="well form-horizontal well_wrap pad0" id="targetSqlMain_con">
    </div>
</div>

<div id="targetSqlListPopup" class="popup_container"></div>
