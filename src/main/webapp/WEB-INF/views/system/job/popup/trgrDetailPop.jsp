<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<article class="popup_wrap" id="trgrPopup">
	<div class="content">
		<article>
			<header>
				<h4>Job 정보</h4>
			</header>
			<div class="form_container" id="trgrJobForm">
				<div class="form_row">
					<div class="col-xs-11">
						<ifvm:inputNew
						id="jobNm"
						dto="jobNm"
						type="text"
						required="true"
						label="Job"
						labelClass="3"
						conClass="9"
						nuc="true"
						readonly="true" />
					</div>
				</div>
				<div class="form_row">
					<div class="col-xs-11">
						<ifvm:inputNew
						id="jobGrp"
						dto="jobGrp"
						type="text"
						required="true"
						label="Job 그룹"
						labelClass="3"
						conClass="9"
						nuc="true"
						readonly="true" />
					</div>
				</div>
			</div>
		</article>
		<article>
			<header>
				<h4>트리거 정보</h4>
			</header>
			<div class="form_container" id="trgrForm">
				<div class="form_row">
					<div class="col-xs-11">
						<ifvm:inputNew
						id="trgrNm"
						dto="trgrNm"
						type="text"
						required="true"
						label="트리거 명"
						labelClass="3"
						conClass="9"  
						nuc="true"
						maxLength="66" />
					</div>
				</div>
				<div class="form_row">
					<div class="col-xs-11">
						<ifvm:inputNew
						type="date"
						id="startDate"
						dto="startDate"
						required="true"
						label="시작일시"
						labelClass="3"
						conClass="3"
						nuc="true" />
						<ifvm:inputNew
						type="time"
						id="startTime"
						dto="startTime"
						conClass="3"
						nuc="true" />
					</div>
				</div>
				<div class="form_row">
					<div class="col-xs-11">
						<ifvm:inputNew 
						type="date"
						id="endDate"
						dto="endDate"
						required="true"
						label="종료일시"
						labelClass="3"
						conClass="3"
						nuc="true" />
						<ifvm:inputNew
						type="time"
						id="endTime"
						dto="endTime"
						conClass="3"
						nuc="true" />
					</div>
				</div>
				<div class="form_row">
					<div class="col-xs-11">
						<ifvm:inputNew
						id="cronExpr"
						dto="cronExpr"
						type="text"
						required="true"
						label="Cron 표현식"
						labelClass="3"
						conClass="9"
						nuc="true"
						maxLength="33" />
					</div>
				</div>
				<div class="form_row">
					<div class="col-xs-11 label_top">
						<ifvm:inputNew 
						type="textarea"
						id="cronSample"
						label="Cron 표현식 예"
						nuc="true"
						labelClass="3"
						conClass="9"
						rows="6"
						readonly="true"
						maxLength="2000" />
					</div>
				</div>
			</div>
		</article>
	</div>
</article>
<div class="pop_btn_area">
	<ifvm:inputNew
	type="button"
	btnType="save"
	text="저장"
	nuc="true"
	btnFunc="saveTrgr" />
	<ifvm:inputNew
	type="button"
	btnType="cancel"
	text="취소"
	nuc="true"
	btnFunc="trgrDetailPopClose" />
</div>

<script>
//지역변수
var trgrFormVali = $("#trgrForm").ifvValidation();
var isOldTrgr = gTrgrRid && !isTrgrNew;

var tempData = {};
tempData.jobNm = gJobNm;
tempData.jobGrp = gJobGrp;
$("#trgrJobForm").dataSetting(tempData, null, false, []);

setCalendar();
setTimepicker();

