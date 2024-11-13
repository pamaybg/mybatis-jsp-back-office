<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
$(document).ready(function(){
	
	//선택 클릭시
    $('#DeleteSelectBtn').on('click', function(){
    	clickDeleteEmployee();
    });
	
  	//취소 클릭시
    $('#DeleteCancelBtn').on('click', function(){
    	beforeDeletePopupClose();
    });
});
</script>

<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div><spring:message code="M01913"/></div>
	</div>
	
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="DeleteSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
			<spring:message code="M01854"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="DeleteCancelBtn">
	    <spring:message code="L00124"/>         
	    </button> 
	</div>
</div>
