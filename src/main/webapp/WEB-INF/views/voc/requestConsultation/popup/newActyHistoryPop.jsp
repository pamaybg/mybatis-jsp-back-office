<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.CommonUtil"%>

<script>

var validation = null;


function clickNewActyContentBtn(){
	validation = $("#formArea").ifvValidation();

	if(validation.confirm()){
		$.ifvSyncPostJSON('<ifvm:action name="setActyHistory"/>',{
			ridCust : $("#detail_ridCust").val()
			, cuserId : $("#detail_personInChargeUserId").val()
			, ridCrmuser : $("#detail_personInChargeRid").val()
			, actyType : $("#modal_todoType").val()
			, sbst : $("#modal_consultContent").val()
			, ridSvcReq : rid
			, msgSubject : $("#modal_consultTitle").val()
		},function(result) {
			if(result.success){
				actyHistoryList();
				actyHistoryPopClose();
			}else{
				alert('<spring:message code="M02248"/>');
			}
		});
	}else{
		alert('<spring:message code="M01055"/>');
	}
}

function init(){
// 	$.ifvGetCommCodeList('select', 'modal_todoType', '<ifvm:action name="getCommCodeList"/>', 'TODO_TYPE_SR', 'voc', false, false, true);

	getCommCodeList();

	$("#modal_consultTitle_area").hide();
	
	showTitleArea();
}

function getCommCodeList() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'TODO_TYPE_SR'
	},function(result) {
		var temp = null;
		var tempList = [];

		for(var i=0; i<result.rows.length; i++){
			if(result.rows[i].codeName == '10'
			|| result.rows[i].codeName == '20'
			|| result.rows[i].codeName == '30'
			|| result.rows[i].codeName == '40'
			|| result.rows[i].codeName == '50'
			|| result.rows[i].codeName == '60'
			|| result.rows[i].codeName == '70'
			|| result.rows[i].codeName == '80'
			|| result.rows[i].codeName == '90'
			|| result.rows[i].codeName == '99' ){
				tempList.push(result.rows[i]);
			}

		}
		temp = $("#modal_todoType_temp").tmpl(tempList);
		$("#modal_todoType").append(temp);
	});
}

function showTitleArea(){
	if($("#modal_todoType").val() == "20" 
// 	|| $("#modal_todoType").val() == "30"
			){
		$("#modal_consultTitle_area").show();
	}else{
		$("#modal_consultTitle_area").hide();
	}
}

$(document).ready(function(){
	init();

	$("#modal_todoType").change(function(){
		showTitleArea();
	});
});
</script>

<div id='formArea'>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="modal_todoType" names="modal_consultType1st" label="유형" labelClass="2" conClass="6" required="true"/>
		<script id="modal_todoType_temp" type="text/x-jquery-tmpl">
			<option value="${'${'}codeName}">${'${'}markName}</option>
		</script>
	</div>
	<div class="row qt_border" id="modal_consultTitle_area">
		<ifvm:inputNew type="text" id="modal_consultTitle" label="유형" labelClass="2" conClass="8" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="modal_consultContent" label="내용" labelClass="2" conClass="8" rows="5" required="true"/>
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" id="newActyContentBtn"  text="V00003" btnType="save" btnFunc="clickNewActyContentBtn"/>
	<ifvm:inputNew type="button" id="closePopBtn"  text="M00805" btnType="" btnFunc="actyHistoryPopClose"/>
</div>