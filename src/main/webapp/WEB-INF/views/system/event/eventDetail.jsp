<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
	<h1>
		<spring:message code="D00001" />
        &gt; <spring:message code="D00030" />
	</h1>
</div>

<div class="page_btn_area">
    <div class="col-xs-5">
        <span><spring:message code="D00032" /></span>
    </div>
    <div class="col-xs-7 searchbtn_r">
		<ifvm:inputNew type="button" id="goEventList" btnFunc="btnListClick" text="D00024" objCode="goEventList_OBJ"/>
    </div>
</div>

<div id="eventDetailTabArea">
	<!-- 탭 컨텐츠 -->
	<div>
		<div id="tabContent" class="white_bg grid_bd0"></div>
	</div>
</div>
<script>

var noticeDetailTab = $('#eventDetailTabArea').DrawTab({
	item : [{label : '<spring:message code="D00033"/>', href : '<ifvm:url name="eventInfoUrl"/>' }]
});

var eventId = $.ifvGetParam('id');
var validation;
var updateFlag = true;

$(document).ready(function() {
	$.ifvmLnbSetting('eventList');
	if(eventId == null) {
		$('#eventParti').attr('disabled', true);
		$('#eventPrizewinner').attr('disabled', true);
		updateFlag = false;
	}
});

function btnListClick() {
	location.href = '<ifvm:url name="eventListUrl"/>';
}

</script>