<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>

var brdCd=null;

var sndSubSid=null;
var sndBrdCd=null;
var evtSubsidryId=null;
var evtBrandId=null;
var evtStoreId=null;
var sndSubsidryId=null;
var sndBrandId=null;
var sndStoreId=null;

function initStoreEditPop(){
    var selObj=campaignStoreGrid.opt.gridControl.getSelectedRecords();
    var id=selObj[0].id;
    evtSubsidryId = selObj[0].evtSubsidryId;
    evtBrandId = selObj[0].evtBrandId;
    evtStoreId = selObj[0].evtStoreId;
    sndSubsidryId = selObj[0].sndSubsidryId;
    sndBrandId = selObj[0].sndBrandId;
    sndStoreId = selObj[0].sndStoreId;
    
	$("#subSid").attr("required", true);
	$("#brdCd").attr("required", true);
	$("#storeCd").attr("required", true);
	$("#sndSubSid").attr("required", true);
	$("#sndBrdCd").attr("required", true);
	$("#sndStoreCd").attr("required", true);
}



/* 계열사 리스트  */
function getSubsidaryList(){
    
	$("#subSid").append("<option value=''></option>");
	$.ifvSyncPostJSON('<ifvm:action name="getChnlCd"/>', {
    }, function(result) {
		for(var i=0;i<result.length;i++){
			if(evtSubsidryId==result[i].rid)
     			$("#subSid").append("<option value='"+result[i].rid+"' selected >"+result[i].subSid+"</option>");
			else
				$("#subSid").append("<option value='"+result[i].rid+"' >"+result[i].subSid+"</option>");
     	}
    });
 }
 
/*브랜드 리스트*/
function getBrdCd(subSid){
	$("#brdCd").append("<option value=''></option>");

	if(subSid==null){
		subSid=$("#subSid").val();
	}
	
	$.ifvSyncPostJSON('<ifvm:action name="getBrdCdByRid"/>', {
	       subSid:subSid
    }, function(result) {
    	   	for(var i=0;i<result.length;i++){
    	   		if(evtBrandId==result[i].rid)
		     		$("#brdCd").append("<option value='"+result[i].rid+"' selected >"+result[i].brdCd+"</option>");
    	   		else
    	   			$("#brdCd").append("<option value='"+result[i].rid+"' >"+result[i].brdCd+"</option>");
    	   	}
    });
}

/* 지점 리스트  */
function getStoreCd(brdCd){
	$("#storeCd").append("<option value=''></option>");
	
	if(brdCd==null){
		brdCd=$("#brdCd").val();
	}
	
	$.ifvSyncPostJSON('<ifvm:action name="getStoreCdByRid"/>', {
		brdCd:brdCd
 },
 function(result) {

	for(var i=0;i<result.length;i++){
		if(evtStoreId==result[i].rid)
  			$("#storeCd").append("<option value='"+result[i].rid+"' selected >"+result[i].storeCd+"</option>");
		else
			$("#storeCd").append("<option value='"+result[i].rid+"'>"+result[i].storeCd+"</option>");
	}
 });
}


/* 하위 계열사 리스트  */
function getSndSubsidaryList(){
    
	$("#sndSubSid").append("<option value=''></option>");
	$.ifvSyncPostJSON('<ifvm:action name="getSndChnlCd"/>', {
    }, function(result) {
		for(var i=0;i<result.length;i++){
			if(sndSubsidryId==result[i].rid)
     			$("#sndSubSid").append("<option value='"+result[i].rid+"' selected >"+result[i].sndSubSid+"</option>");
     		else
     			$("#sndSubSid").append("<option value='"+result[i].rid+"'>"+result[i].sndSubSid+"</option>");
		}
    });
 }
 
/*하위 브랜드 리스트*/
function getSndBrdCd(sndSubSid){
	$("#sndBrdCd").append("<option value=''></option>");

	if(sndSubSid==null){
		sndSubSid=$("#sndSubSid").val();
	}
	
	$.ifvSyncPostJSON('<ifvm:action name="getSndBrdCd"/>', {
	       sndSubSid:sndSubSid
    }, function(result) {
    	   	for(var i=0;i<result.length;i++){
    	   		if(sndBrandId==result[i].rid)
		     		$("#sndBrdCd").append("<option value='"+result[i].rid+"' selected >"+result[i].sndBrdCd+"</option>");
    	   		else
    	   			$("#sndBrdCd").append("<option value='"+result[i].rid+"'>"+result[i].sndBrdCd+"</option>");
    	   	}
    });
}

