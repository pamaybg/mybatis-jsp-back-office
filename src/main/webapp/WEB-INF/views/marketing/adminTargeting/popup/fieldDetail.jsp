<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var fdPop;
var filepageChk = true;
var checkDisp = false;
//타겟 테이블 조회
function getField(){
	if(fieldId != null){
		$.ifvSyncPostJSON('<ifvm:action name="getField"/>',{fieldId : fieldId}
		,function(result) {
			
			$("#colId").text(result.collId);
			$("#colId").val(result.colEngNm);
			$("#joinDefId").text(result.joinDefId);
			$("#joinDefId").val(result.joinNm);
			$("#fieldEngNm").val(result.fieldEngNm);
			$("#fieldKorNm").val(result.fieldKorNm);
			$("#displaySeq").val(result.displaySeq);
			$("#tableId").text(result.tableId);
			$("#srchConDdpVal").val(result.srchConDdpVal);
			
			if(result.calFlag == 'Y'){
				$("input:checkbox[id='calFlag']").attr("checked", true);
				$("#calArea").show();
				
				new ifvm.PopupHeight({
				popupDivId : 'adminTargetingPop',
				contentsId : 'fieldArea'
				});
			
			}
			else{
				$("input:checkbox[id='calFlag']").attr("checked", false);
				$("#calArea").hide();
				
				new ifvm.PopupHeight({
				popupDivId : 'adminTargetingPop',
				contentsId : 'fieldArea'
				});
			}
			
			$("#calDef").val(result.calDef);
			$("#fieldDesc").val(result.fieldDesc);
			$("#filterType").val(result.ftype);
	        $("#filtercolum").val(result.fColunm);
	        $("#filtercolum").text(result.fColid);
	        $("#regdate").val(result.empName);
	        $("#createBy").val(result.createDate);
	        checkDisp = true;
	        if(result.dispFlag == 'Y'){
	        	$("input:checkbox[id='dispFlag']").attr("checked", true);
			}
			else{
				$("input:checkbox[id='dispFlag']").attr("checked", false);
			}
	        
	        if(result.excelFlag == 'Y'){
	        	$("input:checkbox[id='excelFlag']").attr("checked", true);
			}
			else{
				$("input:checkbox[id='excelFlag']").attr("checked", false);
			}
	        
	        if(result.ftype == 'Common'){
	        	$("#filterValuePop").show();
	        }
	        
		});
	}
}

function calCheck(){
	if($("#calFlag").is(":checked")){
		return "Y"
	}
	else return "N"
}

//타겟 테이블 컬럼 수정
function modifyField(){

	var obj = {};
	validation = $("#DataFormArea").ifvValidation();
	
	if(validation.confirm()){
		if($("#filterType").val() == null){
			$("#filterType").val(' ')
		}
		obj.collId = $("#colId").text();
		obj.joinDefId = $("#joinDefId").text();
		obj.fieldEngNm = $("#fieldEngNm").val();
		obj.fieldKorNm = $("#fieldKorNm").val();
		obj.calFlag = calCheck();
		obj.calDef = $("#calDef").val();
		obj.fieldDesc = $("#fieldDesc").val();
		obj.fieldId = fieldId;
		obj.ftype = $("#filterType").val();
        obj.fClounm = $("#filtercolum").text();
        obj.displaySeq = $("#displaySeq").val();
        obj.srchConDdpVal = $("#srchConDdpVal").val();
        if($("input:checkbox[id='dispFlag']").is(":checked")){
        	obj.dispFlag = 'Y';
		}
		else{
			obj.dispFlag = 'N';
		}
        
        if($("input:checkbox[id='excelFlag']").is(":checked")){
        	obj.excelFlag = 'Y';
		}
		else{
			obj.excelFlag = 'N';
		}
        
		$.ifvSyncPostJSON('<ifvm:action name="modifyField"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			subjectFieldList.requestData();
			adminTargetingPopClose();
			
		});
	}
}


