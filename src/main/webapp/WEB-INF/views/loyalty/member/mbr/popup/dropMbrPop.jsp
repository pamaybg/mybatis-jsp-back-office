<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="dropMbrRsnForm">
<br>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="secsnResnCd" names="secsnResnCd" dto="secsnResnCd" label="탈회 사유" labelClass="2" conClass="8"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="secsnResnEtc" names="secsnResnEtc" dto="secsnResnEtc" label="탈회 사유(추가)" labelClass="2" conClass="8" rows="3" maxLength="200"/>
	</div>
<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="dropMbrBtn" objCode="dropMbrBtn_OBJ">
		<spring:message code="탈퇴" />
	</button> 
	<button class="btn btn-sm btn_gray"  id="closeDropPopBtn" objCode="closeDropPopBtn_OBJ">
		<spring:message code="L00941" />
	</button> 
</div>
<script type="text/javascript">

function withdrawMbr(){
	if(confirm('<spring:message code="탈퇴하시겠습니까?"/>')){
		$.ifvSyncPostJSON('<ifvm:action name="withdrawMbr"/>',{
				  mbrNo : mbrNo
				, userId : user_id
				, pgmNo : pgmNo
				, secsnResnCd : $("#secsnResnCd").val()
				, secsnResnEtc :  $("#secsnResnEtc").val()
		}, function(result){
			if(result.message) alert(result.message);
			else alert("탈퇴 성공");
			dropMbrPopup._destroy();
			//qtjs.href('<ifvm:url name="mbrListNewPage"/>');
			history.back();
		},function(result){
			if(result.message) alert(result.message);
			else alert("탈퇴 실패");
		});
	}
	
}

$(document).ready(function(){
	$.fn.ifvmSetSelectOptionCommCode("secsnResnCd", "LOY_SECSN_REASON_CD", null, null, true);
	
	$("#dropMbrBtn").click(function() {
		withdrawMbr();
    });
	
	$("#closeDropPopBtn").click(function() {
		$.fn.ifvmPopupClose();
    });
});
</script>