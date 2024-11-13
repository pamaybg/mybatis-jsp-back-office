<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
.icheckbox {padding-left: 20px;}
#langTab { z-index : 1; }
</style>
<div class="page_btn_area">
    <div class="col-xs-5">
        <span><spring:message code="D00033" /></span>
    </div>
    <div class="col-xs-7 searchbtn_r">
		<ifvm:inputNew type="button" id="btnNew" className="btn_gray" btnFunc="btnSaveClick" btnType="save" text="L00074" objCode="eventInfoSave_OBJ"/>
    </div>
</div>
<div class="well form-horizontal" id="eventInfoForm">
	<div class="row qt_border">
		<ifvm:inputNew type="radio" id="eventStatus" names="eventStatus" dto="eventStatus" required="true" label="L00090" labelClass="2" conClass="9" text="D00005|D00006" values="true|false" checkIndex="2"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="dateTerm" startDto="termStartDate" endDto="termEndDate" startId="termStartDate" endId="termEndDate" required="true"
			label="D00037" labelClass="2" conClass="6" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="seq" names="seq" dto="seq" label="L02333" labelClass="2" conClass="1" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="singleCheckbox" id="popupShowFlag" dto="popupShowFlag" labelClass="2" conClass="6" label="D10215" />
	</div>
</div>

<div id="langUrlTabArea">
	<!-- 탭 컨텐츠 -->
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>

<script>

var noticeDetailTab = $('#langUrlTabArea').DrawTab({
	item : [
	{ 	label : '<spring:message code="D00083"/>', href : '<ifvm:url name="info_lang"/>?eventLang='+'ko' }
	]
});

$(document).ready(function() {
	eventInfo_init(null);
});

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

function eventInfo_init(params) {

	setCalendar();
	if(eventId != null){

		eventInfoDetail(eventId)
	}
}

function btnSaveClick() {
	validation = $('#eventInfoForm').ifvValidation();
	if(validation.confirm() === false) return;
	else{

		var appPopYn;
		if($(':checkbox[dtoparam="popupShowFlag"]:checked').val() == "on"){
			appPopYn = "Y";
		}
		else{
			appPopYn = "N";
		}

		var startDate = dateTrim($('#termStartDate').val());
		var endDate = dateTrim($('#termEndDate').val());
	if(confirm('<spring:message code="M01633"/>') === false) return;
	else{
		$.ifvSyncPostJSON( '<ifvm:action name="insertEventInfo"/>',
				{
				 	eventStatus : $(':radio[name="eventStatus"]:checked').val(),
					startDate : startDate,
					endDate : endDate,
					appPopYn : appPopYn,
					seq : $('#seq').val(),
					eventDesc : $('#eventDesc').val(),
					updateFlag : updateFlag,
					eventId : eventId
				},
				function(result) {

					 if(result.success == true){
						alert('<spring:message code="M00005"/>');
						location.href = '<ifvm:url name="eventDetailUrl"/>' + '?id=' + result.message;
						}
					else{
						alert('<spring:message code="M00029"/>');
						}
				}
			);
		}}}

function eventInfoDetail(id){
	$.ifvSyncPostJSON('<ifvm:action name="getEventInfoDetail"/>', {
		eventId : id
	}, function(result) {

		if(result.eventStatus == "Y"){
			$("input:radio[name='eventStatus']:radio[value='true']").attr("checked",true);
		}
		else{
			$("input:radio[name='eventStatus']:radio[value='false']").attr("checked",true);
		}
		$('#termStartDate').val(result.startDate.substr(0, 10));
		$('#termEndDate').val(result.endDate.substr(0, 10));
		$('#seq').val(result.seq);
		if(result.appPopYn == 'Y'){
			$(':checkbox[dtoparam="popupShowFlag"]').attr("checked",true);
		}
		else{
			$(':checkbox[dtoparam="popupShowFlag"]').attr("checked",false);
		}

		})
}

function dateTrim(param){
	var rtnValue;
	rtnValue = param.split("-");
	return  rtnValue = rtnValue[0] + rtnValue[1] + rtnValue[2];
}

</script>