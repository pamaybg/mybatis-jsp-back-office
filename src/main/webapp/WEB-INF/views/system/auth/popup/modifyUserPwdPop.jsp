<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.BeansUtil" %>

<script type="text/javascript">
var validation = null;

function clickSaveBtn(){
	validation = $("#formArea").ifvValidation();
	var ridCrmuser = null;
	
	//유효성 체크
	if(validation.confirm()){
		//"변경할 비밀번호"와 "변경할 비밀번호 확인"이 같은지 체크
		if($("#modal_mod_password_1").val() == $("#modal_mod_password_2").val()){
			$.ifvSyncPostJSON('<ifvm:action name="modifyUserPwd"/>',{
				ridCrmuser : ifvmUserInfo.id
				, preUserPw : $("#modal_cur_password").val()
				, userPw : $("#modal_mod_password_1").val()
			},function(result) {
				if(pwChangeExp){
					alert('<spring:message code="V00176"/>');
					$.ifvmMarketingLogOut();
				}else{
					alert('<spring:message code="V00177"/>');
				}
				popupContainerClose();
			},function(result) {
				if(result.message == '1'){
					//입력한 현재 비밀번호가 기존의 현재 비밀번호와 일치하지 않는 경우
					alert('<spring:message code="V00178"/>');
				} else if(result.message == '2-1'){
					//변경할 비밀번호가 현재 비밀번호와 같은 경우
					alert('<spring:message code="V00179"/>');
				} else if(result.message.indexOf('2-') != -1){
					//변경할 비밀번호가 이전에 사용한 비밀번호와 같은 경우)
					//alert('<spring:message code="V00180"/>');
					var text = "변경할 비밀번호가 최근 "+"<%=BeansUtil.getApplicationProperty("icignal.login.password.check-cnt")%>"+"번 내의 사용한 비밀번호와 같습니다.";
					alert(text);
				} else if(result.message == '3'){
					//변경할 비밀번호에 로그인 사용자 아이디가 포함된 경우
					alert('<spring:message code="V00182"/>');
				} else if(result.message == '4'){
					//직원일 경우, 변경할 비밀번호에 사번이 포함된 경우
					alert('<spring:message code="V00183"/>');
				} else if(result.message == '5-1'){
					//변경할 비밀번호는 10자리 이상 16자리 미만
					alert('<spring:message code="V00184"/>');
				} else if(result.message == '5-2'){
					//변경할 비밀번호에 한글이 포함된 경우
					alert('<spring:message code="V00185"/>');
				} else if(result.message == '5-3'){
					//변경할 비밀번호에 공백이 포함된 경우
					alert('<spring:message code="V00186"/>');
				} else if(result.message == '5-4'){
					//변경할 비밀번호에 영문, 특수문자, 숫자 중 두가지 이상 조합이 아닌 경우
					alert('<spring:message code="V00187"/>');
				} else if(result.message == '5-5'){
					//대문자, 소문자, 숫자, 특수문자 중 2종류 이상 문자를 조합하여 최소 10자리 이상 입력
					alert('<spring:message code="C00158"/>');
				} else if(result.message == '5-6'){
					//대문자, 소문자, 숫자, 특수문자 중 3종류 이상 문자를 조합하여 최소 8자리 이상 입력
					alert('<spring:message code="C00159"/>');
				} else if(result.message == '5-7'){
					//4자리 이상 연속된 문자나 숫자는 사용 불가함
					alert('<spring:message code="C00160"/>');
				} else if(result.message == '5-8'){
					//4자리 이상 반복 문자나 숫자는 사용 불가함
					alert('<spring:message code="C00161"/>');
				} else{
					alert(result.message + '<spring:message code="V00188"/>');
				}
			});
		}else{
			alert('<spring:message code="V00189"/>');
		}
	}else{
		alert('<spring:message code="M01055"/>');
	}
}

//function popupClose() {
//	$.fn.ifvmPopupClose();
//	//$('#modifyUserPwdPop').ejDialog('destroy');
//}

$(document).ready(function(){
	$("#saveBtn").click(function(){
		clickSaveBtn();
	});

	$("#closeBtn").click(function(){
		popupContainerClose();
	});
	
});

</script>

<style>
.warning_box {
	padding: 15px 15px;
	color: red
}
</style>

<div class="well form-horizontal">
	<div id="formArea">
		<div class="row qt_border">
			<ifvm:inputNew type="password" id="modal_cur_password" label="V00165" labelClass="5" conClass="6" required="true"/>
		</div>	
		<div class="row qt_border">
			<ifvm:inputNew type="password" id="modal_mod_password_1" label="V00166" labelClass="5" conClass="6" required="true"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="password" id="modal_mod_password_2" label="V00167" labelClass="5" conClass="6" required="true" desc="C00152"/>
		</div>
	</div>
	
	<div class="row">
		<div class="warning_box" style="text-align: center;">※비밀번호 변경 주기는 <%=BeansUtil.getApplicationProperty("icignal.login.password.limit-day")%>일 입니다.</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="saveBtn" objCode="modifyUserPwdPopSaveBtn_OBJ">
		<spring:message code="저장" />
	</button>
	<button class="btn btn-sm btn_gray"  id="closeBtn" objCode="modifyUserPwdPopCloseBtn_OBJ">
		<spring:message code="닫기" />
	</button>
	<%--<ifvm:inputNew type="button" id="saveBtn" text="저장" btnFunc="clickSaveBtn" objCode="modifyUserPwdPopSaveBtn_OBJ"/>
	<ifvm:inputNew type="button" id="closeBtn" text="닫기" btnFunc="modifyUserPwdPopClose" objCode="modifyUserPwdPopCloseBtn_OBJ"/>--%>
</div>

