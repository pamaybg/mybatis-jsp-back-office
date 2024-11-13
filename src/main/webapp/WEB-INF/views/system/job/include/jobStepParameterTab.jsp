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
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="신규" id="saveJobStepParamBtn" btnFunc="saveJobStepParamFn" objCode="jobStepParamTabAdd_OBJ"/>
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="수정" id="editJobStepParamBtn" btnFunc="editJobStepParamFn" objCode="jobStepParamTabEdit_OBJ" />
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="삭제" id="removeJobStepParamBtn" btnFunc="removeJobStepParamFn" objCode="jobStepParamTabDel_OBJ" />
		</div>
	</div>
	<div id="jobStepParamGridCon" class="white_bg grid_bd0"></div>
</div>



<div id="jobStepParamPop" class="popup_container content_container"></div>


<script>
//지역변수
var jobStepParamGrid = null;
//전역변수
var gLogRid = "";

var gJobStepParamRid ="";
var isJobStepParamNew = true;
makeJobStepParamGrid();



//로그 그리드 생성
function makeJobStepParamGrid() {
    var ejGridOption = {
   		dataUrl: "<ifvm:action name='getJobStepParamList'/>",
		serializeGridData: function(data) {
			data = getSearchCond(data);
			data.ridStep = gStepRid;
			return data;
       	},
       	rowSelected: function(args) {
       		gJobStepParamRid =  args.data.rid;
       	},
        showStackedHeader:true,
       	stackedHeaderRows:[
       		{
       			stackedHeaderColumns:[
       				{headerText:"매퍼", column:"maprId,maprParam", textAlign : 'center'}
					,{headerText:"명령어", column:"execCmnd,cmndParamTypeNm,cmndParam,workingDir", textAlign : 'center'}
				]
       		}
		],
       	columns :[
       	 {
	   		  field : 'itemTypeNm', headerText : '아이템유형', headerTextAlign : 'center', width: "80px",
	   		  customAttributes : {
	   			  index : 'bjsp.ITEM_TYPE' } //
	   	  }, {
			  field : 'paramDesc', headerText : '설명', headerTextAlign : 'center', width: "100px",
			  customAttributes : {
				  index : 'bjsp.PARAM_DESC' } //
		  }, {
	   		  field : 'maprId', headerText : 'ID', headerTextAlign : 'center', width: "100px",
	   		  customAttributes : {
	   			  index : 'bjsp.MAPR_ID' } //
	   	  }, {
			  field : 'maprParam', headerText : '파라미터', headerTextAlign : 'center', width: "100px",
			  customAttributes : {
				  index : 'bjsp.MAPR_PARAM ' } //
		  },{
			  field : 'execCmnd', headerText : '실행 명령어', headerTextAlign : 'center', width: "80px",textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 'bjsp.EXEC_CMND' } //
		  },  {
			  field : 'cmndParamTypeNm', headerText : '파라미터 유형', headerTextAlign : 'center', width: "80px",
			  customAttributes : {
				  index : 'bjsp.CMND_PARAM_TYPE' } //
		  },{
			  field : 'cmndParam', headerText : '파라미터', headerTextAlign : 'center', width: "100px",
			  customAttributes : {
				  index : 'bjsp.CMND_PARAM' } //
		  },  {
			  field : 'workingDir', headerText : '실행 경로', headerTextAlign : 'center', width: "100px",
			  customAttributes : {
				  index : 'bjsp.WORKING_DIR' } //
		  }, {
			  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",
			  customAttributes : {
				  index : 'emp.NAME' } //
		  }, {
			  field : 'modifyDate', headerText : '수정 일시', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",
			  customAttributes : {
				  index : 'bjsp.MODIFY_DATE' } //
		  },{
    		  field : 'rid', headerText : 'rid', visible : false ,
    		  customAttributes : {
    			  index : 'bjsp.RID' } //
    	  }
       	],
       	loadComplete: function () {
            gJobStepParamRid = "";
            isJobStepParamNew = true;
            //curTabPage = "";
        },
       	requestGridData : {
         	  rows : 10,
         	  sidx : 'bjsp.MODIFY_DATE',
         	  sord : 'desc',
         	  _search : false
        },
        radio: true,
        rowList : [10,25,50,100],
	    tempId: "ifvGridNotSearchTemplete"
	};
    jobStepParamGrid = $("#jobStepParamGridCon").ifvsfGrid({ejGridOption: ejGridOption});
}

//로그 목록 조회
function searchLogList() {
	var data = {};
	data = getSearchCond(data);
	jobStepParamGrid.requestData(data);
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
function saveJobStepParamFn() {
	$("#jobStepParamPop").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='jobStepParamDetailPop'/>",
		title: "Step 파리미터 등록/수정",
		width: 900,
	 	beforeClose: "jobStepParamDtlPopClose"
  });
}

// 팝업 닫기
function jobStepParamDtlPopClose() {
	isJobStepParamNew = true;
}


function editJobStepParamFn(){
	if($.fn.ifvmIsNotEmpty(jobStepParamGrid.opt.gridControl.getSelectedRecords()[0])) {
		isJobStepParamNew = false;
		saveJobStepParamFn();
	}else{
		alert("데이터를 선택해 주세요.");
	}

}

function removeJobStepParamFn(){
	var url = "<ifvm:action name='removeJobStepParam'/>";
	var checkedList = jobStepParamGrid.opt.gridControl.getSelectedRecords();
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
					var curPageNum = jobStepParamGrid.opt.postData.page;
					/* jobStepGrid.requestData({"page": curPageNum}); */
					makeJobStepParamGrid();
					gJobStepParamRid = "";
					isJobStepParamNew = true;
					alert("삭제되었습니다.");
				}, null, "#jobGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}






</script>