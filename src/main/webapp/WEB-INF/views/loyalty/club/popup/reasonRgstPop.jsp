<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal top_well underline" id="clubMbrDetail">
<br>
	<div class="row">
		<ifvm:inputNew type="select" id="reason" names="reason" label="L00660" labelClass="2" conClass="8" required="true"/>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="saveResnBtn" objCode="reasonRgstPopSave_OBJ">
		<spring:message code="M01855" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="cancelResnBtn" objCode="reasonRgstPopCancel_OBJ">
		<spring:message code="M01856" />
	</button>
</div>

<script type="text/javascript">
function saveResn(){
	var c_rid =[];
	var checkedList = clubMbrList.opt.gridControl.getSelectedRecords();
	if (checkedList.length == 0) {
		alert('<spring:message code="I02051"/>');
	}else{
		for(var i = 0; i < checkedList.length; i++){
			c_rid.push(checkedList[i].rid);
		}
	}
	if (c_rid.length>0) {
	    $.ifvSyncPostJSON('<ifvm:action name="saveResnRgst"/>', {
	        rid : clubRid,
	    	ridList : c_rid,
	    	statCd : statType,
	    	reason : $("#reason").val()
	    }, function(result) {
	    	alert('<spring:message code="L02031"/>');
	    	reasonRgstPopupClose();
	    	getClubMbrList();
	    });
	}
	
}

$(document).ready(function(){
	
	if(statType == 'C'){
		$.fn.ifvmSetSelectOptionCommCode("reason", "LOY_CL_REJECT_CD", null, null, true);
	}else if(statType == 'W'){
		$.fn.ifvmSetSelectOptionCommCode("reason", "LOY_CL_WITHDRAW_CD", null, null, true);
	}else{
		alert('error');
		reasonRgstPopupClose();
	}
	
	$("#saveResnBtn").click(function(){
		saveResn();
	});
	
	$("#cancelResnBtn").click(function(){
		reasonRgstPopupClose();
	});
});
</script>