<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<% request.setCharacterEncoding("EUC-KR");%>
<div id ="uploadForm">
	<div class="form-horizontal underline top_well"  >
		<div class="row">

			<div class="col-xs-11">
				<ifvm:inputNew type="text" id="fileName" maxLength="50" dto="fileName " label="L01670" labelClass="3" conClass="7" disabled="true"  required="true"/>
				<div class="col-xs-2">
					<ifvm:inputNew type="button"     text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn"/>
				</div>
			</div>

		</div>
	</div>
</div>
 <div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="upload" text="L01672" id="uploadBtn" btnFunc="fnUpload"/>
	<ifvm:inputNew type="button" btnType="cancel" text="I00404" btnFunc="fnClose" />
</div>

<script>


 function fileSearchFn() {
	 fnExcelUpload(
	            {
	            	url: '<ifvm:action name="uploadExcelUnRgstCard"/>',
	                fileName: $("#fileName").val(),

	            },
	            function (result) {
	            	alert(result.message);
					if(result.success){
						unRgstCardUploadList.requestData();
						unRgstCardUpldItemList.requestData();
						fnClose();

					}
					$.ifvProgressControl(false);

	            },
	            function (){
	                // File 선택 후 동작 할 액션을 정의 한다.
	                 $('#fileName').val(fnExcelUpload.fileName);
				}
	        )
    }
   	function fnUpload(){
   		var uploadValid = $("#uploadForm").ifvValidation();
   		if (uploadValid.confirm() == true) {
		   	if( fnExcelUpload['upload'] ) {
		   		var _obj = {
		   				url: '<ifvm:action name="uploadExcelUnRgstCard"/>',
		                fileName: $("#fileName").val(),
		   		}
		   		fnExcelUpload.data.formData ={
		   				param : JSON.stringify(_obj)
		   		}

		        fnExcelUpload.upload();
		    }else{
			}
	   	}
   	}
    function fnClose() {
    	fileUploadPop.close();
    }

    function checkFileType(filePath) {
        var fileFormat = filePath.split(".");
        if (fileFormat.indexOf("xlsx") > -1) {
            return true;
        } else {
            return false;
        }

    }
</script>