<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var idxNm = false;
var oldIdxNm = null;

//타겟 레벨 조회
function getIdxColList(){
		$.ifvSyncPostJSON('<ifvm:action name="getIdxInform"/>'
				,{ idxId : idxId, tableId : tableId }
		,function(result) {
			$("#idxNm").val(result.idxNm);
			$("#tblSpaceNm").val(result.tblSpaceNm);
			idxId = result.idxId;
			oldIdxNm = result.idxNm;
			if(result.unqYn == 'Y'){
				$("input:checkbox[id='unqYn']").attr("checked", true);
			}
			else{
				$("input:checkbox[id='unqYn']").attr("checked", false);
			}
		});
}

//타겟 레벨 수정
 function modifyIdxColList(){
	var obj = {};
	idxNm = false;
	validation = $("#idxPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.idxId = idxId;
		obj.idxNm = $("#idxNm").val();
		obj.tblSpaceNm = $("#tblSpaceNm").val();
		obj.unqYn = useCheck();
		obj.tableId = tableId;
		if(oldIdxNm != $("#idxNm").val()){
			$.ifvSyncPostJSON('<ifvm:action name="getIdxNmChk"/>',obj
			,function(result) {
				if(result.cnt > 0){
					alert('<spring:message code="M01591"/>');
					idxNm = true;
				}
			});
		}
		if(idxNm == false){
			$.ifvSyncPostJSON('<ifvm:action name="editIdxList"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				getIdxList();
				tableMstPopClose();
			});
		}
	}
} 

//타겟 레벨 저장
 function setIdxColList(){
	var obj = {};
	idxNm = false;
	validation = $("#idxPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.idxNm = $("#idxNm").val();
		obj.tblSpaceNm = $("#tblSpaceNm").val();
		obj.unqYn = useCheck();
		obj.tableId = tableId;
		$.ifvSyncPostJSON('<ifvm:action name="getIdxNmChk"/>',obj
		,function(result) {
			if(result.cnt > 0){
				alert('<spring:message code="M01591"/>');
				idxNm = true;
			}
		});
		if(idxNm == false){
			$.ifvSyncPostJSON('<ifvm:action name="setIdxList"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				getIdxList();
				tableMstPopClose();
			});
		}
	}
} 

function useCheck(){
		if($("#unqYn").is(":checked")){
			return "Y";
		}
		else return "N";
}
 
$(document).ready(function(){
	$("#idxPopFormArea").ifvValidation();

	if(idxId != null) getIdxColList();
	$("#idxPopCancel").on("click", tableMstPopClose);
	
    $("#idxSaveBtn").on("click", function(){
		if(idxId != null) modifyIdxColList();
		else setIdxColList();
	});  
    
	/* $("input[id=idxNm]").keyup(function(event){ 
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-zA-Z0-9\_]/gi,''));
		}
	}); */
    
});
</script>

<div id='idxPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M01590" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="idxNm" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="M01593" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="text" id="tblSpaceNm" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	    	<label class="col-xs-3 control-label"><spring:message code="M01569" /></label>
	        <div class="col-xs-9 control_content">
	            <ifvm:input type="checkbox" id="unqYn" />
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="idxSaveBtn">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="C00126"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="idxPopCancel">         
		<spring:message code="C00040"/>
	</button>  
</div>