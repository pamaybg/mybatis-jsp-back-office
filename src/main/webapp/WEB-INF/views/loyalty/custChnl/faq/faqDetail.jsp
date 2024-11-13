<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
#FaqTab{z-index : 1}
</style>
<div class="page-title">
    <h1>
		<spring:message code="D00001" />
        &gt; <spring:message code="D00068" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span><spring:message code="D00070" /></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnSave" btnFunc="btnMasterSaveClick" btnType="save" text="L00074" objCode="faqDetailbtnSave_OBJ" />
			<ifvm:inputNew type="button" id="btnList" btnFunc="btnListClick" text="D00024" objCode="fagDetailbtnList_OBJ"/>
	    </div>
	</div>
	
	<div class="well form-horizontal" id="faqMasterForm">
		<div class="row qt_border">
			<ifvm:inputNew type="radio" id="faqStatus" names="faqStatus" dto="faqStatus" required="true" label="L00090" labelClass="2" conClass="9" text="D00005|D00006" values="true|false" checkIndex="2"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="faqType" names="faqType" dto="faqType" label="L00291" labelClass="2" conClass="2" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="seq" names="seq" dto="seq" required="true" label="D10221" labelClass="2" conClass="1" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="faqMasterTitle" names="faqMasterTitle" dto="faqMasterTitle" required="true" label="D00007" labelClass="2" conClass="9" maxLength="200" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="date" id="faqShowDate" names="faqShowDate" dto="faqShowDate" label="D00008" labelClass="2" conClass="3" />
		</div>
	</div>
</div>
<div id="faqDetailTabArea">
	<!-- 탭 컨텐츠 -->
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>

<script>

var faqDetailTab = $('#faqDetailTabArea').DrawTab({
	item : items
	/* [
	{ 	label : '<spring:message code="D00083"/>', href : '<ifvm:url name="faq_Ko"/>' },
	{	label : '<spring:message code="D00084"/>', href : '<ifvm:url name="faq_En"/>'},
	{ 	label : '<spring:message code="D00085"/>', href : '<ifvm:url name="faq_Ch"/>' }
	] */
});

var validation;
var updateFlag;

var faqId = $.ifvGetParam('rid');
var masterTitle = $('#faqMasterTitle').val();
	/* $('#faqMasterTitle').val(); */

if(faqId == undefined ){
	updateFlag = false;
}
else{

	updateFlag = true;
}


function setDatePicker() {
	var date = $('#faqShowDate');
	date.val($.ifvGetTodayDate());
	date.ifvDateChecker({});
}


$(document).ready(function() {
	$.ifvmLnbSetting('faqList');
	setDatePicker();
	$.fn.ifvmSetSelectOptionCommCode( "faqType", "FAQ_TYPE", null, null, true);

// 	$.ifvChangeTabContent(faqUrlObj.ko_faq, 'ko_faq', 'faqTab', 'faqContent');

	if(updateFlag){
		detailMasterFaq(faqId);
	}
});

function btnMasterSaveClick() {
	validation = $('#faqMasterForm').ifvValidation();
	masterTitle = $('#faqMasterTitle').val();
	if(validation.confirm() === false) return;
	else{
		var showDate = $("#faqShowDate").val().split('-')
		showDate = showDate[0] + showDate[1] + showDate[2];
	}

	if( faqId == null ){ //신규
		url = '<ifvm:action name="insertMasterFaq"/>';
		if(confirm('<spring:message code="M01633"/>') === false) return;
	} else{					//수정
		url = '<ifvm:action name="insertMasterFaq"/>';
		if(confirm('<spring:message code="M01633"/>') === false) return;
	}

	 $.ifvSyncPostJSON( url,
				{
			 	faqStatus : $(':radio[name="faqStatus"]:checked').val(),
			 	faqName : $('#faqMasterTitle').val(),
			 	faqType	: $('#faqType').val(),
				openDate : showDate,
				faqId : faqId,
				seq: $('#seq').val(),
				updateFlag : updateFlag
				},
				function(result) {

				 if(result.success == true){
					alert('<spring:message code="M00005"/>');
					location.href = '<ifvm:url name="faqDetailUrl"/>'  + '?rid=' + result.message;
				}
				else{
					alert('<spring:message code="M00029"/>');
				}
				}
			);
	masterTitle = $('#faqMasterTitle').val();

}

function btnListClick() {
	qtjs.href('<ifvm:url name="faqListUrl"/>');
}

function detailMasterFaq(id){
	$.ifvSyncPostJSON('<ifvm:action name="getFaqMasterDetail"/>', {
		faqId : id
	}, function(result) {

		if(result.faqStatus == "Y"){
			$("input:radio[name='faqStatus']:radio[value='true']").attr("checked",true);
		}
		else{
			$("input:radio[name='faqStatus']:radio[value='false']").attr("checked",true);
		}
		var date = $('#faqShowDate');
		date.val(result.openDate);
		date.ifvDateChecker({});
		$('#faqMasterTitle').val(result.faqTitle);
		$('#faqType').val(result.faqType);
		$('#seq').val(result.seq);
		})
}



</script>