$("#cronSample").val(
	"\"0 0 12 * * ?\"\t\t\t[매일 12시 실행]"
	+ "\n\"0 15 10 * * ?\"\t\t\t[매일 10시 15분 실행]"
	+ "\n\"0 15 10 * * ? 2005\"\t\t[2005년에 매일 10시 15분 실행]"
	+ "\n\"0 * 14 * * ?\"\t\t\t[매일 14시에 0분~59분까지 매분 실행]"
	+ "\n\"0 0/5 14 * * ?\"\t\t\t[매일 14시에 시작해서 5분 간격으로 실행]"
	+ "\n\"0 0/5 14,18 * * ?\"\t\t[매일 14시부터 14시 55분까지 5분마다, 18시부터 18시 55분까지 5분마다 실행]"
	+ "\n\"0 0-5 14 * * ?\"\t\t\t[매일 14시에 0분, 1분, 2분, 3분, 4분, 5분에 실행]"
	+ "\n\"0 10,44 14 ? 3 WED\"\t\t[매년 3월의 수요일마다 오후 2시 10분과 2시 44분 실행]"
	+ "\n\"0 15 10 ? * MON-FRI\"\t\t[월~금일 10시 15분 0초에 실행 ]"
	+ "\n\"0 15 10 15 * ?\"\t\t\t[매달 15일 오전 10시 15분 실행]"
	+ "\n\"0 15 10 L * ?\"\t\t\t[매달 마지막 날 오전 10시 15분 실행]"
	+ "\n\"0 15 10 ? * 6L\"\t\t\t[매달 마지막 금요일 오전 10시 15분 실행]"
	+ "\n\"0 15 10 ? * 6L 2002-2005\"\t[2002년부터 2005년까지 매달 마지막 금요일 오전 10시 15분 실행]"
	+ "\n\"0 15 10 ? * 6#3\"\t\t[매달 3번째 금요일 오전 10시 15분 실행]"
	+ "\n\"0 0 12 1/5 * ?\"\t\t\t[매달 첫날부터 5일마다 12시 실행]"
	+ "\n\"0 11 11 11 11 ?\"\t\t[매년 11월 11일 오전 11시 11분 실행]"
	+ "\n\"0 0/1 * * * ?\"\t\t\t[매 1분마다 실행]"
	+ "\n\"0 0/10 * * * ?\"\t\t\t[매 10분마다 실행]"
);

if(isOldTrgr) {
	getTrgrDetail();
}

//달력 셋팅
function setCalendar() {
	var startDate = $("#startDate");
	var endDate = $("#endDate");
	//오늘 날짜
	startDate.val($.ifvGetTodayDate());
	//오늘부터 10년 뒤 마지막 날짜
	var endOfDays = (new Date(startDate.val()).getFullYear() + 10) + "-12-31";
	endDate.val(endOfDays);
	startDate.ifvDateChecker({
		maxDate: endDate
	});
	endDate.ifvDateChecker({
		minDate: startDate
	});
}

//시간 셋팅
function setTimepicker() {
	var startTime = $("#startTime");
	var endTime = $("#endTime");
	startTime.timepicker({
		defaultTime: "00:00",
		timeFormat: "H:i",
		showMeridian: false
	});
	endTime.timepicker({
		defaultTime: "23:59",
		timeFormat: "H:i",
		showMeridian: false
	});
}

//트리거 저장
function saveTrgr() {
	if(trgrFormVali.confirm()) {
		var sendData = $("#trgrForm").getSubmitData();
		//날짜 재조합
		sendData.startDttm = new Date(sendData.startDate + "T" + sendData.startTime + ":00");
		sendData.endDttm = new Date(sendData.endDate + "T" + sendData.endTime + ":00");
		var url = !(isOldTrgr) ? "<ifvm:action name='addTrgr'/>" : "<ifvm:action name='editTrgr'/>";
		sendData.ridJobMst = gJobRid;
		if(isOldTrgr) {
			sendData.rid = gTrgrRid;
		}
		var confirmMsg = !(isOldTrgr) ? "저장되었습니다." : "수정되었습니다.";
		$.ifvPostJSON(
			url,
			sendData,
			function() {
				trgrDetailPopClose();
				if(isOldTrgr) {
					var curPageNum = trgrGrid.opt.postData.page;
					trgrGrid.requestData({"page": curPageNum});
				} else {
					trgrGrid.requestData();
				}
				alert(confirmMsg);
			}, null, "#trgrPopup", "bigsize_progressRoll include_progress"
		);
	}
}

//트리거 상세 조회
function getTrgrDetail() {
	var url = "<ifvm:action name='getTrgrDetail'/>";
	var sendData = {};
	sendData.rid = gTrgrRid;
	$.ifvPostJSON(
		url,
		sendData,
		function(_result) {
			var startDttm = new Date(_result.startDttm);
			var endDttm = new Date(_result.endDttm);
			_result.startDate = startDttm.format("yyyy-mm-dd");
			_result.startTime = startDttm.format("HH:MM");
			_result.endDate = endDttm.format("yyyy-mm-dd");
			_result.endTime = endDttm.format("HH:MM");
			$("#trgrForm").dataSetting(_result, null, false, []);
		}, null, "#trgrPopup", "bigsize_progressRoll include_progress"
	);
}
</script>