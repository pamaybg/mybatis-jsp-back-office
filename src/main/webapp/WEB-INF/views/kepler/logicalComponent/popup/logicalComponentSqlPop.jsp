<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
function logicalComponentSqlPop_Init(){
	$("#txtArSql").text(lgcCompData.lgcSql);
}

$(document).ready(function(){
	
	logicalComponentSqlPop_Init();
	
	$("#btnSqlPopClose").on("click", function(){
		logicalComponentPopClose();	
	});
});
</script>


<div class="pop_inner_wrap">
	<ifv:input type="textarea" id="txtArSql" readonly="true" rows="30"/>
</div>
<div class="pop_btn_area">
	<button id="btnSqlPopClose" class="btn btn-sm btn_lightGray2 cancel" objCode="lcsbtnSqlPopClose_OBJ">     
		<spring:message code="M00441"/>
	</button>
</div>