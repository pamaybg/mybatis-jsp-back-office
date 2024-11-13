<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;

//저장
 function setProdDtl(){
	var obj = {};
	var value = false;
	validation = $("#eventWinnerPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.rid = eventRid;

		var _obj = {
			url : '<ifvm:action name = "setProdEntryMultiUpload"/>',
			fileName : $("#fileName").val(),
			data : {
				eventRid : eventRid
			},
		};
		
		fnExcelUpload.data.formData ={	
			param : JSON.stringify(_obj)
		}
		fnExcelUpload.upload();
		getEventApplicantList();
		prodExcelUploadClosePop();
	}
	else{
		alert('파일을 등록해주세요.');
		return;
	}
}

function fileSearchFn() {
	fnExcelUpload(
		{
			url: '<ifvm:action name="setProdEntryMultiUpload"/>',
			fileName: $("#fileName").val(),
			data: {
		},
	}, function (result) {
		alert(result.message);
		$.ifvProgressControl(false);
	}
	, function (){
		// File 선택 후 동작 할 액션을 정의 한다.
		$('#fileName').val(fnExcelUpload.fileName);
	});
}

$(document).ready(function(){
	
	$("#eventWinnerPopFormArea").ifvValidation();

	$("#eventWinnerDtlPopCancel").on("click", function(){
		prodExcelUploadClosePop();
	});

	// 저장 버튼
 	$("#prodDtlSaveBtn").on("click", function(){
		setProdDtl();
	});

});
</script>

<div id='eventWinnerPopFormArea'>
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
			<ifvm:inputNew type="text" id="fileName" dto="fileName " label="M01858" labelClass="2" conClass="7" disabled="true"  required="true"/>
	    	<ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" objCode="prodExcelUploadSearch_OBJ" btnFunc="fileSearchFn"/>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="prodDtlSaveBtn" objCode="prodExcelUploadSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" objCode="prodExcelUploadCancel_OBJ" id="eventWinnerDtlPopCancel">
		<spring:message code="M00284"/>
	</button>
</div>
<div id="prodDtlDialog" class="popup_container"></div>
