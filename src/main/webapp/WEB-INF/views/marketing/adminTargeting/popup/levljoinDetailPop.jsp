<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var fdPop;
var levelJoinChk = true;
var targetLevelChk = false;


//랜덤 문자 생성 문자만
function randomString() {
var chars = "ABCDEFGHIJKLMNOPQRSTUVWXTZ";
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
var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZ";
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

function fdPopClose() {
	fdPop.destroy();
}

//타겟 테이블 조회
function getlvlJoinDef(){
		$.ifvSyncPostJSON('<ifvm:action name="getLvlJoin"/>',{lvlJoinId : lvlJoinId}
		,function(result) { 
		    $("#tableId").text(result.tblLvlId);
			$("#tableId").val(result.tblEngNm);
			$("#colId").text(result.keycolId);  
			$("#colId").val(result.colEngNm); 
			$("#regdate").val(result.createDate); 
			$("#empName").val(result.empName); 
			 
			if(result.mainFg == 'Y'){
				$("input:checkbox[id='mainTblFlag']").attr("checked", true);
			}
			else{
				$("input:checkbox[id='mainTblFlag']").attr("checked", false);
			}
			
			if(result.outerFg == 'Y'){
				$("input:checkbox[id='outerFlag']").attr("checked", true);
			}
			else{
				$("input:checkbox[id='outerFlag']").attr("checked", false);
			}
			 
		});
}

function useCheck(){
	if($("#mainTblFlag").is(":checked")){
		return "Y"
	}
	else return "N"
}

function useOuterCheck(){
	if($("#outerFlag").is(":checked")){
		return "Y"
	}
	else return "N"
}


//타겟 테이블 컬럼 수정
function modifylvlJoinDef(){

	var obj = {};
	
	validation = $("#targetTablePopFormArea").ifvValidation();
	
	if(validation.confirm()){

		 obj.tblId = $("#tableId").text();
		 obj.keyColId = $("#colId").text();  
		 obj.outerFlag = useOuterCheck();
		 obj.mainTblFlag = useCheck();
		 obj.lvlJoinId = lvlJoinId;
		 obj.targetLevelId = selectTargetId;
		$.ifvSyncPostJSON('<ifvm:action name="editLvlJoin"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			levelJoinList.requestData( { targetLevelId : selectTargetId } );
			adminTargetingPopClose();
			
		});
	}
}


//타겟 테이블 컬럼 저장
function setTlvlJoinDef(){
	
	var obj = {};
	
	validation = $("#targetTablePopFormArea").ifvValidation();
	
	if(validation.confirm()){
		 obj.targetLevelId = selectTargetId;
		 obj.tblId = $("#tableId").text();
		 obj.keyColId = $("#colId").text();  
		 obj.outerFlag = useOuterCheck();
		 obj.mainTblFlag = useCheck();
		 obj.tblAliasNm = randomString() + randomIntString() + randomInt();
		 obj.colAliasNm = randomString() + randomIntString() + randomInt();
		 
		$.ifvSyncPostJSON('<ifvm:action name="setTgtLevelJoin"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			levelJoinList.requestData( { targetLevelId : selectTargetId } );
			adminTargetingPopClose();
		});
	}
	
}

$(document).ready(function(){
	$.ifvSyncPostJSON('<ifvm:action name="getLvlJoinMainTbl"/>', {
		tblId : selectTargetId
	},function(result) {
			
		if(result.count > 0){
			//$("#mainTblFlag").attr('disabled', 'true');
		}
	});
	
	if(lvlJoinId != null){
		getlvlJoinDef();
	}
	
	$("#canbtn").on("click", function(){
		adminTargetingPopClose();
	}); 
	
	$("#btnSave").on("click", function(){
		if(lvlJoinId != null){
			modifylvlJoinDef();
			
		}
		else{
			setTlvlJoinDef();
		}
		
	});
	
    $('#searchColumn').on('click', function() {
    	$("#fdPop").ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchTablePop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01174"/>',
	        width: 700,
	        close : 'fdPopClose'
	    });
		
		fdPop = $('#fdPop').data("ejDialog");
	});
    
    $('#searchColumn2').on('click', function() {
	    $('#fdPop').ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchColumnPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01171"/>',
	        width: 700,
	        close : 'fdPopClose'
	    });
		
		fdPop = $('#fdPop').data("ejDialog");
    });
	
    if($("input:checkbox[id='mainTblFlag']").is(":checked") == true){
    	$("#mainTblFlag").attr('disabled', 'true');
    }
    
});
</script>

<style>
.input-group input[type="checkbox"] {
	margin-top: 6px;
} 
</style>
<div class="pop_inner_wrap">
	<div class="form-horizontal" id="targetTablePopFormArea">
		<div class="row qt_border store_content_top">
			<div class="col-xs-6">
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01175"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" required="true" disabled="true" id="tableId"/>
						<span class="input-group-addon" id="searchColumn"><i class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01169"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" required="true" disabled="true" id="colId"/>
						<span class="input-group-addon" id="searchColumn2"><i class="fa fa-search"></i></span>
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
			<div class="col-xs-6">  
				<label class="col-xs-4 control-label"><spring:message code="M01201"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="checkbox" names="" id="mainTblFlag"/>  
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
						<ifvm:input type="text" disabled="true" id="regdate"/>
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