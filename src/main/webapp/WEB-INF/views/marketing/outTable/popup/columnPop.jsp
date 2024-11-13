<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var commCode;


//타겟 테이블 조회
function getTargetTable(){
		$.ifvSyncPostJSON('<ifvm:action name="getDtlcolumn"/>',{id : segColumnId}
		,function(result) {
			
			$("#colEngNm").val(result.colEngNm);
			$("#colKorNm").val(result.colKorNm);
			$("#colTypeCd").val(result.colTypeCd);
			$("#regdate").val(result.modiDd);
			$("#createBy").val(result.empName); 
			$("#colDesc").val(result.colDesc);
			$("#colSize").val(result.colSize);
			$("#colDescription").val(result.colDesc)
			$("#datatype").val(result.flagAtribVal);
			$("#memberkey").val(result.whereSchMemid);
			$("#searchphone").val(result.whereSchHp);
			$("#searchemail").val(result.whereSchEmail);
			$("#caculater").val(result.attrib01);
			$("#mappingColumn").val(result.prmsItemMappgCol);
			$("#colTypeDefine").val(result.colTypeDefine);
			
			if (result.encColYn == "Y") {
				$("input:checkbox[id='encColYn']").prop("checked", true);
			}
			
			initType = result.colTypeDefine;
		});
}



//타겟 테이블 컬럼 수정
function modifyTargetColum(){
	var check = true;
	if(commCode != ' ' && initType != $("#colTypeDefine").val()){
		//현 타입으로 등록되어 있는것이 있는지 체크.
		$.ifvSyncPostJSON('<ifvm:action name="getcolCountCheck"/>',{type : selectTypeCode, colTypeDefine : $("#colTypeDefine").val()}
		,function(result) {       
			
		},function(result) {   
			check = false;
			if(result.errorType == "900100") alert('<spring:message code="M01289"/>');
		});
	}
	
	if(check){
		var obj = {};
		
		validation = $("#targetTablePopFormArea").ifvValidation();
		
		if(validation.confirm()){
			obj.id = segColumnId;
			obj.colEngNm = $("#colEngNm").val();
			obj.colKorNm = $("#colKorNm").val(); 
			obj.colTypeCd = $("#colTypeCd").val();
			obj.colDesc = $("#colDesc").val();
			obj.colSize = $("#colSize").val();
			obj.colDesc = $("#colDescription").val()
			obj.flagAtribVal = $("#datatype").val();
			obj.whereSchMemid = $("#memberkey").val();
			obj.whereSchHp = $("#searchphone").val();
			obj.whereSchEmail = $("#searchemail").val();
			obj.attrib01 = $("#caculater").val();
			obj.prmsItemMappgCol = $("#mappingColumn").val();
			obj.colTypeDefine = $("#colTypeDefine").val();
			obj.encColYn = $("input:checkbox[id='encColYn']").is(":checked") ? "Y" : "N";
			obj.commType = commCode;
			
			$.ifvSyncPostJSON('<ifvm:action name="editOutColumn"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				targetColumnList.searchGrid( { extrTblId : selectTableId } );
				adminTargetingPopClose();
				
			});
		}
	}
}


//타겟 테이블 컬럼 저장
function setTargetColum(){
	var check = true;
	
	if(commCode != ' '){
		//현 타입으로 등록되어 있는것이 있는지 체크.
		$.ifvSyncPostJSON('<ifvm:action name="getcolCountCheck"/>',{type : selectTypeCode, colTypeDefine : $("#colTypeDefine").val()}
		,function(result) {       
			
		},function(result) {   
			check = false;
			if(result.errorType == "900100") alert('<spring:message code="M01289"/>');
		});
	}
	
	
	if(check){
		var obj = {};
		
		validation = $("#targetTablePopFormArea").ifvValidation();
		
		if(validation.confirm()){
	
			obj.extrTblId = selectTableId;
			obj.colEngNm = $("#colEngNm").val();
			obj.colKorNm = $("#colKorNm").val(); 
			obj.colTypeCd = $("#colTypeCd").val();
			obj.colDesc = $("#colDesc").val();
			obj.colSize = $("#colSize").val();
			obj.colDesc = $("#colDescription").val()
			obj.flagAtribVal = $("#datatype").val();
			obj.whereSchMemid = $("#memberkey").val();
			obj.whereSchHp = $("#searchphone").val();
			obj.whereSchEmail = $("#searchemail").val();
			obj.attrib01 = $("#caculater").val();
			obj.colTypeDefine = $("#colTypeDefine").val();
			obj.encColYn = $("input:checkbox[id='encColYn']").is(":checked") ? "Y" : "N";
			obj.commType = commCode;
			
			$.ifvSyncPostJSON('<ifvm:action name="setOutColumn"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				targetColumnList.searchGrid( { extrTblId : selectTableId } );
				adminTargetingPopClose();
			});
		}
	}
}

