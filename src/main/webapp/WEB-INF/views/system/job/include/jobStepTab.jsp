<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>
<script type="text/x-jsrender" id="logDtlFormatter">
	<button class="btn btn-sm" onclick="showLogDtlPop();">
		<i class="fa fa-eye"></i>보기
	</button>
</script>

<style>
#jobStepTabArea .tab-list {width: 500px !important;}
</style>

<!-- 조회결과 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>조회결과</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="신규" id="saveJobStepBtn" btnFunc="saveJobStepFn" objCode="jobStepTabAdd_OBJ" />
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="수정" id="editJobStepBtn" btnFunc="editJobStepFn" objCode="jobStepTabEdit_OBJ" />
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="삭제" id="removeJobStepBtn" btnFunc="removeJobStepFn" objCode="jobStepTabRemove_OBJ" />
		</div>
	</div>
	<div id="jobStepGridCon" class="white_bg grid_bd0"></div>
</div>

<div id="jobStepDtlPop" class="popup_container content_container"></div>



<script>
var jobStepTabApp = {
	    drawTab : function () {
	        $("#jobStepTabArea").empty();

	        $("#jobStepTabArea").DrawTab(
	            {
	                item: [
	/*
	                    {
	                        label: '트리거',
	                        href: '<ifvm:url name='trgrListTab' />'
	                    },
	                    {
	                        label: '알람',
	                        href: '<ifvm:url name='alrtListTab' />'
	                    },
	                    {
	                        label: '후속실행',
	                        href: '<ifvm:url name='sbsqntListTab' />'
	                    } */

	                	/*     {
	                           label: 'MAPPER',
	                           href: '<ifvm:url name="jobStepMapperTab" />'
	                       },
	                	   {
	                           label: 'COMMAND',
	                           href: '<ifvm:url name="jobStepCommandTab" />'
	                       }, */
	                       {
	                           label: 'Step 파라미터 설정',
	                           href: '<ifvm:url name="jobStepParameterTab" />'
	                       }
	                ]
	            }
	        )
	    }
	}

//지역변수
var jobStepGrid = null;
//전역변수
var gLogRid = "";
var gStepRid ="";
var isJobStepNew = true;
setCalendar();
makeJobStepGrid();
jobStepTabApp.drawTab();
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
function makeJobStepGrid() {
    var ejGridOption = {
   		dataUrl: "<ifvm:action name='getJobStepList'/>",
		serializeGridData: function(data) {
			data = getSearchCond(data);
			data.ridJob = gJobRid;
			return data;
       	},
       	rowSelected: function(args) {
       		gStepRid = args.data.rid;
       		jobStepTabApp.drawTab();
       		
       	},
       	columns :[
       		{
  	   		  field : 'stepSeq', headerText : '순서', headerTextAlign : 'center', width: "50px", textAlign : ej.TextAlign.Right ,
  	   		  customAttributes : {
  	   			  index : 'bjs.step_seq' } //
  	   	  }, {
			  field : 'stepNm', headerText : 'Step 명', headerTextAlign : 'center' ,width: "100px",
			  customAttributes : {
				  index : 'bjs.STEP_NM' } //
	   	  },{
	   		  field : 'stepDesc', headerText : '설명', headerTextAlign : 'center',width: "100px",
	   		  customAttributes : {
	   			  index : 'bjs.STEP_DESC' } //
	   	  }, {
			  field : 'stepTypeNm', headerText : '유형', headerTextAlign : 'center' ,width: "100px",
			  customAttributes : {
				  index : 'bjs.step_type' } //
		  },  {
			  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center' ,width: "80px",
			  customAttributes : {
				  index : 'emp.name' } //
		  }, {
			  field : 'modifyDate', headerText : '수정 일시', headerTextAlign : 'center', textAlign : ej.TextAlign.Center ,width: "100px",
			  customAttributes : {
				  index : 'bjs.MODIFY_DATE' } //
		  },{
    		  field : 'rid', headerText : 'rid', visible : false ,
    		  customAttributes : {
    			  index : 'bjs.rid' } //
    	  }
       	],
       	loadComplete: function () {
            /* $("#jobStepTabArea").empty(); */
            
            gStepRid = "";
            isJobStepNew = true;
            curTabPage = "";
        },
       	requestGridData : {
         	  rows : 10,
         	  sidx : 'bjs.step_seq',
         	  sord : 'asc',
         	  _search : false
        },
        radio: true,
        rowList : [10,25,50,100],
	    tempId: "ifvGridNoneLeftTemplete"
	};
    jobStepGrid = $("#jobStepGridCon").ifvsfGrid({ejGridOption: ejGridOption});
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
	jobStepGrid.requestData(data);
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
	$("#jobStepDtlPop").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='jobStepDetailPop'/>",
		title: "Step 등록/수정",
		width: 600,
		beforeClose: "jobStepDtlPopClose"
  });
}

 //로그 상세 팝업 닫기
function jobStepDtlPopClose() {
	isJobStepNew = true;
}




function removeJobStepFn(){
	var url = "<ifvm:action name='removeJobStep'/>";
	var checkedList = jobStepGrid.opt.gridControl.getSelectedRecords();
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
					/* jobStepGrid.requestData({"page": curPageNum}); */
					makeJobStepGrid();
                      /* $("#jobStepTabArea").empty(); */
					curTabPage = "";
					gStepRid = "";
					alert("삭제되었습니다.");
				}, null, "#jobStepGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}

function editJobStepFn(){
	if($.fn.ifvmIsNotEmpty(jobStepGrid.opt.gridControl.getSelectedRecords()[0])) {
		isJobStepNew = false;
		saveJobStepFn();
	}else{
		alert("데이터를 선택해 주세요.");
	}


}

</script>