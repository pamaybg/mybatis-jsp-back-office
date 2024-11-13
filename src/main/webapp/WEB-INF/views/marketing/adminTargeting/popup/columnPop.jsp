<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//타겟 테이블 조회
function getTargetTable(){
		$.ifvSyncPostJSON('<ifvm:action name="getTargetColum"/>',{segColumnId : segColumnId}
		,function(result) {
			
			$("#colEngNm").val(result.colEngNm);
			$("#colKorNm").val(result.colKorNm); 
			$("#colTypeCd").val(result.colTypeCd);
			$("#activeFlag").val(result.activeFlag);
			$("#regdate").val(result.modiDd);
			$("#createBy").val(result.empName); 
			$("#colDesc").val(result.colDesc);
			$("#targetLevelNm").val(result.tblEngNm);
			
			if(result.colPKFlag == 'Y'){
				$("input:checkbox[id='colPKFlag']").attr("checked", true);
			}
			else{
				$("input:checkbox[id='colPKFlag']").attr("checked", false);
			}
		});
}  

function useCheck(){
	if($("#colPKFlag").is(":checked")){
		return "Y"
	}
	else return "N"
}


//타겟 테이블 컬럼 수정
function modifyTargetColum(){

	var obj = {};
	
	validation = $("#targetTablePopFormArea").ifvValidation();
	
	if(validation.confirm()){
		
		obj.segColumnId = segColumnId;
		obj.colEngNm = $("#colEngNm").val()
		obj.colKorNm = $("#colKorNm").val()
		obj.colTypeCd = $("#colTypeCd").val()
		obj.activeFlag = $("#activeFlag").val()
		obj.colDesc = $("#colDesc").val()
		obj.colPKFlag = useCheck();
		$.ifvSyncPostJSON('<ifvm:action name="modifyTargetColum"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			targetColumnList.requestData( { segTableId : selectTblId } );
			adminTargetingPopClose();
			
		});
	}
}


//타겟 테이블 컬럼 저장
function setTargetColum(){
	
	var obj = {};
	
	validation = $("#targetTablePopFormArea").ifvValidation();
	
	if(validation.confirm()){

		obj.segTableId = selectTblId;
		obj.colEngNm = $("#colEngNm").val()
		obj.colKorNm = $("#colKorNm").val()
		obj.colTypeCd = $("#colTypeCd").val()
		obj.activeFlag = useCheck();
		obj.colDesc = $("#colDesc").val();
		obj.colPKFlag = useCheck();
		$.ifvSyncPostJSON('<ifvm:action name="setTargetColum"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			targetColumnList.requestData( { segTableId : selectTblId } );
			adminTargetingPopClose();
		});
	}
	
}

//공통코드 조회 - db 유형
function colType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_SEG_COLUMN_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#colTypeTemplate").tmpl(result.rows);
		$("#colTypeCd").append(temp);
	});
}; 

$(document).ready(function(){

	$("#columnPopCancel").on("click", adminTargetingPopClose);
	$("#targetLevelNm").val(targetTableNm)
	colType();
	
	/* $("#colTypeCd").change(function(){
		if($("#colTypeCd").val() == "DATETIME" || $("#colTypeCd").val() == "DATE" || $("#colTypeCd").val() == "TIMESTAMP"){
			$("#colSize").val("-")
			$("#colSize").attr('disabled', 'true');
		}
		else{
			$("#colSize").val("")
			$("#colSize").removeAttr('disabled');
		}
	}); */
	
	if(segColumnId != null){
		getTargetTable();
	}
	
	$("#btnSave").on("click", function(){
		if(segColumnId != null){
			modifyTargetColum();
		}
		else{
			setTargetColum();
		}
	});
	
});
</script>

<script id="colTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="pop_inner_wrap form-horizontal" id="targetTablePopFormArea">
    <div class="row qt_border">
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01152"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="colKorNm" required="true" maxLength="50"/>
        </div>
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01153"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="colEngNm" required="true" maxLength="50"/>
        </div>
    </div>
    <div class="row qt_border">
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01148"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="colTypeCd" required="true" />
        </div>
        <%-- <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01149"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="colSize" required="true" />
        </div> --%>
    </div>
    <div class="row qt_border">
    	<label class="col-xs-2 control-label"><spring:message code="M01154"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="targetLevelNm" disabled="true" />
        </div>

		<label class="col-xs-2 control-label"><spring:message code="M01202"/></label>
		<div class="col-xs-4 control_content">
		<div class="input-group">
			 <ifvm:input type="checkbox" names="" id="colPKFlag"/>  
		</div>
		</div>
		
    </div>
    <div class="row qt_border">
        <label class="col-xs-2 control-label"><spring:message code="M01129"/></label>
        <div class="col-xs-10 control_content">
            <ifvm:input type="textarea" id="colDesc" rows="3" maxLength="100"/>
        </div>
    </div>
    <div class="row qt_border">
        <label class="col-xs-2 control-label"><spring:message code="M01131"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" disabled="true" id="createBy" /> 
        </div>
        <label class="col-xs-2 control-label"><spring:message code="M01132"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" disabled="true" id="regdate" />
        </div>
    </div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSave">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="columnPopCancel">         
		<spring:message code="M00284"/>
	</button>  
</div>