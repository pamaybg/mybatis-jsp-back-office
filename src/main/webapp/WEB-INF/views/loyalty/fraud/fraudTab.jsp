<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>



<style>
.well{margin-bottom:0;}
.top_well{border-bottom:0;}
</style>

<div class="page-title">
	<h1>
		부정 적립
	</h1>

</div>


<div id="fraudtabTabArea">
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>
<!-- 탭영역 -->
<!-- <div id="tabArea"></div> -->

<!-- <script> -->
<!-- // var policyDetailTab = $('#tabArea').DrawTab({ -->
<!-- // 	item : [ -->
<%-- // 		{ 	label : '<spring:message code="L00135"/>', href : '<ifvm:url name="pgmChnlListNew"/>' } //채널 --%>
<!-- // 	] -->
<!-- // }); -->
<!-- </script> -->

<script type="text/javascript">
	var mbrDetailTab = $('#fraudtabTabArea').DrawTab({
		item : [
			{ label : '직원'   , href : '<ifvm:url name="fraudEmp"/>' },
			{ label : '1일 구매 대상자'   , href : '<ifvm:url name="fraudDayTxnTarget"/>' },
			{ label : '매장별'   , href : '<ifvm:url name="fraudChannel"/>' },
			{ label : '당월 적립횟수 상위자'   , href : '<ifvm:url name="fraudAcrlCntTop"/>' },
			{ label : '당월 적립 5만원 이상'   , href : '<ifvm:url name="fraudAcrlPntTop"/>' }

		]
	});
</script>


<div id="popupContainer" class="popup_container"></div><!-- 팝업 -->
