<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!-- 2018.07.01 김민준   -->
<!-- ejgrid 확장         -->

<script type="text/javascript">
var tableListGrid;
var gridIdtableListGrid;
var fileUploadList;
var tableNm;
var tableId;
var tmpId;
var startDt;
var endDt;
var excelResultId;
var errorId;

// 업로드일시 변수처리
function calDt(){
	startDt = $("#uploadStartDate").val();
	endDt = $("#uploadEndDate").val();
}
// 파일업로드 팝업닫기
function fileUpPopClose(){
	$('#dialog').ejDialog('destroy');
}

// 파일업로드 오류팝업 닫기
function upErrorPopClose(){
	$('#dialogErrorPop').ejDialog('destroy');
}

// 달력
function setFileUpCalendar() {
    var startDate = $(".start_date").find('input'); 
	var endDate = $(".end_date").find('input');
	startDate.val(startDt);
	endDate.val(endDt);
	
	startDate.ifvDateChecker({
		maxDate : endDate
	});
	endDate.ifvDateChecker({
		minDate : startDate
	});
}

// 어카운트명 조회
function getAccountNm(){
	$.ifvSyncPostJSON('<ifvm:action name="getAccountNm"/>',{
	},function(result) {
		var temp = $("#selectAccount").tmpl(result.rows);
		$("#accountNm").append(temp);
		$("#accountNm").attr("disabled",true);
	});
};

// 테이블 목록
function getTableListGrid() {
	var data = [
	            {id:"TMP_O_CUST",tableNm:'<spring:message code="M01749"/>', desc:"", tableId:"T_O_CUST"},
	            {id:"TMP_O_STORE",tableNm:'<spring:message code="M00651"/>', desc:"", tableId:"T_O_STORE"},
	            {id:"TMP_O_SALES",tableNm:'<spring:message code="M01750"/>', desc:"", tableId:"T_O_SALES"},
	            {id:"TMP_O_SALES_DTL",tableNm:'<spring:message code="M01751"/>', desc:"", tableId:"T_O_SALES_DTL"},
	            {id:"TMP_O_SALES_PAY",tableNm:'<spring:message code="M01752"/>', desc:"", tableId:"T_O_SALES_PAY"},
	            {id:"TMP_O_CARD",tableNm:'<spring:message code="M01753"/>', desc:"", tableId:"T_O_CARD"},
	            {id:"TMP_O_SALES_MILEAGE",tableNm:'<spring:message code="M01754"/>', desc:"", tableId:"T_O_SALES_MILEAGE"},
	            {id:"TMP_O_PROD",tableNm:'<spring:message code="M00138"/>', desc:"", tableId:"T_O_PROD"}
		];
    var ejGridOption = {
            rowSelected : function (args) {
            	var selectData = args.data;
       			tableNm  = selectData.tableNm;
       			tableId  = selectData.tableId;
       			tmpId  = selectData.id;
        		getFileUploadList();
           	},
           	datatype: 'clientSide',
           	dataSource : data,
           	columns:[ 
            	{
          		  field : 'id', headerText : 'id', visible : false ,
          		  customAttributes : {
          			  index : 'id' } //
          	  },{
        		  field : 'tableNm', headerText : '<spring:message code="M01154"/>', headerTextAlign : 'center',
        		  customAttributes : {
        			  index : 'tableNm' } //
        	  },{
        		  field : 'desc', headerText : '<spring:message code="M01264"/>', headerTextAlign : 'center',
        		  customAttributes : {
        			  index : 'desc' } //
        	  },{
        		  field : 'tableId', headerText : 'tableId', visible : false ,
        		  customAttributes : {
        			  index : 'tableId' } //
        	  },
            ],
            requestGridData : {
  	    	  nd   : new Date().getTime(),
  	    	  rows : 10,
  	    	  _search : false
  	      },
  	      rowList : [10,25,50,100],
//  	       gridDataInit: false,
            radio: true,
            tempId : 'fileUpPopTemplete'
        };
    tableListGrid = $("#tableListGrid").ifvsfGrid({ ejGridOption : ejGridOption });


}

