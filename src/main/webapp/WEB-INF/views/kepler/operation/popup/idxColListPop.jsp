<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var idxColNm = false;
var oldColNm = null;

//타겟 레벨 조회
function getIdxColInform(){
		$.ifvSyncPostJSON('<ifvm:action name="getIdxColInform"/>'
				,{ idxId : idxId, idxColId : idxColId }
		,function(result) {
			$("#colNm").val(result.colNm);
			$("#orderTypeCd").val(result.orderTypeCd);
			$("#seq").val(result.seq);
			idxColId = result.idxColId;
			oldColNm = result.colNm;
		});
}

//타겟 레벨 수정
 function modifyIdxCol(){
	var obj = {};
	idxColNm = false;
	validation = $("#idxColPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.idxColId = idxColId;
		obj.colNm = $("#colNm").val();
		obj.orderTypeCd = $("#orderTypeCd").val();
		obj.seq = $("#seq").val();
		obj.idxId = idxId;
		if(oldColNm != $("#colNm").val()){
			$.ifvSyncPostJSON('<ifvm:action name="getIdxColNmChk"/>',obj
			,function(result) {
				if(result.cnt > 0){
					alert('<spring:message code="M01601"/>');
					idxColNm = true;
				}
			});
		}
		if(idxColNm == false){
			$.ifvSyncPostJSON('<ifvm:action name="editIdxColList"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				idxColList.opt.grid.setGridParam({ url: "<ifvm:action name='getIdxColList'/>" });
	 		    idxColList.requestData();
				tableMstPopClose();
			});
		}
	}
} 

//타겟 레벨 저장
 function setIdxCol(){
	var obj = {};
	idxColNm = false;
	validation = $("#idxColPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.colNm = $("#colNm").val();
		obj.orderTypeCd = $("#orderTypeCd").val();
		obj.seq = $("#seq").val();
		obj.idxId = idxId;
		$.ifvSyncPostJSON('<ifvm:action name="getIdxColNmChk"/>',obj
		,function(result) {
			if(result.cnt > 0){
				alert('<spring:message code="M01601"/>');
				idxColNm = true;
			}
		});
		if(idxColNm == false){
			$.ifvSyncPostJSON('<ifvm:action name="setIdxColList"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				idxColList.opt.grid.setGridParam({ url: "<ifvm:action name='getIdxColList'/>" });
	 		    idxColList.requestData();
				tableMstPopClose();
			});
		}
	}
} 

$(document).ready(function(){
	$("#idxColPopFormArea").ifvValidation();
	$.fn.ifvmSetSelectOptionCommCode( "orderTypeNm", "ANL_ORDER_TYPE_CD" );
	
	if(idxColId != null) getIdxColInform();
	$("#idxColPopCancel").on("click", tableMstPopClose);
	
    $("#idxColSaveBtn").on("click", function(){
		if(idxColId != null) modifyIdxCol();
		else setIdxCol();
	});  
	
	/* $("input[id=colNm]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-zA-Z0-9\_]/gi,''));
		}
	}); */
});
</script>

<script id="dbTypeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='idxColPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M01164"/></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="colNm" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M00324"/></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="select" id="orderTypeCd" names="orderTypeNm" />
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M01602"/></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="number" id="seq"  required="true" maxLength="5"/>
	        </div>
	    </div>

	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="idxColSaveBtn">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="C00126"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="idxColPopCancel">         
		<spring:message code="C00040"/>
	</button>  
</div>