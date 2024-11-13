<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<article class="popup_wrap" id="sbsqntPopup">
	<div class="content">
		<article>
			<header>
				<h4>후속 실행 Job 정보</h4>
			</header>
			<div class="content">
				<div class="form_container" id="sbsqntForm">
					<div class="form_row">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="sbsqntJobNm"
							dto="sbsqntJobNm"
							type="text"
							required="true"
							label="후속 실행 Job 명"
							labelClass="3"
							conClass="9"
							nuc="true"
							maxLength="66" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-11">
							<ifvm:inputNew
							id="sbsqntActiveYn"
							dto="sbsqntActiveYn"
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
							id="execCondCd"
							dto="execCondCd"
							type="select"
							label="후속 실행 Job 조건 유형"
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
				</div>
			</div>
		</article>
		<article class="grid_content" id="targetJobDiv" hidden>
			<header>
				<h5>타겟 Job 정보</h5>
				<ul class="btn_container">
					<li>
						<ifvm:inputNew
						type="button"
						btnType="plus"
						text="신규"
						nuc="true"
						btnFunc="addTargetJob" />
					</li>
					<li>
			 			<ifvm:inputNew
			 			type="button"
			 			btnType="revise"
			 			text="수정"
			 			nuc="true"
			 			btnFunc="editTargetJob" />
					</li>
					<li>
						<ifvm:inputNew
						type="button"
						btnType="minus"
						text="삭제"
						nuc="true"
						btnFunc="removeTargetJob" />
					</li>
				</ul>
			</header>
			<div class="content grid_container" id="targetJobGridCon"></div>
		</article>
	</div>
</article>
<div class="pop_btn_area">
	<ifvm:inputNew
	type="button"
	btnType="save"
	text="저장"
	nuc="true"
	btnFunc="saveSbsqnt" />
	<ifvm:inputNew
	type="button"
	btnType="cancel"
	text="취소"
	nuc="true"
	btnFunc="sbsqntDetailPopClose" />
</div>
<div id="targetJobDetailPopDiv" class="popup_container content_container"></div>

<script>
//지역변수
var sbsqntFormVali = $("#sbsqntForm").ifvValidation();
var targetJobGrid = null;
var isOldSbsqnt = gSbsqntRid && !isSbsqntNew;
//전역변수
var gTargetJobRid = "";
var isTargetJobNew = true;

getCommCodeList();
changeExecDisplay();
$("#execTime").onlyNumber();
$("#execCondCd").change(changeExecDisplay);

if(isOldSbsqnt) {
	getSbsqntDetail();
}

//공통코드 조회
function getCommCodeList() {
	$.ifvGetCommCodeList("select", "execCondCd", "<ifvm:action name='getCommCodeList'/>", "BAT_JOB_COND_CD", "neims", false, false);
	$.ifvGetCommCodeList("select", "condVal", "<ifvm:action name='getCommCodeList'/>", "BAT_JOB_COND_VAL", "neims", false, false);
}

