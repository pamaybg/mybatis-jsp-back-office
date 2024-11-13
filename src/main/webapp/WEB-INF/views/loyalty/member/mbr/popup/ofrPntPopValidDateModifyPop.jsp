<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal underline top_well" id="modifyOfrPntPop">
<br>
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="ofrNo" names="ofrNo" label="오퍼명" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="ofrNm" names="ofrNm" conClass="4" disabled="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="acrlDesc"  conClass="10" label="사유" required="true" labelClass="2"  rows="3" maxLength="2000"/>
	</div>
	<div class="row qt_border">
				<ifvm:inputNew type="dateTerm" startDto="validStartDate" endDto="validEndDate" startId="validStartDate" endId="validEndDate" required="true" label="O00017" labelClass="2" conClass="8" />
	</div>
</div>
<div class="pop_btn_area">
	<!-- 등록 -->
	<button class="btn btn-sm btn_gray" id="btnSave" objCode="ofrPntValidDateUpdateSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="저장"/>
	</button>
	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="ofrPntValidDateUpdateClose" objCode="ofrPntValidDateUpdateClose_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<script>

function modifyTier(){
	var validation = $("#modifyOfrPntPop").ifvValidation();
	//유효성 체크
	if(validation.confirm()){
		var varData = null;

		if(!confirm('<spring:message code="변경하시겠습니까?"/>') == true) {
			$.ifvProgressControl(false);
			return false;
		}

		varData = {
				acrlRid		       		: rid,
				validStartDate			: $("#validStartDate").val(),
				validEndDate			: $("#validEndDate").val(),
				acrlDesc         		: $("#acrlDesc").val()
		};
		$.ifvSyncPostJSON('<ifvm:action name="modifyPntValidDate"/>', varData
			, function(result) {

					alert("변경되었습니다.");
		    		$.fn.ifvmPopupClose();
		    		ofrPntPopFnClose();
		    		mbrDetail();
			}, function(result) {

		});

	}
}

function setCalender() {
	var validStartDate = $("#validStartDate");
	var validEndDate = $("#validEndDate");
	validStartDate.val(validStartDt);
	validEndDate.val(validEndDt);
	validStartDate.ifvDateChecker({
		maxDate : validEndDate
	});
	validEndDate.ifvDateChecker({
		minDate : validStartDate
	});
}



$(document).ready(function(){

	setCalender();

	$("#ofrNo").val(ofrNo);
	$("#ofrNm").val(ofrNm);


	$("#ofrPntValidDateUpdateClose").click(function(){
		ofrPntPopValidDateModifyClosePop();
	});

	$("#btnSave").click(function(){
		modifyTier();
	});

	//$("#acrlDesc").focus();

	
});

</script>