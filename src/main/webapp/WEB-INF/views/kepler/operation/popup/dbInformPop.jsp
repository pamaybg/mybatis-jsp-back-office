<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var validation;
var PwChk = false;
var serviceNmchk = false;
var ipPortchk = false;
var oldServiceNm = null;
var sysdate = new Date();
var oldConPw = null;
var oldConIp = null;
var oldConPort = null;

//타겟 레벨 조회
function getDbInform(){
	var secretNmDis = document.getElementById('secretNm');
	secretNmDis.disabled = true;
	
		$.ifvSyncPostJSON('<ifvm:action name="getDbRegist"/>',{dbInformId : dbInformId}
		,function(result) {
			$("#serviceNm").val(result.serviceNm);
			$("#secretNm").val(result.secretNm);
			$("#conDbType").val(result.conDbType);
			$("#conIp").val(result.conIp);
			$("#conPort").val(result.conPort);
			$("#conId").val(result.conId);
			$("#conPw").val(result.conPw);
			$("#conUrl").val(result.conUrl);
			$("#dbDesc").val(result.dbDesc);
			$("#empName").val(result.createByName);
			$("#createDate").val((result.createDate).substring(0,10));	
			oldServiceNm = result.serviceNm;
			oldConPw = result.conPw;
			oldConIp = result.conIp;
			oldConPort = result.conPort;
		});
}

//타겟 레벨 수정
 function modifyDbInform(){
	var obj = {};	
	serviceNmchk = false;
	ipPortchk = false;
	validation = $("#dbInformPopFormArea").ifvValidation();
	
	var regExp = /^[A-Za-z0-9/_+=.@-]+]*$/;
/* 	if (!regExp.test($("#secretNm").val())) {
		$.ifvCallValidationBox($("#secretNm"), '서비스명은 영숫자와 /_+=.@- 문자만 포함해야 합니다.');
		return false;
	} */
	
	if(validation.confirm()){
		obj.dbInformId = dbInformId;
		obj.serviceNm = $("#serviceNm").val();
		obj.secretNm = $("#secretNm").val();
		obj.conDbType = $("#conDbType").val();
		obj.conIp = $("#conIp").val();
		obj.conPort = $("#conPort").val();
		obj.conId = $("#conId").val();
		obj.conPw = $("#conPw").val();
		obj.conUrl = $("#conUrl").val();
		obj.dbDesc = $("#dbDesc").val();
		obj.pwChk = PwChk
		if(oldConPw == $("#conPw").val()){
			obj.pwFlag = 'N';
		}else{
			obj.pwFlag = 'Y';
		}
		if(oldServiceNm != $("#serviceNm").val()){
			$.ifvSyncPostJSON('<ifvm:action name="getDbChkRegist"/>',obj
			,function(result) {
				if(result.cnt > 0){
					alert('<spring:message code="M01578"/>');
					serviceNmchk = true;
				}
			});
		}
		if(oldConIp != $("#conIp").val() || oldConPort != $("#conPort").val()){
			$.ifvSyncPostJSON('<ifvm:action name="getIpPortChk"/>',obj
			,function(result) {
				if(result.cnt > 0){
 					alert('<spring:message code="M01696"/>');
					ipPortchk = true;
				}
			});
		}
		if(serviceNmchk == false && ipPortchk == false){
			$.ifvSyncPostJSON('<ifvm:action name="editDbRegist"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				dbInformListInit();
				adminTargetingPopClose();
			});
		}
	}
} 

//타겟 레벨 저장
 function setDbInform(){
	var obj = {};
	serviceNmchk = false;
	ipPortchk = false;
	validation = $("#dbInformPopFormArea").ifvValidation();

	var regExp = /^[A-Za-z0-9/_+=.@-]+]*$/;
