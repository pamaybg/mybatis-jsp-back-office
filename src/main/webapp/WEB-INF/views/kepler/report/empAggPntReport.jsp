<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style type="text/css">
.descript{
	width : 98%;
	font-size: 13px;
	box-sizing: border-box;
	margin: 10px;
	padding: 10px;

}
</style>

<div class="page-title">
    <h1>
    	정형 Report &gt; 임직원적립금현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="empAggPntSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="empAggPntSearchInit_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
	</div>
		<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
			<ifvm:inputNew type="dateTerm" startDto="startDt" endDto="endDt" startId="startDt" endId="endDt" label="검색기간" labelClass="1" conClass="4"/> 
		 </div>
		 <div class="row qt_border">
					<label class="col-xs-1 control-label"><spring:message code="오퍼명"/></label>
            <div class="col-xs-2 control_content">
            <div class="input-group">
                <ifvm:input type="text" id="ofrNm" disabled="true" names="ofrNm" dto="ofrNm"/>
            		<ifvm:inputNew type="hidden" id="ridOfr" dto="ridOfr" label="오퍼번호"/>
            		  		<span class="input-group-addon" id="ofrBtn">
							<a><i class="fa fa-search"></i></a>
						</span>
					</div>
            </div>
		</div>
			<div class="row qt_border">
			<ifvm:inputNew type="text" id="mbrNm" names="mbrNm" dto="mbrNm" label="통합회원명" labelClass="1" conClass="2"/>
					
					
		 </div>
	 </div>
</div>

<%-- 그리드 영역 --%>
<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
      <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelExportBtn" objCode="empAggPntExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div> 
    </div>
    <div id="empAggPntGrid" class="white_bg grid_bd0"></div>
         <div class="page_btn_area" >
   		<div class="col-xs-7">
		 <span>용어설명</span>
    	</div>
    </div>
<textarea id="desc" class = "descript" maxlength="100" rows="6" readonly = true>
• 기초적립금: 검색기간 시작일 전까지의 잔여 적립금
• 적립계 : 적립 - 적립취소
• 사용계: 사용-사용취소
• 소멸계: 탈회+만료 
• 잔여적립금: 기초+적립-사용-소멸
</textarea>
 
   
</div>
<div id="chnlListPopDialog" class="popup_container"></div>
  <div id="ofrPop" class="popup_container"></div>




<script type="text/javascript">
var empAggPntGrid;
var txnDetailCd=null;
var offSetFlag =null;
var sumobj = {};

function getCustomSummary(){
	  sumobj = {};
	$.ifvSyncPostJSON('<ifvm:action name="getEmpAggPntReport"/>',{
		startDt : $("#startDt").val().replace(/-/g,""),
		endDt : $("#endDt").val().replace(/-/g,""),
		ridOfr : $("#ridOfr").val(),
		mbrNm : $("#mbrNm").val(),
		offSetFlag : "N"
	},
	function(result) {
		if(result.rows.length!=0){
			
		sumobj = result.rows[0]; 
		sumobj.a1=sumobj.a1_SUM;
		sumobj.b1=sumobj.b1_SUM;
		sumobj.b2=sumobj.b2_SUM;
		sumobj.b3=sumobj.b3_SUM;
		sumobj.c1=sumobj.c1_SUM;
		sumobj.c2=sumobj.c2_SUM;
		sumobj.c3=sumobj.c3_SUM;
		sumobj.c4=sumobj.c4_SUM;
		sumobj.d1=sumobj.d1_SUM;
		sumobj.d2=sumobj.d2_SUM;
		sumobj.d3=sumobj.d3_SUM;
		sumobj.e1=sumobj.e1_SUM;
		}
	});
}

function currency(args,data){
	return sumobj[args.displayColumn];
} 
function setCalendar() {
	var startDate = $('#startDt');
	var endDate = $('#endDt');

	startDate.val($.ifvGetTodayDate()); 
	endDate.val($.ifvGetTodayDate());
	
    startDate.val($.ifvGetNewDate('m01', -1).newDateS);  //한달전 1일
	endDate.val($.ifvGetNewDate('mEnd').newDateS);      //한달전 말일
	 
	startDate.ifvDateChecker({
		maxDate : endDate
	});
	endDate.ifvDateChecker({
		minDate : startDate
	});
}


