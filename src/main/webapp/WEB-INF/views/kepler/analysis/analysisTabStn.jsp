<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var itemList = null;

//BI 탭 관리 목록 조회
function getBIManageTabList(){
	$.ifvSyncPostJSON('<ifvm:action name="getManageTabList"/>',{
		clientFlag : '1'
	},function(result) {
		itemList = [];
		for(var i=0; i<result.rows.length; i++){
			var data = new Object();
			var modifiedTabLinkUrl = result.rows[i].tabLinkUrl.replace("externalRequest", "externalRequest/include");
			modifiedTabLinkUrl = modifiedTabLinkUrl.substring(modifiedTabLinkUrl.indexOf("externalRequest")-1, modifiedTabLinkUrl.length+1);
			
			data.label = result.rows[i].tabNm;
			data.href = 	window.location.protocol 
							+ "//" 
							+ window.location.hostname;
			
			if(location.port != "") {
				data.href += ":"
				data.href += location.port; 
			}
			
			data.href += modifiedTabLinkUrl;
			
			itemList.push(data);			
		}
	},function(result){
		alert(result.message);
	});
}

//탭 컨텐츠 생성
function tabContent(){
	$('#tabContent').DrawTab({
		item: itemList
	});
}

$(document).ready(function(){
	getBIManageTabList();
	
	tabContent();
});
</script>

<div class="page-title">
	<h1>
		<spring:message code="S00073"/>
	</h1>
</div>

<!-- 탭 컨텐츠 -->
<div id="tabArea">
	<div class="btn-group btn-group-justified" id="tabType">
	       <div id="tabContent" ></div>
	</div>
</div>