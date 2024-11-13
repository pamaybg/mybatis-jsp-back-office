<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/x-jsrender" id="execParamFormatter">
		<button class="btn btn-sm" onclick="showExecParamPop();">
			<i class="fa fa-eye"></i>보기
		</button>
</script>
<script type="text/x-jsrender" id="execStatFormatter">
	{{if resultCd == "R"}}
		<span style="color:#FFA500;">●</span>
	{{/if}}
	{{if resultCd == "COMPLETED"}}
		<span style="color:#0000FF;">●</span>
	{{/if}}
	{{if resultCd == "FAILED"}}
		<span style="color:#FF0000;">●</span>
	{{/if}}
</script>
<div class="page-title">
	<h1>
		<spring:message code="멤버십 배치 관리"/> &gt; <spring:message code="L00030"/>
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" onclick="jobListApp.fnSearch();" objCode="jobListNewSearch_OBJ"><i class="fa fa-search"></i>
				<spring:message code="M00135" />
			</button>
			<button class="btn btn-sm" onclick="jobListApp.fnSearchInit('jobGrid');" objCode="jobListNewInit_OBJ">
				<spring:message code="M00278" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="jobSearchList">
	</div>
</div>
<div>
	<div class="page_btn_area" >
		<div class="col-xs-7">
			<span><spring:message code="M00277" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
				<ifvm:inputNew
						type="button"
						text="수동 실행"
						nuc="true"
						btnFunc="executeJob" objCode="jobListNewExcuteJob_OBJ"/>
				<ifvm:inputNew
						type="button"
						text="신규"
						nuc="true"
						btnFunc="addJob" objCode="jobListNewAddJob_OBJ" />
				<ifvm:inputNew
						type="button"
						text="수정"
						nuc="true"
						btnFunc="editJob" objCode="jobListNewEeditJob_OBJ" />
				<ifvm:inputNew
						type="button"
						text="삭제"
						nuc="true"
						btnFunc="removeJob" objCode="jobListNewRemoveJob_OBJ" />
		</div>
	</div>
	<div id="jobGridCon" class="grid_bd0"></div>
</div>

<div id="jobDetailTabArea"></div>
<div id="jobStepTabArea"></div>

<div id="jobDetailPopDiv" class="popup_container"></div>
<div id="batchExecutePopDiv" class="popup_container"></div>
<div id="execParamListPopDiv" class="popup_container"></div>

<script>

//지역변수
var jobGrid = null;
//전역변수
var gJobRid = "";
var gJobCd = "";
var gJobNm = "";
var gJobGrp = "";
var gLogTblNm = "";
var isJobNew = true;
//탭 구분
var curTabPage = "";
const CONST_LOG = "1";
const CONST_TRG = "2";
const CONST_ALR = "3";
const CONST_SBS = "4";

	/* window.onerror = function(message, url, line) {
	    console.log(message);
	}

	try {
        throw new Error("AAAA");

    }catch(msg){
	} */




getCommCodeList();

$.ifvEnterSetting(["#jobNm"], searchJobList);
$("#jobGrp").change(searchJobList);
$("#lstExecStat").change(searchJobList);

//공통코드 조회
function getCommCodeList() {
	$.ifvGetCommCodeList("select", "jobGrp", "<ifvm:action name='getCommCodeList'/>", "JOB_GRP_CD", "neims", true, true);
	$.ifvGetCommCodeList("select", "lstExecStat", "<ifvm:action name='getCommCodeList'/>", "JOB_STAT_CD", "neims", true, true);
}


//실행인수 포맷팅
function execParamFormatter() {
	var htmlStr = "";
	htmlStr += "<button class=\"btn btn-sm\" onclick=\"showExecParamPop()\">";
	htmlStr += "<i class=\"fa fa-eye\"></i>보기";
	htmlStr += "</button>";
	return htmlStr;
}

//날짜 포맷팅
function dateFormatter(data) {
	if(data === null)
		return "";
	return new Date(data).format("yyyy-mm-dd HH:MM:ss");
}

