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
<style>
#conditionMain_con {
    border-bottom: 0px;
}
#targetGroupDetail_area #saveConditionBtnArea {
    display: none;
}
</style>

<script>
var conditionId = '<%= cleanXss(request.getParameter("conditionId")) %>';
$(document).ready(function() {
    
    
    
    
});
</script>

<jsp:include page="/WEB-INF/views/marketing/chargingStation/stnConditionMain.jsp" />