//공통코드 조회 - db 유형
function colType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_SEG_COLUMN_TYPE'
		, enableNA : true
	},function(result) {
	    var temp;
	    temp = $("#colTypeTemplate").tmpl(result.rows);
		$("#colTypeCd").append(temp);
	});
};

//공통코드 조회 컬럼 속성 정의
function getcoltype(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : commCode
		, enableNA : true
	},function(result) {
	    var temp;
	    temp = $("#colTypeTemplate").tmpl({});
	    $("#colTypeDefine").append(temp);
	    
		temp = $("#colTypeTemplate").tmpl(result.rows);
		$("#colTypeDefine").append(temp);
	});
};


$(document).ready(function(){
	if(selectType != null){
		commCode =  selectType;
		$("#colTypeDefine").show();
		$("#colTypeDefineLable").show();
	}
	else{
		commCode = ' ';
		$("#colTypeDefine").hide();
		$("#colTypeDefineLable").hide();
		
	}
	
	$("#columnPopCancel").on("click", adminTargetingPopClose);
	$("#targetLevelNm").val(selectTableNm)
	colType();
	getcoltype();
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
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="pop_inner_wrap form-horizontal" id="targetTablePopFormArea">
    <div class="row qt_border">
   		 <!-- 한글명  -->
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01152"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="colKorNm" required="true" maxLength="50" />
        </div>
        <!-- 영문명  -->
        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01153"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="colEngNm" required="true" maxLength="50"/>
        </div>
    </div>
    <div class="row qt_border">
    	<!-- 컬럼 유형 -->
        <label class="col-xs-2 control-label"><spring:message code="M01148"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="colTypeCd"/>
        </div>
        <!-- 데이터 속성 값 -->
        <label class="col-xs-2 control-label"><spring:message code="M01276"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="datatype" maxLength="30"/>
        </div>
    </div>
     <div class="row qt_border">
    	<!-- 컬럼 사이즈 -->
        <label class="col-xs-2 control-label"><spring:message code="M01282"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="colSize" maxLength="11" valiItem="number"/>
        </div>
        <!-- 컬럼 설명 -->
        <label class="col-xs-2 control-label"><spring:message code="M01283"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="colDescription" maxLength="100"/>
        </div>
    </div>
    <div class="row qt_border">
   		 <!-- 테이블 명 -->
    	<label class="col-xs-2 control-label"><spring:message code="M01154"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="targetLevelNm" disabled="true" />
        </div>
        <!-- 회원 키 컬럼 -->
    	<label class="col-xs-2 control-label"><spring:message code="M01277"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="memberkey" maxLength="30"/>
        </div>
    </div>
    <div class="row qt_border">
   		 <!-- 조회 전화 -->
    	<label class="col-xs-2 control-label"><spring:message code="M01278"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="searchphone" maxLength="50"/>
        </div>
        <!-- 이메일 -->
    	<label class="col-xs-2 control-label"><spring:message code="M01279"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="searchemail" maxLength="50"/>
        </div>
    </div>
     <div class="row qt_border">
   		 <!-- 퍼미션 항목 매핑 -->
    	<label class="col-xs-2 control-label"><spring:message code="M01281"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" id="mappingColumn" maxLength="50"/>
        </div>
   		 <!-- 퍼미션 항목 매핑 -->
   		 <ifvm:inputNew type="singleCheckbox" id="encColYn" label="M03002" labelClass="2" conClass="4" checked="false" />
    </div>
    <div class="row qt_border">
         <!-- 컬럼 속성 유형-->
    	<label class="col-xs-2 control-label" id="colTypeDefineLable"><spring:message code="M01288"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="select" id="colTypeDefine"/>
        </div>
    </div>
    <div class="row qt_border">
    	<!-- 컬럼 산출식 -->
        <label class="col-xs-2 control-label"><spring:message code="M01280"/></label>
        <div class="col-xs-10 control_content">
            <ifvm:input type="textarea" id="caculater" rows="3" maxLength="300"/>
        </div>
    </div>
<%--     <div class="row qt_border">
        <label class="col-xs-2 control-label"><spring:message code="M01131"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" disabled="true" id="createBy" /> 
        </div>
        <label class="col-xs-2 control-label"><spring:message code="M01132"/></label>
        <div class="col-xs-4 control_content">
            <ifvm:input type="text" disabled="true" id="regdate" />
        </div>
    </div> --%>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSave" objCode="columnPopSave_OBJ">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="columnPopCancel" objCode="columnPopCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>