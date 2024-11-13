<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<div class="form-horizontal underline top_well" id="terminationForm">
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="custName" names="custName" label="L01927" labelClass="3" conClass="7" disabled="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="releaDesc" label="L02582" labelClass="3" conClass="7" rows="5" required="true" maxLength="20"/>	
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="terminationRegBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L02251"/><!-- 등록 -->
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="terminationCancelBtn">
		<spring:message code="L01781"/><!-- 닫기 -->
	</button>
</div>

<script>
var trmRid = '<%= cleanXss(request.getParameter("rid")) %>'
var mbrRid ='<%= cleanXss(request.getParameter("mbrRid")) %>';
$(document).ready(function(){
	
	//마스킹해제된 이름 가져오기
	ClearNm();
	
	//닫기
	$("#terminationCancelBtn").on("click",function(){
		terminationPopupClose();
	});
	
	//등록
	$("#terminationRegBtn").on("click",function(){
		terminationCancel();
	});
	
});

//마스킹해제된 이름 가져오기
function ClearNm() {	
	if ($.fn.ifvmIsNotEmpty(trmRid)) {
	    $.ifvSyncPostJSON('<ifvm:action name="LimitMbrClearMask"/>', {
	        rid: trmRid
	    },
	    function(result) {
	    	$('#custName').val(result.unMaskCustNm);
	    });
	}
}

//부정등록 해지
function terminationCancel(){
	var releaDesc = $('#releaDesc').val();
	validation = $("#terminationForm").ifvValidation();
	
	if(validation.confirm() && confirm('<spring:message code="L02570" />')){/* 해지하시겠습니까? */
		$.ifvSyncPostJSON('<ifvm:action name="terminationCancel"/>',{
			rid : trmRid,
			releaDesc : releaDesc
		}, function(result) {
	        if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	            	$.ifvSyncPostJSON('<ifvm:action name="InsertMbrMsg"/>',{
	            		mbrRid : mbrRid,
	            		type   : "BLACK_MEM",
	            		evtRid : eventRid,
	            		crudType : "CAN_CEL",
	            		rid		 : trmRid
	            	},function(result) {
	            		
	            	});
	                alert('<spring:message code="L02571" />');/* 해지가 완료되었습니다. */
	                getLimitMbrList();
	                terminationPopupClose();
	            }
	        }
	    });
	}
}
</script>
