<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id ="uploadForm">
	<div class="form-horizontal underline top_well"  >
		<div class="row qt_border" >

			<div class="col-xs-12">
				<label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="파일경로"/></label>
				<ifvm:inputNew type="text" id="fileName" dto="fileName" labelClass="2" conClass="8" disabled="true"  required="true"/>
				<ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn" objCode="chnlUploadSearch_OBJ"/>
			</div>

		</div>


	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="upload" text="M00137" id="uploadBtn" btnFunc="fnUploadsave" objCode="chnlUploadSave_OBJ"/>
	<ifvm:inputNew type="button" btnType="cancel" text="I00404" btnFunc="fnClose" objCode="chnlUploadClose_OBJ"/>
</div>
<script>
$(document).ready(function(){
	$("#uploadForm").ifvValidation();
	
});

function fileSearchFn() {
	fnExcelUpload({
		url: '<ifvm:action name="uploadExcelChnlGrpXm"/>',
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
				url: '<ifvm:action name="uploadExcelChnlGrpXm"/>',
				fileName: $("#fileName").val(),
				data: {
					chnlGrpRid    : chnlGrp_Rid
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
	chnlExcelUploadPop.close();
}
</script>