/* 	if (!regExp.test($("#secretNm").val())) {
		$.ifvCallValidationBox($("#secretNm"), '서비스명은 영숫자와 /_+=.@- 문자만 포함해야 합니다.');
		return false;
	} */
	
	if(validation.confirm()){
		obj.serviceNm = $("#serviceNm").val();
		obj.secretNm = $("#secretNm").val();
		obj.conDbType = $("#conDbType").val();
		obj.conIp = $("#conIp").val();
		obj.conPort = $("#conPort").val();
		obj.conId = $("#conId").val();
		obj.conPw = $("#conPw").val();
		obj.conUrl = $("#conUrl").val();
		obj.dbDesc = $("#dbDesc").val();
		obj.pwChk = PwChk
		$.ifvSyncPostJSON('<ifvm:action name="getDbChkRegist"/>',obj
		,function(result) {
			if(result.cnt > 0){
				alert('<spring:message code="M01578"/>');
				serviceNmchk = true;
			}
		});
		$.ifvSyncPostJSON('<ifvm:action name="getIpPortChk"/>',obj
		,function(result) {
			if(result.cnt > 0){
				alert('<spring:message code="M01696"/>');
				ipPortchk = true;
			}
		});
		if(serviceNmchk == false && ipPortchk == false){
			$.ifvSyncPostJSON('<ifvm:action name="setDbRegist"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				dbInformListInit();
				adminTargetingPopClose();
			});
		}
	}
} 

//공통코드 조회 - db 유형
function dbType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'ANL_DB_TYPE_CD'
		, enableNA : true
	},function(result) {
		var temp = $("#dbTypeTemplate").tmpl(result.rows);
		$("#conDbType").append(temp);
	});
}; 

// 오늘일자
function toDate(){
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth()+1;
	var yyyy = today.getFullYear();
	if(dd<10) {
	    dd='0'+dd
	} 
	if(mm<10) {
	    mm='0'+mm
	} 
	today = yyyy+'-' + mm+'-'+dd;
	return today;
}


$(document).ready(function(){
	$("#dbInformPopFormArea").ifvValidation();
	dbType();
	if(dbInformId != null) getDbInform();
	$("#dbInformPopCancel").on("click", adminTargetingPopClose);
	
 	$("#dbInformSaveBtn").on("click", function(){
		if(dbInformId != null) modifyDbInform();
		else setDbInform();
	}); 
	
	$("#conPw").on("change", function(){
		PwChk= true;
	});

	$("input[id=conPort]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	}); 

/*  	$("#conPort").on("keypress", function(e){
 		if ((event.keyCode<48)||(event.keyCode>57)){ 
			alert('<spring:message code="M01611"/>');
			return false;
		} 
	});  */
	
	var userInfo = $.ifvmGetUserInfo();
	if(dbGubun == "I"){
		$("#conDbType").attr("disabled",false);
		$("#createDate").val(toDate());
		$("#empName").val(userInfo.empName);
	}else{
		$("#conDbType").attr("disabled",true);
	}
});
</script>

<script id="dbTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='dbInformPopFormArea'>
	<div class="pop_inner_wrap form-horizontal">
	<br>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00508"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" names="conDbType" id="conDbType"  required="true"/>
	        </div>
	         <label class="col-xs-2 control-label"><spring:message code="M02893"/></label> 
	         <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="secretNm" maxLength="50"/>
	        </div> 
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01440"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="text" id="serviceNm" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01125"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="conIp" required="true" maxLength="200"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01126"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="conPort" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01127"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="conId" required="true" maxLength="50" autoCompleted="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01128"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="password" id="conPw" required="true" maxLength="60" autoCompleted="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M00471"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="text" id="conUrl" required="true" maxLength="200"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01129"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="textarea" id="dbDesc" rows="3" maxLength="100"/>
	        </div>
	    </div>
	    <div class="row">
	        <label class="col-xs-2 control-label"><spring:message code="M01131"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="empName" disabled="true" />
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01132"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="createDate" disabled="true" />
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="dbInformSaveBtn" objCode="dbInformSaveBtn_OBJ">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="dbInformPopCancel" objCode="dbInformPopCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>