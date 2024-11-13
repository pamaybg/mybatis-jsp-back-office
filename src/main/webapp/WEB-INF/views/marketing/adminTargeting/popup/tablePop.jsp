<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function fdPopClose() {
	fdPop.destroy();
}

//타겟 테이블 조회
function getTargetTable(){
		
		$.ifvSyncPostJSON('<ifvm:action name="getTargetTable"/>',{segTableId : segTableId}
		,function(result) {

			$("#tblSchemaNm").val(result.tblSchemaNm);
			$("#tblEngNm").val(result.tblEngNm);
			$("#tblKorNm").val(result.tblKorNm);
			$("#tblDesc").val(result.tblDesc);
			$("#activeFlag").val(result.activeFlag);
			$("#targetLevelNm").val(result.targetLevelNm);
			$("#createBy").val(result.empName);
			$("#regDate").val(result.modiDd);		       
		});
}

function useCheck(){
	if($("#tableActiveFlag").is(":checked")){
		return "Y"
	}
	else return "N"
}

//타겟 테이블 수정
function modifyTargetTable(){

	var obj = {};
	
	validation = $("#targetTablePopFormArea").ifvValidation(); 
	
	if(validation.confirm() == true){
		
		obj.segTableId = segTableId;
		obj.tblSchemaNm = $("#tblSchemaNm").val();
		obj.tblEngNm = $("#tblEngNm").val();
		obj.tblKorNm = $("#tblKorNm").val();
		obj.tblDesc = $("#tblDesc").val();
		obj.activeFlag = useCheck();
		
		$.ifvSyncPostJSON('<ifvm:action name="modifyTargetTable"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			//tableList();
			if(colmPageChk)
				tableList.requestData( { targetLevelId : selectTargetId } );
			else
				tableList.requestData();
			
		});
		adminTargetingPopClose();
	}
}

//타겟 테이블 저장
function setTargetTable(){
	
	var obj = {};
	
	validation = $("#targetTablePopFormArea").ifvValidation();
	
	if(validation.confirm() == true){

		obj.targetLevelId = selectTargetId;//targetTableId;
		obj.tblSchemaNm = $("#tblSchemaNm").val();
		obj.tblEngNm = $("#tblEngNm").val();
		obj.tblKorNm = $("#tblKorNm").val();
		obj.tblDesc = $("#tblDesc").val();
		obj.activeFlag = useCheck();
		
		$.ifvSyncPostJSON('<ifvm:action name="setTargetTable"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			//tableList();
			if(colmPageChk){
				if(segTableId == null)
					tableList.requestData({targetLevelId : null});
			}
			else 
				tableList.requestData( { targetLevelId : selectTargetId } );
		});
		adminTargetingPopClose();
	}
	
}

$(document).ready(function(){
	$("#notdetail").hide();
	$("#targetTablePopFormArea").ifvValidation();
	
	$("#targetLevelNm").val(targetLevelNm);
	$("#tablePopCancel").on("click", function(){
		segTableId = null;
		adminTargetingPopClose();
	});

	
	if(segTableId != null){
		getTargetTable();
	}
	
	$("#subId").on('click', function() {
		$('#fdPop').ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchTargetLevelPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01135" />',
	        width: 700,
	        close : 'fdPopClose'
	    });
		
		fdPop = $('#fdPop').data("ejDialog");
	});
	
	$("#targetTableSaveBtn").on("click", function(){
		if(segTableId != null){
			modifyTargetTable();
		}
		else{
			setTargetTable();
		}
		segTableId = null;
		
	});
	
	setTimeout(function(){	
		if(colmPageChk){
			if(segTableId == null){
				$("#detail").hide();
				$("#notdetail").show();
				tableList.requestData({targetLevelId : null});
			}
		}
	}, 100);
	
});
</script>

<div id="targetTablePopFormArea">
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01136"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="tblSchemaNm" required="true" maxLength="10"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01140"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="tblKorNm" required="true" maxLength="50"/>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="M01141"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="tblEngNm" required="true" maxLength="50"/>
	        </div>
	    </div>
	    <div class="row qt_border">

	        <label class="col-xs-2 control-label"><spring:message code="M01142"/></label>
	        <div class="col-xs-4 control_content" id="detail">
	            <ifvm:input type="text" id="targetLevelNm" disabled="true" />
	        </div>
	        <div class="col-xs-4" id="notdetail">
	            <div class="input-group" id="notdetail">
				<ifvm:input type="text" disabled="true" id="targetLevelNm2"/>
				<span class="input-group-addon" id="subId"><i class="fa fa-search"></i></span>
				</div>
			</div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01129"/></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="textarea" id="tblDesc" rows="3" maxLength="100"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01131"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="createBy" disabled="true" />
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01132"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="regDate" disabled="true" /> 
	        </div>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="targetTableSaveBtn">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tablePopCancel">         
		<spring:message code="M00284"/>
	</button>  
</div>

<div id="fdPop" class="popup_container"></div>