<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>
<script type="text/x-jsrender" id="logStatFormatter">
	{{if status == "R"}}
		<span style="color:#FFA500;">●</span>
	{{/if}}
	{{if status == "COMPLETED"}}
		<span style="color:#0000FF;">●</span>
	{{/if}}
	{{if status == "FAILED"}}
		<span style="color:#FF0000;">●</span>
	{{/if}}
</script>

<!-- 조회결과 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>조회결과</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
		</div>
	</div>

	<div id="jobLogGridCon" class="white_bg grid_bd0"></div>
</div>




<script>
//지역변수


var jobLogGrid = null;
//전역변수
var gExecParam = "";
var gLogRid = "";
$("#jobStepTabArea").empty();
setCalendar();
makeJobLogGrid();

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

function logStatFormatter(_data) {
	var htmlStr = "";
	switch(_data) {
		case "R": htmlStr += "<span style=\"color:#FFA500;\">●</span>"; break;
		case "COMPLETED": htmlStr += "<span style=\"color:#0000FF;\">●</span>"; break;
		case "FAILED": htmlStr += "<span style=\"color:#FF0000;\">●</span>"; break;
		default: break;
	}
	return htmlStr;
}

//로그 그리드 생성
function makeJobLogGrid() {
    var ejGridOption = {
   		dataUrl: "<ifvm:action name='getJobLogHistory'/>",
		serializeGridData: function(data) {
			data.jobNm = gJobNm;
			return data;
       	},
       	rowSelected: function(args) {
       	},
       	columns :[
       		{
	   		  field : 'createTime', headerText : '생성시간', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width: '100px',
	   		  customAttributes : {
	   			  index : 'bje.create_time' } //
	   	  }, {
			  field : 'startTime', headerText : '실행 시간', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width: '100px',
			  customAttributes : {
				  index : 'bje.start_time' } //
		  },  {
			  field : 'endTime', headerText : '종료 시간', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width: '100px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"},
			  customAttributes : {
				  index : 'bje.end_time' } //
		  }, {
			  field : 'status', headerText : '상태', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width: '60px', template : "#logStatFormatter",
			  customAttributes : {
				  index : 'bje.status' } //
		  }, {
			  field : 'exitMessage', headerText : '에러 메세지', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: '100px',
			  customAttributes : {
				  index : 'bje.exit_message' } //
		  }
       	],
       	loadComplete: function () {
        },
       	requestGridData : {
         	  rows : 10,
         	  sidx : 'bje.job_execution_id',
         	  sord : 'desc',
         	  _search : false
        },
        /* radio: true, */
        rowList : [10,25,50,100],
	    tempId: "ifvGridNoneLeftTemplete"
	};
    jobLogGrid = $("#jobLogGridCon").ifvsfGrid({ejGridOption: ejGridOption});
}

//로그 상세 포맷팅
// function logDtlFormatter() {
// 	var htmlStr = "";
// 	htmlStr += "<button class=\"btn btn-sm\" onclick=\"showLogDtlPop()\">";
// 	htmlStr += "<i class=\"fa fa-eye\"></i>보기";
// 	htmlStr += "</button>";
// 	return htmlStr;
// }

//로그 목록 조회
function searchLogList() {
	var data = {};
	data = getSearchCond(data);
	jobLogGrid.requestData(data);
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
function saveJobStepFn() {
	$("#jobLogDtlPop").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='jobLogDetailPop'/>",
		title: "jobLog 상세정보",
		width: 600,
		close: "jobLogDtlPopClose"
  });
}

//엑셀 다운로드
function downloadLogExcel() {
	var url = "<ifvm:action name='downloadLogExcel'/>";
	var data = {};
	var sendData = getSearchCond(data);
	var colArr = [];
	var columns = jobLogGrid.model.columns;
	for(var i = 0; i < columns.length ;  i++){
		colArr.push(columns[i].headerText);
	}
// 	var colArr = logGrid.jqGridOption.colNames;
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