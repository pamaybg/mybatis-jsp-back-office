<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page_btn_area">
    <div class="col-xs-5">
        <span><spring:message code="D00089" /></span>
    </div>
    <div class="col-xs-7 searchbtn_r">
		<ifvm:inputNew type="button" id="btnSave" btnFunc="btnSaveClick" btnType="save" text="L00074" objCode="faqChbtnSave_OBJ"/>
    </div>
</div>

<div class="well form-horizontal" id="faqForm">
<!-- 	<div class="row qt_border"> -->
<%-- 		<ifvm:inputNew type="radio" id="faqLang" names="faqLang" dto="faqLang" required="true" label="M00237" labelClass="2" conClass="9" text="C00037|D00083|D00084|D00085" values="all|ko|en|zh" checkIndex="1"/> --%>
<!-- 	</div> -->
<!-- 	<div class="row qt_border"> -->
<%-- 		<ifvm:inputNew type="radio" id="faqStatus" names="faqStatus" dto="faqStatus" required="true" label="L00090" labelClass="2" conClass="9" text="D00005|D00006" values="true|false" checkIndex="2"/> --%>
<!-- 	</div> -->
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="faqTitle" names="faqTitle" dto="faqTitle" required="true" label="D00007" labelClass="2" conClass="9" maxLength="200" />
	</div>
<!-- 	<div class="row qt_border"> -->
<%-- 		<ifvm:inputNew type="text" id="dpSeq" names="dpSeq" dto="dpSeq" required="true" label="D00007" labelClass="2" conClass="1" /> --%>
<!-- 	</div> -->
<!-- 	<div class="row qt_border"> -->
<%-- 		<ifvm:inputNew type="date" id="faqShowDate" names="faqShowDate" dto="faqShowDate" label="D00008" labelClass="2" conClass="3" /> --%>
<!-- 	</div> -->
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="faqDesc" names="faqDesc" dto="faqDesc" required="true" label="D00009" labelClass="2" conClass="9" rows="8" maxLength="3000"/>
	</div>
</div>
<script>
var validation;
var updateSubFlag;
var faqLang = "zh";
var faqSubId = "";

$(document).ready(function() {
	$.ifvmLnbSetting('faqList');

	 if(updateFlag){
		detailFaq(faqId);
	}
	 else{
			$("#faqTitle").focus(function(){
				alert("FAQ 정보부터 등록하세요.");
				$("#faqMasterTitle").focus();
			})
			$("#faqDesc").focus(function(){
				alert("FAQ 정보부터 등록하세요.");
				$("#faqMasterTitle").focus();
			})
		}
});

function btnSaveClick() {
	validation = $('#faqForm').ifvValidation();
	if(faqId != null){
		if(validation.confirm() === false) return;
		else{

		if( faqId == null ){ //신규
			url = '<ifvm:action name="insertFaq"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		} else{					//수정
			url = '<ifvm:action name="insertFaq"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		}

		 $.ifvSyncPostJSON( url,
					{
			 		faqLang : faqLang,
					faqName : $("#faqTitle").val(),
					faqDesc : $("#faqDesc").val(),
					faqId : faqId,
					updateFlag : updateSubFlag,
					faqSubId : faqSubId
// 					seq :$("#dpSeq").val(),
					},
					function(result) {

					 if(result.success == true){
						alert('<spring:message code="M00005"/>');
						location.href = '<ifvm:url name="faqDetailUrl"/>' + '?rid=' + faqId;
					}
					else{
						alert('<spring:message code="M00029"/>');
					}
					}
				);

		}
	}
	else{
		alert("FAQ 정보부터 등록하세요.")
	}
}


 function detailFaq(id){
	$.ifvSyncPostJSON('<ifvm:action name="getFaqDetail"/>', {
		faqId : id,
		faqLang : faqLang
	}, function(result) {

		if(result != null){
			$('#faqTitle').val(result.faqTitle);
			$('#faqDesc').val(result.faqDesc);
// 			$('#dpSeq').val(result.seq);
			updateSubFlag = true;
			faqSubId = result.faqSubId;
		}
		else{
			$('#faqTitle').val("");
			$('#faqDesc').val("");
// 			$('#dpSeq').val("");
			updateSubFlag = false;
			faqSubId = "";
		}
		})
}



</script>