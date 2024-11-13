<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
	<div class="page_btn_area" >
		<div class="col-xs-7">
			<span>조회 결과</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="plus" text="신규" nuc="true" btnFunc="addSbsqnt" />
			<ifvm:inputNew type="button" btnType="revise" text="수정" nuc="true" btnFunc="editSbsqnt" />
			<ifvm:inputNew type="button" btnType="minus" text="삭제" nuc="true" btnFunc="removeSbsqnt" />
			<ifvm:inputNew type="button" btnType="search" text="재조회" nuc="true" btnFunc="searchSbsqntList" />
		</div>
	</div>
	</header>
	<div id="sbsqntGridCon" class="white_bg grid_bd0"></div>
</div>
<div id="sbsqntDetailPopDiv" class="popup_container"></div>

<script>
//지역변수
var sbsqntGrid = null;
//전역변수
var gSbsqntRid = "";
var isSbsqntNew = true;

curTabPage = CONST_SBS;

makeSbsqntGrid();

//후속 실행 Job 그리드 생성
function makeSbsqntGrid() {
    var sbsqntGridOption = {
    	url: "<ifvm:action name='getSbsqntList'/>",
		serializeGridData: function(_data) {
			_data.ridJobMst = gJobRid;
			return _data;
       	},
       	onSelectCell: function(_data) {
       		gSbsqntRid = _data.rid;
       	},
	    colNames: [
			"후속 실행 Job 명",
			"활성 여부",
			"조건 유형",
			"조건 값",
	        "rid"
        ],
	    colModel: [
			{
				name: "sbsqntJobNm",
				index: "ljs.sbsqnt_job_nm",
				width: "230",
				align: "left",
				sortable: false,
				resizable: false
			},
			{
				name: "activeYn",
				index: "ljs.active_yn",
				width: "230",
				align: "center",
				sortable: false,
				resizable: false
			},
			{
				name: "execCondCd",
				index: "cc1.mark_name",
				width: "230",
				align: "center",
				sortable: false,
				resizable: false
			},
			{
				name: "condVal",
				index: "cc2.mark_name",
				width: "230",
				align: "center",
				sortable: false,
				resizable: false
			},
			{
				name: "rid",
				index: "ljs.rid",
				hidden: true
			}
	    ],
	    sortname: "ljs.active_yn",
	    sortorder: "desc",
	    multiselect: true,
	    rowList: [10],
	    tempId: "ifvGridTemplete"
	};
    sbsqntGrid = $("#sbsqntGridCon").ifvGrid({jqGridOption: sbsqntGridOption});
}

//후속 실행 Job 목록 조회
function searchSbsqntList() {
	sbsqntGrid.requestData();
}

//후속 실행 Job 신규 팝업 호출
function addSbsqnt() {
	$("#sbsqntDetailPopDiv").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='sbsqntDetailPop'/>",
		title: "후속 실행 Job 등록/수정",
		width: 600,
		close: "sbsqntDetailPopClose"
  });
}

//후속 실행 Job 상세 팝업 닫기
function sbsqntDetailPopClose() {
	sbsqntDetailPopDiv._destroy();
	isSbsqntNew = true;
}

//후속 실행 Job 수정 팝업 호출
function editSbsqnt() {
	if($.fn.ifvmIsNotEmpty(sbsqntGrid.getRowDatas())) {
		isSbsqntNew = false;
		addSbsqnt();
	}
}

//후속 실행 Job 목록 삭제
function removeSbsqnt() {
	var url = "<ifvm:action name='removeSbsqntList'/>";
	var checkedList = sbsqntGrid.getCheckedGridData();
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
					var curPageNum = sbsqntGrid.opt.postData.page;
					sbsqntGrid.requestData({"page": curPageNum});
					alert("삭제되었습니다.");
				}, null, "#sbsqntGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}
</script>