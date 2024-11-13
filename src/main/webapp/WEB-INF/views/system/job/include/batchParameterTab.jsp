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
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="신규" id="saveBatchParameterBtn" btnFunc="saveBatchParameterFn" objCode="batchParameterTabAdd_OBJ" />
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="수정" id="editBatchParameterBtn" btnFunc="editBatchParameterFn" objCode="batchParameterTabEdit_OBJ" />
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="삭제" id="removeBatchParameterBtn" btnFunc="removeBatchParameterFn" objCode="batchParameterTabRemove_OBJ" />
		</div>
	</div>
	<div id="batchParameterGridCon" class="white_bg grid_bd0"></div>
</div>

<div id="batchParameterDtlPop" class="popup_container content_container"></div>

<div id="batchParameterTabArea">
</div>

<script>
//지역변수

var batchParameterGrid = null;
//전역변수
var gExecParam = "";
var gLogRid = "";
var gParamRid ="";
var isBatchParameterNew = true;
$("#jobStepTabArea").empty();
setCalendar();
makeBatchParameterGrid();

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
function makeBatchParameterGrid() {
    var ejGridOption = {
   		dataUrl: "<ifvm:action name='getBatchParameterList'/>",
		serializeGridData: function(data) {
			data = getSearchCond(data);
			data.ridJob = gJobRid;
			return data;
       	},
       	rowSelected: function(args) {
       		gParamRid = args.data.rid;
       	},
       	columns :[
       		 {
			  field : 'paramNm', headerText : '파라미터 명', headerTextAlign : 'center' ,width: "100px",
			  customAttributes : {
				  index : 'bjp.PARAM_NM' } //
	   	  },{
	   		  field : 'paramTypeNm', headerText : '유형', headerTextAlign : 'center',width: "80px",
	   		  customAttributes : {
	   			  index : 'bjp.param_type ' } //
	   	  }, {
			  field : 'paramSubTypeNm', headerText : '상세유형', headerTextAlign : 'center' ,width: "90px",
			  customAttributes : {
				  index : 'bjp.param_sub_type' } //
		  },  {
			  field : 'paramVal', headerText : '파라미터 값', headerTextAlign : 'center' ,width: "100px",
			  customAttributes : {
				  index : 'bjp.PARAM_VAL' } //
		  }, {
			  field : 'modifyDate', headerText : '수정자', headerTextAlign : 'center', textAlign : ej.TextAlign.Center ,width: "100px",
			  customAttributes : {
				  index : 'emp.MODIFY_BY' } //
		  },{
			  field : 'modifyDate', headerText : '수정 일시', headerTextAlign : 'center', textAlign : ej.TextAlign.Center ,width: "100px",
			  customAttributes : {
				  index : ' bjp.MODIFY_DATE' } //
		  },{
    		  field : 'rid', headerText : 'rid', visible : false ,
    		  customAttributes : {
    			  index : 'bjp.rid' } //
    	  }
       	],
       	loadComplete: function () {

            gParamRid = "";
            isBatchParameterNew = true;
            curTabPage = "";
        },
       	requestGridData : {
         	  rows : 10,
         	  sidx : 'bjp.rid',
         	  sord : 'asc',
         	  _search : false
        },
        radio: true,
        rowList : [10,25,50,100],
	    tempId: "ifvGridNoneLeftTemplete"
	};
    batchParameterGrid = $("#batchParameterGridCon").ifvsfGrid({ejGridOption: ejGridOption});
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
function saveBatchParameterFn() {
	$("#batchParameterDtlPop").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='batchParameterDetailPop'/>",
		title: "Batch 파라미터 등록/수정",
		width: 600,
	 	beforeClose: "batchParameterDtlPopClose"
  });
}

//로그 상세 팝업 닫기
function batchParameterDtlPopClose() {
	isBatchParameterNew = true;
}


function removeBatchParameterFn(){
	var url = "<ifvm:action name='removeBatchParameter'/>";
	var checkedList = batchParameterGrid.opt.gridControl.getSelectedRecords();
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
					/* batchParameterGrid.requestData({"page": curPageNum}); */
					makeBatchParameterGrid();
				      $("#batchParameterTabArea").empty();
					isBatchParameterNew = true;
					curTabPage = "";
					gParamRid = "";
					alert("삭제되었습니다.");
				}, null, "#batchParameterGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}

function editBatchParameterFn(){
	if($.fn.ifvmIsNotEmpty(batchParameterGrid.opt.gridControl.getSelectedRecords()[0])) {
		isBatchParameterNew = false;
		saveBatchParameterFn();
	}else{
		alert("데이터를 선택해 주세요.");
	}


}
</script>