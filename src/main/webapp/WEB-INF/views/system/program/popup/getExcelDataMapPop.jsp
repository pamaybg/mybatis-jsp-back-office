<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.BeansUtil" %>
<script>

	//조회
	function getDtlExcelData(){
	
		$.ifvSyncPostJSON('<ifvm:action name="getDtlExcelData"/>',{ridExcelH : rid, dRid : dRid}
			,function(result) {			
				$("#headNm").val(result.headNm);
				$("#excelCell").val(result.excelCell);
				$("#dataField").val(result.dataField);
			});
	}
	function setExcelData() {
		var obj = {};
		validation = $("#excelDataMapPopFormArea").ifvValidation();

		if (validation.confirm()) {
			obj.headNm = $("#headNm").val();
			obj.excelCell = $("#excelCell").val();
			obj.dataField = $("#dataField").val();
			obj.ridExcelH = rid;

			$.ifvSyncPostJSON(
					'<ifvm:action name="setExcelData"/>', obj,
					function(result) {
						alert('<spring:message code="M00623"/>');
						ExcelDataMapPopupClose();
						dataMapList(rid);
					});
		}
		
	}

	function ExcelDataMapPopupClose() {
		ExcelDataMapPopup._destroy();
	}
	
	function modifyExcelData(){
		var obj = {};	
		validation = $("#excelDataMapPopFormArea").ifvValidation();
		
		if(validation.confirm()){
			obj.headNm = $("#headNm").val();
			obj.excelCell = $("#excelCell").val();
			obj.dataField = $("#dataField").val();
			obj.dRid = dRid;
			obj.rid = rid;
			
			$.ifvSyncPostJSON('<ifvm:action name="editExcelData"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
			});
		}
		ExcelDataMapPopupClose();
		dataMapList(rid);
	}

	function addExcelFilePopupClose() {
		addExcelFilePopup._destroy();
	}
	
	$(document).ready(function() {

		$("#excelDataMapPopFormArea").ifvValidation();
			
		if(dRid != null) getDtlExcelData();
		
		$("#excelDataCancel").click(function(){
			ExcelDataMapPopupClose();
		});

		$("#excelDataSaveBtn").on("click", function(){
			if(dRid != null) modifyExcelData();
			else setExcelData();
		});
		
	});
</script>

<div id='excelDataMapPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">	   
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="D10268"/></label>
	        <div class="col-xs-8 control_content">
	            <ifvm:input type="text" id="headNm" rows="1" maxLength="40" required="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="D10266"/></label>
	        <div class="col-xs-8 control_content">
	            <ifvm:input type="text" id="excelCell" rows="1" maxLength="3" required="true" placeholder="A3 B3 C3..."/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="D10267"/></label>
	        <div class="col-xs-8 control_content">
	          <ifvm:input type="text" id="dataField" rows="1" maxLength="100" required="true"/>
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="excelDataSaveBtn" objCode="getExcelDataMapSave_OBJ">       
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="excelDataCancel" objCode="getExcelDataMapCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>