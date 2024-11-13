<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<% request.setCharacterEncoding("EUC-KR");%>
<div id ="uploadForm">
	<div class="form-horizontal underline top_well"  >
		<div class="row qt_border">
			<div class="col-xs-12">
				<ifvm:inputNew type="text" id="fileName" dto="fileName " label="L01700" labelClass="2" conClass="8" disabled="true"  required="true"/>
				<ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn" objCode="smsExcelFileSearch_OBJ"/>
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="upload" text="M00137" id="uploadBtn" btnFunc="fnUpload" objCode="smsExcelFileUpload_OBJ"/>
	<ifvm:inputNew type="button" btnType="cancel" text="I00404" btnFunc="fnClose" objCode="smsExcelFileClose_OBJ"/>
</div>

<script>
var uploadValid;

$(document).ready(function() {
});

function fileSearchFn() {
	fnExcelUpload({
		url: '<ifvm:action name="excelUploadSmsUnSub"/>',
		fileName: $("#fileName").val(),
		data: {
			ridCam :$('#ridCam').val(),
			ridOffer :$('#ridOffer').val(),
		},
	}
	, function (result) {
		alert(result.message);
		
		if(result.success){
// 			batchRegistList.requestData();
// 			upldItemList.requestData();
			batchRegistListSearchFn();
			fnClose();
		}
	
		$.ifvProgressControl(false);
	}
	, function (){
		// File 선택 후 동작 할 액션을 정의 한다.
		$('#fileName').val(fnExcelUpload.fileName);
	});
}

function fnUpload(){
	uploadValid = $("#uploadForm").ifvValidation();
	if (uploadValid.confirm() == true) {
		if( fnExcelUpload['upload'] ) {
			var _obj = {	
				url: '<ifvm:action name="uploadExcelPnt"/>',
				fileName: $("#fileName").val(),
				data: {	
					ridCam :$('#ridCam').val(),
					ridOffer :$('#ridOffer').val(),
				},
			};
			
			fnExcelUpload.data.formData ={	
					param : JSON.stringify(_obj)
			}
			
			fnExcelUpload.upload();
		} else {
			
		}
	}
}

function fnClose() {
	fileUploadPop.close();
}

</script>