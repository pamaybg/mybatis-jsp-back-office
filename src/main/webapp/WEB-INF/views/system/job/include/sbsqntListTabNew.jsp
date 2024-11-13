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
    var ejGridOption = {
    	dataUrl: "<ifvm:action name='getSbsqntList'/>",
		serializeGridData: function(_data) {
			_data.ridJobMst = gJobRid;
			return _data;
       	},
       	rowSelected: function(args) {
       		gSbsqntRid = args.data.rid;
       	},
        columns:[
          {
      		  field : 'sbsqntJobNm', headerText : '후속 실행 Job 명', headerTextAlign : 'left', 
      		  customAttributes : {
      			  sortable: false,
      			  index : 'ljs.sbsqnt_job_nm' } //
      	  },{
    		  field : 'activeYn', headerText : '활성 여부', headerTextAlign : 'center',
    		  customAttributes : {
    			  sortable: false,
    			  index : 'ljs.active_yn' } //
    	  },{
    		  field : 'execCondCd', headerText : '조건 유형', headerTextAlign : 'center',
    		  customAttributes : {
    			  sortable: false,
    			  index : 'cc1.mark_name' } //
    	  },{
    		  field : 'condVal', headerText : '조건 값', headerTextAlign : 'center',
    		  customAttributes : {
    			  sortable: false,
    			  index : 'cc2.mark_name' } //
    	  },{
    		  field : 'rid', headerText : 'rid', visible : false,
    		  customAttributes : {
    			  index : 'ljs.rid' } //
    	  },
        ],
        requestGridData : {
        	  nd   : new Date().getTime(),
        	  rows : 10,
        	  sidx : 'ljs.active_yn',
        	  sord : 'desc',
        	  _search : false
          },
        rowList : [10,25,50,100],
        radio: true,
	    tempId: "ifvGridTemplete"
	};
    sbsqntGrid = $("#sbsqntGridCon").ifvsfGrid({ejGridOption: ejGridOption});
}

//후속 실행 Job 목록 조회
function searchSbsqntList() {
	sbsqntGrid.searchGrid();
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
	if($.fn.ifvmIsNotEmpty(sbsqntGrid.opt.gridControl.getSelectedRecords())) {
		isSbsqntNew = false;
		addSbsqnt();
	}
}

//후속 실행 Job 목록 삭제
function removeSbsqnt() {
	var url = "<ifvm:action name='removeSbsqntList'/>";
	var checkedList = sbsqntGrid.opt.gridControl.getSelectedRecords();
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