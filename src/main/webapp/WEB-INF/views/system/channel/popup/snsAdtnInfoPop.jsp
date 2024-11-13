<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var rowid = '<%= cleanXss(request.getParameter("id")) %>';
var chilId = '<%= cleanXss(request.getParameter("chilId")) %>';
var childetail = true; 
var changeChk2= false;
var InfoValidation;

function snSdetailCheck(){
	
	if(chilId == "null"){
		childetail = false;
	}
	else{
		initSnsSetting();
	}
}

function initSnsSetting(){
	
	if(childetail){
		$.ifvSyncPostJSON('<ifvm:action name="getDetailSnsAdtnInfo"/>', {
			  id : chilId
		}, function(result) {
			$("#id").val(chilId);
			$("#snsPageId").val(result.snsPageId);
		    $("#appId").val(result.appId);
		 	$("#appSecurCode").val(result.appSecurCode);
		    $("#snsPageDesc").val(result.snsPageDesc);
		});
	}
}

function saveSnsAdtnInfo(){
	if(InfoValidation.confirm() == false ) return;
	//수정
	if(childetail){
		$.ifvSyncPostJSON('<ifvm:action name="updateSnsAdtnInfo"/>', {
			 id : chilId
			 , mktChnlId 	: rowid
			 , snsPageId 	: $("#snsPageId").val()
			 , appId 		: $("#appId").val()
			 , appSecurCode : $("#appSecurCode").val()
			 , snsPageDesc 	: $("#snsPageDesc").val()
		}, function(result) {
			snsAdditionalInfoGrid.searchGrid();
			alert('<spring:message code="M00429"/>');
		},function(result) {   
			check = false;
			if(result.errorType == "900100") alert('<spring:message code="M01289"/>');
		});
	}
	//신규
	else{
		$.ifvSyncPostJSON('<ifvm:action name="insertSnsAdtnInfo"/>', {
			 mktChnlId 	 	: rowid
			 , snsPageId 	: $("#snsPageId").val()
			 , appId 		: $("#appId").val()
			 , appSecurCode : $("#appSecurCode").val()
			 , snsPageDesc 	: $("#snsPageDesc").val()
		}, function(result) {
			alert('<spring:message code="M00152"/>');
			snsAdditionalInfoGrid.searchGrid();
		},function(result) {   
			check = false;
			if(result.errorType == "900100") alert('<spring:message code="M01289"/>');
		});
	}
	snsAdtnInfoPopupClose();
}

$(document).ready(function(){
	InfoValidation = $("#capacityWrap").ifvValidation();
	
	snSdetailCheck();
	
	$('#snsAdtnInfoSelectBtn').on('click', function(){
		saveSnsAdtnInfo();
	});
	
	$('#snsAdtnInfoCancelBtn').on('click', function(){
		snsAdtnInfoPopupClose();
	});
	
});
</script>

<div id="capacityWrap">
	<div class="pop_inner_wrap form-horizontal">
		<div class="row qt_border">
			<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M02135"/></label>
			<div class="col-xs-8 control_content">
				<ifvm:input type="text" required="true" id="snsPageId"/>				
			</div>
			<div class="col-xs-8 control_content">
				<ifvm:input type="hidden" id="id" />				
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M02136"/></label>
			<div class="col-xs-8 control_content">
				<ifvm:input type="text" required="true" id="appId"/>				
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M02137"/></label>
			<div class="col-xs-8 control_content">
				<ifvm:input type="password" required="true" id="appSecurCode"/>				
			</div>
		</div>
		<div class="row">
			<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M02138"/></label>
			<div class="col-xs-8 control_content">
				<ifvm:input type="textarea" required="true" className="text_description text_description_150" id="snsPageDesc" maxLength="200" placeholder="M02231"/>				
			</div>
		</div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="snsAdtnInfoSelectBtn" objCode="snsAdtnInfoSelect_OBJ">
			<i class="glyphicon glyphicon-check"></i>
			<spring:message code="M00280"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="snsAdtnInfoCancelBtn" objCode="snsAdtnInfoCancel_OBJ">         
			<spring:message code="M00284"/>
		</button> 
	</div>
</div>