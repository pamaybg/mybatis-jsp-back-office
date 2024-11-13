<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<article class="popup_wrap" id="targetJobPopup">
	<div class="content">
		<article>
			<header>
				<h4>타겟 Job 정보</h4>
			</header>
			<div class="content">
				<div class="form_container" id="targetJobForm">
					<div class="form_row">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="targetJobNm"
							dto="targetJobNm"
							type="text"
							label="타겟 Job"
							labelClass="3"
							conClass="8"
							nuc="true"
							required="true"
							readonly="true" />
							<div class="col-xs-1">
								<ifvm:inputNew
								type="button"
								btnType="search"
								nuc="true"
								className="color_fff"
								btnFunc="jobChoicePop" />
							</div>
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="targetJobActiveYn"
							dto="targetJobActiveYn"
							type="checkbox"
							label="활성 여부"
							text="활성"
							labelClass="3"
							conClass="3"
							nuc="true" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="execDelayTime"
							dto="execDelayTime" 
							type="text"
							label="실행 지연시간(초)"
							labelClass="3"
							conClass="3"
							nuc="true"
							required="true" />
						</div>
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
	btnFunc="saveTargetJob" />
	<ifvm:inputNew
	type="button"
	btnType="cancel"
	text="취소"
	nuc="true"
	btnFunc="targetJobDetailPopClose" />
</div>
<div id="jobChoicePopDiv" class="popup_container content_container"></div>

<script>
//지역변수
var targetJobFormVali = $("#targetJobForm").ifvValidation();
var isOldTargetJob = gTargetJobRid && !isTargetJobNew;
//전역변수
var gSelectedJobRid = "";

$("#execDelayTime").onlyNumber();

if(isOldTargetJob) {
	getTargetJobDetail();
}

//Job 선택 화면 팝업
function jobChoicePop() {
	$("#jobChoicePopDiv").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='jobChoicePop'/>",
		title: "Job 선택",
		width: 600,
		close: "jobChoicePopClose"
    });
}

//Job 선택 화면 팝업 닫기
function jobChoicePopClose() {
	jobChoicePopDiv._destroy();
}

//타겟 Job 저장
function saveTargetJob() {
	if(targetJobFormVali.confirm()) {
		var sendData = $("#targetJobForm").getSubmitData();
		sendData.ridExecJob = gSelectedJobRid;
		sendData.activeYn = sendData.targetJobActiveYn === true ? "Y" : "N";
		var url = !(isOldTargetJob) ? "<ifvm:action name='addTargetJob'/>" : "<ifvm:action name='editTargetJob'/>";
		if(isOldTargetJob) {
			sendData.rid = gTargetJobRid;
		} else {
			sendData.ridSbsqnt = gSbsqntRid;
		}
		var confirmMsg = !(isOldTargetJob) ? "저장되었습니다." : "수정되었습니다.";
		$.ifvPostJSON(
			url,
			sendData,
			function() {
				targetJobDetailPopClose();
				if(isOldTargetJob) {
					var curPageNum = targetJobGrid.opt.postData.page;
					targetJobGrid.requestData({"page": curPageNum});
				} else {
					targetJobGrid.requestData();
				}
				alert(confirmMsg);
			}, null, "#targetJobPopup", "bigsize_progressRoll include_progress"
		);
	}
}

//타겟 Job 상세 조회
function getTargetJobDetail() {
	var url = "<ifvm:action name='getTargetJobDetail'/>";
	var sendData = {};
	sendData.rid = gTargetJobRid;
	$.ifvPostJSON(
		url,
		sendData,
		function(_result) {
			_result.targetJobActiveYn = _result.activeYn === "Y" ? true : false;
			gSelectedJobRid = _result.ridExecJob;
			$("#targetJobForm").dataSetting(_result, null, false, []);
		}, null, "#targetJobPopup", "bigsize_progressRoll include_progress"
	);
}
</script>