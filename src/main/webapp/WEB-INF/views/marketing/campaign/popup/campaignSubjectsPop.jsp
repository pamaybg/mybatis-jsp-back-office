<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var camId = "";    //캠페인 아이디
var workflowFlag = true;    //세그먼트 저장시 사용

//Init
function campaignSubjectsPopInit() {
    cDialog.model.title = '<spring:message code="M00823"/>';
    $("#dialog_title").append('<spring:message code="M00823"/>');
    cDialog.model.width = "1090";
    cDialog.model.close = "closeCampaignSubjectsPop";
}

//dialog close
function closeCampaignSubjectsPop(args) {
    cDialog._destroy();
}

//Init Data
function campaignSubjectsPopInitData() {
	//reset value
	camId = diagram._selectedObject.actualTaskId;
    	
    //load targeting contents
    loadTargetingCon();
    
    //get campaign info
    if (isNotEmpty(camId)) {
	    $.ifvPostJSON('<ifvm:action name="getQuickCampaign"/>',{ 
	        camId : camId 
	        }
	        ,function(result) {
	        	setCampaignSubjectsPop(result);
	        }           
	    );
    }
    
    //get chnl type
    $("#chnlType").val(getChnlType());
    
    //피로도 제외여부
    if (getFatigueExcept()) {
        $("input:checkbox[id='fatigueExcept']").attr("checked", true);
    }
}

//세그먼트 화면 설정(기존 세그먼트가 있으면 불러온다.)
function setCampaignSubjectsPop(result) {
	//세그먼트 조회
    if(result.segItem != null && result.segItem.length > 0){
        
        if(result.segItem[0].segType == 'file'){
            $("#uploadRadio").click();
            
            //최종저장 시 사용 객체
            saveTargetObj.dupCnt = result.dupCnt;
            saveTargetObj.allUploadCnt = result.targetCustCnt;
            saveTargetObj.fileName = result.segItem[0].fileName;
            saveTargetObj.memberList = result.memberList;
            saveTargetObj.successCnt = result.agreeCust;
            saveTargetObj.failCnt = result.segItem[0].fileFailCnt;
            
            $('input:radio[name=memType]:input[value=' + result.segItem[0].memType + ']').attr("checked", true);
            
            //파일 순서 결정
            if( $(':radio[name="memType"]:checked').val() != 'internal'){
                result.memberList.sort(function(a,b){return a.memSeq - b.memSeq});
            }
            
            $("#fileConfirmTextArea").text("<spring:message code='M00687'/>");
            gridData = null;
            $("#uploadMemberInfoGrid").empty();
            
            //업로드 결과 회원 정보 조회
            gridData = result.memberList;
            uploadMemberInfoGridFunc();
            
            //업로드 결과 건수 조회
            var resultGridList = new Array();
            var resultAllCnt = {};
            var resultSuccessCnt = {};
            var resultFailCnt = {};
            
            resultAllCnt.name = "<spring:message code='M00700'/>";
            resultAllCnt.uploadCnt = result.targetCustCnt;
            
            resultSuccessCnt.name = "<spring:message code='M00701'/>";
            resultSuccessCnt.uploadCnt = result.agreeCust;
            
            resultFailCnt.name = "<spring:message code='M00702'/>";
            resultFailCnt.uploadCnt = result.segItem[0].fileFailCnt;
            
            resultGridList.push(resultAllCnt);
            resultGridList.push(resultSuccessCnt);
            resultGridList.push(resultFailCnt);
            
            uploadData = resultGridList;
            uploadResultNumberGridFunc();
            
            $("#uploadResult").show();
            
            //결과화면 출력
            $("#savedArea").show();
            $("#segNameTxt").text(result.segItem[0].segName);
            
            
        }
        else{
            
            $("#segmentRadio").click();
            var obj = $.ifvCachedHtml('<ifvm:url name="userTargetingLoad"/>');
            $('#segmentContent').html(obj.responseText);
            loadUiSetting();
            targetLevelId = result.segItem[0].targetLevelId;
            confilterid = result.segItem[0].segId;
            init(); 
        }
    }
}

//세그먼트 화면 Load
var quickFlag = true;
function loadTargetingCon() {
	var obj = $.ifvCachedHtml('<ifvm:url name="fileUpload"/>');
    $('#targetingContents').html(obj.responseText);
	
    loadUiSetting();
    
    setPopHeight();
    
   
}

function setPopHeight(){
	//set height
    new ifvm.PopupHeight({
        popupDivId : 'dialog',
        contentsId : 'dialogPopupWrap'
    });
}

//load시 필요없는 항목 제거
function loadUiSetting(){
	$('.page-title').remove();
    $('.campaign_load_contents #header').remove();
    $('.campaign_load_contents #sideMenu').remove();
    $('.campaign_load_contents .page-title').remove();
    $("#contentsMessage .btn").addClass("btn_gray");
    
    $("#targetSegmentSaveBtn").hide();
    $("#targetSaveBtn").hide();
}

//저장
function campaignSubjectsSaveBtn() {
	var targetingType = $('input:radio[name="targetMethod"]:checked').val();
	var saveFlag = false;
	
	camId = campaign.id;
	
	//targeting 방법에 따른 저장
	//세그먼트
	if (targetingType == "segment") {
	    $("#targetSegmentSaveBtn").trigger("click");
	    saveFlag = true;
	} 
	//업로드
	else if (targetingType == "upload") {
	    $("#targetSaveBtn").trigger("click");
	    saveFlag = true;
	}
	
	//캔버스 저장
	if (saveFlag) {
	 diagram._selectedObject.taskType = diagram._selectedObject.nodeType;
	 diagram._selectedObject.taskDataStatus = "U";
	 
	    //set actual task ID
	    diagram._selectedObject.actualTaskId = campaign.id;
	 
	    //set campaign ID
	    diagram._selectedObject.campaignId = campaign.id;
	    
	    //set old campaign ID
	    diagram._selectedObject.oldCampaignId = campaign.id;
	    
	    //set alertFlag(현재 팝업에서 저장 alert창이 발생하여 중복 발생하지 않기 위해..)
	    workflow.alertFlag = false;
	    
	  	//save workflow
        saveWorkflow();
	}
}

//취소
function campaignSubjectsCancelBtn() {
	closeCampaignSubjectsPop();
}

$(function () {
	campaignSubjectsPopInit();
	campaignSubjectsPopInitData();
	
	//저장 클릭시
    $('#campaignSubjectsSaveBtn').on('click', function(){
    	campaignSubjectsSaveBtn();
    });
	   
    //취소 클릭시
    $('#campaignSubjectsCancelBtn').on('click', function(){
    	campaignSubjectsCancelBtn();
    });
    
    //Targeting 변경으로 인한 팝업 크기 조절
    $('input:radio[name="targetMethod"]').on('click', function(){
    	setTimeout(function(){
    		setPopHeight();
    	}, 100);
    });
  
});
</script>

<div id="dialogPopupWrap">
    <input type="hidden" id="chnlType" value="">
    <input type="checkbox" id="fatigueExcept" style="visibility:hidden">
    
	<div class="pop_inner_wrap form-horizontal">
        <div class="row group_box_line popup_contents_height" id=targetingContents>
        </div>
    </div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="campaignSubjectsSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00280"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="campaignSubjectsCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>