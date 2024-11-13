<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.BeansUtil" %>

<%
 response.setHeader("Cache-Control","100000");
 response.setHeader("Pragma","cache");
 response.setDateHeader("Expires",0);
%>

<script src='${pageContext.request.contextPath}/resources/js/lib/placeholders.min.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/jquery.json-2.3.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/cryptoJS/aes.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/js/cryptoJS/pbkdf2.js' type="text/javascript"></script>

<script src='${pageContext.request.contextPath}/resources/js/jquery.blockUI.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/1.4/ifvValidation/js/ifvValidation.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/1.4/ifvsfPopup/js/ifvsfPopup.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/1.4/ifvDefault/js/ifvDefault.js' type="text/javascript"></script>
<script src='${pageContext.request.contextPath}/resources/1.4/syncfusion/scripts/ej.widget.dialog.min.js' type="text/javascript"></script>

<script>

//중복로그인 시 기존 세션 종료 여부 (true:기존세션종료)
var preSessionAbortYn = false;
var tokenId = '';
var globalUrl; // SMS 인증팝업에서 사용하는 URL
//loginType = email,sms
var loginType="<%= BeansUtil.getApplicationProperty("icignal.login.double.auth-mehtod")%>";
//loginMethod = single: pwd 검증만, double : pwd and 본인인증
var loginMethod="<%=BeansUtil.getApplicationProperty("icignal.login.auth-type")%>";

var langType="<%=BeansUtil.getApplicationProperty("icignal.context.server.lang")%>"

function getEncryptedPassword () {
	var today = $.ifvGetTodayDate().replace("-", "").replace("-", "");
    var iv = today + window.appServiceId;
    var salt = today + window.appServiceId;
    var plainText = $("#password").val();
    var keySize = 128;
    var iterationCount = 1000;
    var passPhrase = (today + window.appServiceId).substring(0, 16);

    
    var key128Bits100Iterations =
            CryptoJS.PBKDF2(passPhrase, CryptoJS.enc.Hex.parse(salt),
            { keySize: keySize/32, iterations: iterationCount });

    var encrypted = CryptoJS.AES.encrypt(
            plainText,
            key128Bits100Iterations,
            { iv: CryptoJS.enc.Hex.parse(iv) });

    return encrypted.toString();
};

function openDialog (msg) {
	$('#dialog').find('.msg').text(msg)
	$('#dialog').modal();
}

//모달 옵션 셋팅
function setModalOptions () {
	$.modal.defaults = {
	  escapeClose: true,
	  clickClose: true,
	  showClose: false
	};
}

function loginSuccess (result) {
	var obj = JSON.parse(result.message);
	var pwChangeExp = obj.pwChangeExp;
	var pwChangeFirst = obj.pwChangeFirst;
	var duplicatedLogin = obj.duplicatedLogin;
	var url = obj.url;
	var authSmsYn = obj.authSmsYn;
	globalUrl = url;
	
	//패스워드 만료
	if(pwChangeExp == "true"){
		location.href = '${pageContext.request.contextPath}/'+url+'?pwChangeExp=true';
	}
	//최초 로그인
	else if(pwChangeFirst == "true") {
		if(confirm('<spring:message code="M02794"/>')) {
			$.ifvLoadPop({url :'<ifvm:url name="modifyFirstLoginPwdPop"/>', params : {}, close: function(){}});
		} else {
			$.ifvmMarketingLogOut();
		}
	}
	//중복 로그인
	else if(duplicatedLogin == "true") {
		var ip;
	    var ipDate;
	         $.ifvSyncPostJSON('/login/getCrmUserIp.do', {
	       		userId : $("#id").val()
	       	}, function(result) {
	       		ip = result.ip;
	       		ipDate = result.ipDate;
	       		
	       	});
		if(confirm('현재 접속 중인 아이디 입니다.\n(기존접속 IP:'+ip+')\n(로그인 시간:'+ipDate+')\n기존 접속을 끊고 접속하시겠습니까?')) {
			//기존 세션 종료
			preSessionAbortYn = true;
			$("#login-form").submit();

			//기존 세션 종료 여부 초기화
			preSessionAbortYn = false;
		}
	}
	else {
		//SMS 인증 [BAT 전용]
		//기존방식
		location.href = '${pageContext.request.contextPath}/'+url;
	}
}

