<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="auth_container">
	<div class="er_header">
		<i class="fa fa-exclamation-triangle"></i>
	</div>
	<div class="er_body">
		<p class="desc_main">죄송합니다.<br/>요청하신 페이지를 찾을 수 없습니다.</p>
		<p class="desc_sub">${message}</p>
	</div>
	<div class="er_btn_wrap">
		<button class="qt_btn" onclick="goMain();" >메인으로 돌아가기</button>
	</div>
	<script>
	function goMain() {
			location.href = '/loyalty/member/mbr/mbrListNew';
	}
	</script>
</div>