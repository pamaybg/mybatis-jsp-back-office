<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var targetTableId;
var targetTableNm;
var subjectChk = true;
var fdPop;

function fdPopClose() {
	fdPop.destroy();
}

//타겟 테이블 조회
function getSubjec(){
		$.ifvSyncPostJSON('<ifvm:action name="getSubjectArea"/>',{subjectAreaId : subjectAreaId}
		,function(result) {
			$("#targetLevelId").val(result.targetLevelNm);
			$("#baseTblId").text(result.baseTblId);
			$("#baseTblId").val(result.baseTblNm);
			$("#subjectAreaNm").val(result.subjectAreaNm);
			$("#subjectDesc").val(result.subjectDesc);
			$("#createBy").val(result.empName);
			$("#regdate").val(result.modiDd);
			$("#displaySeq").val(result.displaySeq)
		});
}



//타겟 테이블 수정
function modifySubject(){

	var obj = {};
	
	validation = $("#dataForm").ifvValidation();
	
	if(validation.confirm()){
		
		obj.subjectAreaId = subjectAreaId;
		obj.baseTblId = $("#baseTblId").text();
		obj.subjectAreaNm = $("#subjectAreaNm").val();
		obj.subjectDesc = $("#subjectDesc").val();
		obj.displaySeq = $("#displaySeq").val();
		subjectAreaId = subjectAreaId;

		
		$.ifvSyncPostJSON('<ifvm:action name="modifySubjectArea"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			subjectAreaList.requestData();	
			
			
		});
		adminTargetingPopClose();
	}
}

//랜덤 문자 생성 문자만
function randomString() {
var chars = "ABCDEFGHIJKLMNOPQRSTUVWXTZ";
var string_length = 1;
var randomstring = '';
for (var i=0; i<string_length; i++) {
var rnum = Math.floor(Math.random() * chars.length);
randomstring += chars.substring(rnum,rnum+1);
}
return randomstring;
}

//랜덤 문자 생성 문자 숫자 조합
function randomIntString() {
var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZ";
var string_length = 2;
var randomstring = '';
for (var i=0; i<string_length; i++) {
var rnum = Math.floor(Math.random() * chars.length);
randomstring += chars.substring(rnum,rnum+1);
}
return randomstring;
}

//랜덤 숫자만 생성
function randomInt() {
var chars = "0123456789";
var string_length = 1;
var randomstring = '';
for (var i=0; i<string_length; i++) {
var rnum = Math.floor(Math.random() * chars.length);
randomstring += chars.substring(rnum,rnum+1);
}
return randomstring;
}

//타겟 테이블 저장
function setSubject(){
	var obj = {};
	
	validation = $("#dataForm").ifvValidation();
	
	if(validation.confirm()){
		
		obj.aliasNm = randomString();
		obj.aliasNm += randomIntString() + randomInt();

		obj.targetLevelId = targetLevelId;
		obj.baseTblId = $("#baseTblId").text();
		obj.subjectAreaNm = $("#subjectAreaNm").val();
		obj.subjectDesc = $("#subjectDesc").val();
		obj.displaySeq = $("#displaySeq").val();
		
		$.ifvSyncPostJSON('<ifvm:action name="setSubjectArea"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			subjectAreaList.requestData();

		});
		adminTargetingPopClose();
	}
	
}

$(document).ready(function() {
	
	pageSetUp();
	$("#targetLevelId").val(targetLevelNm)
	
	$("#btnPop").on("click", function(){
		$("#fdPop").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchTablePop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01174"/>',
	        width: 700,
	        close : 'fdPopClose'
	    });
		
		fdPop = $('#fdPop').data("ejDialog");
	});  
	
	if(subjectAreaId != null){
		getSubjec();
	}
	$("#subjectPopupCancel").on("click", function(){	
		adminTargetingPopClose();
	});
	
	$("#btnSave").on("click", function(){
		if(subjectAreaId != null){
			modifySubject();
		}
		else{
			setSubject();
		}
		
	});
	
});
</script>

<style>
.input-group input[type="checkbox"] {
	margin-top: 6px;
} 
</style>
<div class="pop_inner_wrap" id="dataForm">
	<div class="form-horizontal">
		<div class="row qt_border store_content_top">
			<div class="col-xs-6">
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01155"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" required="true" id="subjectAreaNm" maxLength="50"/>
					</div>
				</div>
			</div>
			
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01156"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" required="true" id="baseTblId"/>
						<span class="input-group-addon" id="btnPop">
						<i class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<label class="col-xs-4 control-label"><spring:message code="M01105"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" id="targetLevelId"/>
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="M01157"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" id="displaySeq" maxLength="11" valiItem="number"/>
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-12">
				<label class="col-xs-2 control-label"><spring:message code="M01129"/></label>
				<div class="col-xs-10 control_content">
					<div class="input-group">
						<textarea rows="5" id="subjectDesc" maxLength="100"></textarea>
					</div>
				</div>
			</div> 
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="M01131"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" id="createBy"/>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<label class="col-xs-4 control-label"><spring:message code="M01132"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="date" id="regdate" disabled="true"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSave">     
		<i class="glyphicon glyphicon-check"></i>    
		<spring:message code="M00280"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="subjectPopupCancel">         
        <spring:message code="M00284"/>
    </button> 
</div>

<div id="fdPop" class="popup_container"></div>