function empAggPntGridList(){
    var ejGridOption = {
           serializeGridData : function(data) {
                data.startDt= $("#startDt").val().replace(/-/g,"");
                data.endDt= $("#endDt").val().replace(/-/g,"");
                data.mbrNm = $("#mbrNm").val();
                data.ridOfr = $("#ridOfr").val();
                data.offSetFlag = null;
                return data;
             },  
           showStackedHeader: true,
           stackedHeaderRows: [         	  
	     	{
		  	  stackedHeaderColumns: 
  			[
  	  		 /* {headerText: "오퍼명",textAlign : 'center',column: "ofrNm"},
  	  		 {headerText: "회사명",textAlign : 'center',column: "companyNm"},
  	  		 {headerText: "부서명",textAlign : 'center',column: "teamNm"},
  	  		 {headerText: "사번",textAlign : 'center',column: "empNo"}, 
  	  		 {headerText: "이름",textAlign : 'center',column: "custNm"},  	  		     

  		     {headerText: "기초적립금",textAlign : 'center',column: "a1"}, */
  		    {headerText: "",textAlign : 'center',column: "ofrNm,companyNm,teamNm,empNo,custNm"},
  		    {headerText: null,textAlign : 'center',column: "a1"},
   			{headerText: "적립",textAlign : 'center',column: "b1,b2,b3"},
   			{headerText: "사용",textAlign : 'center',column: "c1,c2,c4"},
   			{headerText: "",textAlign : 'center',column: "c3"},
   			{headerText: "소멸",textAlign : 'center',column: "d1,d2,d3"},
   			{headerText: "",textAlign : 'center',column: "e1"}
   			]}
	       ],
	       showSummary: true,
	          summaryRows: [{
	              title: "합계",
	              summaryColumns: [
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "a1",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "b1",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "b2",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "b3",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "c1",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "c2",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "c3",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "c4",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "d1",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "d2",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "d3",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "e1",  format: "{0:n0}"},
		             	]
	          }],
           dataUrl : '<ifvm:action name="getEmpAggPntReport"/>',
             columns:[
            	 {
                     field : 'ofrNm' ,headerText : '오퍼명', headerTextAlign : 'center', textAlign: 'center', width:'180'
                 },{
                     field : 'companyNm' ,headerText : '회사명', headerTextAlign : 'center', textAlign: 'center', width:'80'
                 },{
                     field : 'teamNm' ,headerText : '부서명', headerTextAlign : 'center', textAlign: 'center', width:'90'
                 }, {
                     field : 'empNo' ,headerText : '사번', headerTextAlign : 'center', textAlign: 'center', width:'90'
                 },{
                     field : 'custNm' ,headerText : '이름', headerTextAlign : 'center', textAlign: 'center', width:'80'
                 },{
                     field : 'a1' ,headerText : '기초적립금', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                 },	{
                   field : 'b1' ,headerText : '적립', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'b2' ,headerText : '적립취소', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'b3' ,headerText : '계', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'c1' ,headerText : '사용', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'c2' ,headerText : '사용취소', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'c4' ,headerText : '계', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'c3' ,headerText : '마이너스충당', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'd1' ,headerText : '탈회', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'd2' ,headerText : '만료', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'd3' ,headerText : '계', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'e1' ,headerText : '잔여 적립금', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                }
          ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : '1',
          	  sord : 'asc',
          	  _search : false,
         },
         isHorizontalScroll:true,
         rowList : [10,25,50,100],
         gridDataInit: true,
         radio: false,
         tempId : 'ifvGridSimplePageTemplete2'
      };
    empAggPntGrid = $("#empAggPntGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

function chnlListPopClose(){
	chnlListPopDialog._destroy();
}

//초기화
function searchCondInit(){
	setCalendar();
	$("#ofrNm").val("");
	$("#ridOfr").val("");
}

/*  오퍼 팝업 */
function ofrDetailPopup(){
	txnDetailCd = '161';
	$("#ofrPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="ofrPopPntReport"/>', 
        contentType: "ajax",
        title: '오퍼 조회',
        width: 1200,
        close : 'ofrClosePop'
    });
}
function ofrClosePop() {
	ofrPop._destroy();
}


$(document).ready(function() {
	setCalendar();
	getCustomSummary();
	empAggPntGridList();
	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	getCustomSummary();
    	empAggPntGridList();
       });
	
	//오퍼 조회
	$("#ofrBtn").click(function(){
		ofrDetailPopup();
	});

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	searchCondInit();
    }); 
    
    
    $('#btnChnlListPop').on('click',function(){
    	chnlListPop();
    });
    
    
	//엑셀다운로드
   $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/empAggPntReportExcel.do','empAggPntGrid' );
    });
	 
	
});
</script>