/* 하위 지점 리스트  */
function getSndStoreCd(sndBrdCd){
	$("#sndStoreCd").append("<option value=''></option>");
	
	if(sndBrdCd==null){
		sndBrdCd=$("#sndBrdCd").val();
	}
	
	$.ifvSyncPostJSON('<ifvm:action name="getSndStoreCd"/>', {
		sndBrdCd:sndBrdCd
 },
 function(result) {

	for(var i=0;i<result.length;i++){
		if(sndStoreId==result[i].rid)
  			$("#sndStoreCd").append("<option value='"+result[i].rid+"' selected>"+result[i].sndStoreCd+"</option>");
		else
			$("#sndStoreCd").append("<option value='"+result[i].rid+"'>"+result[i].sndStoreCd+"</option>");
	}
 });
}

$(document).ready(function() {
	initStoreEditPop();
	getSubsidaryList();
	getSndSubsidaryList();
	getBrdCd(evtSubsidryId);
	getStoreCd(evtBrandId);
	getSndBrdCd(sndSubsidryId);
	getSndStoreCd(sndBrandId);
	
	
	$('#subSid').change(function() {
		var subSid = $(this).val();
	 	$("#brdCd").children().remove();
	 	$("#storeCd").children().remove();
		getBrdCd(subSid);

	});
	//브랜드 변경시
	$('#brdCd').change(function() {
		var brdCd = $(this).val();
		$("#storeCd").children().remove();
		getStoreCd(brdCd);
	});
	
	$('#sndSubSid').change(function() {
		var sndSubSid = $(this).val();
	 	$("#sndBrdCd").children().remove();
	 	$("#sndStoreCd").children().remove();
		getSndBrdCd(sndSubSid);

	});
	//하위 브랜드 변경시
	$('#sndBrdCd').change(function() {
		var sndBrdCd = $(this).val();
		$("#sndStoreCd").children().remove();
		getSndStoreCd(sndBrdCd);
	});
	
	//닫기 클릭시
	$('#editStorePopCloseBtn').on('click', function(){
		editStorePopupClose();
    });
	
	//저장 클릭시
	$('#editStorePopSaveBtn').on('click', function(){
		if(storeCd.selectedIndex==0 || sndStoreCd.selectedIndex==0){
			alert("모든 값은 필수입니다.")
		}else{
		editCampaignStore();
		}
    });
	
	
});

</script>
<div>
	<div class="row qt_border">
		<label class="col-xs-2 control-label">이벤트 발생점</label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="select" id="subSid" names="subSid" required="true"/>
	        </div>
	        <div class="col-xs-3 control_content">
	            <ifvm:input type="select" id="brdCd" names="brdCd" required="true"/>
            </div>
	        <div class="col-xs-3 control_content">
	            <ifvm:input type="select" id="storeCd" names="storeCd" required="true"/>
	            <input type="hidden" id="rid" names="rid"/>
	        </div>     
	</div>
	  
	<div class="row qt_border">
		<label class="col-xs-2 control-label">메시지 전송점</label>
			<div class="col-xs-3 control_content">
				<ifvm:input type="select" id="sndSubSid" names="sndSubSid" required="true"/>
	        </div>
	        <div class="col-xs-3 control_content">
	            <ifvm:input type="select" id="sndBrdCd" names="sndBrdCd" required="true"/>
			</div>
			<div class="col-xs-3 control_content">
				<ifvm:input type="select" id="sndStoreCd" names="sndStoreCd" required="true"/>
			</div>
	</div>
	  
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="editStorePopSaveBtn">
			<i class="glyphicon glyphicon-check"></i>
		        <spring:message code="M00137"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="editStorePopCloseBtn">         
		        <spring:message code="M00441"/>
		</button> 
	 </div>
	 
</div>