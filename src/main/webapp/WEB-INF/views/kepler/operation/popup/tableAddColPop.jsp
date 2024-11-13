<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
#len1 {display: none;}
#len2 {display: none;}
</style>

<script>
var validation;
var gropCode;
var tableColNm = false;
var oldTblColNm = null;

function comboData(){
	getDataTypeComboList();
	getYnComboList();
	getColTypeComboList();
}


/* 데이터 타입 */
function getDataTypeComboList(){
	gropCode = 'DB_DATA_TYPE_CD';
	$.fn.ifvmSetSelectOptionCommCode( "dataTypeCd", "DB_DATA_TYPE_CD" );
}; 
/* 널 여부 */
function getYnComboList(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{ groupCode : 'YES_NO_FLAG', enableNA : true
	},function(result) {
		var temp = $("#dbTypeTemplate").tmpl(result.rows);
		$("#nullYn").append(temp);
	});
}; 
/* 디멘젼/메저 구분 */
function getColTypeComboList(){
	$.fn.ifvmSetSelectOptionCommCode( "colTypeCd", "ANL_COL_TYPE_CD" );
	/* $.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{ groupCode : 'ANL_COL_TYPE_CD', enableNA : true
	},function(result) {
		var temp = $("#dbTypeTemplate").tmpl(result.rows);
		$("#colTypeCd").append(temp);
	}); */
}; 
//타겟 레벨 조회
function getTableAddCol(){
	$.ifvSyncPostJSON('<ifvm:action name="getTableAddColList"/>'
			,{ colId : colId, tableId : tableId , dbType : dbType }
	,function(result) {
		$("#colNm").val(result.colNm);
		$("#dataTypeCd").val(result.dataTypeCd);
		$("#len").val(result.len);
		$("#nullYn").val(result.nullYn);
		$("#seq").val(result.seq);
		$("#deftVal").val(result.deftVal);
		$("#colDpNm").val(result.dpNm);
		$("#colTypeCd").val(result.colTypeCd);
		tableId = result.tableId;
		oldTblColNm = result.colNm;
		if(result.pkYn == 'Y'){
			$("input:checkbox[id='pkYn']").attr("checked", true);
		}
		else{
			$("input:checkbox[id='pkYn']").attr("checked", false);
		}
		dataTypeChk();
	});
}

function getTableAddColSeq(){
	$.ifvSyncPostJSON('<ifvm:action name="getTableAddColSeq"/>'
			,{ tableId : tableId }
	,function(result) {
		$("#seq").val(result.seq);
	});
}

//타겟 레벨 수정
 function modifyTableAddCol(){
	var obj = {};
	validation = $("#tableAddColPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.colId = colId;
		obj.colNm = $("#colNm").val();
		obj.pkYn = useCheck();
		obj.dataTypeCd = $("#dataTypeCd").val();
		obj.len = $("#len").val();
		obj.nullYn = nullYn();
		obj.seq = $("#seq").val();
		obj.deftVal = $("#deftVal").val();
		obj.dpNm = $("#colDpNm").val();
		obj.colTypeCd = $("#colTypeCd").val();
		obj.tableId = tableId;
		obj.gropCode = gropCode;
		if(oldTblColNm != $("#colNm").val()){
			$.ifvSyncPostJSON('<ifvm:action name="getTblColNmChk"/>',obj
			,function(result) {
				if(result.cnt > 0){
					alert('<spring:message code="M01601"/>');
					tableColNm = true;
				}
			});
		}
		if(tableColNm == false){
			$.ifvSyncPostJSON('<ifvm:action name="editTableAddColList"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				getTableColList();
				tableMstPopClose();
			});
		}
	}
} 

//타겟 레벨 저장
 function setTableAddCol(){
	var obj = {};
	tableColNm = false;
	validation = $("#tableAddColPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.colNm = $("#colNm").val();
		obj.pkYn = useCheck();
		obj.dataTypeCd = $("#dataTypeCd").val();
		obj.len = $("#len").val();
		obj.nullYn = nullYn();
		obj.seq = $("#seq").val();
		obj.deftVal = $("#deftVal").val();
		obj.dpNm = $("#colDpNm").val();
		obj.colTypeCd = $("#colTypeCd").val();
		obj.tableId = tableId;
		obj.gropCode = gropCode;
		$.ifvSyncPostJSON('<ifvm:action name="getTblColNmChk"/>',obj
		,function(result) {
			if(result.cnt > 0){
				alert('<spring:message code="M01601"/>');
				tableColNm = true;
			}
		});
		if(tableColNm == false){
			$.ifvSyncPostJSON('<ifvm:action name="setTableAddColList"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				getTableColList();
				tableMstPopClose();
			});
		}
	}
} 

function useCheck(){
		if($("#pkYn").is(":checked")){
			return "Y";
		}
		else return "N";
}

function nullYn(){
		if($("#nullYn").val() == "Y"){
			return "Y";
		}else{
			return "N";
		}
}

