<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var initType;

//타겟 테이블 조회
function getTargetTable(){
		
		$.ifvSyncPostJSON('<ifvm:action name="getDtlTable"/>',{id : outTableId}
		,function(result) {
			$("#tblSchemaNm").val(result.tblSchemaNm);
			$("#tblEngNm").val(result.tblEngNm);
			$("#tblKorNm").val(result.tblKorNm);
			$("#tblDesc").val(result.tblDesc);
			$("#targetLevelNm").val(result.targetLevelNm);
			$("#type").val(result.typeCdNm);
			/* $("#createBy").val(result.empName);
			$("#regDate").val(result.modiDd); */		
			initType = result.type;
		});
}

//타겟 테이블 수정
function modifyTargetTable(){
	var check = true;
/* 	if(initType != $("#type").val()){
		//현 타입으로 등록되어 있는것이 있는지 체크.
		$.ifvSyncPostJSON('<ifvm:action name="getTblcountCheck"/>',{type : $("#type").val()}
		,function(result) {       
			
		},function(result) {       
			check = false;
			if(result.errorType == "900100") alert('<spring:message code="M01289"/>');
		});
	} */
	if(check){
		
		var obj = {};
		
		validation = $("#targetTablePopFormArea").ifvValidation(); 
		
		if(validation.confirm() == true){
			
			obj.id = outTableId;
			obj.tblSchemaNm = $("#tblSchemaNm").val();
			obj.tblEngNm = $("#tblEngNm").val();
			obj.tblKorNm = $("#tblKorNm").val();
			obj.tblDesc = $("#tblDesc").val();
			obj.type = $("#type").val();
			
			$.ifvSyncPostJSON('<ifvm:action name="editOutTbl"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				tableList.searchGrid( { targetLevelId : selectTargetId } );
				
			});
			adminTargetingPopClose();
		}
	}
}

//타겟 테이블 저장
function setTargetTable(){
	var check = true;
	console.log("1111111111111111111")
	//현 타입으로 등록되어 있는것이 있는지 체크.
	$.ifvSyncPostJSON('<ifvm:action name="getTblcountCheck"/>',{
	    type : $("#type").val()
	}, function(result) {       
		
	}, function(result) {   
		check = false;
		if(result.errorType == "900100") alert('<spring:message code="M01289"/>');
	});
	console.log("222222222222222222222")
	if(check){
		var obj = {};
		validation = $("#targetTablePopFormArea").ifvValidation();

		if(validation.confirm() == true){
	
			obj.targetLevelId = selectTargetId;
			obj.tblSchemaNm = $("#tblSchemaNm").val();
			obj.tblEngNm = $("#tblEngNm").val();
			obj.tblKorNm = $("#tblKorNm").val();
			obj.tblDesc = $("#tblDesc").val();
			obj.type = $("#type").val();
			$.ifvSyncPostJSON('<ifvm:action name="setOutTable"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				tableList.searchGrid( { targetLevelId : selectTargetId } );
			});
			adminTargetingPopClose();
		}
	}
}

//공통코드 조회 - db 유형
function colType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'EXTERNAL_TABLE_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#colTypeTemplate").tmpl(result.rows);
		$("#type").append(temp);
	});
}; 

$(document).ready(function(){
	colType();
	$("#notdetail").hide();
	$("#targetTablePopFormArea").ifvValidation();
	
	$("#targetLevelNm").val(selectTargetNm);
	
	$("#tablePopCancel").on("click", function(){
		outTableId = null;
		adminTargetingPopClose();
	});

	
	if(outTableId != null){
		getTargetTable();
	}
	
	$("#targetTableSaveBtn").on("click", function(){
		if(outTableId != null){
			modifyTargetTable();
		}
		else{
			setTargetTable();
		}
		outTableId = null;
		
	});
	
});
</script>

<script id="colTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id="targetTablePopFormArea">
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01136"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="tblSchemaNm" required="true" maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01140"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="tblKorNm" required="true" maxLength="50"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01141"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="tblEngNm" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">

	        <label class="col-xs-2 control-label"><spring:message code="M01142"/></label>
	        <div class="col-xs-4 control_content" id="detail">
	            <ifvm:input type="text" id="targetLevelNm" disabled="true" />
	            <div class="col-xs-4" id="notdetail">
	            <div class="input-group" id="notdetail">
				<ifvm:input type="text" disabled="true" id="targetLevelNm2"/>
				</div>
			</div>
	        </div>
	        
			
			<label class="col-xs-2 control-label"><spring:message code="M01275"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="type"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01129"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="textarea" id="tblDesc" rows="3" maxLength="100"/>
	        </div>
	    </div>
	    <%-- <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01131"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="createBy" disabled="true" />
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01132"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="regDate" disabled="true" /> 
	        </div>
	    </div> --%>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="targetTableSaveBtn" objCode="tablePopSave_OBJ">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tablePopCancel" objCode="tablePopCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>