function loginError (result) {
	var msg = '';
   if(result.message==null){
   	msg ='<spring:message code="V00175"/>';
   }else if(result.message == 'idPwd') {
		msg ='<spring:message code="M00298"/>';
	}else if(result.message == 'overUserPwCnt'){
		msg ='<spring:message code="V00172"/>'; //사용자 비밀번호 입력에 5번 이상 실패하여 30분간 로그인 시도가 제한됩니다.
	}else if(result.message == 'overdueUserPw'){
		msg ='<spring:message code="V00173"/>';
	}else if(result.message.indexOf('.') != -1){
		var empName = result.message.split(",")[0];
		var host = result.message.split(",")[1];
		msg =empName+', '+host+', <spring:message code="V00174"/>';
	}else if(result.message.indexOf("remainingTime") > -1){
		var remainingTime = result.message.split('/')[1];
		if(remainingTime == null || remainingTime === 'null') {
			msg ='<spring:message code="C00157"/>';
		} else {
			msg ='<spring:message code="C00155" arguments="'+remainingTime+'"/>';
		}
	}else if(result.message == 'overEmailAuth'){
		msg ="이메일 인증 시간이 초과 하였습니다. 다시 인증해주세요.";
		$("#emailAuthCheckBtn").attr("disabled",false);
	}else if(result.message == 'notEmailAuth'){
		msg ="이메일 인증후 로그인 해주세요.";
	}else if(result.message == 'notEmailAuthId'){
		msg ="로그인 하려는 email과 인증 email이 다릅니다.";
	}else if(result.message == 'lastLoginDateOver'){
		msg ='<spring:message code="C00175"/>';
	}else if(result.message == 'userStatInactive'){
		msg ='<spring:message code="C00176"/>';
	}else if (result.message == 'acesStartDateOver') {
		msg ='<spring:message code="C00185"/>';
	}else if (result.message == 'acesEndDateOver') {
		msg ='<spring:message code="C00186"/>';
	}else{
		msg ='<spring:message code="V00175"/>';
	}
	openDialog(msg);
}


$(document).ready(function() {
	setModalOptions();
	$("#login-form").validate({
		rules : {
			id : {
				required : true,
				minlength : 1
			},
			password : {
				required : true,
				minlength : 3,
				maxlength : 20
			}
		},
		// Messages for form validation
		messages : {
			id : {
				required : 'Please enter your id'
			},
			password : {
				required : 'Please enter your password'
			}
		},
		// Do not change code below
 		errorPlacement : function(error, element) {
			error.insertAfter(element);
		},
		submitHandler : function (){
			var jsonHeaderData = {
				email : $("#id").val(),
				password : getEncryptedPassword(),
				preSessionAbortYn : preSessionAbortYn,
				tokenId : tokenId,
				loginMethod : loginMethod,
				sendchnl : loginType,
				lang:langType
			}
			$.ifvPostHeaderJSON('<ifvm:action name="MKTLogin"/>', {}, jsonHeaderData, loginSuccess, loginError)
		}
	});
});
</script>

<body>
<div class="login-container">
    <img class="logo" src="${pageContext.request.contextPath}/resources/images/mobile/login.png">
    <h3 class="title bold">DESCENTE KOREA</h3>
    <h3 class="title">매장고객 캠페인 결재 시스템</h3>
    <form action="index.html" method="POST" id="login-form" class="smart-form client-form" novalidate="novalidate">
	    <div class="loginForm">
	      <input type="text" name="id" id="id" placeholder="ID">
	      <input type="password" name="password" id="password" placeholder="Password">
	      <button type="submit" class="btn" id="submitLogin">Login</button>
	    </div>
    </form>
    <div class="info"> 
      비밀번호 분실시 DX팀 강영두 프로에게 디링크로 문의해 주세요
    </div>
  </div>
</body>
<!-- login 실패시 dialog -->
<div id="dialog" class="modal">
	<div class="mobile-dialog-container">
		<div class="mobile-dialog-contents">
			<div class="msg"></div>
		</div>
	</div>
	<div class="mobile-dialog-footer">
		<button type="button" class="confirm" onClick="$.modal.close()">확인</button>
	</div>
</div>
