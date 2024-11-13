<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<div class="form-horizontal underline top_well" id="limitMbrAddForm">
	<!-- 회원명 -->
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="custName" names="custName" label="L01406" labelClass="3" conClass="7" disabled="true"/>
	</div>
	<!-- 제한시작일 -->
	<div class="row qt_border">
		<!-- 페이지 로드 시 첫번째 활성영역인 제한시작일로 focus 이벤트가 자동발생하므로 hidden input 추가. -->
		<input type="text" style="border:none; width: 1px;"/>
		<ifvm:inputNew type="date" id="startDate" label="L02553" labelClass="3" conClass="7" required="true"/>
	</div>
	<!-- 제한종료일 -->
	<div class="row qt_border">
		<ifvm:inputNew type="date" id="endDate" label="L02554" labelClass="3" conClass="7" required="true"/>
	</div>
	<!-- 사유 -->
	<div class="row qt_border">
		<ifvm:inputNew type="textarea" id="limitDesc" label="L01633" labelClass="3" conClass="7" rows="5" required="true" maxLength="20"/>	
	</div>
</div>
<div class="pop_btn_area">
	<!-- 등록 -->
	<button class="btn btn-sm btn_gray" id="InsertLimitMbrBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L02251"/>
	</button>
	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="limitMbrAddCancelBtn">
		<spring:message code="L01781"/>
	</button>
</div>
<div id="popupContainer2" class="popup_container"></div><!-- 팝업 -->

<script>
var ridMbr ='<%= cleanXss(request.getParameter("ridMbr")) %>';
var rid ='<%= cleanXss(request.getParameter("rid")) %>';

$(document).ready(function(){
	
	selectNm();//마스킹해제된 이름 가져오기
	
	setValidCalendar();//달력셋팅
	
	//닫기
	$("#limitMbrAddCancelBtn").on("click",function(){
		limitMbrAddPopupClose();
	});
	
	//등록
	$("#InsertLimitMbrBtn").on("click",function(){
		InsertLimitMbr();
	});

});
 
//마스킹해제된 이름 가져오기
function selectNm() {	
	if ($.fn.ifvmIsNotEmpty(rid)) {
	    $.ifvSyncPostJSON('<ifvm:action name="evtWinnerClearMask"/>', {
	        rid:rid
	    },
	    function(result) {
	    	$('#custName').val(result.unMaskCustNm);
	    });
	}
}

//부정회원 등록
function InsertLimitMbr() {	
	var startDate = $('#startDate').val();
	var endDate = $('#endDate').val();
	var limitDesc = $('#limitDesc').val();
	validation = $("#limitMbrAddForm").ifvValidation();
	if(validation.confirm() && confirm('<spring:message code="L02557" />')){/* 부정회원으로 등록하시겠습니까? */
		$.ifvSyncPostJSON('<ifvm:action name="InsertLimitMbr"/>',{
			ridMbr : ridMbr,
			startDt : startDate,
			endDt : endDate,
			evtRid : eventRid,
			limitDesc : limitDesc
		}, function(result) {
	        if ($.fn.ifvmIsNotEmpty(result)) {
	            if (result.success == true) {
	            	$.ifvSyncPostJSON('<ifvm:action name="InsertMbrMsg"/>',{
	            		mbrRid : ridMbr,
	            		type   : "BLACK_MEM",
	            		evtRid : eventRid
	            	},function(result) {
	            		
	            	});
	                alert('<spring:message code="L02556" />');/* 등록되었습니다. */
	                limitMbrAddPopupClose();
	            }
	        }
	    });
	}
}

//달력셋팅
function setValidCalendar() {	
	var startDate = $('#startDate');
	var endDate = $('#endDate');

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
}
</script>