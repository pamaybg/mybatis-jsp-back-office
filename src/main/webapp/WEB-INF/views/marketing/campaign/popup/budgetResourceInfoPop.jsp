<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var budgetResourceGrid;
var gridIdbudgetResourceGrid;
//model
var campaignResource = {
        resourceList: []
};
//validation
var budgetResourceInputValidation;

//예산 및 자원 정보 목록
function getBudgetResourceList(){
	var jqGridOption = {
	    loadComplete : function(obj){
	    },
	    onSelectRow : function (data) {
	        
	    },
	    serializeGridData : function( data ){
	        
	    },
	    data : campaignResource.resourceList,
	    datatype: 'clientSide',
	    colNames:[ 
	               '<spring:message code="M00755"/>',
	               '<spring:message code="M00788"/>',
	               '<spring:message code="M00786"/>',
	               '<spring:message code="M00787"/>',
	               '<spring:message code="M00600"/>',
	               //'id'
	             ],
	    colModel:[
	        
	        { name:'resourceTypeCodeName', index:'', sortable : false, width:'100px', align:'center', resizable : false },
	        { name:'itemName', index:'', sortable : false, resizable : false },
	        { name:'resourceUseAmt', index:'', sortable : false, resizable : false, width:'100px', align:'right', formatter:numberFormat},
	        { name:'resourceUseUnitCodeName', index:'', sortable : false, width:'100px', align:'center', resizable : false },
	        { name:'resourceDtlDesc', index:'', sortable : false, resizable : false },
	        //{ name:'id', index:'', hidden : true }
	    ],
	    radio: true,
	    gridview:true,
	    tempId : 'ifvGridSimpleTemplete'
    };
    
	budgetResourceGrid = $("#budgetResourceGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdbudgetResourceGrid = $("#gridIdbudgetResourceGrid");
}

//숫자 콤마표시
function numberFormat(cellvalue, options, rowObjec) {
    var value = "";
    if (isNotEmpty(cellvalue)) {
        value = $.ifvNumberFormat(cellvalue);
    }
    
    return value;
}

//dialog close
function closebudgetResourcePop(args) {
	cDialog._destroy();
}

//budgetResourceInit
function budgetResourceInit() {
    pageSetUp();
    
    //유형
    $.fn.ifvmSetSelectOptionCommCode("resourceTypeCode", "MKT_RSRC_TYPE");
    //단위
    $.fn.ifvmSetSelectOptionCommCode("resourceUseUnitCode", "MKT_UNIT_CD");
    
    cDialog.model.title = '<spring:message code="M00783"/>';
    $("#dialog_title").append('<spring:message code="M00783"/>');
    cDialog.model.width = "600";
    cDialog.model.close = "closebudgetResourcePop";
    
    //validation
    budgetResourceInputValidation = $("#BudgetResourcePopInput").ifvValidation();
}

//budgetResourceInitData
function budgetResourceInitData() {
	//node data get/reset
    campaignResource = {resourceList: []};
	
    if ( $.fn.ifvmIsNotEmpty(diagram._selectedObject.data.campaignResource) 
    		&& $.fn.ifvmIsNotEmpty(diagram._selectedObject.data.campaignResource.resourceList) ) {
    	   $.each(diagram._selectedObject.data.campaignResource.resourceList, function(index, data) {
        		campaignResource.resourceList.push(data);
    	   });
    } else {
    	diagram._selectedObject.data.campaignResource = {resourceList: [] };
    }
    
    //캠페인 ID
    campaign.id = diagram._selectedObject.actualTaskId;
    
    //call 예산 및 자원 정보 조회
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignResource"/>', {
    	campaignId: campaign.id
    },
    function(result) {
    	if ($.fn.ifvmIsNotEmpty(result)) {
    		$.each(result.resourceList, function(index, data){
    			data.resourceUseAmt = Math.ceil(data.resourceUseAmt);
    		});
    		
    		campaignResource =  result;
    	}
    });
    
    //유형설정
    //diagram._selectedObject.taskType = "BUDGET";
    
    //예산 및 자원목록
    getBudgetResourceList();
}

//예산 및 자원 정보 input reset
function budgetResourceInputReset() {
	$("#resourceDtlDesc").val('');
    $("#resourceUseAmt").val('');
    $("#resourceUseUnitCode").val('');
    $("#resourceTypeCode").val('');
    $("#itemName").val('');
}

//예산 및 자원 정보 입력
function budgetResourcePopInputBtn() {
    //check validation
	if (budgetResourceInputValidation.confirm()) {
		var data = {
	            resourceDtlDesc: $("#resourceDtlDesc").val(),
	            resourceUseAmt: $("#resourceUseAmt").val(),
	            resourceUseUnitCode: $("#resourceUseUnitCode").val(),
	            resourceUseUnitCodeName: $("#resourceUseUnitCode :selected").text(),
	            resourceTypeCode: $("#resourceTypeCode").val(),
	            resourceTypeCodeName: $("#resourceTypeCode :selected").text(),
	            itemName: $("#itemName").val(),
	    };
	        
		if ($.fn.ifvmIsEmpty(data.resourceUseUnitCode)) {
		    data.resourceUseUnitCodeName = '';
		}
		if ($.fn.ifvmIsEmpty(data.resourceTypeCode)) {
		    data.resourceTypeCodeName = '';
		}
		
		//
		campaignResource.resourceList.push(data);
		//input 값들 초기화
		budgetResourceInputReset();
		
		//그리드 데이터 clear 후 데이터 재설정
		gridIdbudgetResourceGrid.clearGridData();
		gridIdbudgetResourceGrid.setGridParam({data: campaignResource.resourceList}).trigger("reloadGrid");
		
		new ifvm.PopupHeight({
            popupDivId : 'dialog',
            contentsId : 'dialogPopupWrap'
        });
	}
}

