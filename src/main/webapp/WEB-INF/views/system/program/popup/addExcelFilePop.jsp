<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page import="com.icignal.common.util.BeansUtil" %>
<script>

var ppgmId = pgmId;
var tempName = null;
var fileName = null;

	//공통코드 조회 - 엑셀 생성 유형
	function excelCreateType() {
		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
			groupCode : 'EXCEL_CREATE_TYPE_CD',
		}, function(result) {
			var temp = $("#excelCreateTypeTemplate").tmpl(result.rows);
			$("#excelCreateType").append(temp);
		});
	};


	function saveTempFile() {
		if ($('#excelCreateType').val() == 'T') {
			if (fileName == null && $('#templateFile').val() == "") {
				alert("템플릿 파일을 등록하세요.");
			} else {
				if ($('#uploadTemplateFile').val() != "") {
					templateFileSearchFn(); //템플릿 저장
				}
				setProgramExcelFile();
				addExcelFilePopupClose();
				ExcelDownloadListGrid();
			}
		} else if ($('#excelCreateType').val() == 'G') {
			setProgramExcelFile();
			addExcelFilePopupClose();
			ExcelDownloadListGrid();
		} else {
			alert("템플릿 생성코드가 잘못되었습니다.");
		}
	}

	//조회
	function getDtlExcel() {

		$.ifvSyncPostJSON('<ifvm:action name="getDtlExcel"/>', {
			rid : rid
		}, function(result) {

			$("#pgmId").val(result.pgmId);
			$("#title").val(result.title);
			$("#excelSeq").val(result.excelSeq);
			$("#excelCreateType").val(result.excelCreateTypeCd);
			$("#templateFile").val(result.templateFile);
			$('#excelObjcode').val(result.objCode);

		});
	}

	//엑셀 파일 생성 저장
	function setProgramExcelFile() {
		var obj = {};
		validation = $("#excelFilePopFormArea").ifvValidation();
		if (validation.confirm()) {
			
			obj.pgmId = $("#pgmId").val();
			obj.title = $("#title").val();
			obj.excelCreateType = $("#excelCreateType").val();
			obj.objCode = $('#excelObjcode').val();
			if(tempName !=null){
				obj.tempName = tempName;
			}
			

			$.ifvSyncPostJSON('<ifvm:action name="setProgramExcelFile"/>', obj,
					function(result) {
						alert('<spring:message code="M00623"/>');
					});
		}
	}

	//새로운 템플릿 파일 등록
	function templateFileSearchFn() {
		var formData = new FormData();
		formData.append("file", $("#uploadTemplateFile")[0].files[0]);
		$.ajax({
			url : '<ifvm:action name="excelTempUpload"/>',
			data : formData,
			processData : false,
			contentType : false,
			async : false,
			type : 'POST',
			success : function(data) {
				tempName = data[0].name;
			},
			error : function(error) {
				alert("템플릿 등록을 실패하였습니다.");
			}
		});
	}

	//수정

	function modifyExcelFile() {
		if ($('#excelCreateType').val() == 'T') {
			if (fileName == null && $('#templateFile').val() == "") {
				alert("템플릿 파일을 등록하세요.");
			} else {
				if($('#uploadTemplateFile').val() != ""){
					templateFileSearchFn(); //템플릿 저장
				}
				modifyExcelFileD();
				addExcelFilePopupClose();
				ExcelDownloadListGrid();
			}
		} else if ($('#excelCreateType').val() == 'G') {
			modifyExcelFileD();
			addExcelFilePopupClose();
			ExcelDownloadListGrid();
		} else {
			alert("템플릿 생성코드가 잘못되었습니다.");
		}	
	}

	function modifyExcelFileD() {

		var obj = {};
		validation = $("#excelFilePopFormArea").ifvValidation();

		if (validation.confirm()) {
			obj.pgmId = $("#pgmId").val();
			obj.title = $("#title").val();
			obj.excelCreateType = $("#excelCreateType").val();
			obj.templateFile = $("#templateFile").val();
			obj.objCode = $('#excelObjcode').val();
			if(tempName != null){
				obj.tempName = tempName;
			}
			obj.rid = rid;

			$.ifvSyncPostJSON('<ifvm:action name="editExcelFile"/>', obj,
					function(result) {
						alert('<spring:message code="M00624"/>');

					});
		}
	}

	//엑셀 생성유형이 템플릿이면 업로드 가능
	function check() {
		$('#excelCreateType').change(function() {
			if ($(this).val() == 'G') {
				$('#uploadTemplateFile').attr("disabled", true);
			} else {
				$('#uploadTemplateFile').attr("disabled", false);
			}
		});
	}

	//업로드 파일 포맷 제한
	function reviewUploadFile(fileObj) {

		var filePath = fileObj.value;
		fileName = filePath.substring(filePath.lastIndexOf("\\") + 1);
		var fileKind = fileName.split(".")[1];

		if (fileKind != "xlsx" && fileKind != "xls") {
			alert("Excel File (xlsx, xls)만 가능 합니다.");
			document.getElementById("uploadTemplateFile").value = "";
			document.getElementById("uploadTemplateFile").select();
			document.selection.clear();
		}
	}

	function addExcelFilePopupClose() {
		addExcelFilePopup._destroy();
	}

	$(document).ready(function() {

		excelCreateType();
		$("#excelFilePopFormArea").ifvValidation();
		$('#pgmId').val(ppgmId);

		if (rid != null) {
			getDtlExcel();
		}else{
			$("#excelSeqDiv").hide();
			}

		$("#excelFileCancel").click(function() {
			addExcelFilePopupClose();
		});

		$("#excelFileSaveBtn").on("click", function() {
			if (rid != null)
				modifyExcelFile();
			else
				saveTempFile();			
		});
		check();

	});
</script>

<script id="excelCreateTypeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='excelFilePopFormArea'>

	<div class="pop_inner_wrap form-horizontal">	   
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="D10271"/></label>
	        <div class="col-xs-8 control_content">
	            <ifvm:input type="textarea" id="pgmId" rows="1" maxLength="100" disabled="true"/>
	        </div>
	    </div>
	    <div class="row qt_border" id="excelSeqDiv">
	        <label class="col-xs-3 control-label"><spring:message code="D10263"/></label>
	        <div class="col-xs-8 control_content">
	            <ifvm:input type="textarea" id="excelSeq" rows="1" maxLength="100" disabled="disabled"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="L01431"/></label>
	        <div class="col-xs-8 control_content">
	            <ifvm:input type="textarea" id="title" rows="1" maxLength="100" required="true"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code="D10269"/></label>
	        <div class="col-xs-8 control_content">
	          <ifvm:input type="select" id="excelCreateType" required="true"/>
	        </div>
	    </div>
	   	<div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="I02100"/></label>
	        <div class="col-xs-8 control_content">
	            <ifvm:input type="text" id="excelObjcode" rows="1" maxLength="100"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-3 control-label"><spring:message code="D10270"/></label>
	        <div class="col-xs-8 control_content">
				<ifvm:input type="textarea" id="templateFile" rows="1" maxLength="100" disabled="true" />
			</div>
	    </div>
	    <div class="row qt_border">
	    		<label class="col-xs-3 control-label"><spring:message code="D10272"/></label>
	    		<div class="col-xs-8 control_content">
	   			<input type="file" id="uploadTemplateFile" onchange="reviewUploadFile(this);" disabled="" />
	   			</div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="excelFileSaveBtn" objCode="excelFileSave_OBJ">       
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="excelFileCancel" objCode="excelFileCancel_OBJ">         
		<spring:message code="M00284"/>
	</button>  
</div>