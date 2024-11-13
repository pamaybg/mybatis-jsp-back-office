<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
	<div class="page_btn_area">
        <div class="col-xs-7">
            <span>조회결과</span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <ifvm:inputNew type="button" id="btnPlay" text="시작" nuc="true" btnFunc="startTrgr" />
            <ifvm:inputNew type="button" id="btnStop" text="정지" nuc="true" btnFunc="pauseTrgr" />
            <ifvm:inputNew type="button" btnType="plus" text="신규" nuc="true" btnFunc="addTrgr" />
            <ifvm:inputNew type="button" btnType="revise" text="수정" nuc="true" btnFunc="editTrgr" />
            <ifvm:inputNew type="button" btnType="minus" text="삭제" nuc="true" btnFunc="removeTrgr" />
            <ifvm:inputNew type="button" btnType="search" text="재조회" nuc="true" btnFunc="searchTrgrList" />
        </div>
	</div>

	<div id="trgrGridCon" class="white_bg grid_bd0"></div>

</div>
<div id="trgrDetailPopDiv" class="popup_container"></div>

<script>
//지역변수
var trgrGrid = null;
//전역변수
var gTrgrRid = "";
var isTrgrNew = true;

curTabPage = CONST_TRG;

//아이콘 삽입(시작, 정지)
var $iPlay = $("<i>").attr("class", "fa fa-play");
$("#btnPlay").prepend($iPlay[0]);
var $iStop = $("<i>").attr("class", "fa fa-stop");
$("#btnStop").prepend($iStop[0]);

makeTrgrGrid();

//트리거 그리드 생성
function makeTrgrGrid() {
    var ejGridOption = {
   		dataUrl: "<ifvm:action name='getTrgrList'/>",
		serializeGridData: function(_data) {
			_data.ridJobMst = gJobRid;
			return _data;
       	},
       	rowSelected: function(args) {
       		gTrgrRid = args.data.rid;
       	},
       	columns : [
          {
      		  field : 'trgrNm', headerText : '트리거 명', headerTextAlign : 'center', width: "130",
      		  customAttributes : {
      			sortable: false,
      			  index : 'lit.trgr_nm' } //
      	  },{
    		  field : 'trgrStatCd', headerText : '상태', headerTextAlign : 'center', width: "130",
    		  customAttributes : {
    			  sortable: false,
    			  index : 'cc1.mark_name' } //
    	  },{
    		  field : 'startDttm', headerText : '시작일시', headerTextAlign : 'center', width: "130",
    		  customAttributes : {
    			  sortable: false,
    			  index : 'ltj.start_dttm' } //
    	  },{
    		  field : 'endDttm', headerText : '종료일시', headerTextAlign : 'center', width: "130",
    		  customAttributes : {
    			  sortable: false,
    			  index : 'ltj.end_dttm' } //
    	  },{
    		  field : 'preExecDttm', headerText : '이전 실행일시', headerTextAlign : 'center', width: "130",
    		  customAttributes : {
    			  sortable: false,
    			  index : '' } //
    	  },{
    		  field : 'nextExecDttm', headerText : '다음 실행일시', headerTextAlign : 'center', width: "130",
    		  customAttributes : {
    			  sortable: false,
    			  index : '' } //
    	  },{
    		  field : 'cronExpr', headerText : 'Cron 표현식', headerTextAlign : 'center', width: "130",
    		  customAttributes : {
    			  sortable: false,
    			  index : 'ltj.cron_expr' } //
    	  },{
    		  field : 'rid', headerText : 'rid', visible : false ,
    		  customAttributes : {
    			  index : 'ljt.rid' } //
    	  }
       	],
       	requestGridData : {
       	  nd   : new Date().getTime(),
       	  rows : 10,
       	  sidx : 'ljt.start_dttm',
       	  sord : 'desc',
       	  _search : false
      },
      radio: true,
      rowList: [10,25,50],
      tempId: "ifvGridTemplete"
	};
    trgrGrid = $("#trgrGridCon").ifvsfGrid({ejGridOption: ejGridOption});
}

//트리거 목록 조회
function searchTrgrList() {
	trgrGrid.searchGrid();
}

//트리거 신규 팝업 호출
function addTrgr() {
	$("#trgrDetailPopDiv").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='trgrDetailPop'/>",
		title: "트리거 등록/수정",
		width: 600,
		close: "trgrDetailPopClose"
  });
}

//트리거 상세 팝업 닫기
function trgrDetailPopClose() {
	trgrDetailPopDiv._destroy();
	isTrgrNew = true;
}

//트리거 수정 팝업 호출
function editTrgr() {
	if($.fn.ifvmIsNotEmpty(trgrGrid.opt.gridControl.getSelectedRecords())) {
		isTrgrNew = false;
		addTrgr();
	}
}

//트리거 목록 삭제
function removeTrgr() {
	var url = "<ifvm:action name='removeTrgrList'/>";
	var checkedList = trgrGrid.opt.gridControl.getSelectedRecords();
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
					var curPageNum = trgrGrid.opt.postData.page;
					trgrGrid.searchGrid({"page": curPageNum});
					alert("삭제되었습니다.");
				}, null, "#trgrGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}

//트리거 시작
function startTrgr() {
	startPauseTrgr("NORMAL");
}

//트리거 정지
function pauseTrgr() {
	startPauseTrgr("PAUSED");
}

//트리거 상태 변경
function startPauseTrgr(statCd) {
	var url = "<ifvm:action name='startPauseTrgr'/>";
	var checkedList = trgrGrid.opt.gridControl.getSelectedRecords();
	var isNormal = statCd === "NORMAL";
	var confirmMsg = isNormal ? "시작하시겠습니까?" : "정지하시겠습니까?";
	var resultMsg = isNormal ? "시작되었습니다." : "정지되었습니다.";
	if(checkedList.length == 1) {
		if(confirm(confirmMsg)) {
			var sendData = {};
			sendData.rid = checkedList[0].rid;
			sendData.statCd = isNormal ? "NORMAL" : "PAUSED";
			$.ifvPostJSON(
				url,
				sendData,
				function(_result) {
					if(_result.message === "NORMAL") {
						resultMsg = "이미 시작 상태입니다.";
					} else if(_result.message === "PAUSED") {
						resultMsg = "이미 정지 상태입니다.";
					}
					var curPageNum = trgrGrid.opt.postData.page;
					trgrGrid.searchGrid({"page": curPageNum});
					alert(resultMsg);
				}, null, "#trgrGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}
</script>