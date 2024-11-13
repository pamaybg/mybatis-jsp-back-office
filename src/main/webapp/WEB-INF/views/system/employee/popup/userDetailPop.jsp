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

<script>
var empNo = "<%= cleanXss(request.getParameter("empNo")) %>";
var ridUser = "<%= cleanXss(request.getParameter("ridUser")) %>";
var idEmployee = "<%= cleanXss(request.getParameter("id")) %>";

var validation;
var isUserValid;
var userPwChanged;
var isChanged = false;
var userStat = null;

function userDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="getUserDetail"/>',{
		rid : ridUser
	},
	function(result) {
		$('#rid').val(ridUser);
		$('#empNo').val(result.empNo);
		$('#userId').val(result.userId);
		$('#userPw_1').val(result.userPw);
		$('#userPw_2').val(result.userPw);
		$('#pwExpirDate').val(result.pwExpirDate);
		$('#userStat').val(result.userStat).attr("selected", "selected");
		$('#acesStartDate').val(result.acesStartDate);
		$('#acesEndDate').val(result.acesEndDate);
		userStat = result.userStat;
	});
};

function setChannelCalendar() {
    var pwExpirDate = $('#pwExpirDate');
	var vaildAcesStartDate = $("#acesStartDate");
	var vaildAcesEndDate = $("#acesEndDate");
	
	if(ridUser != null && ridUser != "null"){
		pwExpirDate.val();
	    pwExpirDate.ifvDateChecker({});
	    vaildAcesStartDate.val();
	    vaildAcesStartDate.ifvDateChecker({});
	    vaildAcesEndDate.val();
	    vaildAcesEndDate.ifvDateChecker({});
	} else {
		pwExpirDate.val();
	    pwExpirDate.ifvDateChecker({});
		vaildAcesStartDate.val($.ifvGetTodayDate());
	    vaildAcesStartDate.ifvDateChecker({});
		vaildAcesEndDate.val('2091-12-31');
	    vaildAcesEndDate.ifvDateChecker({});
	}

}

