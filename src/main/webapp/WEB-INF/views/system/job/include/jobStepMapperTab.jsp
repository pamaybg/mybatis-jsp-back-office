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
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="신규" id="saveJobStepMapperBtn" btnFunc="saveJobStepMapperFn"  objCode="jobStepMapperTabAdd_OBJ"/>
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="수정" id="editJobStepMapperBtn" btnFunc="editJobStepMapperFn" objCode="jobStepMapperTabEdit_OBJ" />
			<ifvm:inputNew type="button" btnType="save" nuc="true" text="삭제" id="removeJobStepMapperBtn" btnFunc="removeJobStepMapperFn" objCode="jobStepMapperTabDel_OBJ"/>
		</div>
	</div>

	<div id="jobStepMapperGridCon" class="white_bg grid_bd0"></div>
</div>

<div id="jobStepMapperPop" class="popup_container content_container"></div>


<script>
//지역변수
var jobStepMapperGrid = null;
//전역변수
var gExecParam = "";
var gLogRid = "";

var gMapperRid ="";
var isJobStepMapperNew = true;
makeJobStepMapperGrid();



//로그 그리드 생성
function makeJobStepMapperGrid() {
    var ejGridOption = {
   		dataUrl: "<ifvm:action name='getJobStepMapperList'/>",
		serializeGridData: function(data) {
			data = getSearchCond(data);
			data.ridStep = gStepRid;
			return data;
       	},
       	rowSelected: function(args) {
       		gMapperRid =  args.data.rid;
       	},
       	columns :[
       	 {
	   		  field : 'mapperDesc', headerText : '메퍼 설명', headerTextAlign : 'center', width: "100px",
	   		  customAttributes : {
	   			  index : 'bjsm.mapper_desc' } //
	   	  }, {
			  field : 'mapperId', headerText : '매퍼 ID', headerTextAlign : 'center', width: "120px",
			  customAttributes : {
				  index : 'bjsm.mapper_id' } //
		  }, {
			  field : 'itemType', headerText : '아이템유형', headerTextAlign : 'center', width: "80px",textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 'bjsm.item_type' } //
		  },  {
			  field : 'mapperParam', headerText : '매퍼param', headerTextAlign : 'center', width: "80px",
			  customAttributes : {
				  index : 'bjsm.mapper_param' } //
		  },{
			  field : 'condExtrApplyYn', headerText : '추출조건적용유무', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",
			  customAttributes : {
				  index : 'bjsm.cond_extr_apply_yn' } //
		  },

		  {
			  field : 'condExtrBaseDt', headerText : '추출조건기준일', headerTextAlign : 'center',textAlign : ej.TextAlign.Right, width: "80px",
			  customAttributes : {
				  index : 'bjsm.cond_extr_base_dt' } //
		  },

		  {
			  field : 'condExtrTerm', headerText : '추출조건기간', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, width: "80px",
			  customAttributes : {
				  index : 'bjsm.cond_extr_term' } //
		  },
		  {
			  field : 'condExtrStartdt', headerText : '추출조건시작일', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",  formatter:'date', formatoptions:{newformat:"Y-m-d"},
			  customAttributes : {
				  index : 'bjsm.cond_extr_startdt' } //
		  },
		  {
			  field : 'condExtrEnddt', headerText : '추출조건종료일', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",  formatter:'date', formatoptions:{newformat:"Y-m-d"},
			  customAttributes : {
				  index : 'bjsm.cond_extr_enddt' } //
		  },
		  {
			  field : 'condExtrStartdtBefore', headerText : '최근추출조건시작일', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",  formatter:'date', formatoptions:{newformat:"Y-m-d"},
			  customAttributes : {
				  index : 'bjsm.cond_extr_startdt_before' } //
		  },
		  {
			  field : 'condExtrEnddtBefore', headerText : '최근추출조건종료일', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",  formatter:'date', formatoptions:{newformat:"Y-m-d"},
			  customAttributes : {
				  index : 'bjsm.cond_extr_enddt_before' } //
		  },


		  {
			  field : 'condExtrUnit', headerText : '조건단위', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",
			  customAttributes : {
				  index : 'bjsm.cond_extr_unit' } //
		  },


		  {
			  field : 'modifyBy', headerText : '수정자', headerTextAlign : 'center', width: "80px",
			  customAttributes : {
				  index : 'emp.name' } //
		  }, {
			  field : 'modifyDate', headerText : '수정 일시', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: "80px",
			  customAttributes : {
				  index : 'bjsm.MODIFY_DATE' } //
		  },{
    		  field : 'rid', headerText : 'rid', visible : false ,
    		  customAttributes : {
    			  index : 'bjsm.rid' } //
    	  }
       	],
       	loadComplete: function () {
            gMapperRid = "";
            isJobStepMapperNew = true;
            curTabPage = "";
        },
       	requestGridData : {
         	  rows : 10,
         	  sidx : 'bjsm.modify_date',
         	  sord : 'desc',
         	  _search : false
        },
        radio: true,
        rowList : [10,25,50,100],
	    //tempId: "ifvGridTemplete"
	};
    jobStepMapperGrid = $("#jobStepMapperGridCon").ifvsfGrid({ejGridOption: ejGridOption});
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
	jobStepMapperGrid.requestData(data);
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
function saveJobStepMapperFn() {
	$("#jobStepMapperPop").ifvsfPopup({
		enableModal: true,
		enableResize: false,
		contentUrl: "<ifvm:url name='jobStepMapperDetailPop'/>",
		title: "job stepMapper",
		width: 600,
		close: "jobStepMapperPopClose"
  });
}

// 팝업 닫기
function jobStepMapperPopClose() {
	jobStepMapperPop._destroy();
}


function editJobStepMapperFn(){
	if($.fn.ifvmIsNotEmpty(jobStepMapperGrid.opt.gridControl.getSelectedRecords()[0])) {
		isJobStepMapperNew = false;
		saveJobStepMapperFn();
	}else{
		alert("데이터를 선택해 주세요.");
	}

}

function removeJobStepMapperFn(){
	var url = "<ifvm:action name='removeJobStepMapper'/>";
	var checkedList = jobStepMapperGrid.opt.gridControl.getSelectedRecords();
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
					makeJobStepMapperGrid();
					gMapperRid = "";
					isJobStepNew = true;
					alert("삭제되었습니다.");
				}, null, "#jobGridCon", "bigsize_progressRoll include_progress"
			);
		}
	}
}






</script>