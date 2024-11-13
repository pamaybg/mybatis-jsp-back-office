<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var wordDictionaryChk = true;
var rid = null;

// 용어사전 조회
function getWordDictionaryDtl(){
		$.ifvSyncPostJSON('<ifvm:action name="getWordDicDetail"/>',{rid : rid}
		,function(result) {
			$("#logicalName").val(result.logicalName);
			$("#logicalDesc").val(result.logicalDesc);
			$("#physicalName").val(result.physicalName);
			$("#physicalDesc").val(result.physicalDesc);
			$("#logicalSynonm").val(result.logicalSynonm);
			$("#physicalSynonm").val(result.physicalSynonm);
			$("#tag").val(result.tag); 

		});
}

 //용어사전 목록 저장
 function setWordDictionary(){
	var obj = {};
	wordDictionaryChk = true;

	if(validation.confirm()){
		obj.logicalName = $("#logicalName").val();
		obj.logicalDesc = $("#logicalDesc").val();
		obj.logicalSynonm = $("#logicalSynonm").val();
		obj.physicalName = $("#physicalName").val();
		obj.physicalDesc = $("#physicalDesc").val();
		obj.physicalSynonm = $("#physicalSynonm").val();
		obj.tag = $("#tag").val();

		$.ifvSyncPostJSON('<ifvm:action name="getWordDictionaryChk"/>',obj
		,function(result) {
			if(result.cnt > 0) wordDictionaryChk = false;
		});
		if(wordDictionaryChk){
			$.ifvSyncPostJSON('<ifvm:action name="setWordDictionary"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
			});
		}else{
			alert('<spring:message code="M01965" />');
			return;
		}
	}
}

 //용어사전 목록 수정
function modifyWordDictionary(){
	var obj = {};
	wordDictionaryChk = true;
	if(validation.confirm()){
		obj.rid = rid;
		obj.logicalName = $("#logicalName").val();
		obj.logicalDesc = $("#logicalDesc").val();
		obj.logicalSynonm = $("#logicalSynonm").val();
		obj.physicalName = $("#physicalName").val();
		obj.physicalDesc = $("#physicalDesc").val();
		obj.physicalSynonm = $("#physicalSynonm").val();
		obj.tag = $("#tag").val();

		$.ifvSyncPostJSON('<ifvm:action name="getWordDictionaryChk"/>',obj
		,function(result) {
			if(result.cnt > 0) wordDictionaryChk = false;
		});
		if(wordDictionaryChk){
			$.ifvSyncPostJSON('<ifvm:action name="editWordDictionary"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
			});
		}else{
			alert('<spring:message code="M01965" />');
			return;
		}
	}
}

 var getParameter = function (param) {
     var returnValue;
     var url = location.href;
     var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
     for (var i = 0; i < parameters.length; i++) {
         var varName = parameters[i].split('=')[0];
         if (varName.toUpperCase() == param.toUpperCase()) {
             returnValue = parameters[i].split('=')[1];
             return decodeURIComponent(returnValue);
         }
     }
 };


$(document).ready(function(){

	validation = $("#wordDictionaryDetailForm").ifvValidation();
	
	if($.fn.ifvmIsNotEmpty(getParameter('rid'))){
		rid = getParameter('rid');
	}else{
		rid = null;
	}
	if(rid != null) getWordDictionaryDtl();

	
	// 목록 버튼
    $("#wordDictionaryListBtn").click(function() {
        qtjs.href('<ifvm:url name="wordDictionaryList"/>');
    });
    
	// 저장 버튼
 	$("#wordDictionarySaveBtn").on("click", function(){
		if(rid != null) modifyWordDictionary(); 
		else setWordDictionary();
		qtjs.href('<ifvm:url name="wordDictionaryList"/>');
	});

});
</script>

<div class="page-title">
	<h1>
		용어 사전관리 &gt; 용어 사전
	</h1>
</div>

<div class="page_btn_area" id="headForm">
    <div class="col-xs-7">
        <span><spring:message code="L02676"/></span>
    </div>
    <div class="col-xs-5 searchbtn_r">
        <button class="btn btn-sm" id="wordDictionarySaveBtn" objCode="wordDictionarySaveBtn_OBJ"><spring:message code="L00074"/></button>
        <button class="btn btn-sm" id="wordDictionaryListBtn" objCode="wordDictionaryListBtn_OBJ"><spring:message code="M00002"/></button>
    </div>
</div>

<div class="form-horizontal underline top_well" id="channelDetailForm" >
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="LO2677" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="logicalName" maxLength="60" required="true"/>
	        </div>

	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="LO2680" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="physicalName" maxLength="60" required="true"/>
	        </div>

	    </div>
	    
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="LO2678" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="logicalDesc" maxLength="60" required="true"/>
	        </div>

	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="LO2681" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="physicalDesc" maxLength="60" required="true"/>
	        </div>
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="LO2679" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="logicalSynonm" maxLength="60" />
	        </div>

	        <label class="col-xs-2 control-label"><spring:message code="LO2682" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="physicalSynonm" maxLength="60" />
	        </div>
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="LO2683" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="tag" maxLength="60" required="true"/>
	        </div>
	    </div>
</div>
  