function saveUser(){
	validation = $("#userForm").ifvValidation();
	
	isUserValid = validation.confirm();
	
	if(isUserValid){
		if($("#userPw_1").val() == $("#userPw_2").val()){
			
			if(ridUser != null && ridUser != "null"){
	    		//수정
	    		if(isChanged){
	    			//비밀번호 변경 했을 시
	    			$.ifvPostJSON( '<ifvm:action name="updateUserDetail"/>',
	            			{
	        					ridLoyPgm : $('#ridLoyPgm').val()
	        					, userId : $('#userId').val()
	        					, userPw : $('#userPw_1').val()
	        					, pwExpirDate : $('#pwExpirDate').val()
	        					, userStat : $('#userStat').val()
	        					, acesStartDate : $("#acesStartDate").val()
	    						, acesEndDate : $("#acesEndDate").val()	        					
	        					, ridCrmuser : ridUser
	            			},
	            			function(result) {
	            				
	            				if(result.message == '1'){
	            					alert('<spring:message code="I00741"/>');
	            					userDetailPopupClose();
	            					userList(idEmployee);
	            				}else{
	            					alert('<spring:message code="M01912"/>');
	            					$('#userId').focus();
	            				}
	            				isChanged = false;
	            			},
	            			function(result){
	            				if(result.message == '1'){
	            					//입력한 현재 비밀번호가 기존의 현재 비밀번호와 일치하지 않는 경우
	            					alert('<spring:message code="V00178"/>');
	            				}else if(result.message == '2-1'){
	            					//변경할 비밀번호가 현재 비밀번호와 같은 경우
	            					alert('<spring:message code="V00179"/>');
	            				}else if(result.message == '2-2'){
	            					//변경할 비밀번호가 첫번째 이전 비밀번호와 같은 경우
	            					alert('<spring:message code="V00180"/>');
	            				}else if(result.message == '2-3'){
	            					//변경할 비밀번호가 두번째 이전 비밀번호와 같은 경우
	            					alert('<spring:message code="V00181"/>');
	            				}else if(result.message == '3'){
	            					//변경할 비밀번호에 로그인 사용자 아이디가 포함된 경우
	            					alert('<spring:message code="V00182"/>');
	            				}else if(result.message == '4'){
	            					//직원일 경우, 변경할 비밀번호에 사번이 포함된 경우
	            					alert('<spring:message code="V00183"/>');
	            				}else if(result.message == '5-1'){
	            					//변경할 비밀번호는 10자리 이상 16자리 미만
	            					alert('<spring:message code="V00184"/>');
	            				}else if(result.message == '5-2'){
	            					//변경할 비밀번호에 한글이 포함된 경우
	            					alert('<spring:message code="V00185"/>');
	            				}else if(result.message == '5-3'){
	            					//변경할 비밀번호에 공백이 포함된 경우
	            					alert('<spring:message code="V00186"/>');
	            				}else if(result.message == '5-4'){
	            					//변경할 비밀번호에 영문, 특수문자, 숫자 중 두가지 이상 조합이 아닌 경우
	            					alert('<spring:message code="V00187"/>');
	            				}else if(result.message == '5-5'){
	            					//대문자, 소문자, 숫자, 특수문자 중 2종류 이상 문자를 조합하여 최소 10자리 이상 입력
	            					alert('<spring:message code="C00158"/>');
	            				}else if(result.message == '5-6'){
	            					//대문자, 소문자, 숫자, 특수문자 중 3종류 이상 문자를 조합하여 최소 8자리 이상 입력
	            					alert('<spring:message code="C00159"/>');
	            				}else if(result.message == '5-7'){
	            					//4자리 이상 연속된 문자나 숫자는 사용 불가함
	            					alert('<spring:message code="C00160"/>');
	            				}else if(result.message == '5-8'){
	            					//4자리 이상 반복 문자나 숫자는 사용 불가함
	            					alert('<spring:message code="C00161"/>');
	            				}else{
	            					alert('<spring:message code="V00188"/>');
	            				}
	            			}
	            		);
	    		}else{
	    		//비밀번호 변경 안 했을 시
	    			$.ifvPostJSON( '<ifvm:action name="updateUserDetail"/>',
	            			{
	        					ridLoyPgm : $('#ridLoyPgm').val()
	        					, userId : $('#userId').val()
	        					, pwExpirDate : $('#pwExpirDate').val()
	        					, userStat : $('#userStat').val()
	        					, acesStartDate : $("#acesStartDate").val()
	    						, acesEndDate : $("#acesEndDate").val()
	        					, rid : ridUser
	            			},
	            			function(result) {
	            				if(result.message == '1'){
	            					alert('<spring:message code="I00741"/>');
	            					userDetailPopupClose();
	            					userList(idEmployee);
	            				}else{
	            					alert('<spring:message code="M01912"/>');
	            					$('#userId').focus();
	            				}
	            				isChanged = false;
	            			},
	            			function(result){
	            				alert('<spring:message code="I00742"/>');
	            			}
	            		);
	    		}
	    		
	    		//상태 변화시 
	    		if($('#userStat').val() != userStat && $('#userStat').val() == "ACTIVE"){
	    			$.ifvSyncPostJSON( '<ifvm:action name="setActiveUserLoginHist"/>',{
	    				  userId : $('#userId').val()
	    				, rid : ridUser
           			},function(){});
	    		}
	    		
	    	}else {
	    		//신규
	    		$.ifvPostJSON( '<ifvm:action name="insertUserDetail"/>',
	        			{
	    					idEmployee : idEmployee
	    					, ridLoyPgm : $('#ridLoyPgm').val()
	    					, userId : $('#userId').val()
	    					, userPw : $('#userPw_1').val()
	    					, pwExpirDate : $('#pwExpirDate').val()
	    					, userStat : $('#userStat').val()
	    					, empNo : $("#empNo").val()
	    					, acesStartDate : $("#acesStartDate").val()
	    					, acesEndDate : $("#acesEndDate").val()
	        			},
	        			function(result) {
	        				if(result.message == '1'){
	        					alert('<spring:message code="I00741"/>');
	        					userDetailPopupClose();
	        					userList(idEmployee);
	        				}else{
	        					alert('<spring:message code="M01912"/>');
	        					$('#userId').focus();
	        				}
	        				isChanged = false;
	        			},
	        			function(result){
            				if(result.message == '3'){
            					//변경할 비밀번호에 로그인 사용자 아이디가 포함된 경우
            					alert('<spring:message code="V00182"/>');
            				}else if(result.message == '4'){
            					//직원일 경우, 변경할 비밀번호에 사번이 포함된 경우
            					alert('<spring:message code="V00183"/>');
            				}else if(result.message == '5-1'){
            					//변경할 비밀번호는 10자리 이상 16자리 미만
            					alert('<spring:message code="V00184"/>');
            				}else if(result.message == '5-2'){
            					//변경할 비밀번호에 한글이 포함된 경우
            					alert('<spring:message code="V00185"/>');
            				}else if(result.message == '5-3'){
            					//변경할 비밀번호에 공백이 포함된 경우
            					alert('<spring:message code="V00186"/>');
            				}else if(result.message == '5-4'){
            					//변경할 비밀번호에 영문, 특수문자, 숫자 중 두가지 이상 조합이 아닌 경우
            					alert('<spring:message code="V00187"/>');
            				}else if(result.message == '5-6'){
            					alert('대문자, 소문자, 숫자, 특수문자 중 3종류 이상 문자를 조합하여 최소 8자리 이상 입력 해주세요.');
            				}else{
            					alert('<spring:message code="V00188"/>');
            				}
	        			}
	        		);
	    	}
			
		}else{
			alert('<spring:message code="V00189"/>');
		}
		
	}else{
		alert('<spring:message code="M01055"/>');
	}
	
}

