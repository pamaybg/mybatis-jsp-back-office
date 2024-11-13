<%@page import="com.icignal.common.util.CommonUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<header id="header" class="mobile-header">
  <span class="title">DESCENTE KOREA</span>
  <div class="btn logout" id="logoutBtn">
    로그아웃
  </div>
</header>

<script>
var ifvmUserInfo = $.ifvmGetUserInfo();

$(document).ready(function(){
	$("#logoutBtn").click(function() {
		$.ifvmMarketingLogOut();
		if(window.parent.document.getElementById("TSPhone")){
			TSPhone.AgentLogOut();
       	}
		
	})
	
	$("a[href='avascript:$.ifvmMarketingLogOut();']").click(function(){
		if(window.parent.document.getElementById("TSPhone")){
			TSPhone.AgentLogOut();
       	}
	});
});
</script>