//타겟 테이블 컬럼 저장
function setField(){
	
	var obj = {};
	
	validation = $("#DataFormArea").ifvValidation();
	
	if(validation.confirm()){
		if($("#filterType").val() == null){
			$("#filterType").val(' ')
		}
		obj.collId = $("#colId").text();
		obj.joinDefId = $("#joinDefId").text();
		obj.fieldEngNm = $("#fieldEngNm").val();
		obj.fieldKorNm = $("#fieldKorNm").val();
		obj.calFlag = calCheck();
		obj.calDef = $("#calDef").val();
		obj.fieldDesc = $("#fieldDesc").val();
		obj.subjectAreaId = selectAreaId;
		obj.ftype = $("#filterType").val();
        obj.fClounm = $("#filtercolum").text();
        obj.displaySeq = $("#displaySeq").val();
        obj.srchConDdpVal = $("#srchConDdpVal").val();
        if($("input:checkbox[id='dispFlag']").is(":checked")){
        	obj.dispFlag = 'Y';
		}
		else{
			obj.dispFlag = 'N';
		}
        
        if($("input:checkbox[id='excelFlag']").is(":checked")){
        	obj.excelFlag = 'Y';
		}
		else{
			obj.excelFlag = 'N';
		}
        
		$.ifvSyncPostJSON('<ifvm:action name="setField"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			subjectFieldList.requestData();
			adminTargetingPopClose();
		});
	}
	
}

//공통코드 조회 - db 유형
function colType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_FILTER_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#fileTypeTemplate").tmpl(result.rows);
		//$("#colTypeCd").append(temp);
		
	});
}; 


function fdPopClose() {
	fdPop.destroy();
}

$(document).ready(function() {
	pageSetUp();
	colType();
	$("#tableId").hide();
	$("#calClass").hide();
	$("#subjectAreaId").val(subjectAreaNm);
	$("#tableId").text(selectbaseTblId);
	$("#filterValuePop").hide();
	
	$("#btnSave").on("click", function(){
		if(fieldId != null){
			modifyField();
		}
		else{
			setField();
		}
	});
	
	$("#btnCancel").on('click', function() { 
		adminTargetingPopClose();
	});
	
	$('#searchColumn').on('click', function() {
		$('#fdPop').ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchColumnPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01171"/>',
	        width: 700,
	        close : 'fdPopClose'
	    });	
		fdPop = $('#fdPop').data("ejDialog");;
	});
	
	$('#searchColumn2').on('click', function() {
		$('#fdPop').ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchFillterPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01183"/>',
	        width: 700,
	        close : 'fdPopClose'
	    });	
		fdPop = $('#fdPop').data("ejDialog");;
	});
	
	$('#searchJoinDefinition').on('click', function() {
		$('#fdPop').ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchJoinDefinitionPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01172"/>',
	        width: 700,
	        close : 'fdPopClose'
	    });
		
		fdPop = $('#fdPop').data("ejDialog");;
	});
	
	
	$("#filterType").on('change', function() {
		
		if(this.value == "Common"){
			$("#filterValuePop").show();
		}
		else{
			$("#filterValuePop").hide();
			$("#filtercolum").text("");
			$("#filtercolum").val("");
		}
		
		
		
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	//상태 값 코드
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_FILTER_TYPE'
		, enableNA : true
	},function(result) {
		
		var size = result.rows.length;
		arrStore = {};
		arrStore.markName = "";
		for(var i=size;i>=0;i--){
			if(i != 0){
				temp = result.rows[i-1];
				result.rows[i] = temp;
			}
			else{ 
				result.rows[0] = {};
				result.rows[0] = arrStore;
			}
		}
		
		var temp = $("#persnaltemp").tmpl(result.rows);
		$("#persnal").append(temp);
		var temp = $("#commStatustemp").tmpl(result.rows);
		$("#filterType").append(temp);
	});
	
	
	setTimeout(function(){	getField(), 200});
	
	//장용 추가 화면 변경
	 if(!checkDisp){
		$("#dispFlag").attr('checked', true);
		$("#excelFlag").attr('checked', true);
	 } 
	
	$("#calArea").hide();
	
	$("#calFlag").on('click', function(){

		if($("input:checkbox[id='calFlag']").is(":checked")){
			$("#calArea").show();
			
			new ifvm.PopupHeight({
			popupDivId : 'adminTargetingPop',
			contentsId : 'fieldArea'
			});
			
		}
		else{
			$("#calArea").hide();
			new ifvm.PopupHeight({
				popupDivId : 'adminTargetingPop',
				contentsId : 'fieldArea'
				});
		}
		
	});
	
});
</script>


