<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags"  %>

<div>
	<div class="pop_inner_wrap" >
        <div class="temp_title_bb">
          	  실행인수 정보
        </div>
    </div>

	<div class="form-horizontal" id="execParamPopup">
			<div class="row">
				<div class="col-xs-11">
					<ifvm:inputNew 
					type="select"
					id="paramTypeCd"
					dto="paramTypeCd"
					required="true"
					label="인수 유형"
					nuc="true"
					labelClass="3"
					conClass="3" />
					<ifvm:inputNew 
					type="number"
					id="paramSeq"
					dto="paramSeq"
					required="true"
					label="인수 순서"
					nuc="true"
					labelClass="3"
					conClass="3"
					maxLength="12" />
				</div>
			</div>
			<div class="row">
				<div class="col-xs-11">
					<ifvm:inputNew 
					type="text"
					id="paramNm"
					dto="paramNm"
					required="true"
					label="인수 명"
					nuc="true"
					labelClass="3"
					conClass="3"
					maxLength="50" />
					<ifvm:inputNew 
					type="text"
					id="paramVal"
					dto="paramVal"
					label="인수 값"
					nuc="true"
					labelClass="3"
					conClass="3"
					maxLength="83" />
				</div>
			</div>
	</div>
	<div class="pop_btn_area">
		<ifvm:inputNew
		type="button"
		btnType="save"
		text="저장"
		nuc="true"
		btnFunc="saveExecParam" />
		<ifvm:inputNew
		type="button"
		btnType="cancel"
		text="취소"
		nuc="true"
		btnFunc="execParamDetailPopClose" />
	</div>
</div>

<script>
//지역변수
var execParamFormVali = $("#execParamPopup").ifvValidation();
var isOldParam = gExecParamRid && !isExecParamNew;

getCommCodeList();
valueValidation("#paramNm");
$("#paramSeq").onlyNumber();

if(isOldParam) {
	getExecParamDetail();
}

//공통코드 조회
function getCommCodeList() {
	$.ifvGetCommCodeList("select", "paramTypeCd", "<ifvm:action name='getCommCodeList'/>", "PARAM_TYPE_CD", "neims", false, false);
}

//실행인수 저장
function saveExecParam() {
	if(execParamFormVali.confirm()) {
		var sendData = $("#execParamForm").getSubmitData();
		var url = !(isOldParam) ? "<ifvm:action name='addExecParam'/>" : "<ifvm:action name='editExecParam'/>";
		sendData.ridJobMst = gJobRid;
		if(isOldParam) {
			sendData.rid = gExecParamRid;
		}
		var confirmMsg = !(isOldParam) ? "저장되었습니다." : "수정되었습니다.";
		$.ifvPostJSON(
			url,
			sendData,
			function(_result) {
				var isDupError = _result.message === "PARAM_SEQ_DUP";
				if(isDupError) {
					confirmMsg = "인수 순서 중복";
				}
				if(!isDupError) {
					execParamDetailPopClose();
					if(isOldParam) {
						var curPageNum = execParamGrid.opt.postData.page;
						execParamGrid.requestData({"page": curPageNum});
					} else {
						execParamGrid.requestData();
					}
				}
				alert(confirmMsg);
			}, null, "#execParamPopup", "bigsize_progressRoll include_progress"
		);
	}
}

//실행인수 상세 조회
function getExecParamDetail() {
	var url = "<ifvm:action name='getExecParamDetail'/>";
	var sendData = {};
	sendData.rid = gExecParamRid;
	$.ifvPostJSON(
		url,
		sendData,
		function(_result) {
			$("#execParamForm").dataSetting(_result, null, false, []);
		}, null, "#execParamPopup", "bigsize_progressRoll include_progress"
	);
}
</script>