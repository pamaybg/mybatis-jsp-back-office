<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//팝업 닫기
function pointDtlPopClose() {
	$('#pointDialog').ejDialog('destroy');
} 

function getPointAcrlRdmData(){
	return glbPointAcrlDto;
}

</script>

<script id="selectOptionTmpl" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="pop_inner_wrap">
	<div class="form-horizontal">
		<div class="row qt_border store_content_top">
		</div>
		<!-- 테이블명 -->
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="D10016"/></label>	
				<div class="col-xs-8 control_content">
					<div class="input-group">
					<ifvm:input type="text" disabled="true" required="true" id="inputCustNm"/>
					<span class="input-group-addon" id="btnSelectMemberPop">
							<a><i class="fa fa-search"></i></a>
					</span>
				   </div>
				</div>
			</div>
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="D10015"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" id="inputMbrNo" readonly="true" disabled="true"/>
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="D10097"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" id="inputCreateBy" readonly="true" disabled="true"/>
					</div>
				</div>
			</div>
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="D10093"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="select" id="selectPointTxnType" dto="selectPointTxnType" names="selectPointTxnType" disabled="true"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button id="btnPointTxnAcrlRdmSave" class="btn btn-sm btn_gray">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="D10099"/>
	</button>
	<button id="btnPointTxnAcrlRdmCancel" class="btn btn-sm btn_lightGray2 cancel">
		<spring:message code="D10100"/>
	</button>
</div>