<%@page import="com.icignal.common.util.CommonUtil"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>

$(document).ready(function(){
	var lnbMenuObj = {};
	lnbMenuObj.oneDepth = [{txt:'<spring:message code="M00111"/>', link : '/sample/grid/grid' },
	                       {txt:'<spring:message code="M00112"/>', link : '/sample/scrollPage/scrollPage' },
	                       {txt:'forms', link : '/sample/forms/forms' },
	                       {txt:'push', link : '/sample/push/push' },
	                       {txt:'email', link : '/sample/email/email' },
	                       {txt:'uiElements' }];
	
	lnbMenuObj.oneDepth[5].twoDepth =[{txt:'popup', link : '/sample/popup/popup' },{txt:'calendar', link : '/sample/uiElements/uiElements' }];
	
	$("#nav").lnbMenu({
	    data : lnbMenuObj
	});	
});

</script>
<nav class="lnb" id="nav">
    <div class="title" id="lnbMenu_title"></div>
</nav>

<!-- <nav id="nav">
	<ul>
		<li><a href="/sample/grid">Grid</a></li>
		<li><a href="/sample/scrollPage">ScrollPage</a></li>
		<li><a href="/sample/forms">forms</a></li>
		<li><a href="/sample/uiElements">UI Elements</a></li>
	</ul>
</nav> -->