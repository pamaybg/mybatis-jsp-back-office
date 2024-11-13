<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var increaseMbrGrid;

//등급그룹 목록 조회
function getNewIncreaseMbr(){
    var ejGridOption = {
      	serializeGridData : function( data ){
      		if ($.fn.ifvmIsNotEmpty(requestitem)) {
      			data.item = requestitem;
            }     
      		data.yyyymm =$('#year').val()+$('#month').val();
            return data;
       	},
       	showSummary:true,
       	summaryRows: [
       		{
                title: "합계:",
                summaryColumns: [
             	   { summaryType: ej.Grid.SummaryType.Sum, displayColumn: "totalMbr"		, dataMember: "totalMbr", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "newMbrCnt"		, dataMember: "newMbrCnt", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "nowHisMbr"		, dataMember: "nowHisMbr", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "nowWPMbr"		, dataMember: "nowWPMbr", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "newIbk"			, dataMember: "newIbk", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "newMbr"		    , dataMember: "newMbr", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "newApp"			, dataMember: "newApp", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "newWeb"			, dataMember: "newWeb", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "ptnrNewIbk"		, dataMember: "ptnrNewIbk", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "dropMbr"			, dataMember: "dropMbr", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "dayDropMbr"		, dataMember: "dayDropMbr", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "newStore"		, dataMember: "newStore", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "newWP"			, dataMember: "newWP", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "transNewIbk"		, dataMember: "transNewIbk", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "newFamMbr"		, dataMember: "newFamMbr", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "newFamMbrCnt"	, dataMember: "newFamMbrCnt", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "accrueFmaCnt"	, dataMember: "accrueFmaCnt", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "accrueFmaCntMbr"	, dataMember: "accrueFmaCntMbr", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "pushYn"			, dataMember: "pushYn", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "eMailYn"			, dataMember: "eMailYn", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "smsYn"			, dataMember: "smsYn", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "webReceipt"		, dataMember: "webReceipt", format: "{0:n0}" }
             	  ,{ summaryType: ej.Grid.SummaryType.Sum, displayColumn: "anniverCnt"		, dataMember: "anniverCnt", format: "{0:n0}" }
                ]  
            },
            {
               title: "평균:",
               summaryColumns: [
            	   { summaryType: ej.Grid.SummaryType.Average, displayColumn: "totalMbr"		, dataMember: "totalMbr", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "newMbrCnt"		, dataMember: "newMbrCnt", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "nowHisMbr"		, dataMember: "nowHisMbr", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "nowWPMbr"		, dataMember: "nowWPMbr", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "newIbk"			, dataMember: "newIbk", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "newMbr"		    , dataMember: "newMbr", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "newApp"			, dataMember: "newApp", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "newWeb"			, dataMember: "newWeb", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "ptnrNewIbk"		, dataMember: "ptnrNewIbk", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "dropMbr"			, dataMember: "dropMbr", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "dayDropMbr"		, dataMember: "dayDropMbr", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "newStore"		, dataMember: "newStore", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "newWP"			, dataMember: "newWP", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "transNewIbk"		, dataMember: "transNewIbk", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "newFamMbr"		, dataMember: "newFamMbr", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "newFamMbrCnt"	, dataMember: "newFamMbrCnt", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "accrueFmaCnt"	, dataMember: "accrueFmaCnt", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "accrueFmaCntMbr"	, dataMember: "accrueFmaCntMbr", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "pushYn"			, dataMember: "pushYn", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "eMailYn"			, dataMember: "eMailYn", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "smsYn"			, dataMember: "smsYn", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "webReceipt"		, dataMember: "webReceipt", format: "{0:n0}" }
              	  ,{ summaryType: ej.Grid.SummaryType.Average, displayColumn: "anniverCnt"		, dataMember: "anniverCnt", format: "{0:n0}" }
               ]  
            }
           ],
       	dataUrl : '<ifvm:action name="getSelectIncreaseMbr"/>',
        columns:[ 
        	  {
	      		  field : 'yyyymmdd' ,headerText : '일자', headerTextAlign : 'center', textAlign: 'center',
	      		  customAttributes : {
	      			  index : 'yyyymmdd' , sortable: false}/*  */
	      	  },{
	      		  field : 'totalMbr' ,headerText : '총 회원수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'totalMbr' , sortable: false}/*  */
	      	  },{
	      		  field : 'newMbrCnt' ,headerText : '신규 멤버십 회원수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'newMbrCnt' , sortable: false}/* new */
	      	  },{
	      		  field : 'nowHisMbr', headerText : '현제 간편 회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'nowHisMbr' , sortable: false}/* */
	      	  },{
	      		  field : 'nowWPMbr', headerText : '현재 위포인트 회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'nowWPMbr' , sortable: false}/*  ㅡ */
	      	  },{
	      		  field : 'newIbk', headerText : '현재 IBK 회원수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'newIbk' , sortable: false}/*  */
	      	  },{
	      		  field : 'newMbr', headerText : '신규 회원수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'nowWPMbr' , sortable: false}/*  */
	      	  },{
	      		  field : 'newApp', headerText : 'APP', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'newApp' , sortable: false}/* */
	      	  },{
	      		  field : 'newWeb', headerText : 'WEB', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'newWeb' , sortable: false}/*  */
	      	  },{
	      		  field : 'ptnrNewIbk', headerText : '제휴(IBK)', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'ptnrNewIbk' , sortable: false}/* new */
	      	  },{
	      		  field : 'dropMbr', headerText : '누적탈퇴', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'dropMbr' , sortable: false}/*  */
	      	  },{
	      		  field : 'dayDropMbr', headerText : '당일탈퇴', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'dayDropMbr' , sortable: false}/*  */
	      	  },{
	      		  field : 'newStore', headerText : '멤버십 전환(간편)', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'newStore' , sortable: false}/*  */
	      	  },{
	      		  field : 'newWP', headerText : '멤버십 전환(위포인트)', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'newWP' , sortable: false}/*  */
	      	  },{
	      		  field : 'transNewIbk', headerText : '멤버십 전환(IBK)', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'transNewIbk' , sortable: false}/* new */
	      	  },{
	      		  field : 'newFamMbr', headerText : '신규 패밀리수', headerTextAlign : 'center', textAlign: 'right',
	      		  customAttributes : {
	      			  index : 'newFamMbr' , sortable: false}/*  */
	      	  },{
	      		  field : 'newFamMbrCnt', headerText : '신규 패밀리 회원수', headerTextAlign : 'center', textAlign: 'right',
	      		  customAttributes : {
	      			  index : 'newFamMbrCnt' , sortable: false}/*  */
	      	  },{
	      		  field : 'accrueFmaCnt', headerText : '누적 패밀리수', headerTextAlign : 'center', textAlign: 'right',
	      		  customAttributes : {
	      			  index : 'accrueFmaCnt' , sortable: false}/*  */
	      	  },{
	      		  field : 'accrueFmaCntMbr', headerText : '누적 패밀리 회원수', headerTextAlign : 'center', textAlign: 'right',
	      		  customAttributes : {
	      			  index : 'accrueFmaCntMbr' , sortable: false}/*  */
	      	  },{
	      		  field : 'pushYn', headerText : 'Push동의회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'pushYn' , sortable: false}/*  */
	      	  },{
	      		  field : 'eMailYn', headerText : 'E-Mail동의회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'eMailYn' , sortable: false}/*  */
	      	  },{
	      		  field : 'smsYn', headerText : 'SMS동의회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'smsYn' , sortable: false}/*  */
	      	  },{
	      		  field : 'webReceipt', headerText : '전자영수증 등록회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'webReceipt' , sortable: false}/*  */
	      	  },{
	      		  field : 'anniverCnt', headerText : '기념일 등록회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'anniverCnt' , sortable: false}/*  */
	      	  }
        ],
        stackedHeaderRows: [{ 
            stackedHeaderColumns:[
            	{ headerText: "멤버십 누적 회원수"	   , column: "totalMbr,newMbrCnt,nowHisMbr, nowWPMbr, newIbk" 	 ,		 headerTextAlign : "center" },
                { headerText: "가입채널별", column: "newMbr,newApp,newWeb,ptnrNewIbk" ,  headerTextAlign : "center" },
                { headerText: "탈퇴", 	 column: "dropMbr,dayDropMbr" ,  headerTextAlign : "center" },
                { headerText: "전환 고객수", column: "newStore,newWP,transNewIbk" ,  headerTextAlign : "center" },
                { headerText: "패밀리"   , column: "newFamMbr, newFamMbrCnt, accrueFmaCnt ,accrueFmaCntMbr"  ,  headerTextAlign : "center" },
                { headerText: "기능여부"  , column: "pushYn, eMailYn, smsYn, webReceipt,anniverCnt" 	 	 	 ,  headerTextAlign : "center" },
            ] 	
        }],
        actionComplete: function(args){
			$(this.getHeaderContent().find(".e-stackedHeaderCell")[1]).css("text-align", "center");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[2]).css("text-align", "center");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[3]).css("text-align", "center");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[4]).css("text-align", "center");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[5]).css("text-align", "center");
        	$(this.getHeaderContent().find(".e-stackedHeaderCell")[6]).css("text-align", "center");
        },
        requestGridData : {
	      	  nd   : new Date().getTime(),
	      	  rows : 10,
	      	  _search : false
	    },
	    rowList : [10,25,50,100],
	  	showStackedHeader:true,
        gridDataInit : true,
    	allowCellMerging : true,
        tempId : 'ifvGridSimplePageTemplete3'
    };
    
    increaseMbrGrid = $("#increaseMbrGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
function summaryFunc() {
	   var reqdata = purchaseList.opt.gridControl.model.currentViewData[0].totalamount
	   return reqdata;
	}
	function mbrtotalSum() {
	   var reqdata = purchaseList.opt.gridControl.model.currentViewData[0].mbrtotal
	   return reqdata;
	}
//공통 조회조건 필수값 체크
// function validationCheck(table){
// 	var validationVal =  false;
// 	$(".SearchCondition .searchTextVal option:selected").filter(function(){
// 		if($(this).attr('jointgtclm') == table){
// 			if($(this).parents('.SearchCondition').css("display") !="none"){
// 				if($.fn.ifvmIsNotEmpty( $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())){
// 					validationVal = true;
// 				}
// 			}
// 		}
// 	})
// 	return validationVal;
// }

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
	$.ifvExcelDn('/kepler/report/increaseMbrExport.do','increaseMbrGrid');
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
        &gt; 일자별 회원수
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
<!--     <div class="well form-horizontal well_bt5" id="settleSolPayHistorySearchList" > -->
<!--     </div> -->
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
    <div id="increaseMbrGrid" class="white_bg grid_bd0"></div> 
</div>
