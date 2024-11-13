<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

$(document).ready(function() {
	
	objectTypeCommonCode();
	$("#validationArea").dataSetting(setDtoData);
});

function objectTypeCommonCode(){
	
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'UI_VIEW_CD'
	},function(result){
		
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#objectTypeWrap").append(temp);
	});
};

function authDetailsave(){
	$.ifvSyncPostJSON('<ifvm:action name="authDetailsave"/>', {
		viewType: $("#objectTypeWrap").val(),
		id: setDtoData.id
	},function(result){
		alert("저장되었습니다.");
		authPopupClose();
		objectListCon._doAjax();
		
	},function(result){
		
	});
}

</script>

<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="well underline form-horizontal" id="validationArea" >			
	
	<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>오브젝트명</label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="text" dto="objNm" maxLength="50" required="true" disabled="true" />
			</div>
		</div>
		</div>
		
			<div class="row qt_border">
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>오브젝트코드</label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="text" dto="objType" maxLength="50" required="true" disabled="true" />
			</div>
		</div>
		<label class="col-xs-2 control-label"><span class="asterisk">*</span>오브젝트설명</label>
			<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" id="text" dto="objDesc" maxLength="50" required="true" disabled="true" />
			</div>
		</div>
		</div>
</div>
	

<!-- </div> -->

<div class="pop_btn_area">
	<button id="btnSave" class="btn btn-sm btn_gray" onClick="authDetailsave()">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00170" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnClosePop" onClick="authPopupClose()"><spring:message code="M00441" /></button>
</div>

<div id="commCodeExParDialog" class="popup_container"></div>