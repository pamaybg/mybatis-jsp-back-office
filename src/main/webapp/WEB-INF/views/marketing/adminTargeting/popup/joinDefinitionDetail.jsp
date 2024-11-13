<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var fdPop;
var subjectChk = true;
function fdPopClose() {
	fdPop.destroy();
}


//타겟 테이블 조회
function getJoinDef(){
		$.ifvSyncPostJSON('<ifvm:action name="getJoinDef"/>',{subjectAreaId : joinDefId}
		,function(result) {
			
			$("#baseTblId").text(result.destTblId);
		    $("#baseTblId").val(result.baseNm);
			//$("#aliasNm").val(result.aliasNm);
			$("#joinDefDesc").val(result.joinDefDesc);
			$("#subjectAreaId").val(result.subjectAreaNm);
			$("#regdate").val(result.createDate);
			$("#empName").val(result.empName);
			if(result.outerFlag == 'Y'){
				$("input:checkbox[id='outerFlag']").attr("checked", true);
			}
			else{
				$("input:checkbox[id='mainTblFlag']").attr("checked", false);
			}
		});
}

function useOuterCheck(){
	if($("#outerFlag").is(":checked")){
		return "Y"
	}
	else return "N"
}


//타겟 테이블 컬럼 수정
function modifyJoinDef(){

	var obj = {};
	
	validation = $("#dataForm").ifvValidation();
	
	if(validation.confirm()){
		
		obj.joinDefId = joinDefId;
		obj.destTblId = $("#baseTblId").text()
		//obj.aliasNm = $("#aliasNm").val() 
		obj.outerFlag = useOuterCheck();
		obj.joinDefDesc = $("#joinDefDesc").val();

		$.ifvSyncPostJSON('<ifvm:action name="modifyJoinDef"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			joinDefinitionList.requestData( { subjectAreaId : selectAreaId } );
			adminTargetingPopClose();
		});
	}
	
}

//랜덤 문자 생성 문자만
function randomString() {
var chars = "ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
var string_length = 1;
var randomstring = '';
for (var i=0; i<string_length; i++) {
var rnum = Math.floor(Math.random() * chars.length);
randomstring += chars.substring(rnum,rnum+1);
}
return randomstring;
}

//랜덤 문자 생성 문자 숫자 조합
function randomIntString() {
var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
var string_length = 2;
var randomstring = '';
for (var i=0; i<string_length; i++) {
var rnum = Math.floor(Math.random() * chars.length);
randomstring += chars.substring(rnum,rnum+1);
}
return randomstring;
}

//랜덤 숫자만 생성
function randomInt() {
var chars = "0123456789";
var string_length = 1;
var randomstring = '';
for (var i=0; i<string_length; i++) {
var rnum = Math.floor(Math.random() * chars.length);
randomstring += chars.substring(rnum,rnum+1);
}
return randomstring;
}

//타겟 테이블 컬럼 저장
function setTJoinDef(){
	
	var obj = {};
	
	validation = $("#dataForm").ifvValidation();
	
	if(validation.confirm()){

		obj.subjectAreaId = selectAreaId;
		obj.destTblId = $("#baseTblId").text()
		//obj.aliasNm = $("#aliasNm").val() 
		obj.outerFlag = useOuterCheck();
		obj.joinDefDesc = $("#joinDefDesc").val();
		obj.destAliasNm = randomString() + randomIntString() + randomInt();
		
		$.ifvSyncPostJSON('<ifvm:action name="setJoinDef"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			
			joinDefinitionList.requestData( { subjectAreaId : selectAreaId } );
			adminTargetingPopClose();
		});
		
		
	}
	
}

$(document).ready(function(){
	$("#subjectAreaId").val(subjectAreaNm);
	$("#notdetail").hide();
	if(joinDefId != null){
		getJoinDef();
	}
	
	$("#canbtn").on("click", function(){
		adminTargetingPopClose();
	});
	
	$("#btnSave").on("click", function(){
		if(joinDefId != null){
			modifyJoinDef();
		}
		else{
			setTJoinDef();
		}
		
	});

	$('#searId').on('click', function() {
		$('#fdPop').ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchTablePop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01116"/>',
	        width: 700,
	        close : 'fdPopClose'
	    });
		
		fdPop = $('#fdPop').data("ejDialog");
	});
	
	$("#subId").on('click', function() {
		$('#fdPop').ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchAreaPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01113"/>',
	        width: 700,
	        close : 'fdPopClose'
	    });
		
		fdPop = $('#fdPop').data("ejDialog");
	});
	
	
	
	setTimeout(function(){	
		if(detailCheck){
			if(joinDefId == null){
				$("#deatail").hide();
				$("#notdetail").show();
			}
		}
	}, 100);
});
</script>

<style>
.input-group input[type="checkbox"] {
	margin-top: 6px;
} 
</style>
<div class="pop_inner_wrap" id="dataForm">
	<div class="form-horizontal">
		<div class="row qt_border store_content_top">
			<div class="col-xs-6">
				<label class="col-xs-4 control-label"><spring:message code="M01155"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group" id="deatail">
						<ifvm:input type="text" disabled="true" id="subjectAreaId"/>
					</div>
					<div class="input-group" id="notdetail">
						<ifvm:input type="text" disabled="true" id="subjectAreaId2"/>
						<span class="input-group-addon" id="subId">
						<i class="fa fa-search">
						</i></span>						
					</div>
				</div>
			</div>
			<div class="col-xs-6">  
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01166"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" required="true" id="baseTblId"/>
						<span class="input-group-addon" id="searId"><i class="fa fa-search"></i></span>						
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6">  
				<label class="col-xs-4 control-label"><spring:message code="M01168"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="checkbox" names="" id="outerFlag"/>
					</div>
				</div>
			</div>
		</div>

		<div class="row qt_border store_content_top">
			<div class="col-xs-12">
				<label class="col-xs-2 control-label"><spring:message code="M01129"/></label>
				<div class="col-xs-10 control_content">
					<div class="input-group">
						<textarea rows="5" id="joinDefDesc" maxLength="100"></textarea>
					</div>
				</div>
			</div> 
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="M01131"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" id="empName"/> 
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
	<button class="btn btn-sm btn_lightGray2" id="canbtn">         
        <spring:message code="M00284"/>
    </button> 
</div>

<div id="fdPop" class="popup_container"></div>