<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
	$( document ).ready(function() {
		$( "#txtBaseSql" ).text( ANALYSIS_CONFIG.ANALYSIS_SQL.BASE_SQL );
		
		$( "#btnAnalysisSqlPopClose" ).click(function() {
			ANALYSIS_SQL_POP._destroy();
		});
	});
</script>

<div class="pop_inner_wrap">
	<spring:message code="M01713" />
	<ifv:input type="textarea" id="txtBaseSql" readonly="true" rows="30" />
</div>

<div class="pop_btn_area">
	<button id="btnAnalysisSqlPopClose" class="btn btn-sm btn_lightGray2 cancel" objCode="btnAnalysisSqlPopClose_OBJ">    
		<spring:message code="M00441"/>
	</button>
</div>