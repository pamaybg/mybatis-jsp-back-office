<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//공통코드 파일 유형 조회
function fileType(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>',{
		groupCode : 'MKT_FILE_TYPE'
		, enableNA : true
	},function(result) {
		var temp = $("#fileTypeTemplate").tmpl(result.rows);
		$("#fileType").append(temp);
		
	});
}; 

$(document).ready(function(){
	//공통코드 파일 유형 조회
	fileType();
	excelHeader = null;
	
	// 파일유형 변경시
	$("#fileType").on("change", function(){
		$("#hideFile").val(""); 
		$("#filePath").val("");
	});
	
	// 찾아보기
	$("#btnBrowse").click(function(){
		formData.delete("file");
		formData.delete("importType");
		formData.delete("tableId");
		formData.delete("fileNm"); 
		$("#hideFile").trigger("click");
	});
	
	//파일 검색 클릭 후 파일 선택 시 실행
	$("#hideFile").on("change", function(){
		var validationCheck = false;
		var fileValue  = $("#hideFile").val().split('\\'); 
		var fileNm = fileValue[fileValue.length-1];
		fileName = fileNm;
		excelHeader = null;

		// 파일 형식 체크 CSV, xlsx, xls
		$("#filePath").val(this.value);
		if($("#fileType").val() == 'CSV'){
			if($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'csv'){
				validationCheck = true;
			}
		}else{
			if($("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xlsx' || $("#hideFile")[0].files[0].name.split('.')[1].toLowerCase() == 'xls'){
				validationCheck = true;
			}
		}
		if(validationCheck){
			
			if(($("#hideFile")[0].files[0].type.split('/')[1]=='vnd.ms-excel') || $("#hideFile")[0].files[0].type.split('/')[1]== 'vnd.openxmlformats-officedocument.spreadsheetml.sheet'){
				//파일업로드
				formData.append("file", $("#hideFile")[0].files[0]);  
				formData.append("importType", importType);  
				formData.append("appServiceId", appServiceId);
				formData.append("country", country);
				formData.append("lang", lang);
				formData.append("tableId", tableId);
				formData.append("fileNm", fileNm);

				$.ajax({
					url: '<ifvm:action name="getExcelHaedList"/>',
					data: formData,
					processData: false,
					contentType: false,
					type: 'POST',
					success: function(data){	
						excelHeader = data.headerNm;
					}
				});  
			}else{
				alert("<spring:message code='M00703'/>");
				$("#hideFile").removeAttr("value");
			}	
			//초기화
			$("#hideFile").val(""); 
			
		}else{
			alert("<spring:message code='M00703'/>");
			$("#hideFile").removeAttr("value");
		} 
	});	
});

</script>
	
<script id="fileTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>	

<style>
#hideFile {display:none}
</style>

<div class="fileUpFormArea">
	<label class="col-xs-10 description_title">
		<spring:message code="M01774"/></label>
		<div class="row qt_border">
		<label class="col-xs-1 control-label">
			<spring:message code="M00682"/></label>	
			<div class="col-xs-4 control_content">
				<ifvm:input type="select" id="fileType"/> 
			</div>
		</div>
		<div class="row qt_border">
			<label class="col-xs-1 control-label">
				<spring:message code="M01775"/></label>	
			<div class="col-xs-8 control_content">
				<ifvm:input type="text" id="filePath"/> 
			</div>
			<button class="ifv_search_box_search_btn" id="btnBrowse" >
				<spring:message code="M00203"/>     
        	</button> 
        		<ifvm:input type="file" id="hideFile" />
		</div>
</div>
