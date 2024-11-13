<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;

//타겟 레벨 조회
function getTableAdvance(){
		$.ifvSyncPostJSON('<ifvm:action name="getTableAdvance"/>',{tableId : tableId}
		,function(result) {
			$("#pctfree").val(result.pctFree);
			$("#initrans").val(result.initRans);
			$("#maxtrans").val(result.maxTrans);
			$("#initial").val(result.initIal);
			$("#next").val(result.next);
			$("#minextents").val(result.minExtents);
		});
}

//타겟 레벨 저장
 function editTableAdvance(){
	var obj = {};
	validation = $("#tableAdvencePopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.pctfree = $("#pctfree").val();
		obj.initrans = $("#initrans").val();
		obj.maxtrans = $("#maxtrans").val();
		obj.initial = $("#initial").val();
		obj.next = $("#next").val();
		obj.minextents = $("#minextents").val();
		obj.tableId = tableId;
		$.ifvSyncPostJSON('<ifvm:action name="editTableAdvance"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			getTableList();
			tableMstPopClose();
		});
	}
} 

$(document).ready(function(){
	$("#tableAdvencePopFormArea").ifvValidation();
	
	if(tableId != null) getTableAdvance();
	$("#tableAdvancePopCancel").on("click", tableMstPopClose);
	
 	$("#tableAdvanceSaveBtn").on("click", function(){
		editTableAdvance();
	}); 

	$("input[id=pctfree]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	$("input[id=initrans]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	$("input[id=maxtrans]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	$("input[id=initial]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	$("input[id=next]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	$("input[id=minextents]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});
	
});
</script>

<div id='tableAdvencePopFormArea'>

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
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="tableAdvanceSaveBtn">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00137"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tableAdvancePopCancel">         
		<spring:message code="C00040"/>
	</button>  
</div>