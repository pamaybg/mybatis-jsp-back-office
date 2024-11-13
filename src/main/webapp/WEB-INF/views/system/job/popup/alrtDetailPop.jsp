<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<article class="popup_wrap" id="alrtPopup">
	<div class="content">
		<article>
			<header>
				<h4>알람 정보</h4>
			</header>
			<div class="content">
				<div class="form_container" id="alrtForm">
					<div class="form_row">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="alrtNm"
							dto="alrtNm"
							type="text"
							required="true"
							label="알람 명"
							labelClass="3"
							conClass="9"
							nuc="true"
							maxLength="66" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="activeYn"
							dto="activeYn"
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
							id="alrtCondCd"
							dto="alrtCondCd"
							type="select"
							label="알람 조건 유형"
							labelClass="3"
							conClass="3"
							nuc="true" />
						</div>
					</div>
					<div class="form_row none" id="condValForm">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="condVal"
							dto="condVal"
							type="select"
							label="조건 값"
							labelClass="3"
							conClass="3"
							nuc="true" />
						</div>
					</div>
					<div class="form_row none" id="execTimeForm">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="execTime"
							dto="execTime"
							type="text"
							required="true"
							label="실행 시간"
							labelClass="3"
							conClass="3"
							nuc="true"
							maxLength="5" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="trsChnlCd"
							dto="trsChnlCd"
							type="select"
							label="채널 유형"
							labelClass="3"
							conClass="3"
							nuc="true" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="rcvr"
							dto="rcvr"
							type="text"
							required="true"
							label="수신자"
							placeholder="멀티 수신자는 콤마로 분리해서 입력하세요."
							labelClass="3"
							conClass="9"
							nuc="true"
							maxLength="133" />
						</div>
					</div>
					<div class="form_row none" id="sbjtForm">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="sbjt"
							dto="sbjt"
							type="text"
							required="true"
							label="제목"
							labelClass="3"
							conClass="9"
							nuc="true"
							maxLength="133" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-11 label_top">
							<ifvm:inputNew
							id="msgContent"
							dto="msgContent"
							type="textarea"
							required="true"
							label="메세지 내용"
							rows="5"
							labelClass="3"
							conClass="9"
							nuc="true"
							maxLength="1333" />
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
	btnFunc="saveAlrt" />
	<ifvm:inputNew
	type="button"
	btnType="cancel"
	text="취소"
	nuc="true"
	btnFunc="alrtDetailPopClose" />
</div>

<script>
//지역변수
var alrtFormVali = $("#alrtForm").ifvValidation();
var isOldAlrt = gAlrtRid && !isAlrtNew;

getCommCodeList();
changeAlrtDisplay();
changeChnlDisplay();
$("#execTime").onlyNumber();
$("#alrtCondCd").change(changeAlrtDisplay);
$("#trsChnlCd").change(changeChnlDisplay);

if(isOldAlrt) {
	getAlrtDetail();
}

//공통코드 조회
function getCommCodeList() {
	$.ifvGetCommCodeList("select", "alrtCondCd", "<ifvm:action name='getCommCodeList'/>", "BAT_JOB_COND_CD", "neims", false, false);
	$.ifvGetCommCodeList("select", "condVal", "<ifvm:action name='getCommCodeList'/>", "BAT_JOB_COND_VAL", "neims", false, false);
	$.ifvGetCommCodeList("select", "trsChnlCd", "<ifvm:action name='getCommCodeList'/>", "BAT_ALARM_CHANNEL", "neims", false, false);
}

//알람 조건 유형에 따른 화면 변경 처리
function changeAlrtDisplay() {
	switch($("#alrtCondCd").val()) {
		case "RESULT":
			$("#condValForm").removeClass("none");
			$("#execTimeForm").addClass("none");
			execTime.removeAttribute("required");
			break;
		case "TIME":
			$("#condValForm").addClass("none");
			$("#execTimeForm").removeClass("none");
			execTime.setAttribute("required", true);
			break;
	}
}

//채널 유형에 따른 화면 변경 처리
function changeChnlDisplay() {
	switch($("#trsChnlCd").val()) {
		case "MAIL":
			$("#sbjtForm").removeClass("none");
			sbjt.setAttribute("required", true);
			break;
		case "SMS":
			$("#sbjtForm").addClass("none");
			sbjt.removeAttribute("required");
			break;
	}
}

//알람 저장
function saveAlrt() {
	var regExpEmail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	var regExpCell = /^(01[016789]{1}|070|02|0[3-9]{1}[0-9]{1})-[0-9]{3,4}-[0-9]{4}$/;
	var regExp = null;
	var isError = false;
	if(alrtFormVali.confirm()) {
		var sendData = $("#alrtForm").getSubmitData();
		regExp = sendData.trsChnlCd === 'MAIL' ? regExpEmail : regExpCell;
		var rcvrArr = sendData.rcvr.split(',');
		rcvrArr.forEach(function(rcvrStr) {
			if(isError) {
				return;
			}
			if(!regExp.test(rcvrStr)) {
				alert("이메일 또는 전화번호 형식으로 입력해주세요.");
				isError = true;
				return;
			}
		});
		if(!isError) {
			sendData.activeYn = sendData.activeYn === true ? "Y" : "N";
			var url = !(isOldAlrt) ? "<ifvm:action name='addAlrt'/>" : "<ifvm:action name='editAlrt'/>";
			if(isOldAlrt) {
				sendData.rid = gAlrtRid;
			} else {
				sendData.ridJobMst = gJobRid;
			}
			var confirmMsg = !(isOldAlrt) ? "저장되었습니다." : "수정되었습니다.";
			$.ifvPostJSON(
				url,
				sendData,
				function() {
					alrtDetailPopClose();
					if(isOldAlrt) {
						var curPageNum = alrtGrid.opt.postData.page;
						alrtGrid.requestData({"page": curPageNum});
					} else {
						alrtGrid.requestData();
					}
					alert(confirmMsg);
				}, null, "#alrtPopup", "bigsize_progressRoll include_progress"
			);
		}
	}
}

//알람 상세 조회
function getAlrtDetail() {
	var url = "<ifvm:action name='getAlrtDetail'/>";
	var sendData = {};
	sendData.rid = gAlrtRid;
	$.ifvPostJSON(
		url,
		sendData,
		function(_result) {
			_result.activeYn = _result.activeYn === "Y" ? true : false;
			$("#alrtForm").dataSetting(_result, null, false, []);
			changeAlrtDisplay();
			changeChnlDisplay();
		}, null, "#alrtPopup", "bigsize_progressRoll include_progress"
	);
}
</script>