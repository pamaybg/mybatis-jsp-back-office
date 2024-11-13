<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<% request.setCharacterEncoding("EUC-KR");%>
<div id ="uploadForm">
	<div class="form-horizontal underline top_well"  >
		<div class="row qt_border" >
			 <div class="col-xs-12">
				<%-- <ifvm:inputNew type="select" id="uploadTypeCd" dto="uploadTypeCd " label="L01669" labelClass="2" conClass="3" required="true" disabled="true"/> --%>
				<ifvm:inputNew type="select" id="offerType" dto="offerType " label="L02378" labelClass="2" conClass="4" required="true" />
			</div>

			<div class="col-xs-12">
				<ifvm:inputNew type="text" id="fileName" dto="fileName " label="L01700" labelClass="2" conClass="8" disabled="true"  required="true"/>
				<ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn"/>
			</div>

		</div>


	</div>
</div>
<div class="pop_btn_area">
	<ifvm:inputNew type="button" btnType="upload" text="M00137" id="uploadBtn" btnFunc="fnUpload"/>
	<ifvm:inputNew type="button" btnType="cancel" text="I00404" btnFunc="fnClose" />
</div>

<script>
var uploadValid;
function commCodeSetting(){
	$.ifvGetCommCodeList('select', 'uploadTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'OFFER_TYPE_CD', 'loy', true, false);
	$.ifvGetCommCodeList('select', 'offerType', '<ifvm:action name="getCommCodeList2"/>', 'DAISO_MBR_EXCEL_UP_TYPE', 'loy', true, false);
}

function fileSearchFn(){

}

$(document).ready(function() {
	commCodeSetting();

	//업로드유형 : 마일리지 고정
	$('#uploadTypeCd').val('POINT');
	$("#offerType").val('HHP_NO');

// 	setCalendar();
});

function fileSearchFn() {
	fnExcelUpload({
		url: '<ifvm:action name="uploadExcelMbr"/>',
		fileName: $("#fileName").val(),
		data: {
			uploadTypeCd :$("#uploadTypeCd").val(),
			procTypeCd :$("#offerType").val(),
			offerType :$("#offerType").val(),
// 			pntApplyDt :$('#pntApplyDt').val(),
			ridCam :$('#ridCam').val(),
			ridOffer :$('#ridOffer').val(),
		},
	}
	, function (result) {
		alert(result.message);

		if(result.success){
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
				url: '<ifvm:action name="uploadExcelMbr"/>',
				fileName: $("#fileName").val(),
				data: {
					uploadTypeCd :$("#uploadTypeCd").val(),
					procTypeCd :$("#offerType").val(),
					offerType :$("#offerType").val(),
// 					pntApplyDt :$('#pntApplyDt').val(),
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

/**
 * 캠페인 검색
 */
function camSearchFn() {

}

function setCalendar() {
	var pntApplyDt = $('#pntApplyDt');
	//오늘날짜
	pntApplyDt.val($.ifvGetTodayDate());
	//설정
	pntApplyDt.ifvDateChecker({
		minDate : $.ifvGetTodayDate()
	});
}


</script>