//실행 조건 유형에 따른 화면 변경 처리
function changeExecDisplay() {
	switch($("#execCondCd").val()) {
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

//후속 실행 Job 저장
function saveSbsqnt() {
	if(sbsqntFormVali.confirm()) {
		var sendData = $("#sbsqntForm").getSubmitData();
		sendData.activeYn = sendData.sbsqntActiveYn === true ? "Y" : "N";
		var url = !(isOldSbsqnt) ? "<ifvm:action name='addSbsqnt'/>" : "<ifvm:action name='editSbsqnt'/>";
		if(isOldSbsqnt) {
			sendData.rid = gSbsqntRid;
		} else {
			sendData.ridJobMst = gJobRid;
		}
		var confirmMsg = !(isOldSbsqnt) ? "저장되었습니다." : "수정되었습니다.";
		$.ifvPostJSON(
			url,
			sendData,
			function() {
				sbsqntDetailPopClose();
				if(isOldSbsqnt) {
					var curPageNum = sbsqntGrid.opt.postData.page;
					sbsqntGrid.requestData({"page": curPageNum});
				} else {
					sbsqntGrid.requestData();
				}
				alert(confirmMsg);
			}, null, "#sbsqntPopup", "bigsize_progressRoll include_progress"
		);
	}
}

//후속 실행 Job 상세 조회
function getSbsqntDetail() {
	var url = "<ifvm:action name='getSbsqntDetail'/>";
	var sendData = {};
	sendData.rid = gSbsqntRid;
	$.ifvPostJSON(
		url,
		sendData,
		function(_result) {
			_result.sbsqntActiveYn = _result.activeYn === "Y" ? true : false;
			$("#sbsqntForm").dataSetting(_result, null, false, []);
			changeExecDisplay();
			makeTargetJobGrid();
			$("#targetJobDiv").removeAttr("hidden");
		}, null, "#sbsqntPopup", "bigsize_progressRoll include_progress"
	);
}

//타겟 Job 그리드 생성
function makeTargetJobGrid() {
    var targetJobGridOption = {
       	url: "<ifvm:action name='getTargetJobList'/>",
   		serializeGridData: function(_data) {
   			_data.ridSbsqnt = gSbsqntRid;
   			return _data;
        },
       	onSelectCell: function(_data) {
       		gTargetJobRid = _data.rid;
       	},
   	    colNames: [
   			"Job",
   			"활성 여부",
   			"실행 지연시간(초)",
   	        "rid"
           ],
   	    colModel: [
   			{
   				name: "jobNm",
   				index: "ljm.job_nm",
   				width: "181",
   				align: "left",
				sortable: false,
				resizable: false
   			},
   			{
   				name: "activeYn",
   				index: "ljst.active_yn",
   				width: "181",
   				align: "center",
				sortable: false,
				resizable: false
   			},
   			{
   				name: "execDelayTime",
   				index: "ljst.exec_delay_time",
   				width: "181",
   				align: "right",
				sortable: false,
				resizable: false
   			},
   			{
   				name: "rid",
   				index: "ljst.rid",
   				hidden: true
   			}
   	    ],
   	    sortname: "ljst.active_yn",
   	    sortorder: "desc",
   	    multiselect: true,
   	    rowList: [10], 
   	    tempId: "ifvGridTemplete"
   	};
	targetJobGrid = setIfvGrid("targetJobGridCon", targetJobGridOption);
}

//타겟 Job 신규 팝업 호출
function addTargetJob() {
	$("#targetJobDetailPopDiv").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='targetJobDetailPop'/>",
		title: "타겟 Job 등록/수정",
		width: 600,
		close: "targetJobDetailPopClose"
  });
}

//타겟 Job 상세 팝업 닫기
function targetJobDetailPopClose() {
	targetJobDetailPopDiv._destroy();
	isTargetJobNew = true;
}

//타겟 Job 수정 팝업 호출
function editTargetJob() {
	if($.fn.ifvmIsNotEmpty(targetJobGrid.getRowDatas())) {
		isTargetJobNew = false;
		addTargetJob();
	}
}

//타겟 Job 목록 삭제
function removeTargetJob() {
	var url = "<ifvm:action name='removeTargetJobList'/>";
	var checkedList = targetJobGrid.getCheckedGridData();
	if(checkedList.length > 0) {
		if(confirm("삭제하시겠습니까?")) {
			var sendData = {};
			var rids = new Array();
			for(var i = 0; i < checkedList.length; i ++) {
				rids.push(checkedList[i].rid);
			}
			sendData.rids = rids;
			$.ifvPostJSON(
				url,
				sendData,
				function() {
					var curPageNum = targetJobGrid.opt.postData.page;
					targetJobGrid.requestData({"page": curPageNum});
					alert("삭제되었습니다.");
				}, null, "#targetJobGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}
</script>