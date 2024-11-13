<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var mbrCaseGrid;

//등급그룹 목록 조회
function getNewIncreaseMbr(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }
      		var d= new Date();
      		var reqYear =String(d.getFullYear());
      		var reqMonth =d.getMonth()+1;
      		var reqDate = String(d.getDate()-1);
      		reqMonth=reqMonth>=10?reqMonth:'0'+reqMonth;
      		var reqDate2 = $('#year').val()+$('#month').val();

      		if(reqYear+reqMonth == reqDate2){
      			data.toMonth=reqYear+reqMonth+reqDate;
      		}else{
      			data.agoMonth =$('#year').val()+$('#month').val();
      		}
            return data;
       	},
       	allowCellMerging: true,
       	allowTextWrap: true,
       	dataUrl : '<ifvm:action name="mbrCaseList"/>',
        columns:[
        	  {
	      		  field : 'typeA' ,headerText : '', headerTextAlign : 'center',textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'typeA' , sortable: false}/*  */
	      	  },{
	      		  field : 'typeB' ,headerText : '', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'typeB' , sortable: false}/*  */
	      	  },{
	      		  field : 'mon0m', headerText : '당월', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'mon0m' , sortable: false}/* */
	      	  },{
	      		  field : 'mon1m', headerText : '전월', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'mon1m' , sortable: false}/*   */
	      	  },{
	      		  field : 'mon1mRate', headerText : '전월 비교 비율', headerTextAlign : 'center', textAlign: 'right', format : '{0:n2}',
	      		  customAttributes : {
	      			  index : 'mon1mRate' , sortable: false}/* */
	      	  },{
	      		  field : 'mon12m', headerText : '전년도 동월', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'mon12m' , sortable: false}/*  */
	      	  },{
	      		  field : 'mon12mRate', headerText : '전년도 동월 비율', headerTextAlign : 'center', textAlign: 'right',format : '{0:n2}',
	      		  customAttributes : {
	      			  index : 'mon12mRate' , sortable: false}/*  */
	      	  },{
	      		  field : 'seq', headerText : '', headerTextAlign : 'center', visible: false, isPrimaryKey: true,
	      		  customAttributes : {


	      			  index : 'seq' , sortable: false}/*  */
	      	  }
        ],
        mergeCellInfo: function (args) {
		    if (args.data.seq == '1') {
		        if (args.column.field == "typeA")  {
		        	 args.merge(1, 5);
		        }
		    }else if (args.data.seq == '6') {
		        if (args.column.field == "typeA")  {
		        	 args.merge(1,4);
		        }
		    }else if (args.data.seq == '11') {
		        if (args.column.field == "typeA")  {
		        	 args.merge(1,2);
		        }
		    }else if (args.data.seq == '13') {
		        if (args.column.field == "typeA")  {
		        	 args.merge(1,5);
		        }
		    }
        },
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  _search : false
	    },
// 	    rowList : [10,25,50,100],
// 	  	showStackedHeader:true,
        gridDataInit : true,
    	allowCellMerging : true,
        tempId : 'ifvGridSimplePageTemplete3'
    };

    mbrCaseGrid = $("#mbrCaseGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

function commcodeSetting(){
	   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
	   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
}
//공통 조회 조건 목록 설정
// function settleSolPayListSearchInit() {
// //     $.fn.ifvmSetCommonCondList("settleSolPayHistorySearchList","SETTLE_MONTH_POINT_EXCT_LIST");

//     $(".searchTextVal option:selected").filter(function(){
//         $(this).parents('.SearchCondition').find('.searchCondition option[value="NOT"]').remove();
//     })
// }

//공통 조회 호출
function reqDataSearch() {
   var reportSearchObj = $('#reportSearchCondition').getSubmitData();
   getNewIncreaseMbr();
}

//엑셀 다운로드
function excelExport() {
	$.ifvExcelDn('/kepler/report/mbrCaseListExport.do','mbrCaseGrid');
}
function sysdateSet(){
	   var d= new Date();
	   var reqYear =String(d.getFullYear());
	   var reqMonth =d.getMonth()+1;
	   reqMonth=reqMonth>=10?reqMonth:'0'+reqMonth;
	   $('#year').val(reqYear);
	   $('#month').val(reqMonth);
}

$(document).ready(function() {
	commcodeSetting();
    //공통 조회 조건 목록 설정
    //현제날짜 세팅
	sysdateSet();

    //전체 그리드 조회
    getNewIncreaseMbr();

    //조회
    $('#reportSearchBtn').on('click', function(){
    	reqDataSearch();
    });

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	commcodeSetting();
    });

  	//엑셀 다운로드
    $("#excelExportBtn").on('click', function(){
    	excelExport();
    });
});

</script>

<div class="page-title">
    <h1>
        레포트
        &gt; 월별 회원수 리포트
    </h1>
</div>

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
     <div class="form-horizontal underline top_well" id="reportSearchCondition">
       <div class="row qt_border">
            <label class="col-xs-1 control-label">
            년</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="year" names="year" dto="year"/>
            </div>
            <label class="col-xs-1 control-label">
            월</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="month" names="month" dto="month"/>
            </div>
      </div>
    </div>
</div>

<div>
    <div class="page_btn_area" id =''>

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelExportBtn">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="mbrCaseGrid" class="white_bg grid_bd0"></div>
</div>
