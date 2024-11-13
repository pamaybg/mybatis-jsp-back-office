<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<div class="pop_inner_wrap" id="cerOwnPopWrap">
	<div id="contents">

	</div>
</div>

<script>
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
var chnlTypeCd = '<%= cleanXss(request.getParameter("chnlTypeCd")) %>';
function getContents(){

	var action ='<ifvm:action name="getMbrChnlHistContents"/>';
	var dataObj = {
			rid : rid,
			chnlTypeCd : chnlTypeCd
	}
	$.ifvSyncPostJSON(action, dataObj, function(result) {

		if ($.fn.ifvmIsNotEmpty(result)) {

			$("#contents").html(result.contents);

		}
	})
}


$(document).ready(function(){

	getContents();

});


</script>