<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

$(document).ready(function(){
	$("#importTypeA").on("click", function(){
		importType = $("#importTypeA").val();
	});
	$("#importTypeB").on("click", function(){
		importType = $("#importTypeB").val();
	});
	$("#importTypeC").on("click", function(){
		importType = $("#importTypeC").val();
	});
});

</script>
	

<div class="fileUpFormArea">
	<label class="col-xs-10 description_title"><spring:message code="M01770"/></label>
	<div class="col-xs-10 form-horizontal">
		<label class="radio-inline">
			<ifvm:input type="radio" names="importType" values="A" id="importTypeA" checked="true" />
			<spring:message code="M01771"/>
		</label>
	</div>
	<div class="col-xs-10 form-horizontal">
		<label class="radio-inline">
			<ifvm:input type="radio" names="importType" values="B" id="importTypeB" />
			<spring:message code="M01772"/>
		</label>
	</div>	
	<div class="col-xs-10 form-horizontal">	
		<label class="radio-inline">
			<ifvm:input type="radio" names="importType" values="C" id="importTypeC" />
			<spring:message code="M01773"/>
		</label>
	</div>
</div>
