<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
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
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0">
        <script src='${pageContext.request.contextPath}/resources/1.4/ifvCommon/js/jquery-2.1.4.min.js' type="text/javascript"></script>
        <script src='${pageContext.request.contextPath}/resources/1.4/ifvCommon/js/lib.js' type="text/javascript"></script>
		<script src='${pageContext.request.contextPath}/resources/1.4/ifvCommon/js/util.js' type="text/javascript"></script>
		<script src='${pageContext.request.contextPath}/resources/1.4/ifvCommon/js/templete.js' type="text/javascript"></script>
		<script src='${pageContext.request.contextPath}/resources/1.4/ifvPopup/js/ifvPopup.js' type="text/javascript"></script>
	 <jsp:include page="/WEB-INF/views/layouts/default/sessionScript.jsp" />
		
		<!-- JQUERY VALIDATE -->
		<script src="${pageContext.request.contextPath}/resources/bootstrap/js/plugin/jquery-validate/jquery.validate.min.js"></script>
		<link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/common/common.css" />
	</head>
	<body>

<div style="font-size:20pt">인증하기 버튼을 눌러 인증을 진행해주세요
<button id="authEmail">인증하기</button></div>
	</body>
</html>


<script>

/* 이메일 인증 페이지(사용시 추후 수정 필요)  */
var tokenId = "<%= cleanXss(request.getParameter( "tokenId" )) %>";

var authDt = new Date();

$(document).ready(function() {
	$('#authEmail').on('click', function(){
			authEmail();
	});
});
			
		
/* email 인증 버튼  */		
function authEmail(){
	var sendObj = {
			tokenId : tokenId,
			authDt : authDt
		 };
			$.ajax({
			type : 'post',
			url : '${pageContext.request.contextPath}/auth/email/authEmailConfirm.do',
			data : JSON.stringify(sendObj),
			dataType : 'json',
			contentType : "application/json; charset=utf-8",
			success : function(obj){
				alert(obj.message);
			},
			error: function(xhr, status, error){
			}
		}); 

}	
</script>