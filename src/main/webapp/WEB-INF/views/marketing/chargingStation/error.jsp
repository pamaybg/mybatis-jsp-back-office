<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
	<head>
		<title>페이지 오류</title>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0">
	</head>
	<body>
		<div class="auth_container">
			<div class="er_header">
				<p>페이지 오류</p>
			</div>
			<div class="er_body">
				<div class="er_logo">
				</div>
					<p class="desc_main">요청하신 페이지를 찾을 수 없습니다.</p>
				<p class="desc_sub">${message}</p>
				<br/>
			</div>
		</div>
	 </body>
</html> 
