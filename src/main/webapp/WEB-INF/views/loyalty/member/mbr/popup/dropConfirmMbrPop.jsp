<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<br>
<div class="row qt_border" id="dropConfirmMbrRsnForm">
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" required="true" id="secsnAbleResnEtc" names="secsnAbleResnEtc" dto="secsnAbleResnEtc" label="사유" labelClass="2" conClass="8" rows="3" maxLength="200"/>
	</div>
	<lebel>* 식별키 삭제시, 회원가입이 당일부터 가능합니다.</lebel>
<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="dropConfirmMbrBtn" objCode="dropConfirmMbrConfirm_OBJ">
		<spring:message code="확인" />
	</button> 
	<button class="btn btn-sm btn_gray"  id="closeDropConfirmPopBtn" objCode="dropConfirmMbrClose_OBJ">
		<spring:message code="L00941" />
	</button> 
</div>
<script type="text/javascript">

function dromConfirmMbr(){
	var validation = $("#dropConfirmMbrRsnForm").ifvValidation();
	//유효성 체크
	if(validation.confirm('<spring:message code="식별키를 삭제하겠습니까?"/>')){
	$.ifvSyncPostJSON('<ifvm:action name="mbrSecsnMbrToAble"/>',{
			  ridCust : rid_cust 
			, rid     : ridMbrSecsn
			, custTypeCd : custTypeCd
			, secsnAbleResnEtc :  $("#secsnAbleResnEtc").val()
	}, function(result){
		if(result.message) alert(result.message);
		else alert("식별키 삭제 성공");
		dropConfirmMbrPopup._destroy();
		dropMbrList._doAjax();
	},function(result){
		if(result.message) alert(result.message);
		else alert("식별키 삭제 실패");
	});
	}
	
}

$(document).ready(function(){
	
	$("#dropConfirmMbrBtn").click(function() {
		dromConfirmMbr();
    });
	
	$("#closeDropConfirmPopBtn").click(function() {
		$.fn.ifvmPopupClose();
    });
});
</script>