<script id="commStatustemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script id="fileTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>


<style>
.input-group input[type="checkbox"] {
	margin-top: 6px;
} 

/* #targetTablePopFormArea {height:500px;}  */
</style>
<div id="fieldArea">
<div class="pop_inner_wrap" id="DataFormArea">
	<div class="form-horizontal">
		<div class="row qt_border store_content_top">
			<div class="col-xs-6">
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01231"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" required="true" id="fieldEngNm" maxLength="50"/>
					</div>
				</div>
			</div>
			<div class="col-xs-6">  
				<label class="col-xs-4 control-label"><span class="asterisk">*</span>
				<spring:message code="M01157"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" required="true" id="displaySeq" valiItem ="number" maxLength="11"/>
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01164"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" id="colId" required="true"/>
						<span class="input-group-addon" id="searchColumn" ><i class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<label class="col-xs-4 control-label"><spring:message code="M01110"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" id="joinDefId"/>
						<span class="input-group-addon" id="searchJoinDefinition"><i class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6">
				<label class="col-xs-4 control-label"><spring:message code="M01155"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" id="subjectAreaId"/>
						<ifvm:input type="text" disabled="true" id="tableId"/>
					</div>
				</div>
			</div>
			
			
			<div class="col-xs-6">  
				<label class="col-xs-4 control-label"><spring:message code="M01160"/></label>
				<div class="col-xs-1 control_content">
					<div class="input-group">
						<ifvm:input type="checkbox" names="" id="dispFlag"/>
					</div>
				</div>
				
				<label class="col-xs-4 control-label"><spring:message code="M01384"/></label>
				<div class="col-xs-1 control_content">
					<div class="input-group">
						<ifvm:input type="checkbox" names="" id="excelFlag"/>
					</div>
				</div>
				
			</div>
		</div>


		<div class="row qt_border store_content_top">
			<div class="col-xs-6">
				<label class="col-xs-4 control-label"><spring:message code="M01179"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="select" id="filterType"/>
					</div>
				</div>
			</div>
			<div class="col-xs-6" id="filterValuePop">  
				<label class="col-xs-4 control-label"><spring:message code="M01180"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" id="filtercolum"/>
						<span class="input-group-addon" id="searchColumn2"><i class="fa fa-search"></i></span>  
					</div> 
				</div>
			</div>
		</div>
		
		<div class="row qt_border store_content_top" id="calClass">
			<div class="col-xs-6">  
				<label class="col-xs-4 control-label"><spring:message code="M01162"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="checkbox" names="" id="calFlag"/>
					</div>
				</div>
			</div>
		</div>
			
		<div class="row qt_border store_content_top" id="calArea">
			<div class="col-xs-12">
				<label class="col-xs-2 control-label"><spring:message code="M01163"/></label>
				<div class="col-xs-10 control_content">
					<div class="input-group">
						<textarea rows="5" id="calDef"></textarea>
					</div>
				</div>
			</div> 
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-12">
				<label class="col-xs-2 control-label"><spring:message code="M01130"/></label>
				<div class="col-xs-10 control_content">
					<div class="input-group">
						<textarea rows="1" id="srchConDdpVal" maxLength="100"></textarea>
					</div>
				</div>
			</div> 
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-12">
				<label class="col-xs-2 control-label"><spring:message code="M01129"/></label>
				<div class="col-xs-10 control_content">
					<div class="input-group">
						<textarea rows="3" id="fieldDesc" maxLength="100"></textarea>
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
						<ifvm:input type="text" id="regdate" disabled="true"/>
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
	<button class="btn btn-sm btn_lightGray2" id="btnCancel">         
        <spring:message code="M00284"/>
    </button> 
</div>
</div>
<div id="fdPop" class="popup_container"></div>