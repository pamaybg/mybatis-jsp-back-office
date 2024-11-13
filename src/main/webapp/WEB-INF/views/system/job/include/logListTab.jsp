<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>조회조건</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew
					type="button"
					btnType="download"
					text="엑셀 다운로드"
					nuc="true"
					btnFunc="downloadLogExcel" />
			<ifvm:inputNew
					type="button"
					btnType="search"
					text="조회"
					nuc="true"
					btnFunc="searchLogList" />
		</div>
	</div>

	<div class="form-horizontal underline top_well" id="searchFormArea" >
		<div class="row">
			<ifvm:inputNew
					type="dateTerm"
					startDto="startDate"
					endDto="endDate"
					startId="startDate"
					endId="endDate"
					label="시작 일시 기간"
					nuc="true"
					labelClass="1"
					conClass="4" />
		</div>
	</div>

</div>
<!-- 조회결과 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>조회결과</span>
		</div>
	</div>
	<div id="logGridCon" class="white_bg grid_bd0"></div>
</div>

<div id="logDtlListPopDiv" class="popup_container content_container"></div>

<script>
//지역변수
var logGrid = null;
//전역변수
var gExecParam = "";
var gLogRid = "";

setCalendar();
makeLogGrid();

//달력 셋팅
function setCalendar() {
	var startDate = $("#startDate");
	var endDate = $("#endDate");
	//오늘 날짜
	startDate.val($.ifvGetTodayDate());
	endDate.val($.ifvGetTodayDate());
	startDate.ifvDateChecker({
		maxDate : endDate
	});
	endDate.ifvDateChecker({
		minDate : startDate
	});
}

//로그 그리드 생성
function makeLogGrid() {
    var logGridOption = {
    	url: "<ifvm:action name='getJobLogList'/>",
		serializeGridData: function(data) {
			data = getSearchCond(data);
			data.ridJobMst = gJobRid;
			data.logTblNm = gLogTblNm;
			return data;
       	},
       	onSelectCell: function(data, index) {
       		if(index === 5) {
       			gExecParam = data.execParam === null ? "[]" : data.execParam;
       		}
       		if(index === 8) {
       			gLogRid = data.rid;
       		}
       	},
	    colNames: [
			"시작일시",
			"종료일시",
			"소요시간",
			"실행결과",
			"실행인수",
			"요청 메시지",
			"응답 메시지",
	        "로그상세"
        ],
	    colModel: [
			{
				name: "frDttm",
				index: "jl1.fr_dttm",
				width: "113",
				align: "center",
				formatter: dateFormatter,
				sortable: false,
				resizable: false
			},
			{
				name: "endDttm",
				index: "jl2.end_dttm",
				width: "113",
				align: "center",
				formatter: dateFormatter,
				sortable: false,
				resizable: false
			},
			{
				name: "spentTime",
				index: "",
				width: "113",
				align: "left",
				sortable: false,
				resizable: false
			},
			{
				name: "statCd",
				index: "jl2.stat_cd",
				width: "113",
				align: "center",
				formatter: execStatFormatter,
				sortable: false,
				resizable: false
			},
			{
				name: "execParam",
				index: "jl1.exec_param",
				width: "113",
				align: "center",
				formatter: execParamFormatter,
				sortable: false,
				resizable: false
			},
			{
				name: "reqRsltMsg",
				index: "jl1.rslt_msg",
				width: "113",
				align: "left",
				sortable: false,
				resizable: false
			},
			{
				name: "resRsltMsg",
				index: "jl2.rslt_msg",
				width: "113",
				align: "left",
				sortable: false,
				resizable: false
			},
			{
				name: "rid",
				index: "jl1.rid",
				width: "113",
				align: "center",
				formatter: logDtlFormatter,
				sortable: false,
				resizable: false
			}
	    ],
	    sortname: "jl1.fr_dttm",
	    sortorder: "desc",
	    multiselect: true,
	    rowList: [10], 
	    tempId: "ifvGridTemplete"
	};
    logGrid = $("#logGridCon").ifvGrid({jqGridOption: logGridOption});
}

//로그 상세 포맷팅
function logDtlFormatter() {
	var htmlStr = "";
	htmlStr += "<button class=\"btn btn-sm\" onclick=\"showLogDtlPop()\">";
	htmlStr += "<i class=\"fa fa-eye\"></i>보기";
	htmlStr += "</button>";
	return htmlStr;
}

//로그 목록 조회
function searchLogList() {
	var data = {};
	data = getSearchCond(data);
	logGrid.requestData(data);
}

//로그 조회 조건 형성
function getSearchCond(_data) {
	var sendData = $("#logForm").getSubmitData();
	_data.startDate = sendData.startDate;
	_data.endDate = sendData.endDate;
	_data.jobCd = gJobCd;
	return _data;
}

//로그 상세 팝업 호출
function showLogDtlPop() {
	$("#logDtlListPopDiv").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='logDtlListPop'/>",
		title: "로그 상세 정보",
		width: 600,
		close: "logDtlListPopClose"
  });
}

//로그 상세 팝업 닫기
function logDtlListPopClose() {
	logDtlListPopDiv._destroy();
}

//엑셀 다운로드
function downloadLogExcel() {
	var url = "<ifvm:action name='downloadLogExcel'/>";
	var data = {};
	var sendData = getSearchCond(data);
	var colArr = logGrid.jqGridOption.colNames;
	//불필요한 헤더 제거
	colArr.pop();
	var href = url
		+ "?"
		+ "startDate=" + sendData.startDate
		+ "&endDate=" + sendData.endDate
		+ "&jobCd=" + sendData.jobCd
		+ "&logTblNm=" + gLogTblNm
		+ "&headerList=" + colArr.join();
	qtjs.href(href);
}
</script>