// 파일업로드 이력 조회
function getFileUploadList(){
    var ejGridOption = {
//    		recordDoubleClick : function(data){
//         	/* var data = fileUpRecordGrid.getRowData()[data-1];
//         	excelResultId = data.id;
//         	uploadErrorPop(); */
//         },
        rowSelected : function (args) {
        	var selectData = args.data;
    		for(var i=0; i<selectData.length; i++){
    			errorId  = selectData[i].id;
			}
        },
   		serializeGridData : function( data ){
   			data.startDate = startDt;
   			data.endDate = endDt;
   			data.tableId = tableId;
   		},		
   		loadComplete : function(obj){
   			setFileUpCalendar();
   		},
        dataUrl : '<ifvm:action name="getExcelUpResult"/>',
        columns:[ 
        	{
	      		  field : 'fileNm', headerText : '<spring:message code="M00443"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'aur.file_nm' } //
	      	  },{
	    		  field : 'allCnt', headerText : '<spring:message code="M01757"/>', headerTextAlign : 'center',
	    		  customAttributes : {
	    			  index : 'aur.all_cnt' } //
	    	  },{
	    		  field : 'okCnt', headerText : '<spring:message code="M01758"/>', headerTextAlign : 'center',
	    		  customAttributes : {
	    			  index : 'aur.ok_cnt' } //
	    	  },{
	    		  field : 'noCnt', headerText : '<spring:message code="M01759"/>', headerTextAlign : 'center',
	    		  customAttributes : {
	    			  index : 'aur.no_cnt' } //
	    	  },{
	    		  field : 'uploadTime', headerText : '<spring:message code="M01760"/>', headerTextAlign : 'center',
	    		  customAttributes : {
	    			  index : 'aur.upload_time' } //
	    	  },{
	    		  field : 'createByName', headerText : '<spring:message code="M00184"/>', headerTextAlign : 'center',
	    		  customAttributes : {
	    			  index : 'ep.name' } //
	    	  },{
	    		  field : 'createDate', headerText : '<spring:message code="M01756"/>', headerTextAlign : 'center',
	    		  customAttributes : {
	    			  index : 'aur.create_date' } //
	    	  },{
	    		  field : 'id', headerText : 'id', visible : false ,
	    		  customAttributes : {
	    			  index : 'aur.id' } //
	    	  },
        ],
        requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 'aur.create_date',
	    	  sord : 'desc',
	    	  _search : false
	      },
	    rowList : [10,25,50,100],
        radio: true,
        tempId : 'fileUpGridTemplete' 
    };
    
    fileUpRecordGrid = $("#fileUpRecordGrid").ifvsfGrid({ ejGridOption : ejGridOption });
    
}

// 파일업로드 팝업 열기
function fileUploadOpen() {
 $("#dialog").ifvsfPopup({
 	 enableModal : true,
     enableResize: false,
     contentUrl: '<ifvm:url name="fileUploadPop"/>',
     contentType: "ajax",
     title: '<spring:message code="M00824"/>',
     width: 810,
     close : 'fileUpPopClose' 
 });
}
// 파일업로드 오류팝업 열기
function uploadErrorPop(){
	 $("#dialogErrorPop").ifvsfPopup({
	 	 enableModal : true,
	     enableResize: false,
	     contentUrl: '<ifvm:url name="uploadErrorPop"/>',
	     contentType: "ajax",
	     title: '<spring:message code="M01766"/>',
	     width: 800,
	     close : 'upErrorPopClose' 
	 });
}
// 업로드일시 검색 버튼
function fnBtnSearch() {
	errorId = null;
	calDt();
	getFileUploadList();
}

