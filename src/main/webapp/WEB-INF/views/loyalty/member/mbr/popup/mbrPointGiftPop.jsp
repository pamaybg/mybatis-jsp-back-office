<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="mbrPointGiftTabArea"></div>
<script type="text/javascript">
function initTab() {
	$("#mbrPointGiftTabArea").empty();

	mbrPointGiftTabArea = $("#mbrPointGiftTabArea").DrawTab(
    {
    	 item: [
			{
               label: '<spring:message code="포인트양도"/>',
               href: '<ifvm:url name="mbrPointGiftForm"/>'
			},
			{
               label: '<spring:message code="포인트양도이력"/>',
               href: '<ifvm:url name="mbrPointGiftHist"/>'
			}
        ]
    });
}

$(document).ready(function(){
	
	initTab();
	//width 값 초기화
	$(".tab-list").attr("style", "width : ");
})
</script>