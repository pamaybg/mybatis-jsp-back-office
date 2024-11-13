<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>
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
var ridCallBack = '<%= cleanXss(request.getParameter("ridCallBack")) %>';
var validation = null;

//상세
function getCBStatusDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="getCBStatusDetail"/>',{
		rid : ridCallBack
	},function(result) {
		$("#modal_cbStatType").val(result.cbStatType);
		$("#modal_cbDesc").val(result.cbDesc);
	},function(result) {
		alert(result.message);
	});
}

//수정
function clickChangeCBStatusBtn(){
	validation = $("#formArea").ifvValidation();

	if(validation.confirm()){
		$.ifvSyncPostJSON('<ifvm:action name="modifyChangeCBStatus"/>',{
			rid : ridCallBack
			, statusCd : $("#modal_cbStatType").val()
			, desc : $("#modal_cbDesc").val()
		},function(result) {
			if(result.success){
				if(mbrNo != "" && mbrNo != "null"){
				 	clickSearchCallBackListBtn();
				}else{
					getCallbackList(null);
				}
				changeCBStatusPopClose();
			}else{
				alert('<spring:message code="M02248"/>');
			}
		});
	}else{
		alert('<spring:message code="M01055"/>');
	}
}

function init(){
	$.ifvGetCommCodeList('select', 'modal_cbStatType', '<ifvm:action name="getCommCodeList"/>', 'NOR_TM_RESULT', 'voc', false, false, true);
	
	getCBStatusDetail();
}

$(document).ready(function(){
	init();
});
</script>

<div id='formArea'>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="modal_cbStatType" names="modal_consultType1st" label="V00217" labelClass="2" conClass="6" required="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="modal_cbDesc" label="L00885" labelClass="2" conClass="8" rows="5"/>
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" id=""  text="V00003" btnType="plus" btnFunc="clickChangeCBStatusBtn"/>
	<ifvm:inputNew type="button" id=""  text="M00805" btnType="" btnFunc="changeCBStatusPopClose"/>
</div>