<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//세그먼트 새로 생성
function saveNewSegment(){
	
	var newTarget = targetLevelId;
	
	if(typeof(confilterid) != "undefined" && confilterid != null ){
		
		var obj = {};
		
		obj.segId = confilterid;
		obj.segNm = $("#saveSegName").val();
			
		/* 퀵캠페인일 경우 세그먼트 복사  */
		$.ifvPostJSON('<ifvm:action name="targetCopySegment"/>',obj
		,function(result) {
			
			var obj = $.ifvCachedHtml('<ifvm:url name="userTargetingLoad"/>');
			$('#segmentContent').html(obj.responseText);
			if(typeof(quickFlag) != "undefined" && quickFlag != null){
				loadUiSetting();
				targetLevelId = newTarget;
				confilterid = result.message;
				init(); 
			}
			else{
				targetLevelId = newTarget;
				confilterid = result.message;
				qtjs.href('<ifvm:url name="userTargeting"/>?id='+confilterid+"&targetLevelId="+targetLevelId);
			}
			
		});
		
		segmentPopupClose();
		
	}
	else{
		if($("#saveSegName").val() != null && $("#saveSegName").val() != ""){
			$.ifvPostJSON('<ifvm:action name="setNewSegment"/>', {
				   segName : $("#saveSegName").val()
				   ,targetLevelId : newTarget
			}, function(result) {
				
				var id = result.message;
				if(result.success){
					alert("<spring:message code='M00624'/>");
					
					if(typeof(quickFlag) != "undefined" && quickFlag != null){
						var obj = $.ifvCachedHtml('<ifvm:url name="userTargetingLoad"/>');
						$('#segmentContent').html(obj.responseText);
						loadUiSetting();
						targetLevelId = newTarget;
						confilterid = id;
						init(); 
						
						userMainPopClose();
						
					}
					else{
						qtjs.href('<ifvm:url name="userTargeting"/>?id='+id+"&targetLevelId="+targetLevelId);
					}
					
					
				}
				else{
					alert('<spring:message code="M01050"/>');	
				}
		
			}, function(result){
				alert('<spring:message code="M00258"/>');
			});
			segmentPopupClose();
		}
		else {
			alert('<spring:message code="M00672"/>');
		}
	}
	
	//타겟 레벨아이디 초기화
	//targetLevelId="";

}


$(document).ready(function(){
	
	if(newSegFlag){
		$("#segmentNewName").text('<spring:message code="M00664"/>');
	}
	else{
		$("#segmentNewName").text('<spring:message code="M00672"/>');
	}
	
	
	
	$("#segmentPopConfirmBtn").on("click", function(){
		//기본내용 저장
		saveNewSegment();
		
	});
	
});
</script>

<div class="pop_inner_wrap">
	<label id="segmentNewName"><spring:message code="M00672"/></label>
	<ifvm:input type="text" id="saveSegName"/>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="segmentPopConfirmBtn">         
		<spring:message code="M00279"/>
	</button> 
</div>