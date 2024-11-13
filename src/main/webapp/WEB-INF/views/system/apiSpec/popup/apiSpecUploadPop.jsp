<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//파일첨부 추가하기
function tempFileUpload(){
		var formData = new FormData();
		formData.append("file", $("#uploadFile")[0].files[0]);
		$.ajax({
			url: '<ifvm:action name="tempUploadS3"/>',
			data: formData,
			
			processData: false,
			contentType: false,
			async: false,
			type: 'POST',
			success: function(data){
				var fileName = data[0].oriName;
				var url = data[0].url;
				insertApiSpecFile(fileName,url);
				alert("저장 완료");
			}
		});
}

function insertApiSpecFile(fileName,url){
	$.ifvSyncPostJSON('<ifvm:action name="apiSpecUpload"/>',{
		fileNm: fileName,
		filePath : url,
		rid : rid
	
    },function(result){

	},function(result){
    	alert("엑셀파일");//에러
	});
	
	/*
	var formData = new FormData();
	formData.append("fileNm", fileName);
	formData.append("filePath", fileName);
	
	$.ajax({
		url: '<ifvm:action name="apiSpecUpload"/>',
		processData: false,
		contentType: false,
		async: false,
		dataType : 'json',
		type: 'POST',
		data:{
			"fileNm":fileName,
			"filePath":url
			
		},
		success: function(data){
		
		}
	});*/
	
}

function fnClose() {
	fileUploadPop.close();
}

$(document).ready(function(){
	
	// 저장 버튼
 	$("#prodDtlSaveBtn").on("click", function(){
 		tempFileUpload();
		fnClose();
	});
	
	//취소
 	$("#apiSpecPopCancel").on("click", function(){
 		fnClose();
 	});
 	
});
</script>

<div id='apiSpecPopFormArea'>
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
			<input type="file" id="uploadFile"/>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="prodDtlSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="apiSpecPopCancel" btnFunc="fnClose">
		<spring:message code="M00284"/>
	</button>
</div>
<div id="prodDtlDialog" class="popup_container"></div>
