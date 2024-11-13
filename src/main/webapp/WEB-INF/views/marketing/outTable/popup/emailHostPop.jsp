<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
/* var PwChk = false; */
var pwChk = false;
$(document).ready(function(){
	
	$("#emailHostPopCancel").on("click", function(){
		adminTargetingPopClose();
	});
	$("#emailHostSaveBtn").on("click", function(){
		var obj = {};
		validation = $("#emailHostPopFormArea").ifvValidation();
		
		if(validation.confirm()){
			if(emailHostId != ""){
				// 수정
				obj.id = emailHostId;
				obj.host = $("#host").val();
				obj.port = $("#port").val();
				obj.email = $("#email").val();
				obj.pwd = $("#pwd").val();
				obj.pwChk = pwChk;
				obj.awsName = $("#awsName").val();
				
				$.ifvSyncPostJSON('<ifvm:action name="editemailHost"/>',obj
				,function(result) {
					alert('<spring:message code="M00267"/>');
					//$.fn.ifvmSubmitSearchCondition("emailHostList", emailHostListInit);
					adminTargetingPopClose();
					emailHostList._doAjax();
				});
			} else {
				// 입력
				obj.host = $("#host").val();
				obj.port = $("#port").val();
				obj.email = $("#email").val();
				obj.pwd = $("#pwd").val();
				obj.pwChk = pwChk;
				obj.awsName = $("#awsName").val();
				$.ifvSyncPostJSON('<ifvm:action name="saveEmailHost"/>',obj
				,function(result) {
					alert('<spring:message code="M00267"/>');
					//$.fn.ifvmSubmitSearchCondition("emailHostList", emailHostListInit);
					adminTargetingPopClose();
					emailHostList._doAjax();
				});
			}
		}
	});
});

/*로딩 시 세팅해주는 부분. 
* 선택구역,반경 등의 Data를 가져와 화면에 뿌려준다.
*/
$(function(){
	
	if(emailHostId != "") {
		//이벤트 조회
		$.ifvSyncPostJSON('<ifvm:action name="getDetailEmailHost"/>', {
			id : emailHostId
		}, function(result) {
			$("#host").val(result.host);
			$("#port").val(result.port);
			$("#email").val(result.email);
			$("#pwd").val(result.pwd);
			$("#createBy").val(result.createBy);
			$("#createDate").val(result.createDate);
			$("#awsName").val(result.awsName);
		});
	} else {
		$("#host").val("");
		$("#port").val("");
		$("#createBy").val("");
		$("#createDate").val("");
		$("#awsName").val("");
	}
	
	$("#pwd").on("change", function(){
		pwChk= true;
	});
});
</script>

<div id='emailHostPopFormArea'>
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01376'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="host" required="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='M01377'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="port" required="true"/>
	        </div>
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='발신자 이메일'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="email" required="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code='비밀번호'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="password" id="pwd" required="true"/>
	        </div>
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code='AWS Name'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="awsName"/>
	        </div>
	    </div>

	    <div class="row">
	        <label class="col-xs-2 control-label"><spring:message code='M00184'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="createBy" disabled="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code='M00185'/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="date" id="createDate" disabled="true"/>
	        </div>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="emailHostSaveBtn" objCode="emailHostionPopSave_OBJ">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="emailHostPopCancel" objCode="emailHostionPopCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>