function init(){
	$('#empNo').val(empNo);
	
	$.fn.ifvmSetSelectOptionCommCode("userStat", "CRM_USER_STATUS", null, null, false);
	
	setChannelCalendar();
	
	if(ridUser != null && ridUser != "null"){
		//상세
		userDetail();
	}else{
		//신규
		$("#userId").attr("disabled",false);
		$("#userStat").val($($("#userStat").children()[1]).val());
	}
}

//선택 클릭시
function clickSelectUserDetailBtn(){
	saveUser();
}

//취소 클릭시
function clickCancelUserDetailBtn(){
	userDetailPopupClose();
}

$(document).ready(function(){
	
	init();
	
	$('#userPw_1, #userPw_2').change(function(){
		isChanged = true;
	});
	
});
</script>

<div id="pop_main_div">
	<div class="well" id="userForm">
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="empNo" required="true" label="M01909" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="password" id="userPw_1" required="true" label="M00584" labelClass="2" conClass="3"/>
			</div>
		</div>
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="text" id="userId" required="true" label="M00193" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="password" id="userPw_2" required="true" label="V00171" labelClass="2" conClass="3"/>
			</div>
		</div>
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="date" id="pwExpirDate" label="M01910" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="select" id="userStat" names="userStat" label="C00125" labelClass="2" conClass="3" />
				<ifvm:inputNew type="hidden" id="rid" conClass="3" />
			</div>
		</div>
		<div class="row qt_border">
			<div class="form-horizontal">
				<ifvm:inputNew type="date" id="acesStartDate" label="V00300" labelClass="2" conClass="3" required="true" />
				<ifvm:inputNew type="date" id="acesEndDate" label="V00301" labelClass="2" conClass="3" required="true"/>
			</div>
		</div>		
	</div>
	
	
	<div class="pop_btn_area">
		<ifvm:inputNew type="button" id="selectUserDetailBtn" text="V00003" btnFunc="clickSelectUserDetailBtn" objCode="userDetailPopSave_OBJ"/>
		<ifvm:inputNew type="button" id="cancelUserDetailBtn" text="L00124" btnFunc="clickCancelUserDetailBtn" objCode="userDetailPopClose_OBJ"/>
	</div>
</div>
