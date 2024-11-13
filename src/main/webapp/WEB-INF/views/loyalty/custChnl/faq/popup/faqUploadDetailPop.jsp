<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id ="uploadForm">
	<div class="form-horizontal underline top_well"  >
		<div class="row qt_border" >
			 <div class="col-xs-12 text-center">
				<label><span class="asterisk">*</span>기존 컨텐츠는 모두 삭제되고, 업로드 데이터가 신규로 등록됩니다.</label>
			</div>
			<div class="col-xs-12">
				<ifvm:inputNew type="text" id="fileName" dto="fileName" labelClass="2" conClass="8" disabled="true"  required="true"/>
				<ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn" objCode="faqUploadfileSearchBtn_OBJ"/>
			</div>

		</div>


	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="upload" text="M00137" id="uploadBtn" btnFunc="fnUploadsave" objCode="faqUploaduploadBtn_OBJ"/>
	<ifvm:inputNew type="button" btnType="cancel" text="I00404" btnFunc="fnClose" objCode="faqUploadclose_OBJ"/>
</div>
<script>
$(document).ready(function(){
	$("#uploadForm").ifvValidation();
	
});

function fileSearchFn() {
	fnExcelUpload({
		url: '<ifvm:action name="uploadExcelFaq"/>',
		fileName: $("#fileName").val(),
		data: {
		},
	}
	, function (result) {
		alert(result.message);
		if(result.success){
			fnClose();
			
		}
		$.ifvProgressControl(false);
	}
	, function (){
		// File 선택 후 동작 할 액션을 정의 한다.
		$('#fileName').val(fnExcelUpload.fileName);
	});
}

function fnUploadsave(){
	uploadValid = $("#uploadForm").ifvValidation();
	if (uploadValid.confirm() == true) {
		if( fnExcelUpload['upload'] ) {
			var _obj = {
				url: '<ifvm:action name="uploadExcelFaq"/>',
				fileName: $("#fileName").val(),
				data: {
					faqType :$("#faqType").val(),
					seq :$("#seq").val(),
					faqNm :$("#faqNm").val(),
					faqDesc :$('#faqDesc').val(),
					openDt :$('#openDt').val(),
					faqStatus :$('#faqStatus').val(),
				},
			};

			fnExcelUpload.data.formData ={
					param : JSON.stringify(_obj)
			}
			fnExcelUpload.upload();
		} else {
			
		}
	}
	
	$.ifvProgressControl(false);
	location.reload();
}

function fnClose() {
	fileUploadPop.close();
}
</script>