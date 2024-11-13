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
<div class="pop_inner_wrap">
	<div id="contents">

	</div>
</div>

<script>
var actyMsgRid = '<%= cleanXss(request.getParameter("actyMsgRid")) %>';

function getActyHistoryMsg(){
	var action ='<ifvm:action name="getActyHistoryMsg"/>';
	var dataObj = {
			rid : actyMsgRid
	}
	$.ifvSyncPostJSON(action, dataObj, function(result) {

		if ($.fn.ifvmIsNotEmpty(result)) {

			$("#contents").html(result.sbst);

		}
	})
}


$(document).ready(function(){
	getActyHistoryMsg();
});
</script>