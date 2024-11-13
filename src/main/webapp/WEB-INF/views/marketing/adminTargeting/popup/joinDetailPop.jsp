<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var fdPop;
detailCheck = true;
var subjectChk = true;
var joinBtnCehck = true;
function fdPopClose() {
	fdPop.destroy();
}

//타겟 테이블 조회
function getJoinDef(){
		$.ifvSyncPostJSON('<ifvm:action name="getJoinDetail"/>',{joinSpecId : joinSpecId}
		,function(result) {
			$("#regdate").val(result.modiDd);
			$("#empName").val(result.empName);
			$("#joinDefId").val(result.joinDefId);
			$("#srcFieldId").text(result.srcFieldId);
			$("#srcFieldId").val(result.srcNm);
			//$("#outerFlag").val();
			//$("#activeFlag").val();
			$("#joinSpcDesc").val(result.joinSpcDesc);		
			$("#joincolId").text(result.destColId);
			$("#joincolId").val(result.colEngNm);	
			$("#colId").val(result.joinNm);
			$("#colId").text(result.nmColId);
			
			if(result.outerFlag == 'Y'){
				$("input:checkbox[id='outerFlag']").attr("checked", true);
			}
			else{
				$("input:checkbox[id='outerFlag']").attr("checked", false);
			}
			
			/* if(result.activeFlag == 'Y'){
				$("input:checkbox[id='activeFlag']").attr("checked", true);
			}
			else{
				$("input:checkbox[id='activeFlag']").attr("checked", false);
			} */
			
		});
}

/* function useCheck(){
	if($("#activeFlag").is(":checked")){
		return "Y"
	}
	else return "N"
} */

function useOuterCheck(){
	if($("#outerFlag").is(":checked")){
		return "Y"
	}
	else return "N"
}


//타겟 테이블 컬럼 수정
function modifyJoinDef(){
	var obj = {};
	validation = $("#targetTablePopFormArea").ifvValidation();
	
	if(validation.confirm()){
		obj.joinSpecId = joinSpecId;
		obj.destColId = $("#joincolId").text();
		obj.srcFieldId = $("#srcFieldId").text();
		obj.outerFlag = useOuterCheck();
		//obj.activeFlag = useCheck();
		obj.joinSpcDesc = $("#joinSpcDesc").val();
		obj.nmColId = $("#colId").text();
		$.ifvSyncPostJSON('<ifvm:action name="modifyJoinDetail"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			joinDetailList.requestData( { joinDefId : selectjoinId } );
		});
		adminTargetingPopClose();
	}
}


//타겟 테이블 컬럼 저장
function setTJoinDef(){
	var obj = {};
	validation = $("#targetTablePopFormArea").ifvValidation();
	
	if(validation.confirm()){
		obj.joinDefId = selectjoinId;
		obj.destColId = $("#joincolId").text();
		obj.srcFieldId = $("#srcFieldId").text();
		obj.outerFlag = useOuterCheck();
		//obj.activeFlag = useCheck();
		obj.joinSpcDesc = $("#joinSpcDesc").val();
		obj.nmColId = $("#colId").text();
		$.ifvSyncPostJSON('<ifvm:action name="setJoinDetail"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			joinDetailList.requestData( { joinDefId : selectjoinId } );
		});
		adminTargetingPopClose();
	}
}

$(document).ready(function(){
	
	$("#joinDefId").val(selectNm);
	
	if(joinSpecId != null) getJoinDef();
	
	$("#canbtn").on("click", function(){ adminTargetingPopClose(); });
	
	$("#btnSave").on("click", function(){
		if(joinSpecId != null) modifyJoinDef();
		else setTJoinDef();
		
		
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
	
	$('#searchJColumn').on('click', function() {
		joinBtnCehck = false;
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
	
	$('#searchField').on('click', function() {
		$('#fdPop').ejDialog({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="searchFieldPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01173"/>',
	        width: 900,
	        close : 'fdPopClose'
	    });
		fdPop = $('#fdPop').data("ejDialog");;
	});
	
	$("#joinDefId").val(selectNm);
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
				<label class="col-xs-4 control-label"><spring:message code="M01110"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true"  id="joinDefId"/>
					</div>
				</div>
			</div>
			
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M00524"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" required="true" disabled="true" id="joincolId"/>
						<span class="input-group-addon" id="searchJColumn"><i class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
			
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01170"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" required="true" disabled="true" id="srcFieldId"/>
						<span class="input-group-addon" id="searchField"><i class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01169"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" required="true" disabled="true" id="colId"/>
						<span class="input-group-addon" id="searchColumn"><i class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<%-- <div class="col-xs-6">  
				<label class="col-xs-4 control-label"><spring:message code="M01139"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="checkbox" names="" id="activeFlag"/>
					</div>
				</div>
			</div> --%>
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
						<textarea rows="5" id="joinSpcDesc" maxLength="100"></textarea>
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