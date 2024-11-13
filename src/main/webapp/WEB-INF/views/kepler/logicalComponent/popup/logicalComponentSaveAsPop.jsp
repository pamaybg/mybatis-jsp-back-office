<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function addSaveAs() {
	
	if(!confirm("<spring:message code='M01438' />")){
		return;
	}
	
	lgcCompData.lgcCompNm = $("#inputSaveAsName").val();
	lgcCompData.lgcDesc = $("#inputSaveAsDesc").val();
	
	addLogicalComponentSaveAs();
	
	logicalComponentPopClose();
}

$(document).ready(function(){
	$("#btnSaveAsPopAdd").on("click", function(){
		addSaveAs();
	});
	
	$("#btnSaveAsPopCancel").on("click", function(){
		logicalComponentPopClose();
	});
});
</script>

<div id="contentTypeArea">
	<div class="pop_inner_wrap">
		<div class="form-horizontal">
			<div class="row qt_border store_content_top">
				<!-- 로지컬 컴포넌트명 -->
				<div class="col-xs-12"> 
					<label class="col-xs-4 control-label"><span class="asterisk">*</span><spring:message code="M01427"/></label>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifv:input type="text" id="inputSaveAsName" maxLength="25" />
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="form-horizontal">
			<div class="row qt_border store_content_top">
				<!-- 설명 -->
				<div class="col-xs-12">
					<label class="col-xs-4 control-label"><spring:message code="M00324"/></label>
					<div class="col-xs-8 control_content">
						<div class="input-group">
							<ifv:input type="text" id="inputSaveAsDesc" maxLength="100" />
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="pop_btn_area">
		<!-- 저장 -->
		<button id="btnSaveAsPopAdd" class="btn btn-sm btn_gray" objCode="lcsbtnSaveAsPopAdd_OBJ">
			<i class="glyphicon glyphicon-check"></i>         
			<spring:message code="M00137"/>
		</button>
		<!-- 취소 -->
		<button id="btnSaveAsPopCancel" class="btn btn-sm btn_lightGray2 cancel" objCode="lcsbtnSaveAsPopCancel_OBJ">     
			<spring:message code="M00171"/>
		</button>
	</div>
</div>