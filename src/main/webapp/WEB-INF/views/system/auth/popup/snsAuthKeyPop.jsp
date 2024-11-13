<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function naverLoginPop() {
	 $.ifvSyncPostJSON('<ifvm:action name="naverLoginAuth"/>', {
	    },
	    function(result) {
	    	//window.open(result.naverAuthUrl,"","width=600,height=600,left=600");
	    	location.href = result.naverAuthUrl;
	    });
}

function facebookLoginPop() {
	 $.ifvSyncPostJSON('<ifvm:action name="facebookLoginAuth"/>', {
	    },
	    function(result) {
	    	location.href = result.facebookAuthUrl;
	    	//window.open(result.facebookAuthUrl,"","width=600,height=600,left=600");
	    },function(result) {
	    	alert("서비스 준비중입니다.");
	    });
}

function kakaoLoginPop() {
	 $.ifvSyncPostJSON('<ifvm:action name="kakaoLoginAuth"/>', {
	    },
	    function(result) {
	    	//window.open(result.gogleAuthUrl,"","width=600,height=600,left=600");
	    	location.href = result.kakaoAuthUrl;
	    });
}

function gogleLoginPop() {
	 $.ifvSyncPostJSON('<ifvm:action name="googleLoginAuth"/>', {
	    },
	    function(result) {
	    	//window.open(result.gogleAuthUrl,"","width=600,height=600,left=600");
	    	location.href = result.gogleAuthUrl;
	    },function(result) {
	    	alert("서비스 준비중입니다.");
	    });
}

function snsPopupClose() {
	snsAuthKeyPop._destroy();
}

$(document).ready(function() {
	 $("#naverLgoinPopBtn").click(function(){
		naverLoginPop();
	 }); 
	 $("#kakaoLgoinPopBtn").click(function(){
		kakaoLoginPop();
	 });
	 $("#facebookLoginPop").click(function(){
		facebookLoginPop();
	 });
	 $("#gogleLoginPop").click(function(){
		gogleLoginPop();
	 }); 
});
</script>
<div id="snsListArea" style="margin-top:10px; text-align:center;">
<!-- <button id="btnMutiply"> -->
	<img src="<ifvm:image name='sns_naver'/>" width="50" height="50" onclick="naverLoginPop();" style="cursor:pointer; margin:0 10px;"/>
<!-- <button id="kakaoLgoinPopBtn"> -->
	<img src="<ifvm:image name='sns_kakao'/>" onclick="kakaoLoginPop();"  width="50" height="50" style="cursor:pointer; margin:0 10px;"/>
	<img src="<ifvm:image name='sns_gogle'/>" onclick="gogleLoginPop();"  width="50" height="50" style="cursor:pointer; margin:0 10px;"/>
	<img src="<ifvm:image name='sns_facebook'/>" onclick="facebookLoginPop();"  width="50" height="50" style="cursor:pointer; margin:0 10px;"/>
</div>