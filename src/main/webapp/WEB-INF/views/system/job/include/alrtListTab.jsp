<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<div>
	<div class="page_btn_area" >
		<div class="col-xs-7">
			<span>조회 결과</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="plus" text="신규" nuc="true" btnFunc="addAlrt" />
			<ifvm:inputNew type="button" btnType="revise" text="수정" nuc="true" btnFunc="editAlrt" />
			<ifvm:inputNew type="button" btnType="minus" text="삭제" nuc="true" btnFunc="removeAlrt" />
			<ifvm:inputNew type="button" btnType="search" text="재조회" nuc="true" btnFunc="searchAlrtList" />
		</div>
	</div>
	<div id="alrtGridCon" class="white_bg grid_bd0"></div>
</div>
<div id="alrtDetailPopDiv" class="popup_container"></div>

<script>
//지역변수
var alrtGrid = null;
//전역변수
var gAlrtRid = "";
var isAlrtNew = true;
curTabPage = CONST_ALR;
makeAlrtGrid();
//알람 그리드 생성
function makeAlrtGrid() {
    var alrtGridOption = {
    	url: "<ifvm:action name='getAlrtList'/>",
		serializeGridData: function(_data) {
			_data.ridJobMst = gJobRid;
			return _data;
       	},
       	onSelectCell: function(_data) {
       		gAlrtRid = _data.rid;
       	},
	    colNames: [
			"알람 명",
			"활성 여부",
			"조건 유형",
			"조건 값",
			"채널 유형",
			"수신자",
	        "rid"
        ],
	    colModel: [
			{
				name: "alrtNm",
				index: "lja.alrt_nm",
				width: "130",
				align: "left",
				sortable: false,
				resizable: false
			},
			{
				name: "activeYn",
				index: "lja.activeYn",
				width: "130",
				align: "center",
				sortable: false,
				resizable: false
			},
			{
				name: "alrtCondCd",
				index: "cc1.mark_name",
				width: "130",
				align: "center",
				sortable: false,
				resizable: false
			},
			{
				name: "condVal",
				index: "cc2.mark_name",
				width: "130",
				align: "center",
				sortable: false,
				resizable: false
			},
			{
				name: "trsChnlcd",
				index: "cc3.mark_name",
				width: "130",
				align: "center",
				sortable: false,
				resizable: false
			},
			{
				name: "rcvr",
				index: "lja.rcvr",
				width: "130",
				align: "left",
				sortable: false,
				resizable: false
			},
			{
				name: "rid",
				index: "lja.rid",
				hidden: true
			}
	    ],
	    sortname: "lja.active_yn desc, lja.create_date",
	    sortorder: "desc",
	    multiselect: true,
	    rowList: [10],
	    tempId: "ifvGridTemplete"
	};
    alrtGrid = $("#alrtGridCon").ifvGrid({jqGridOption :  alrtGridOption});
}

//알람 목록 조회
function searchAlrtList() {
	alrtGrid.requestData();
}

//알람 신규 팝업 호출
function addAlrt() {
	$("#alrtDetailPopDiv").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='alrtDetailPop'/>",
		title: "알람 등록/수정",
		width: 600,
		close: "alrtDetailPopClose"
  });
}

//알람 상세 팝업 닫기
function alrtDetailPopClose() {
	alrtDetailPopDiv._destroy();
	isAlrtNew = true;
}

//알람 수정 팝업 호출
function editAlrt() {
	if($.fn.ifvmIsNotEmpty(alrtGrid.getRowDatas())) {
		isAlrtNew = false;
		addAlrt();
	}
}

//알람 목록 삭제
function removeAlrt() {
	var url = "<ifvm:action name='removeAlrtList'/>";
	var checkedList = alrtGrid.getCheckedGridData();
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
					var curPageNum = alrtGrid.opt.postData.page;
					alrtGrid.requestData({"page": curPageNum});
					alert("삭제되었습니다.");
				}, null, "#alrtGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}
</script>