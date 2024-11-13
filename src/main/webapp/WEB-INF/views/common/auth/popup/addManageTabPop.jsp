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
var ridManageTab = '<%= cleanXss(request.getParameter("ridManageTab")) %>';
var validation = null;

function init(){
	if(ridManageTab != "null" && ridManageTab != "undefined"){
		//상세
		getManageTabPopDetail();
	}
}

//
function getManageTabPopDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="getManageTabPopDetail"/>',{
		rid : ridManageTab
	},function(result) {

		$("#formArea").dataSetting(result);
	},function(result){
		alert(result.message);
	});
}

function saveManageTabPop(){
	var action = null;
	var data = null;
	var submitData = null;
	validation = $("#formArea").ifvValidation();
	
	if(validation.confirm()){
		
		data = $("#formArea").getSubmitData();
		
		if(ridManageTab != "null" && ridManageTab != "undefined"){
			action = '<ifvm:action name="modifyManageTab"/>';
			submitData = {
				rid : ridManageTab
				, tabSort : data.tabSort
				, tabNm : data.tabNm
				, tabLinkUrl : data.tabLinkUrl
			};
		}else{
			action = '<ifvm:action name="setManageTab"/>';
			submitData = {
				tabSort : data.tabSort
				, tabNm : data.tabNm
				, tabLinkUrl : data.tabLinkUrl
			};
		}
		
		$.ifvSyncPostJSON(action,submitData
		,function(result) {

			if (result.success) {
				alert('<spring:message code="V00219"/>');
				addManageTab.close();
			}
		},function(result){
			alert(result.message);
		});
	
	}else{
		alert('<spring:message code="M01055"/>');
	}
}

$(document).ready(function(){
	init();
});

</script>

<div id='formArea'>
	<div class="row qt_border">
		<ifvm:inputNew type="hidden" id="rid" dto="rid" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="tabSort" dto="tabSort" label="M02727" labelClass="2" conClass="8" required="true" maxLength="8" valiItem="number"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="tabNm" dto="tabNm" label="M02728" labelClass="2" conClass="8" required="true" maxLength="50"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="tabLinkUrl" dto="tabLinkUrl" label="M02729" labelClass="2" conClass="8" rows="5" required="true" maxLength="300"/>
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" id=""  text="V00003" btnType="plus" btnFunc="saveManageTabPop"/>
	<ifvm:inputNew type="button" id=""  text="M00805" btnType="" btnFunc="addManageTab.close"/>
</div>