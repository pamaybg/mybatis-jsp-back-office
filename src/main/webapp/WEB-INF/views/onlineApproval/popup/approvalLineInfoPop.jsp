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
<script>
var campaignApprovalData = {campaignInfo : {}};
var campaignId = '<%= cleanXss(request.getParameter("campaignId")) %>';
var empListPopGrid;

$(document).ready(function() {
    //캠페인기본정보 호출
    $.ifvSyncPostJSON('<ifvm:action name="getCampaignDefaultInfo"/>', {
        id: campaignId
    },
    function(result) {
        if ($.fn.ifvmIsNotEmpty(result)) {
            campaignApprovalData.campaignInfo = result;
        }
    });
    
    
    

});




</script>




<jsp:include page="/WEB-INF/views/marketing/approval/approvalDetail.jsp"/>