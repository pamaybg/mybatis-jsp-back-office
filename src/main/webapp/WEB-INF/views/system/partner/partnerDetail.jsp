<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
#NoticeTab{z-index : 1}
</style>
<div class="page-title">
    <h1>
        제휴관리
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span>제휴 관리 정보</span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnMasterSave" btnFunc="btnMasterSaveClick" btnType="save" text="L00074" objCode="partnerDetailSave_OBJ"/>
			<ifvm:inputNew type="button" id="goPartnerList" btnFunc="btnListClick" text="D00024" objCode="goPartnerList_OBJ" />
	    </div>
	</div>
	
	<div class="well form-horizontal" id="noticeMasterForm">
		<div class="row qt_border">
			<ifvm:inputNew type="radio" id="ptnrStatus" names="ptnrStatus" dto="ptnrStatus" required="true" label="L00090" labelClass="2" conClass="9" text="D00005|D00006" values="true|false" checkIndex="2"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="dateTerm" nuc="true" startDto="termStartDate" endDto="termEndDate" startId="termStartDate" endId="termEndDate" required="true"
				label="제휴 기간" labelClass="2" conClass="6" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="dispSeq" names="dispSeq" dto="dispSeq" nuc="true" label="순번" labelClass="2" conClass="2" />
			<ifvm:inputNew type="singleCheckbox" id="solYn" dto="solYn" nuc="true" label="SOL페이" values="solYn" labelClass="1" conClass="1" />
		</div>
		
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="category" names="category" dto="category" label="M00690" labelClass="2" conClass="3" required="true"/>
		</div>
	</div>
</div>
<div id="partnerDetailTabArea">
	<!-- 탭 컨텐츠 -->
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>
<script>

var partnerDetailTab = $('#partnerDetailTabArea').DrawTab({
	item : [
	{ 	label : '제휴내용', href : '<ifvm:url name="partnerInfo"/>' }
	]
});

var validation;

var updateFlag;
var ptnrId = $.ifvGetParam('rid');

//이미지 업로드
var imageInfo = new Array();


if(ptnrId == undefined ){
	updateFlag = false;
}
else{

	updateFlag = true;
}

$(document).ready(function() {
	$.ifvmLnbSetting('noticeList');
	setCalendar();
	$.fn.ifvmSetSelectOptionCommCode("category", "PTNR_TYPE", null, null, true);

	if(updateFlag){
		detailNotice(ptnrId);
	}
});

function detailNotice(id){
	$.ifvSyncPostJSON('<ifvm:action name="getPartnerMasterDetail"/>', {
		ptnrId : ptnrId
	}, function(result) {

		if(result.ptnrStatus == "Y"){
			$("input:radio[name='ptnrStatus']:radio[value='true']").attr("checked",true);
		}
		else{
			$("input:radio[name='ptnrStatus']:radio[value='false']").attr("checked",true);
		}
		$('#termStartDate').val(result.startDate.substr(0, 10));
		$('#termEndDate').val(result.endDate.substr(0, 10));
		if (result.solYn=="Y"){
			$("#solYn").attr("checked",true);
		}else{
			$("#solYn").attr("checked",false);
		}
		$('#dispSeq').val(result.dispSeq);
		$('#category').val(result.category);
		})
}

function btnMasterSaveClick() {
	validation = $('#noticeMasterForm').ifvValidation();
	var v_solYn = $.fn.ifvmIsNotEmpty($("#solYn").attr("checked")) ?  "Y" : "N";
	var startDate = dateTrim($('#termStartDate').val());
	var endDate = dateTrim($('#termEndDate').val());
	if(validation.confirm() === false) return;
	else{

		var url;
		var category =$("#category").val();

	  if( ptnrId == null ){ //신규
			url = '<ifvm:action name="insertPartnerMaster"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		} else{					//수정
			url = '<ifvm:action name="insertPartnerMaster"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		}

	 $.ifvSyncPostJSON( url,
			{
		 	ptnrStatus : $(':radio[name="ptnrStatus"]:checked').val(),
		 	dispSeq : $("#dispSeq").val(),
			ptnrId : ptnrId,
			updateFlag : updateFlag,
			category : category,
			solYn :v_solYn,
			startDate : startDate,
			endDate : endDate
			},
			function(result) {

			 if(result.success == true){
				alert('<spring:message code="M00005"/>');
				location.href = '<ifvm:url name="partnerDetailUrl"/>' + '?rid=' + result.message;
			}
			else{
				alert('<spring:message code="M00029"/>');
			}
			}
		);


	}

}

function setCalendar() {
	 var startDate = $('#termStartDate');
	 var endDate = $('#termEndDate');
	 //오늘날짜
	 startDate.val($.ifvGetTodayDate());
	 //오늘부터 한달 뒤
	 endDate.val($.ifvGetNewDate('m', +1).newDateS);

	 //설정
	 startDate.ifvDateChecker({
	  maxDate : endDate
	 });

	 endDate.ifvDateChecker({
	  minDate : startDate
	 });

	 var annDate = $('#eventAnnDate');
	 annDate.val($.ifvGetTodayDate());
	 annDate.ifvDateChecker({});
}
function dateTrim(param){
	var rtnValue;
	rtnValue = param.split("-");
	return  rtnValue = rtnValue[0] + rtnValue[1] + rtnValue[2];
}
function btnListClick() {
	location.href = '<ifvm:url name="partnerList"/>';
}
</script>