<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>
<script type="text/x-jsrender" id="logDtlFormatter">
	<button class="btn btn-sm" onclick="showLogDtlPop();">
		<i class="fa fa-eye"></i>보기
	</button>
</script>


<!-- 조회결과 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>조회결과</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="신규" id="saveJobStepCommandBtn" btnFunc="saveJobStepCommandFn" objCode="jobStepCommandTabAdd_OBJ"/>
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="수정" id="editJobStepCommandBtn" btnFunc="editJobStepCommandFn" objCode="jobStepCommandTabEdit_OBJ" />
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="삭제" id="removeJobStepCommandBtn" btnFunc="removeJobStepCommandFn" objCode="jobStepCommandTabDel_OBJ" />
		</div>
	</div>

	<div id="jobStepCommandGridCon" class="white_bg grid_bd0"></div>
</div>

<div id="jobStepCommandPop" class="popup_container content_container"></div>


<script>
//지역변수
var jobStepCommandGrid = null;
//전역변수
var gExecParam = "";
var gLogRid = "";

var gCommandRid ="";
var isJobStepCommandNew = true;
makeJobStepCommandGrid();



//로그 그리드 생성
function makeJobStepCommandGrid() {
    var ejGridOption = {
   		dataUrl: "<ifvm:action name='getJobStepCommandList'/>",
		serializeGridData: function(data) {
			data = getSearchCond(data);
			data.ridStep = gStepRid;
			return data;
       	},
       	rowSelected: function(args) {
       		gCommandRid =  args.data.rid;
       	},
       	columns :[
       	 {
	   		  field : 'itemTypeNm', headerText : '아이템유형', headerTextAlign : 'center', width: "80px",
	   		  customAttributes : {
	   			  index : 'c1.mark_name' } //
	   	  }, {
			  field : 'command', headerText : '명령어', headerTextAlign : 'center', width: "120px",
			  customAttributes : {
				  index : 'bjsc.command' } //
		  }, {
			  field : 'commandParamTypeNm', headerText : '명령어 param 유형', headerTextAlign : 'center', width: "80px",textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 'c2.mark_name' } //
		  },  {
			  field : 'commandParam', headerText : '명령어 param', headerTextAlign : 'center', width: "120px",
			  customAttributes : {
				  index : 'bjsc.command_param' } //
		  },{
			  field : 'workingDirectory', headerText : '명령어 실행 경로', headerTextAlign : 'center', width: "120px",
			  customAttributes : {
				  index : 'bjsc.working_directory' } //
		  },

		  {
			  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', width: "80px",
			  customAttributes : {
				  index : 'emp.name' } //
		  }, {
			  field : 'modifyDate', headerText : '수정 일시', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",
			  customAttributes : {
				  index : 'bjsc.MODIFY_DATE' } //
		  },{
    		  field : 'rid', headerText : 'rid', visible : false ,
    		  customAttributes : {
    			  index : 'bjsc.rid' } //
    	  }
       	],
       	loadComplete: function () {
            gCommandRid = "";
            isJobStepCommandNew = true;
            curTabPage = "";
        },
       	requestGridData : {
         	  rows : 10,
         	  sidx : 'bjsc.modify_date',
         	  sord : 'desc',
         	  _search : false
        },
        radio: true,
        rowList : [10,25,50,100],
	    //tempId: "ifvGridTemplete"
	};
    jobStepCommandGrid = $("#jobStepCommandGridCon").ifvsfGrid({ejGridOption: ejGridOption});
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
	jobStepCommandGrid.requestData(data);
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
function saveJobStepCommandFn() {
	$("#jobStepCommandPop").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='jobStepCommandDetailPop'/>",
		title: "job stepCommand",
		width: 600,
		close: "jobStepCommandPopClose"
  });
}

// 팝업 닫기
function jobStepCommandPopClose() {
	jobStepCommandPop._destroy();
}


function editJobStepCommandFn(){
	if($.fn.ifvmIsNotEmpty(jobStepCommandGrid.opt.gridControl.getSelectedRecords()[0])) {
		isJobStepCommandNew = false;
		saveJobStepCommandFn();
	}else{
		alert("데이터를 선택해 주세요.");
	}

}

function removeJobStepCommandFn(){
	var url = "<ifvm:action name='removeJobStepCommand'/>";
	var checkedList = jobStepCommandGrid.opt.gridControl.getSelectedRecords();
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
					makeJobStepCommandGrid();
					gCommandRid = "";
					isJobStepNew = true;
					alert("삭제되었습니다.");
				}, null, "#jobGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}






</script>