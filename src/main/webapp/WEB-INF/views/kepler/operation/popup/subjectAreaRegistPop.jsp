<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var validation;
var subjectAreaNmchk = false;
var oldSubjectAreaNm = null;

//타겟 레벨 조회
function getSubjectArea(){
		$.ifvSyncPostJSON('<ifvm:action name="getSubjectAreaRegist"/>',{subjectAreaId : subjectAreaId}
		,function(result) {
			$("#subjectAreaNm").val(result.subjectAreaNm);
			$("#subjectDesc").val(result.subjectDesc);
			oldSubjectAreaNm = result.subjectAreaNm;
		});
}

//타겟 레벨 수정
 function modifySubjectArea(){
	var obj = {};
	subjectAreaNmchk = false;
	validation = $("#subjectAreaPopFormArea").ifvValidation();
	
	if(validation.confirm()){
		obj.subjectAreaId = subjectAreaRegistList.opt.gridControl.getSelectedRecords()[0].subjectAreaId;
		obj.subjectAreaNm = $("#subjectAreaNm").val();
		obj.subjectDesc = $("#subjectDesc").val();
		if(oldSubjectAreaNm != $("#subjectAreaNm").val()){
			$.ifvSyncPostJSON('<ifvm:action name="getSubjectAreaChkRegist"/>',obj
			,function(result) {
				if(result.cnt > 0){
					alert('<spring:message code="M01600"/>');
					subjectAreaNmchk = true;
				}			
			});
		}
		if(subjectAreaNmchk == false){
			$.ifvSyncPostJSON('<ifvm:action name="editSubjectAreaRegist"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				subjectAreaListInit();
				adminTargetingPopClose();
			});
		}
	}
} 

//타겟 레벨 저장
 function setSubjectArea(){
	var obj = {};
	subjectAreaNmchk = false;
	validation = $("#subjectAreaPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.subjectAreaNm = $("#subjectAreaNm").val();
		obj.subjectDesc = $("#subjectDesc").val();
		$.ifvSyncPostJSON('<ifvm:action name="getSubjectAreaChkRegist"/>',obj
		,function(result) {
			if(result.cnt > 0){
				alert('<spring:message code="M01600"/>');
				subjectAreaNmchk = true;
			}			
		});
		if(subjectAreaNmchk == false){
			$.ifvSyncPostJSON('<ifvm:action name="setSubjectAreaRegist"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				subjectAreaListInit();
				adminTargetingPopClose();
			});
		}
	}
} 


$(document).ready(function(){
	$("#subjectAreaPopFormArea").ifvValidation();

	if(subjectAreaId != null) getSubjectArea();
	$("#subjectAreaPopCancel").on("click", adminTargetingPopClose);
	
 	$("#subjectAreaSaveBtn").on("click", function(){
		if(subjectAreaId != null) {
			modifySubjectArea();
		} else {
			setSubjectArea();
		}
	}); 
	
});
</script>

<script id="dbTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='subjectAreaPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01596"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="text" id="subjectAreaNm" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-2 control-label"><spring:message code="M01598"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="text" id="subjectDesc"  maxLength="200"/>
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="subjectAreaSaveBtn" objCode="subjectAreaSaveBtn_OBJ">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="subjectAreaPopCancel" objCode="subjectAreaPopCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>