function dataTypeChk(){
	if(	dbType == "MySQL"){
		if($("#dataTypeCd").val() == 'VARCHAR' || $("#dataTypeCd").val() == 'ENUM'){
			$("#len").attr("disabled",false);
			$("#len").attr("required",true);
			$("#len1").hide();
			$("#len2").show();
		}else if($("#dataTypeCd").val() == 'DATE' || $("#dataTypeCd").val() == 'DATETIME' || $("#dataTypeCd").val() == 'TIMESTAMP'){
			$("#len").attr("disabled",true);
			$("#len").attr("required",false);
			$("#len").val("");
			$("#len1").show();
			$("#len2").hide();
		}else{
			$("#len").attr("disabled",false);
			$("#len").attr("required",false);
			$("#len1").show();
			$("#len2").hide();
		}
	}else{
		if($("#dataTypeCd").val() == 'VARCHAR2' || $("#dataTypeCd").val() == 'CHAR'){
			$("#len").attr("disabled",false);
			$("#len").attr("required",true);
			$("#len1").hide();
			$("#len2").show();
		}else if($("#dataTypeCd").val() == 'DATE' || $("#dataTypeCd").val() == 'BLOB' || $("#dataTypeCd").val() == 'CLOB'){
			$("#len").attr("disabled",true);
			$("#len").attr("required",false);
			$("#len").val("");
			$("#len1").show();
			$("#len2").hide();
		}else{
			$("#len").attr("disabled",false);
			$("#len").attr("required",false);
			$("#len1").show();
			$("#len2").hide();
		}
	}
	
	$("#tableAddColPopFormArea").ifvValidation();
}
 
$(document).ready(function(){
	dbTypeCheck();
	comboData();
	dataTypeChk();
	
	
	if(colId != null) {
		getTableAddCol();
	}else{
		getTableAddColSeq();
	}
	
	$("#tableAddColPopCancel").on("click", tableMstPopClose);
	
    $("#tableAddColSaveBtn").on("click", function(){
		if(colId != null) modifyTableAddCol();
		else setTableAddCol();
	});  
    
    /* 데이터 타입 변경 */
	$("#dataTypeCd").change(function(e){
		dataTypeChk();
	});
	
	/* $("input[id=colNm]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-zA-Z0-9\_]/gi,''));
		}
	}); */
	
	/* if(dbGubun == "I"){
		$("#colNm").attr("disabled",false);
		$("#pkYn").attr("disabled",false);
		$("#dataTypeCd").attr("disabled",false);
		$("#len").attr("disabled",false);
		$("#nullYn").attr("disabled",false);
		$("#deftVal").attr("disabled",false);
		$("#colTypeCd").attr("disabled",false);
	}else{
		$("#colNm").attr("disabled",true);
		$("#pkYn").attr("disabled",true);
		$("#dataTypeCd").attr("disabled",true);
		$("#len").attr("disabled",true);
		$("#nullYn").attr("disabled",true);
		$("#deftVal").attr("disabled",true);
		$("#colTypeCd").attr("disabled",true);
	} */
	
});
</script>

<script id="dbTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='tableAddColPopFormArea'>

	<div class="pop_inner_wrap">
	    <div class="row qt_border">
	        <label class="col-xs-5 control-label"><span class="asterisk">*</span><spring:message code="M01164" /></label>
	        <div class="col-xs-7 control_content">
	            <ifvm:input type="text" id="colNm" names="colNm"  required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-5 control-label"><spring:message code="M01202" /></label>
	        <div class="col-xs-7 control_content">
	            <ifvm:input type="checkbox" id="pkYn" />
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-5 control-label"><span class="asterisk">*</span><spring:message code="M01571" /></label>
	        <div class="col-xs-7 control_content">
	            <ifvm:input type="select" id="dataTypeCd" names="dataTypeCd" required="true" />
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label id="len1" class="col-xs-5 control-label"><spring:message code="M00444" /></label>
	    	<label id="len2" class="col-xs-5 control-label"><span class="asterisk">*</span><spring:message code="M00444" /></label>
	        <div class="col-xs-7 control_content">
	            <ifvm:input type="text" id="len" maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-5 control-label"><spring:message code="M01564" /></label>
	        <div class="col-xs-7 control_content">
	            <ifvm:input type="select" id="nullYn" />
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-5 control-label"><span class="asterisk">*</span><spring:message code="M01602" /></label>
	        <div class="col-xs-7 control_content">
	            <ifvm:input type="number" id="seq"  required="true" maxLength="5"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-5 control-label"><spring:message code="M01574" /></label>
	        <div class="col-xs-7 control_content">
	            <ifvm:input type="text" id="deftVal"  maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-5 control-label"><spring:message code="M01573" /></label>
	        <div class="col-xs-7 control_content">
	            <ifvm:input type="textarea" id="colDpNm"  maxLength="500"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-5 control-label"><span class="asterisk">*</span><spring:message code="M01572" /></label>
	        <div class="col-xs-7 control_content">
	            <ifvm:input type="select" id="colTypeCd" names="colTypeCd"  required="true"/>
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="tableAddColSaveBtn" objCode="tableAddColSaveBtn_OBJ">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tableAddColPopCancel" objCode="tableAddColPopCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>