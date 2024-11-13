<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/views/layouts/default/sessionScript.jsp" />
<style>
	.notice{
	}
</style>
<script type="text/javascript">
var startTime;
var timeCount;

//타이머 시작
function timerStart(){
	timeCount = 180;	//3분 설정 
	startTime = setInterval(timerCal,1000);	//1초마다 실행
}

//타이머 시간계산
function timerCal(){
	timeCount = timeCount - 1; //1초씩감소  
	timeMinute = Math.floor(timeCount/60);
	if(Math.floor(timeCount/60) < 10){timeMinute = '0'+ timeMinute;} 

	timeMinute = timeMinute + ":"; //01:00 , 02:00 ....

	if((timeCount%60)<10){timeMinute = timeMinute + '0';} // 초 01,02,03 ...

	timeMinute = timeMinute + (timeCount%60);
	
	$("#timeRemain").text(timeMinute);
	
	if(timeCount == 0)timerStop() // 타이머종료 
	
}

//타이머종료
function timerStop(){
	clearInterval(startTime)
}

//SMS 인증번호전송
function transCertiSms(){
	$.ifvSyncPostJSON('<ifvm:action name="checkTelNum"/>', {
		email : $("#id").val()
    },function(result){
    	$.ifvSyncPostJSON('<ifvm:action name="transCertiSms"/>', {
    		email : $("#id").val()
        },function(result){
        	timerStart(); // 타이머시작
        	alert('인증번호를 전송하였습니다. 제한시간안에 입력해주세요.');
        },function(result){
        	alert('인증번호 전송이 실패하였습니다. \n관리자에게 문의하십시오.');
        });
    },function(result){
    	alert('핸드폰번호가 존재하지않습니다. \n관리자에게 문의하십시오.');
    });
}

//SMS 인증 확인
function checkCertiSms(){
	
	var validation = $('#certiFrom').ifvValidation();
	if(validation.confirm() === false) {
		alert('인증번호를 입력해주세요.'); //인증번호 입력여부 판단
	} else {
		$.ifvPostHeaderJSON('<ifvm:action name="checkTransCetiSms"/>', {
			email :  $("#id").val(),
			rdmCode : $("#certiPwd").val() 
		},
		{	email :  $("#id").val(),
			password : getEncryptedPassword()
		},function(result){
			loginConfirmSuccess(result);
		},function(result){
			loginConfirmError(result);
			$('#reTransBtn').text('재전송');
		});
	}
}

$(document).ready(function(){
	
	timerStop();
	$("#timeRemain").val('');
	
	//확인 버튼 클릭시
	$("#certiPwdBtn").on('click',function(){
		checkCertiSms();
	});
	
	//전송 버튼 클릭시
	$("#reTransBtn").on('click',function(){
		$("#transCnt").text(parseInt($('#transCnt').text()) + 1); //전송 최대 5회
		if($("#transCnt").text() < 6){
			transCertiSms();
		}else{
			alert('전송 최대횟수를 초과하였습니다.\n재로그인후 다시시도해주세요.');
		}
	});
});
</script>

<div class="modal-dialog" style="width:500px;">
	<div class="modal-content">
		<div class="modal-header">
	   		<button type="button" class="close" onclick="$.modalClose()">&times;</button>
	   		<h4 class="modal-title">SMS 인증</h4>
  		</div>
	    <div class="modal-body">
	    	<div id ='certiFrom'>
	    		<div class="row qt_border">
	    			<div class="col-xs-2 control-label" style="vertical-align: middle;"><span class="asterisk">*</span>인증번호</div>
	    			<div class="col-xs-4">
	    				<input type="text" id="certiPwd" style="height: 23px; width: 150px;" required="true"/>
	    			</div>
	    			<div class="col-xs-3" style="padding-left: 10px;">
	    				<button id="certiPwdBtn" class="certiPwdBtn" style="height:23px; padding: 3px;width: 50px;">확인</button>
	    				<button id="reTransBtn" class="reTransBtn"   style="height:23px; padding: 3px;width: 50px;">전송</button> 
	    			</div>
	    			<div class="col-xs-2" style="padding-left: 10px; text-align:center; vertical-align: middle;">
	    				<span id="timeRemain" style="color: #44bb44;"></span>
	    			</div>
	    		</div>
	    		<div class="row qt_border">
	    			<div class="col-xs-2 control-label"></div>
	    			<div class="col-xs-8"><span id="notice" class="notice" style="color:red; font-size:10px">※제한시간안에 인증코드를 입력해주세요.</span></div>
	    			<p id="transCnt" style="visibility:hidden;">0</p>
	    		</div>
	    	</div>
	    </div>
 	</div>
</div>