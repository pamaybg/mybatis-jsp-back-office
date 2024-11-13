<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
#appPopTab{z-index : 1}
</style>
<div class="page-title">
    <h1>
		<spring:message code="D00001" />
        &gt; <spring:message code="D00058" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span>App 팝업</span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnSave" btnFunc="btnSaveMasterClick" btnType="save" text="L00074" objCode="appPopListDetailSave_OBJ" />
			<ifvm:inputNew type="button" id="goAppPopList" btnFunc="btnListClick" text="D00024" objCode="goAppPopList_OBJ"/>
	    </div>
	</div>
	
	<div class="well form-horizontal" id="appPopMasterForm">
		<div class="row qt_border">
			<ifvm:inputNew type="select" id="appPopType" names="appPopType" dto="appPopType" required="true" label="D00061" labelClass="2" conClass="9" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="appPopMasterTitle" names="appPopMasterTitle" dto="appPopMasterTitle" required="true" label="D00086" labelClass="2" conClass="9" maxLength="200" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="date" id="popShowStartDate" names="popShowStartDate" dto="popShowStartDate" required="true" label="L00377" labelClass="2" conClass="3" />
			<ifvm:inputNew type="time" id="popShowStartTime" names="popShowStartTime" dto="popShowStartTime" required="true" label="D00064" labelClass="3" conClass="3" />
		</div>
		<div class="row qt_border">
			<ifvm:inputNew type="date" id="popShowEndDate" names="popShowEndDate" dto="popShowEndDate" required="true" label="L00402" labelClass="2" conClass="3" />
			<ifvm:inputNew type="time" id="popShowEndTime" names="popShowEndTime" dto="popShowEndTime" required="true" label="D00066" labelClass="3" conClass="3" />
		</div>
	</div>
</div>
<div id="appPopDetailTabArea">
	<!-- 탭 컨텐츠 -->
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>

<script id="selectAppPopUpTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<script>
	
var appPopDetailTab = $('#appPopDetailTabArea').DrawTab({
	item : [ 
	{ 	label : '<spring:message code="D00083"/>', href : '<ifvm:url name="appPop_lang"/>?appPopLang='+'ko' }, 
	{	label : '<spring:message code="D00084"/>', href : '<ifvm:url name="appPop_lang"/>?appPopLang='+'en' }, 
	{ 	label : '<spring:message code="D00085"/>', href : '<ifvm:url name="appPop_lang"/>?appPopLang='+'zh' } 
	]
});

var startDate = $('#popShowStartDate');
var startTime = $('#popShowStartTime');
var endDate = $('#popShowEndDate');
var endTime = $('#popShowEndTime');


var validation;
var updateFlag;
var appPopId = $.ifvGetParam('rid');

if(appPopId == undefined ){
	updateFlag = false;
}
else{
	
	updateFlag = true;
}

function setDateAndTime() {
	startDate.val($.ifvGetTodayDate());
	endDate.val($.ifvGetNewDate('m', +1).newDateS);

	startDate.ifvDateChecker({
		maxDate : endDate
	});
	 
	endDate.ifvDateChecker({
		minDate : startDate
	});

	startTime.timepicker({
		defaultTime : '00:00',
		timeFormat: 'H:i',
		showMeridian : false
	});

	endTime.timepicker({
		defaultTime : '23:59',
		timeFormat: 'H:i',
		showMeridian : false
	});
}

$(document).ready(function() {
	$.ifvmLnbSetting('appPopList');

	getCommonCode();

	if(updateFlag){
		detailAppPop();
	}
	else{
		setDateAndTime();
	}
});

function btnSaveMasterClick() {
	validation = $('#appPopMasterForm').ifvValidation();
		
	if(validation.confirm() === false) return;
	else{
		
		var url;
		var openDate = to_date($('#popShowStartDate').val()) + to_time($('#popShowStartTime').val())
		var endDate = to_date($('#popShowEndDate').val()) + to_time($('#popShowEndTime').val())
	 
	 $.ifvSyncPostJSON( '<ifvm:action name="insertAppPopMaster"/>',
			{
		 	openDate : openDate,
			endDate : endDate,
			appPopMasterTitle : $("#appPopMasterTitle").val(),
			appPopType : $('#appPopType').val(),
			updateFlag : updateFlag,
			appPopId : appPopId
			},
			function(result) {
				
			 if(result.success == true){
				alert('<spring:message code="M00005"/>');
				location.href = '<ifvm:url name="appPopDetailUrl"/>' + '?rid=' + result.message;
			}
			else{
				alert('<spring:message code="M00029"/>');
			}
			}
		);
	}
	
}

function btnListClick() {
	location.href = '<ifvm:url name="appPopListUrl"/>';
}

function getCommonCode() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'APP_POPUP_TYPE'
		,schemas : 'com'
		, enableNA : false
	}, function(result) {
		for (var i=0; i<result.rows.length; i++) {
			if (result.rows[i].codeName != "NA") {
				result.rows[i].codeName = result.rows[i].codeName;
			}
		}
		var temp = $("#selectAppPopUpTemplate").tmpl(result.rows);
		$("#appPopType").append(temp);
	});
}

function to_date(date){
	var Date = date.split('-');
	var rtnValue = "";
	for(var i=0; i<Date.length; i++){
		rtnValue = rtnValue + Date[i];
	}
	return rtnValue;
}
function to_time(time){
	var Time = time[0] + time[1] + time[3] + time[4]
	return Time;
}

function detailAppPop(){
	
	$.ifvSyncPostJSON('<ifvm:action name="getAppPopMaster"/>', {
		appPopId : appPopId
	}, function(result) {
		
		$("#appPopType").val(result.appPopStatus).attr("selected", "selected");
		$('#appPopMasterTitle').val(result.appPopMasterName);
		$('#popShowStartDate').val(result.openDate);
		$('#popShowStartTime').val(result.openTime);
		$('#popShowEndDate').val(result.endDate);
		$('#popShowEndTime').val(result.endTime);
		$('#popShowEndDate').ifvDateChecker({minDate : startDate});
		$('#popShowStartDate').ifvDateChecker({maxDate : endDate});
		$('#popShowStartTime').timepicker({
			timeFormat: 'H:i',
			showMeridian : false
		});

		$('#popShowEndTime').timepicker({
			timeFormat: 'H:i',
			showMeridian : false
		});
		
	});
}

</script> 