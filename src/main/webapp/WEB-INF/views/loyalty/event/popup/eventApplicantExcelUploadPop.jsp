<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;

//저장
 function saveExcelData(){
	var obj = {};
	var value = false;
	validation = $("#eventApplicantPopFormArea").ifvValidation();

	if(validation.confirm()) {
		obj.rid = eventRid;
		
		var _obj = {
			url : '<ifvm:action name = "setEventApplicantMultiUpload"/>',
			fileName : $("#fileName").val(),
			data : {
				 eventRid : eventRid
				,eventNo : $("#eventNo").val()
				,excelUploadType : $('input[name="excelUploadType"]:checked').val()
			},
		};
		
		fnExcelUpload.data.formData = {	
			param : JSON.stringify(_obj)
		};
		
		fnExcelUpload.upload();
		
		getEventApplicantList();
		
		eventApplicantUploadPopClose();
	} else {
		alert('파일을 등록해주세요.');
		return;
	}
}
// 엑셀파일 찾기 팝업에서 찾아보기 버튼 기능
function fileSearchFn() {
	fnExcelUpload(
		{	 url: '<ifvm:action name="setEventApplicantMultiUpload"/>'
			,fileName: $("#fileName").val()
			,data: { }
		}, function (result) {
			alert(result.message);
			$.ifvProgressControl(false);
		}
		, function (){
			// File 선택 후 동작 할 액션을 정의 한다.
			$('#fileName').val(fnExcelUpload.fileName);
		}
	);
}


$(document).ready(function(){
	$("#eventApplicantPopFormArea").ifvValidation();

	// 저장 버튼
 	$("#uploadBtn").on("click", function(){
		saveExcelData();
	});
	
	//취소
 	$("#eventApplicantUploadPopCancel").on("click", function(){
 		eventApplicantUploadPopClose();
 	});
 	
});
</script>

<div id='eventApplicantPopFormArea'>
	<div class="pop_inner_wrap form-horizontal">
		<div class="row qt_border">
			<ifvm:inputNew type="radio" id="excelUploddType" names="excelUploadType" dto="excelUploadType" conClass="9" text="참여자 추가 업로드|참여자 전체 삭제 후 업로드" values="T2|T1" checkIndex="1"/>
		</div>
	    <div class="row qt_border">
			<ifvm:inputNew type="text" id="fileName" dto="fileName " label="M01858" labelClass="2" conClass="7" disabled="true"  required="true"/>
	    	<ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn" objCode="fileSearchBtn_OBJ"/>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="uploadBtn" objCode="uploadBtn_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="eventApplicantUploadPopCancel" objCode="eventApplicantUploadPopCancel_OBJ">
		<spring:message code="M00284"/>
	</button>
</div>

<div id="prodDtlDialog" class="popup_container"></div>
