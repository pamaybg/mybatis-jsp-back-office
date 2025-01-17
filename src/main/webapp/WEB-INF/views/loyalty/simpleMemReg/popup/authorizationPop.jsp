<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
</script>

<script>
function tabContent(){
	testTab = $('#tabContent').DrawTab({
		item: [
			{label:'<spring:message code="L00813"/>' , href: '<ifvm:url name="moblieAuthorization"/>'},
			{label:'<spring:message code="L00814"/>' , href: '<ifvm:url name="mypinAuthorization"/>' },
		]
	});
}

$(document).ready(function(){
	tabContent();
})

</script>
 <div id="tabArea">
	<div id="tabContent" ></div> 
 </div>