<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>
<script type="text/x-jsrender" id="logStatFormatter">
	{{if status == "R"}}
		<span style="color:#FFA500;">●</span>
	{{/if}}
	{{if status == "COMPLETED"}}
		<span style="color:#0000FF;">●</span>
	{{/if}}
	{{if status == "FAILED"}}
		<span style="color:#FF0000;">●</span>
	{{/if}}
</script>


<div>
<div class="page-title">
	<h1>Batch 관리
	 <span> &gt; Batch로그 이력</span>
	</h1>
</div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>조회결과</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="search"  text="M00135"  id="makeBatchLogBtn" btnFunc="manualReqListSearch"/>
            <ifvm:inputNew type="button"   text="M00278"  id="batchSearchInitBtn" btnFunc="batchSearchInit"/>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="batchSearchList">
	</div>

	<div id="batchLogGridCon" class="white_bg grid_bd0"></div>
</div>

<script>
var batchLogGrid = null;

function logStatFormatter(_data) {
	var htmlStr = "";
	switch(_data) {
		case "R": htmlStr += "<span style=\"color:#FFA500;\">●</span>"; break;
		case "COMPLETED": htmlStr += "<span style=\"color:#0000FF;\">●</span>"; break;
		case "FAILED": htmlStr += "<span style=\"color:#FF0000;\">●</span>"; break;
		default: break;
	}
	return htmlStr;
}

//로그 그리드 생성
function makeBatchLogGrid() {
    var ejGridOption = {
   		dataUrl: "<ifvm:action name='getBatchLogList'/>",
   		serializeGridData : function( data ){

   	      if ($.fn.ifvmIsNotEmpty(requestitem)) {
              data.item = requestitem;
          }
   	      	return data;
   			},
       	rowSelected: function(args) {
       	},
       	columns :[
       		{
  	   		  field : 'jobDesc', headerText : 'Job명', headerTextAlign : 'center',   width: '100px',
  	   	  }, {
  	   		  field : 'jobNm', headerText : 'Job프로그램', headerTextAlign : 'center', width: '100px',
  	   	  }, {
			  field : 'startTime', headerText : '실행 시작 시간', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width: '100px',
		  },  {
			  field : 'endTime', headerText : '실행 종료 시간', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width: '100px', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"},
		  },  {
			  field : 'lastExecTime', headerText : '수행시간(초)', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width: '70px',
		  }, {
			  field : 'status', headerText : '상태', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,  width: '60px', template : "#logStatFormatter",
		  }, {
			  field : 'exitMessage', headerText : '에러 메세지', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, width: '100px',
		  }
       	],
       	requestGridData : {
         	  rows : 50,
         	  sidx : 'jobDesc',
         	  sord : 'desc',
         	  _search : false
        },
        rowNum: 50,
        rowList : [50,100],
	};
    batchLogGrid = $("#batchLogGridCon").ifvsfGrid({ejGridOption: ejGridOption});
}
function batchSearchInit(){
	 $.fn.ifvmSetCommonCondList("batchSearchList","PGM_B_002");
}
//공통 조회 호출
function manualReqListSearch() {
    $.fn.ifvmSubmitSearchCondition("batchSearchList", makeBatchLogGrid);
}

$(document).ready(function() {
	batchSearchInit();
	manualReqListSearch();
});
</script>