<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var validation;
var PwChk = false;
//타겟 레벨 조회
function getTargetLevel(){
	var serviceNmDis = document.getElementById('serviceNm');
	serviceNmDis.disabled = true;	
	
	$.ifvSyncPostJSON('<ifvm:action name="getDtlTgtLevel"/>',{id : targetLevelId}
		,function(result) {
			
			$("#targetLevelNm").val(result.targetLevelNm);
			$("#dbNm").val(result.dbNm);
			$("#conDbType").val(result.conDbTypeCdNm);
			$("#conIp").val(result.conIp);
			$("#conPort").val(result.conPort);
			$("#conId").val(result.conId);
			$("#conPw").val(result.conPw);
			$("#targetDesc").val(result.targetDesc);
			/* $("#empName").val(result.createBy); */
			$("#createDate").val(result.createDate);
			$("#serviceNm").val(result.serviceNm);
		});
}

//타겟 레벨 수정
function modifyTargetLevel(){
	
	var obj = {};	
	validation = $("#targetLvelPopFormArea").ifvValidation();
	
	if(validation.confirm()){
		obj.id = targetLevelId;
		obj.targetLevelNm = $("#targetLevelNm").val();
		obj.dbNm = $("#dbNm").val();
		obj.conDbType = $("#conDbType").val();
		obj.conIp = $("#conIp").val();
		obj.conPort = $("#conPort").val();
		obj.conId = $("#conId").val();
		obj.conPw = $("#conPw").val();
		obj.targetDesc = $("#targetDesc").val();
		obj.serviceNm = $("#serviceNm").val();
		obj.pwChk = PwChk
		$.ifvSyncPostJSON('<ifvm:action name="editOutTgtLvl"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			targetLevelListInit();
			adminTargetingPopClose();
		});
	}
}

//타겟 레벨 저장
function setTargetLevel(){
	var obj = {};
	validation = $("#targetLvelPopFormArea").ifvValidation();

	var regExp = /^[A-Za-z0-9/_+=.@-]+]*$/;
	if (!regExp.test($("#serviceNm").val())) {
		$.ifvCallValidationBox($("#serviceNm"), '서비스명은 영숫자와 /_+=.@- 문자만 포함해야 합니다.');
		return false;
	}
	
	if(validation.confirm()){
		obj.targetLevelNm = $("#targetLevelNm").val();
		obj.dbNm = $("#dbNm").val();
		obj.conDbType = $("#conDbType").val();
		obj.conIp = $("#conIp").val();
		obj.conPort = $("#conPort").val();
		obj.conId = $("#conId").val();
		obj.conPw = $("#conPw").val();
		obj.targetDesc = $("#targetDesc").val();
		obj.pwChk = PwChk
		obj.serviceNm = $("#serviceNm").val();
		$.ifvSyncPostJSON('<ifvm:action name="setTgtLevel"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			targetLevelListInit();
			adminTargetingPopClose();
		});
	}
}

//공통코드 조회 - db 유형
function dbType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'CHNL_CON_DB_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#dbTypeTemplate").tmpl(result.rows);
		$("#conDbType").append(temp);
	});
}; 


$(document).ready(function(){
	$("#targetLvelPopFormArea").ifvValidation();
	dbType();
	if(targetLevelId != null) getTargetLevel();
	$("#targetLevelPopCancel").on("click", adminTargetingPopClose);
	
	$("#targetLevelSaveBtn").on("click", function(){
		if(targetLevelId != null) modifyTargetLevel();
		else setTargetLevel();
	});
	
	
	$("#conPw").on("change", function(){
		PwChk= true;
	});
	
});
</script>

<script id="dbTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='targetLvelPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01122"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="targetLevelNm" required="true" maxLength="50"/>
	        </div>
	         <label class="col-xs-2 control-label"><span class="asterisk">*</span>서비스명</label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="serviceNm" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01123"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="conDbType" required="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01124"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="dbNm" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01125"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="conIp" required="true" maxLength="200"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01126"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="conPort" required="true" maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01127"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="conId" required="true" maxLength="30"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01128"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="password" id="conPw" required="true" maxLength="30"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01129"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="textarea" id="targetDesc" rows="3" maxLength="100"/>
	        </div>
	    </div>
	    <div class="row">
	        <label class="col-xs-2 control-label"><%-- <spring:message code="M01131"/> --%></label>
	        <div class="col-xs-4 control_content">
	            <%-- <ifvm:input type="text" id="empName" disabled="true" /> --%>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01132"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="createDate" disabled="true" />
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="targetLevelSaveBtn" objCode="targetLevelPopSave_OBJ">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="targetLevelPopCancel" objCode="targetLevelPopCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>