//실행결과 포맷팅
function execStatFormatter(_data) {
	var htmlStr = "";
	switch(_data) {
		case "R": htmlStr += "<span style=\"color:#FFA500;\">●</span>"; break;
		case "COMPLETED": htmlStr += "<span style=\"color:#0000FF;\">●</span>"; break;
		case "FAILED": htmlStr += "<span style=\"color:#FF0000;\">●</span>"; break;
		default: break;
	}
	return htmlStr;
}

//Job 검색 조건 초기화
function initSearchCond() {
	$("#jobSearchForm").ifvFormClean([]);
	$("#jobGrp").val("NA");
	$("#lstExecStat").val("NA");
	searchJobList();
}

//Job 목록 조회
function searchJobList() {
	var sendData = $("#jobSearchForm").getSubmitData();
	jobGrid.requestData(sendData);
	$("#jobDetailTabArea").empty();
	gJobRid = "";
	gJobCd = "";
	gJobNm = "";
	gJobGrp = "";
	gLogTblNm = "";
	isJobNew = true;
	curTabPage = "";
}

//Job 수동 실행
function executeJob() {

	var checkedList = jobGrid.opt.gridControl.getSelectedRecords();
	if(checkedList.length == 1) {
 		if(confirm("실행하시겠습니까?")) {
			var sendData = {};
			sendData = checkedList[0];
			var url = "<ifvm:action name='executeJob'/>";
			$.ifvPostJSON(
				url,
				sendData,
				function() {
					jobListApp.fnSearch();
                    $("#jobDetailTabArea").empty();
					gJobRid = "";
					gJobCd = "";
					gJobNm = "";
					gJobGrp = "";
					gLogTblNm = "";
					isJobNew = true;
					curTabPage = "";
					alert("실행되었습니다.");
				},function(result){
					jobListApp.fnSearch();
					 $("#jobDetailTabArea").empty();
					alert("실패하였습니다.")

				},null, "#jobGridCon", "bigsize_progressRoll include_progress"
			);
		}
 	} else {
		alert("반드시 1 개를 체크후 실행해야 합니다.");
	}
}
function batchExecutePop(){
	$("#batchExecutePopDiv").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='batchExecutePop'/>",
		title: "수동실행",
		width: 600,
		beforeClose: "batchExecutePopClose"
    });
}

function batchExecutePopClose() {
	isJobNew = true;
}


//Job 신규 팝업 호출
function addJob() {
	$("#jobDetailPopDiv").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='jobDetailPop'/>",
		title: "Batch 등록/수정",
		width: 800,
		beforeClose: "jobDetailPopClose"
    });
}

//Job 상세 팝업 닫기
function jobDetailPopClose() {
	isJobNew = true;
}

//Job 수정 팝업 호출
function editJob() {
	if($.fn.ifvmIsNotEmpty(jobGrid.opt.gridControl.getSelectedRecords()[0])) {
		isJobNew = false;
		addJob();
	}else{
		alert("데이터를 선택해주세요.");
	}
}

//Job 목록 삭제
function removeJob() {
	var url = "<ifvm:action name='removeJobList'/>";
	var checkedList = jobGrid.opt.gridControl.getSelectedRecords();
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
					var curPageNum = jobGrid.opt.postData.page;
					jobListApp.fnSearch();
                    $("#jobDetailTabArea").empty();
					gJobRid = "";
					gJobCd = "";
					gJobNm = "";
					gJobGrp = "";
					gLogTblNm = "";
					isJobNew = true;
					curTabPage = "";
					alert("삭제되었습니다.");
				}, null, "#jobGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}

//실행인수 목록 팝업 호출
function showExecParamPop() {
	$("#execParamListPopDiv").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='execParamListPop'/>",
		title: "실행인수 정보",
		width: 600,
		beforeClose: "execParamListPopClose"
    });
}

//실행인수 목록 팝업 닫기
function execParamListPopClose() {
	jgExecParam = "";

}


