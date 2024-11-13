<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;

//타겟 레벨 조회
function getIdxAdvance(){
		$.ifvSyncPostJSON('<ifvm:action name="getIdxAdvance"/>',{ idxId : idxId }
		,function(result) {
			$("#pctfree").val(result.pctfree);
			$("#initrans").val(result.initrans);
			$("#maxtrans").val(result.maxtrans);
			$("#initial").val(result.initial);
			$("#next").val(result.next);
			$("#minextents").val(result.minextents);
			$("#maxextents").val(result.maxextents);
			$("#bufferPool").val(result.bufferPool);
			$("#loggingYn").val(result.loggingYn);
			$("#compressYn").val(result.compressYn);
			$("#parallelYn").val(result.parallelYn);
		});
}

//타겟 레벨 저장
 function editIdxAdvance(){
	var obj = {};
	validation = $("#idxAdvencePopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.pctfree = $("#pctfree").val();
		obj.initrans = $("#initrans").val();
		obj.maxtrans = $("#maxtrans").val();
		obj.initial = $("#initial").val();
		obj.next = $("#next").val();
		obj.minextents = $("#minextents").val();
		obj.maxextents = $("#maxextents").val();
		obj.bufferPool = $("#bufferPool").val();
		obj.loggingYn = $("#loggingYn").val();
		obj.compressYn = $("#compressYn").val();
		obj.parallelYn = $("#parallelYn").val();
		obj.idxId = idxId;
		$.ifvSyncPostJSON('<ifvm:action name="editIdxAdvance"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			getIdxList();
			tableMstPopClose();
		});
	}
} 

$(document).ready(function(){
	$("#idxAdvencePopFormArea").ifvValidation();
	
	if(idxId != null) getIdxAdvance();
	$("#idxAdvancePopCancel").on("click", tableMstPopClose);
	
 	$("#idxAdvanceSaveBtn").on("click", function(){
		editIdxAdvance();
	}); 
 	
	$("#pctfree").on("keypress", function(event){
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert('<spring:message code="M00046" />');
			return false;
		}
	});
	$("#initrans").on("keypress", function(event){
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert('<spring:message code="M00046" />');
			return false;
		}
	});
	$("#maxtrans").on("keypress", function(event){
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert('<spring:message code="M00046" />');
			return false;
		}
	});
	$("#initial").on("keypress", function(event){
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert('<spring:message code="M00046" />');
			return false;
		}
	});
	$("#next").on("keypress", function(event){
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert('<spring:message code="M00046" />');
			return false;
		}
	});
	$("#minextents").on("keypress", function(event){
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert('<spring:message code="M00046" />');
			return false;
		}
	});
	$("#maxextents").on("keypress", function(event){
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert('<spring:message code="M00046" />');
			return false;
		}
	});
});
</script>

<div id='idxAdvencePopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="M01566" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="pctfree" maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01558" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="initrans"  maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01561" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="maxtrans"  maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01557" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="initial"  maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01563" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="next"  maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01562" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="minextents"  maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01560" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="maxextents"  maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01551" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="bufferPool"  maxLength="7"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01559" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="loggingYn"  maxLength="1"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01553" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="compressYn"  maxLength="1"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01565" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="parallelYn"  maxLength="1"/>
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="idxAdvanceSaveBtn">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00137"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="idxAdvancePopCancel">         
		<spring:message code="C00040"/>
	</button>  
</div>