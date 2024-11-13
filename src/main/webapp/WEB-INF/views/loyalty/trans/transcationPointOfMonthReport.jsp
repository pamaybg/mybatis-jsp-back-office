<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 월별 포인트 현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn">
                <spring:message code="M00278" />
            </button>
        </div>
	</div>
	<div class="well form-horizontal well_bt5" id="transactionSearchList">
    </div>
</div>

<%-- 그리드 영역 --%>
<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <%-- <button class="btn btn-sm" id="excelExportBtn">
                <spring:message code="M01218" />
            </button> --%>
        </div>
    </div>
    <div id="pntOfMonthListGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
var pntOfMonthListGrid;
var gridDataInit = false;

function getTranPointOfMonList(){
    var ejGridOption = {
           serializeGridData : function(data) {
        	   if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.item = requestitem;
               }
        	    data.startDt= $('.SearchCondition').find('.changeTypeAreaCode .start_date input').val().replace(/-/g, '');
                data.endDt = $('.SearchCondition').find('.changeTypeAreaCode .end_date input').val().replace(/-/g, '');
                         
                return data;
             },loadComplete : function(obj){
             	
             },
          showStackedHeader: true,
          showSummary: true,
          summaryRows: [{
              title: "합계",
              summaryColumns: [
            	  {
                  summaryType: ej.Grid.SummaryType.Sum,
                  displayColumn: "basePnt",
                  dataMember: "basePnt",
                  format: "{0:n0}"
                 },
                 {
                     summaryType: ej.Grid.SummaryType.Sum,
                     displayColumn: "acrlPnt",
                     dataMember: "acrlPnt",
                     format: "{0:n0}"
                  },
                 {
                     summaryType: ej.Grid.SummaryType.Sum,
                     displayColumn: "rdmPnt",
                     dataMember: "rdmPnt",
                     format: "{0:n0}"
                 },
                 {
                     summaryType: ej.Grid.SummaryType.Sum,
                     displayColumn: "extPnt",
                     dataMember: "extPnt",
                     format: "{0:n0}"
                 }, {
                     summaryType: ej.Grid.SummaryType.Sum,
                     displayColumn: "extOutPnt",
                     dataMember: "extOutPnt",
                     format: "{0:n0}"
                 },
                 {
                     summaryType: ej.Grid.SummaryType.Sum,
                     displayColumn: "totPnt",
                     dataMember: "totPnt",
                     format: "{0:n0}"
                 }             
              ]
          }
          ],
      	dataUrl : '<ifvm:action name="getMonthOfPoint"/>',
          columns:[
          	   {
                   field : 'chnlType' ,headerText : '구분', headerTextAlign : 'center', textAlign: 'center',
                   customAttributes : {
                      index : 'chnlType' , sortable: false}/*  */
                },{
                   field : 'basePnt', headerText : '기초', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                   customAttributes : {
                      index : 'basePnt' , sortable: false}/* */
                },{
                    field : 'acrlPnt', headerText : '적립', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                    customAttributes : {
                       index : 'acrlPnt' , sortable: false}/* */
                 },{
                   field : 'rdmPnt', headerText : '사용', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                   customAttributes : {
                      index : 'rdmPnt' , sortable: false}/*   */
                },{
                   field : 'extPnt', headerText : '자동 소멸', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', 
                   customAttributes : {
                      index : 'extPnt' , sortable: false}/* */
                },{
                    field : 'extOutPnt', headerText : '탈회 소멸', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', 
                    customAttributes : {
                       index : 'extOutPnt' , sortable: false}/* */
                 },{
                   field : 'totPnt', headerText : '기말', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                   customAttributes : {
                      index : 'totPnt' , sortable: false}/*  */
                }
          ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : '1',
          	  sord : 'asc',
          	  _search : false,
         },
         rowList : [10,25,50,100],
         gridDataInit: gridDataInit,
         radio: false,
         tempId : 'ifvGridSimpleTemplete2'
      };
    pntOfMonthListGrid = $("#pntOfMonthListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

//공통 조회 조건 목록 설정
function transactionListSearchInit() {
    $.fn.ifvmSetCommonCondList("transactionSearchList","TRAN_POINT_MONTH");
    searchInitialize();
}

function searchInitialize(){
	initDateSetting();
}

//현재날짜 조회
function sysdateSet(){
	   var d= new Date();
	   var reqYear =String(d.getFullYear());
	   var reqMonth =d.getMonth()+1;
	   reqMonth=reqMonth>=10?reqMonth:'0'+reqMonth;
	   $('#year').val(reqYear);
	   $('#month').val(reqMonth);
   }
   

function transactionListSearch() {
	var searchValidation =true ;

	if(!searchBlankCheck()){
		alert('<spring:message code="L01859" />');
		searchValidation=false;
		return;
	}
	
	var startDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .start_date input').val());
	var EndDate = new Date($('.SearchCondition').find('.changeTypeAreaCode .end_date input').val());
	var todayDate =new Date($.ifvGetTodayDate());
    startDate.setHours(0, 0, 0, 0);
    EndDate.setHours(0, 0, 0, 0);
    todayDate.setHours(0, 0, 0, 0);
    
    var year = EndDate.getFullYear();
    var month = EndDate.getMonth();
    var day = EndDate.getDate();
	var d = new Date();
    d.setHours(0, 0, 0, 0);

    d.setYear(year);
    d.setMonth(month-2);
    d.setDate(day); 
	
	if(startDate>todayDate){
		alert('현재일까지만 조회가능합니다.');
		searchValidation=false;
		return;
	}
	
	if(EndDate>todayDate){
		alert('현재일까지만 조회가능합니다.');
		searchValidation=false;
		return;
	}
	
	if(startDate < d){
        alert('최대 2개월 까지만 조회가 가능합니다.');
		searchValidation=false;
		return;
	}
		
	if(searchValidation){
		gridDataInit=true;
		getTranPointOfMonList();
	}else{
		return;
	}
	
}
function searchBlankCheck(){
	var blankCheck=false;
	var searchCondSize= $('.changeTypeAreaCode').size();
	var displayRowNum=[];
	var txnCheck=0;
	$($('.row.qt_border.SearchCondition')).each(function(index,item){
		if($("#rows"+index).css("display") !="none"){
			
			if($("#rows"+index).children(".changeTypeAreaCode").find('.smart-form').size()!=0){ //date
				if($("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_frt.start_date").children(".smart-form").children(".input").children("input").val() !=""
					&& $("#rows"+index).children(".changeTypeAreaCode").children(".col-xs-2.cal_scd.end_date").children(".smart-form").children(".input").children("input").val() !="" ){
					txnCheck++;
				}
			}
			if($("#rows"+index+ " .searchTextVal option:selected").attr('joinsrcclm')=="TXN_NUM"){
				if($("#rows"+index+ " .changeTypeAreaCode input").val()!=""){
					txnCheck++;
				}
			}
		}
	})  //빈값 처리
	if(txnCheck>0){
		blankCheck=true;
	}
	return blankCheck;
}

function DateFormat(date){
	var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}

function initDateSetting(){
	$('.SearchCondition').find('.changeTypeAreaCode .end_date input').val($.ifvGetTodayDate());
	var todayDate =new Date($.ifvGetTodayDate());
    todayDate.setHours(0, 0, 0, 0);
    var year = todayDate.getFullYear();
    var month = todayDate.getMonth();
    var day = todayDate.getDate();
    var d = new Date();
    d.setYear(year);
    d.setMonth(month-2);
    d.setDate(day); 
    d.setHours(0, 0, 0, 0);
    var startDt =   DateFormat(d);     
	$('.SearchCondition').find('.changeTypeAreaCode .start_date input').val(startDt);
}
$(document).ready(function() {
	
    transactionListSearchInit(); 
	getTranPointOfMonList();
	initDateSetting();

	//조회
    $('#reportSearchBtn').on('click', function(){
    	transactionListSearch();
    	
    });

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	transactionListSearchInit();
    }); 
 
    
   
	//엑셀다운로드
/*     $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/mbrFlagExelDown.do','pntOfMonthListGrid' );
    });
	 */
	
});
</script>