//예산 및 자원 정보 삭제
function budgetResourcePopRemoveBtn() {
    //삭제할 row id 및 index 찾기
    var _curr = $.fn.ifvmGridSelectRowIndex("gridIdbudgetResourceGrid");
    
    //삭제
    if (_curr >= 0) { 
    	campaignResource.resourceList.splice(_curr, 1);
    }
    
    //그리드 데이터 clear 후 데이터 재설정
    gridIdbudgetResourceGrid.clearGridData();
    gridIdbudgetResourceGrid.setGridParam({data: campaignResource.resourceList}).trigger("reloadGrid");
    
    new ifvm.PopupHeight({
        popupDivId : 'dialog',
        contentsId : 'dialogPopupWrap'
    });
}

//예산 및 자원 정보 저장
function budgetResourcePopSaveBtn() {
	diagram._selectedObject.data.campaignResource = campaignResource;
	diagram._selectedObject.taskDataStatus = getTaskStatusCode(campaignResource);
	campaignResource.dataStatus = getTaskStatusCode(campaignResource);
	campaignResource.campaignId = campaign.id;
	
    //call 예산 및 자원 정보 저장
    $.ifvSyncPostJSON('<ifvm:action name="saveCampaignResource"/>', 
    	campaignResource,
    function(result) {
    	//save workflow
        saveWorkflow();
    	
    	//close popup
    	closebudgetResourcePop();
    });
}

$(function () {
	budgetResourceInit();
	budgetResourceInitData();
	
	//입력 클릭시
    $('#budgetResourcePopInputBtn').on('click', function(){
    	budgetResourcePopInputBtn();
    });
	
    //삭제 클릭시
    $('#budgetResourcePopRemoveBtn').on('click', function(){
    	budgetResourcePopRemoveBtn();
    });
	
	//저장 클릭시
    $('#budgetResourcePopSaveBtn').on('click', function(){
    	budgetResourcePopSaveBtn();
    });
	
    //draft 클릭시
    $('#budgetResourcePopDraftBtn').on('click', function(){
    	budgetResourcePopSaveBtn();
    });
	   
    //취소 클릭시
    $('#budgetResourcePopCancelBtn').on('click', function(){
    	closebudgetResourcePop();
    });
    
});
</script>

<style>
.textHeight{height:69px;}
</style>

<div id="dialogPopupWrap">
    <div class="pop_inner_wrap form-horizontal">
		<header class="temp_title_bb">
			<spring:message code="M00784"/>
			<button class="btn_pop_white pop_top_btn" id="budgetResourcePopInputBtn" >
				<img src="<ifvm:image name='ico_input'/>" alt="" />
				<spring:message code="M00785"/>
			</button>
		</header>
        <div class="row qt_border" id="BudgetResourcePopInput">
        	<div class="col-xs-4">
        		<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M00755"/></label>
	            <div class="col-xs-8 half_bottom">
	                <ifvm:input type="select" required="true" id="resourceTypeCode" names="resourceTypeCode" />
	            </div>
        		<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M00786"/></label>
	            <div class="col-xs-8 half_bottom">
	                <ifvm:input type="number" required="true" maxLength="30" id="resourceUseAmt" />
	            </div>
	            <label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M00787"/></label>
	            <div class="col-xs-8 half_bottom">
	                <ifvm:input type="select" required="true" id="resourceUseUnitCode" names="resourceUseUnitCode" />
	            </div>
	            
        	</div>
        	<div class="col-xs-8">
	        	<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M00788"/></label>
	            <div class="col-xs-9 half_bottom">
	                <ifvm:input type="text" required="true" maxLength="30" id="itemName" />
	            </div>
        		<label class="col-xs-3 control-label"><spring:message code="M00600"/></label>
	            <div class="col-xs-9 half_bottom">
	                <ifvm:input type="textarea" className="textHeight" maxLength="200" id="resourceDtlDesc" />
	            </div>
	            
        	</div>
        </div>
        
        <header class="temp_title">
			<spring:message code="M00789"/>
			<button class="btn_pop_white pop_top_btn" id="budgetResourcePopRemoveBtn" >
				<img src="<ifvm:image name='btn_delete'/>" alt="" />
				<spring:message code="M00275"/>
			</button>
		</header>
        <div class="con_size grid_scroll3" id="budgetResourceGrid">
        </div>
    </div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="budgetResourcePopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00280"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2 cancel" id="budgetResourcePopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>
