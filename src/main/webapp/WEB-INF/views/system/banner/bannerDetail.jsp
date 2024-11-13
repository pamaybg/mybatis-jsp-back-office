<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
#BannerTab{z-index : 1}
</style>
<div class="page-title">
    <h1>
		<spring:message code="D00001" />
        &gt; 배너관리
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span>배너관리<%-- <spring:message code="D00004" /> --%></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnMasterSave" btnFunc="btnMasterSaveClick" btnType="save" text="L00074" objCode="bannerDetilSave_OBJ" />
			<ifvm:inputNew type="button" id="goBanner" btnFunc="btnListClick" text="D00024" objCode="goBanner_OBJ"/>
	    </div>
	</div>
	
	<div class="well form-horizontal" id="bannerMasterForm">
		<div class="row qt_border">
			<ifvm:inputNew type="radio" id="bannerStatus" names="bannerStatus" dto="bannerStatus" required="true" label="L00090" labelClass="2" conClass="9" text="D00005|D00006" values="true|false" checkIndex="2"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="bannerMasterTitle" names="bannerMasterTitle" dto="bannerMasterTitle" nuc="true" required="true" label="베너 제목" labelClass="2" conClass="9" maxLength="200"/>
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="date" id="bannerShowDate" names="bannerShowDate" dto="bannerShowDate" label="D00008" labelClass="2" conClass="3" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="bannerSeqData" names="bannerSeqData" dto="bannerSeqData" required="true" label="L02333" labelClass="2" conClass="1"/>
		</div>
	</div>
</div>
<div id="bannerDetailTabArea">
	<!-- 탭 컨텐츠 -->
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>
<script>

var bannerDetailTab = $('#bannerDetailTabArea').DrawTab({
	item : [
	{ 	label : '<spring:message code="D00083"/>', href : '<ifvm:url name="banner_lang"/>?bannerLang='+'ko' },
	{	label : '<spring:message code="D00084"/>', href : '<ifvm:url name="banner_lang"/>?bannerLang='+'en'},
	{ 	label : '<spring:message code="D00085"/>', href : '<ifvm:url name="banner_lang"/>?bannerLang='+'zh' }
	]
});

var validation;

var updateFlag;
var bannerId = $.ifvGetParam('rid');

//이미지 업로드
var imageInfo = new Array();


if(bannerId == undefined ){
	updateFlag = false;
}
else{

	updateFlag = true;
}

function setDatePicker() {
	var date = $('#bannerShowDate');
	date.val($.ifvGetTodayDate());
	date.ifvDateChecker({});
}



$(document).ready(function() {
	$.ifvmLnbSetting('banner');
	setDatePicker();

	if(updateFlag){
		detailBanner(bannerId);
	}
});

function detailBanner(id){
	$.ifvSyncPostJSON('<ifvm:action name="getBannerMasterDetail"/>', {
		bannerId : bannerId
	}, function(result) {

		if(result.bannerStatus == "Y"){
			$("input:radio[name='bannerStatus']:radio[value='true']").attr("checked",true);
		}
		else{
			$("input:radio[name='bannerStatus']:radio[value='false']").attr("checked",true);
		}
		var date = $('#bannerShowDate');
		date.val(result.openDate);
		date.ifvDateChecker({});


		$('#bannerMasterTitle').val(result.bannerTitle);
		$('#bannerSeqData').val(result.bannerSeq);
		})
}

function btnMasterSaveClick() {
	validation = $('#bannerMasterForm').ifvValidation();
	if(validation.confirm() === false) return;
	else{

		var url;
		var showDate = $("#bannerShowDate").val().split('-')
		showDate = showDate[0] + showDate[1] + showDate[2];

	  if( bannerId == null ){ //신규
			url = '<ifvm:action name="insertBannerMaster"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		} else{					//수정
			url = '<ifvm:action name="insertBannerMaster"/>';
			if(confirm('<spring:message code="M01633"/>') === false) return;
		}

	 $.ifvSyncPostJSON( url,
			{
		 	bannerStatus : $(':radio[name="bannerStatus"]:checked').val(),
			bannerName : $("#bannerMasterTitle").val(),
			openDate : showDate,
			bannerId : bannerId,
			updateFlag : updateFlag,
			bannerSeq : $("#bannerSeqData").val(),
			},
			function(result) {

			 if(result.success == true){
				alert('<spring:message code="M00005"/>');
				location.href = '<ifvm:url name="bannerDetailUrl"/>' + '?rid=' + result.message;
			}
			else{
				alert('<spring:message code="M00029"/>');
			}
			}
		);


	}

}

function btnListClick() {
	location.href = '<ifvm:url name="bannerListUrl"/>';
}
</script>