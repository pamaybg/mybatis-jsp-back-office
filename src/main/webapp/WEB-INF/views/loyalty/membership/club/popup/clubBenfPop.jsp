<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
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
<script type="text/javascript">
var validationPop;
var clubBenfRid = '<%= cleanXss(request.getParameter("rid")) %>';
$(document).ready(function(){

	init();
});

function init(){
	clubBenfPopSelectBoxSetting();
	clubBenfPopSetValidCalendar();
	clubBenfDtlSetting();
}
function clubBenfDtlSetting(){
	if (clubBenfRid != "null") {
		$.ifvSyncPostJSON( '<ifvm:action name="getClubBenfDtl"/>',{rid :clubBenfRid }
		,function(result) {
			$("#clubBenfPopForm").dataSetting(result);
		});
	}

}

function campaignSearchFn(){
	 $("#campaignSearchHelpPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="campaignSearchHelp"/>',
	        contentType: "ajax",
	        title: "캠페인 목록",
	        width: '700px',
	        close : function(obj) {
				if(typeof obj.event !="undefined"){
					$("#clubBenfPopForm #camName").val(obj.event.campaignName);
					$("#clubBenfPopForm #ridCamMst").val(obj.event.id);
				}
				campaignSearchHelpPop._destroy();
			}
	   });
}


function getBasicChnl(){
	$("#basicChnl").val( $("#clubForm #chnlNm").val());
}


function clubBenfPopSelectBoxSetting(){
	$.fn.ifvmSetSelectOptionCommCode("type", "LOY_CLUB_BENF_CD", null, null, true);

}


function clubBenfPopSetValidCalendar(){
	 	var startDate = $("#validStartDate");
	    var endDate = $("#validEndDate");

	   	startDate.val($.ifvGetTodayDate());
	  	endDate.val('2999-12-31');
	   	endDate.ifvDateChecker({});


		startDate.ifvDateChecker({
			maxDate : endDate
		});

		endDate.ifvDateChecker({
			minDate : startDate
		});
}

function clubBenfPopSetEndData(){
	var date = new Date();
	var year = date.getFullYear();
	var month = new String(date.getMonth()+1);
	var day = new String(date.getDate());

	// 한자리수일 경우 0을 채워준다.
	if(month.length == 1){
	  month = "0" + month;
	}
	if(day.length == 1){
	  day = "0" + day;
	}

	date = year + 10 + '-' + month + '-' + day;

	var startDate = $("#validStartDate");
	var endDate = $("#validEndDate");
	endDate.val(date);

	endDate.ifvDateChecker({
		minDate : startDate
	});
}

function saveClubBenfPopFn(){
	validationPop = $("#clubBenfPopForm").ifvValidation();
	if(validationPop.confirm()){
		var submitData = $("#clubBenfPopForm").getSubmitData();
		submitData.rid =  clubBenfRid;
		$.ifvSyncPostJSON( clubBenfRid=="null" ? '<ifvm:action name="insertClubBenf"/>' : '<ifvm:action name="updateClubBenf"/>',submitData
		,function(result) {
			alert('<spring:message code="M00295"/>');
			clubBenfGrid.requestData();
			clubBenfPopClose();
		});
	}
}

function cancelClubBenfPopFn(){
	clubBenfPopClose();
}




function clubChnlPopupClose(obj){
	if(typeof obj !="undefined" && obj.type !="close"){
		$("#clubBenfPopForm #chnlPop").val(obj.chnlNo);
		$("#clubBenfPopForm #ridChnl").val(obj.rid);
		$("#clubBenfPopForm #chnlPopNm").val(obj.chnlNm);
	}
	chnlLimitSearchPop._destroy();
}

</script>



<div class="pop_inner_wrap form-horizontal" >
	<div id="clubBenfPopForm" class="content">

		<div class="form_container">
			<div class="form_row">
				<div class="col-xs-12">
				<ifvm:inputNew type="text" id="name" dto="name" label="혜택명" labelClass="3" conClass="7"  nuc="true" required="true" />
				</div>
			</div>
		</div>

		<div class="form_container">
			<div class="form_row">
				<div class="col-xs-12">
				<ifvm:inputNew type="select" id="type" dto="type" names="type" label="혜택유형" labelClass="3" conClass="7"  nuc="true" required="true" />
				</div>
			</div>
		</div>

		<div class="form_container">
			<div class="form_row">
				<div class="col-xs-12">
					<ifvm:inputNew type="search" id="camName|campaignSearchBtn"
						names="camName" hidId="ridCamMst" hidDto="ridCamMst" dto="camName"
						disabled="false" btnFunc="campaignSearchFn" label="관련캠페인명" nuc ="true"
						labelClass="3" conClass="7" />
				</div>
			</div>
		</div>

		<div class="form_container">

			<div class="form_row">
				<div class="col-xs-12">
							<ifvm:inputNew type="dateTerm" startDto="validStartDate"
							endDto="validEndDate" startId="validStartDate"
							endId="validEndDate" label="효력시작일/종료일" nuc="true" labelClass="3"
							conClass="7" />
				</div>
			</div>
		</div>



		<div class="form_container">
			<div class="form_row">
				<div class="col-xs-12">
				<ifvm:inputNew type="textarea" id="comment" dto="comment" rows="6"  label="상세설명" nuc="true" labelClass="3" conClass="9" maxLength="1000"  />
				</div>
			</div>
		</div>
	</div>
</div>

<div class="pop_btn_area">
       	<ifvm:inputNew type="button" btnType="save"    text="L00074"  id="saveClubBenfPopBtn" btnFunc="saveClubBenfPopFn"/>
        <ifvm:inputNew type="button"    text="L00073"  id="cancelClubBenfPopBtn" btnFunc="cancelClubBenfPopFn"/>
</div>


<div id="campaignSearchHelpPop" class ="popup_container"></div>
