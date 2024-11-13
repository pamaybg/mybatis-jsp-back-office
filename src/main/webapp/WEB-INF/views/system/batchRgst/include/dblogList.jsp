<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>
<!-- 조회결과 -->
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span>조회결과</span>
		</div>
		<div class="col-xs-5 searchbtn_r">
		</div>
	</div>

	<div id="jobLogGridCon" class="white_bg grid_bd0"></div>
</div>


<script>
//지역변수
var jobLogGrid = null;
//전역변수
makeJobLogGrid();
//로그 그리드 생성
function makeJobLogGrid() {
    var ejGridOption = {
   		dataUrl: "<ifvm:action name='getAprLogDetail'/>",
		serializeGridData: function(data) {
			data.trNo=trNum;
			return data;
       	},
       	columns :[
       	 {
	   		  field : 'trNo', headerText : '고유번호', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	   		  customAttributes : {
	   			  index : 'las.TR_NO' , searchable : true} //
	   	  }, {
			  field : 'logType', headerText : '로그유형', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 'las.LOG_TYPE' , searchable : true} //
		  },  {
			  field : 'occuPgmType', headerText : '발생유형', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 'las.OCCU_PGM_TYPE', searchable : true } //
		  }, /*{
			  field : 'reqType', headerText : '요청유형', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 'las.REQ_TYPE' , searchable : true}, visible : false,
		  },*/{
			  field : 'pgmNm', headerText : '프로그램명', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 'las.PGM_NM' , searchable : true} //
		  }, {
			  field : 'errSrcNum', headerText : '소스번호', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
			  customAttributes : {
				  index : 'las.ERR_SRC_NUM', searchable : true } //
		  }, {
			  field : 'errMsg', headerText : '메시지', headerTextAlign : 'center',
			  customAttributes : {
				  index : 'las.ERR_MSG', searchable : true } //
		  }, {
			  field : 'errDesc', headerText : '메시지 상세', headerTextAlign : 'center', 
			  customAttributes : {
				  index : 'las.ERR_DESC' , searchable : true} //
		  }
       	],
       	requestGridData : {
         	  rows : 10,
         	  sidx : 'las.TR_NO',
         	  sord : 'desc',
         	  _search : false
        },
        rowList : [10,25,50,100],
	};
    jobLogGrid = $("#jobLogGridCon").ifvsfGrid({ejGridOption: ejGridOption});
}

</script>