$(document).ready(function() {
	// 어카운트명 조회
	getAccountNm();
	// 업로드일시 시작일
	startDt = $.ifvGetTodayDate();
	// 업로드일시 종료일
	endDt = $.ifvGetTodayDate();
	// 테이블목록 조회
	getTableListGrid();
	// 파일업로드이력 조회
	getFileUploadList();
		
	// 템플릿 다운로드
	$("#tempDown").click(function () {
		if(tableNm != null){
	 		if(tableId == 'T_O_CUST'){ // 회원
	 			location.href = '<ifvm:url name="fileDownload"/>/t_o_cust.csv';
			}else if(tableId == 'T_O_STORE'){ // 매장
				location.href = '<ifvm:url name="fileDownload"/>/t_o_store.csv';
			}else if(tableId == 'T_O_SALES'){ // 매출
				location.href = '<ifvm:url name="fileDownload"/>/t_o_sales.csv';
			}else if(tableId == 'T_O_SALES_DTL'){ // 매출상세
				location.href = '<ifvm:url name="fileDownload"/>/t_o_sales_dtl.csv';
			}else if(tableId == 'T_O_SALES_PAY'){ // 매출결제
				location.href = '<ifvm:url name="fileDownload"/>/t_o_sales_pay.csv';
			}else if(tableId == 'T_O_CARD'){ // 맴버쉽카드
				location.href = '<ifvm:url name="fileDownload"/>/t_o_card.csv';
			}else if(tableId == 'T_O_SALES_MILEAGE'){ // 매출포인트
				location.href = '<ifvm:url name="fileDownload"/>/t_o_sales_mileage.csv';
			}else if(tableId == 'T_O_PROD'){ // 상품
				location.href = '<ifvm:url name="fileDownload"/>/t_o_prod.csv';
			}
		}else{
			alert('<spring:message code="M00004" />');
		}
		
	});

	// 파일 업로드
	$("#fileUpload").click(function () {
		if(tableNm != null){
			fileUploadOpen();	
		}else{
			alert('<spring:message code="M00004" />');
		}
	});
	
	// 오류내역확인
	$("#btnErr").click(function () {
		if(errorId != null){
			excelResultId = errorId;
			uploadErrorPop();	
		}else{
			alert('<spring:message code="M00004" />');
		}
	});
});

</script>

<script id="selectAccount" type="text/x-jquery-tmpl">
	<option value="${'${'}id}">${'${'}text}</option>
</script>


<script id="fileUpPopTemplete" type="text/ifvGrid-tmpl">
<div class="ifv_grid_templete">
	<div class="grid_con">
		{grid}
	</div>
</div>
</script>

<style>
.search_fl {float: left; }
.search_cl {clear: both; display: block; content: "";}
.search_dash {line-height: 27px; width: 5px; height: 27px;text-align: center;}
.search_label.search_fl {margin-right: 15px; height: 27px; line-height: 27px;} 
.ifv_search_box_search_btn.search_fl {margin-left: 5px; height: 27px; line-height: 27px;}
</style>

<script id="fileUpGridTemplete" type="text/ifvGrid-tmpl">
	<div class="ifv_grid_templete">
		<div class="filter_area">
			<div class="left search_cl">
				<label class="control-label search_fl search_label">
					<spring:message code="M01756" /></label>
				<div class="control_content search_fl">	
					<div class="cal_frt start_date search_fl">
						<ifvm:input type="date" id="uploadStartDate" />
					</div>
					<div class="search_fl search_dash">~</div>
					<div class="cal_scd end_date search_fl">
						<ifvm:input type="date" id="uploadEndDate" />
					</div>	
					<button class="ifv_search_box_search_btn search_fl" onClick="fnBtnSearch()">
       					<spring:message code="M00013" />
       				</button>
				</div>
			</div>
			<div class="right ">
				{rowsBox}
			</div>
		</div>
		<div class="grid_con">
			{grid}
		</div>
		<div class="page">
			{page}
			<div class="total_area">{total}</div>
		</div>
	</div>
</script>


<div class="page-title">
	<h1>
		 <spring:message code="O00203"/> &gt; <spring:message code="L00030"/>
	</h1>
</div>

<div class="well form-horizontal">
	<div class="row  qt_border">
		<div class="form-horizontal">			
			<label class="col-xs-1 control-label"><spring:message code="M01747"/></label>
			<div class="col-xs-3">
				<ifvm:input type="select" id="accountNm" />
			</div>
		</div>
	</div>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
	 		<span><spring:message code="M00534"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm btn_gray" id='tempDown' objCode="dataImportNewTempDown_OBJ">
	 			<spring:message code="M01748"/>
			</button> 
			<button class="btn btn-sm btn_gray" id='fileUpload' objCode="dataImportNewFileUpload_OBJ">
				<spring:message code="M00824"/>
			</button> 	
		</div>
	</div>
	<div id="tableListGrid" class="white_bg grid_bd0"></div>
</div>
<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
	 		<span><spring:message code="M01755" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm btn_gray" id='btnErr' objCode="dataImportNewErrChk_OBJ">
	 			<spring:message code="M01767"/>
			</button> 
		</div>
	</div>
	<div id="fileUpRecordGrid" class="white_bg grid_bd0"></div>
</div>
<div id="dialog" class="popup_container"></div>
<div id="dialogErrorPop" class="popup_container"></div>