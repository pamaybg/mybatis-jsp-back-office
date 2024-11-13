<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var resourceListGrid;
//model
var campaignResource;
//model 정의
function initModels(data) {
	var infoModel = function(data) {
		
		//data set
		this.camResource = data;
		//캠페인아이디
        this.camResource.campaignId = campaign.id;
		
		campaignResource = this;
	};
	 
	//konckout bindings
	 myObservableArray: ko.observableArray(/* array of any complex obects */)
	ko.applyBindings(new infoModel(data), document.getElementById("campaignResourcePop") );
}

//캠페인기본정보 호출
function getCampaignResource() {
	
	
    var jqGridOption = {
            onSelectRow : function (data) {
               
            },
            serializeGridData : function( data ){
                return data;
            },
            colNames:[ '유형',
                       '유효시작일',
                       '수량',
                       '단위',
                       '비고',
                       'id'
                     ],
            colModel:[
                { name:'campaignName', index:'c.CAM_NM', resizable : false },
                { name:'campaignStartDate', index:'c.CAM_START_DD', resizable : false },
                { name:'campaignEndDate', index:'c.CAM_END_DD', resizable : false },
                { name:'campaignStatusCodeName', index:'c2.MARK_NAME', resizable : false },
                { name:'campaignPlannerName', index:'e.NAME', resizable : false },
                { name:'id', index:'c.id', hidden : true }
                
            ],
            radio: true,
        };
    resourceListGrid = $("#resourceListGrid").ifvGrid({ jqGridOption : jqGridOption });	
	
	
};

//dialog close
function closeCampaignResourcePop(args) {
	//
	campaignDefaultInfo = {};
	//dialog 파괴
	cDialog._destroy();
}

//캠페인기본정보 저장
function saveCampaignDefaultInfo() {
    //달력 binding 안되는 현상 발생 값을 찾아 넣어준다.
    campaignDefaultInfo.camDefaultInfo.campaignStartDate = $("#campaignStartDate").val();
    campaignDefaultInfo.camDefaultInfo.campaignEndDate = $("#campaignEndDate").val();
    
    if($.fn.ifvmGetUrl().match("campaignList")) {
        $.ifvSyncPostJSON('<ifvm:action name="saveCampaignDefaultInfo"/>', 
            campaignDefaultInfo.camDefaultInfo
        ,
        function(result) {
            campaignDefaultInfo = {};
            cDialog._destroy();
            alert('<spring:message code="M00152" />');
    
            campaign.selRow = campaignListGrid.getCheckedGridData()[0].rowId;
            getCampaignList();
            
        });
    } else {
        //데이터 유형 : 캠페인정보 : INFO
        diagram._selectedObject.taskType = "INFO";
        //다이어그램 nodeset data
        diagram._selectedObject.data.campaignDefaultInfo = campaignDefaultInfo.camDefaultInfo;
        cDialog._destroy();
    }
}

//달력
function setCalendarDate() {
    var startDate = $("#campaignStartDate");//changeTypeArea.find(".start_date").find('input'); 
    var endDate = $("#campaignEndDate");//changeTypeArea.find(".end_date").find('input'); 
    startDate.val($.ifvGetTodayDate());
    endDate.val($.ifvGetNewDate('m', 1).newDateS);
    
    startDate.ifvDateChecker({
        maxDate : endDate,
    });
    
    endDate.ifvDateChecker({
        minDate : startDate,
    });
}

//캠페인기본정보 팝업 설정
function campaignResourcePopInit() {
  
    //팝업설정
    cDialog.model.title = "";
    $("#dialog_title").append("예산 및 자원 정보");
    cDialog.model.width = "600";
    cDialog.model.close = "closeCampaignInfoPop";
    
    /* wfDialog.setModel({
        title: "기본정보",
        width: "600",
        close: "closeCampaignInfoPop",
    }); */
    
}

$(function () {
	//캠페인기본정보 폼 설정
	campaignResourcePopInit();
	//캠페인 자원 데이터 호출
	getCampaignResource();
	
	//저장 클릭시
    $('#campaignInfoPopSaveBtn').on('click', function(){
    	saveCampaignDefaultInfo();
    });
	
    //draft 완료 클릭시
    $('#campaignInfoPopDramftSaveBtn').on('click', function(){
        saveCampaignDefaultInfo();
    });
	   
    //취소 클릭시
    $('#campaignInfoPopCancelBtn').on('click', function(){
    	closeCampaignInfoPop();
    });
    
});
</script>

<style>
.campaignInfoTextarea{height:60px;}
</style>

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap">
	    <div class="form-horizontal" id="campaignResourcePop">
	        <div id="resourceListGrid" style="width:550px;"data-bind="koGrid: { data: camResource.resourceList }"></div>
	    </div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="campaignInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00280"/>
	    </button> 
	    <button class="btn btn-sm btn_gray" id="campaignInfoPopDramftSaveBtn">
			<spring:message code="M00286"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2 cancel" id="campaignInfoPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>