var jobListApp = {
   fnSearchInit : function(gridId)  {
       $.fn.ifvmSetCommonCondList("jobSearchList","PGM_B_001",gridId);
   },
   fnSearch : function() {
       $.fn.ifvmSubmitSearchCondition("jobSearchList", this.makeJobGrid);
   },
   makeJobGrid : function () {  // Job 그리드 생성
           var ejGridOption = {
        		dataUrl: "<ifvm:action name='getJobList'/>",
       			serializeGridData : function( data ){
       		      if ($.fn.ifvmIsNotEmpty(requestitem)) {
                      data.item = requestitem;
                  }
       	      		return data
       			},
               rowSelected: function (args ){
                   	   gJobRid = args.data.rid;
                       gJobNm = args.data.jobNm;
                       gJobDesc = args.data.jobDesc;
                       jobTabApp.drawTab();
               },
               columns : [
            	   {
              		  field : 'jobNm', headerText : 'JOB 명', headerTextAlign : 'center', width: "150px", customAttributes : {searchable : true}
              	  },{
             		  field : 'jobDesc', headerText : '설명', headerTextAlign : 'center', width: "150px", customAttributes : {searchable : true}
             	  }
                  ,{
                      field : 'useYnNm', headerText : '사용유무', headerTextAlign : 'center',textAlign : 'center', width: "70px", customAttributes : {searchable : true, index : 'cc.MARK_NAME'}
                  }                    
              	  ,{
            		  field : 'execCycle', headerText : 'cron 표현식', headerTextAlign : 'center', width: "80px",textAlign : ej.TextAlign.Center,
            		  customAttributes : {
            			  sortable: false
            		 	}
            	  },{
            		  field : 'execCycleDesc', headerText : 'cron 표현식설명', headerTextAlign : 'center', width: "80px",textAlign : ej.TextAlign.Left,
            	  }
            	  ,{
            		  field : 'lastExecStartDt', headerText : '최종 실행시작일시', headerTextAlign : 'center', width: "100px",textAlign : ej.TextAlign.Center,
            	  },{
            		  field : 'lastExecEndDt', headerText : '최종 실행종료일시', headerTextAlign : 'center', width: "100px", textAlign : ej.TextAlign.Center,

            	  },{
            		  field : 'lastExecTime', headerText : '수행시간(초)', headerTextAlign : 'center', width: "70", textAlign : ej.TextAlign.Center,
            	  } ,{
            		  field : 'resultCd', headerText : '최종 실행결과', headerTextAlign : 'center', width: "80", template : "#execStatFormatter", textAlign : ej.TextAlign.Center,
            	  },{
            		  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', width: "80",
            	  },{
            		  field : 'rid', headerText : 'rid', visible : false
            	  }
               ],

               loadComplete: function () {
                   $("#jobDetailTabArea").empty();
                   gJobRid = "";
                   gJobCd = "";
                   gJobNm = "";
                   gJobGrp = "";
                   gLogTblNm = "";
                   isJobNew = true;
                   curTabPage = "";
               },

               requestGridData : {
               	  nd   : new Date().getTime(),
               	  sidx : 'lastExecEndDt',
               	  sord : 'desc',
               	  _search : false
               },
               radio: true,
               queryCellInfo : function(args){
            	   var date =args.data.lstExecDttm;
            	   var value ;
            	   if(args.column.field == "lstExecDttm"){
            		   if(date != null){
	            		   value = $.ifvFormatDate('yyyy-mm-dd hh:mi:ss', new Date(date));
	            		   $(args.cell).text(value);
            		   }
            	   }
               }

           };
           jobGrid = $("#jobGridCon").ifvsfGrid({ejGridOption: ejGridOption});
       }
};

var jobTabApp = {
    drawTab : function () {
        $("#jobDetailTabArea").empty();

        $("#jobDetailTabArea").DrawTab(
            {
                item: [
					{
                          label: 'Step',
                          href: '<ifvm:url name="jobStepTab" />'
					},
					{
                        label: 'JOB 파라미터 설정',
                        href: '<ifvm:url name="batchParameterTab" />'
					},
                    {
                        label: '실행 이력',
                        href: '<ifvm:url name="jobLogTab" />'
                    } ,
//                     {
// 						label: '알람',
// 						href: '<ifvm:url name='alrtListTab' />'
// 					},
                ]
            }
        )
    }
}
$(document).ready(function() {
    //공통 조회 조건 목록 설정
	jobListApp.fnSearchInit();
	jobListApp.fnSearch();

});

</script>