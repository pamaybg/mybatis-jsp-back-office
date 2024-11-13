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
    	정형 Report &gt; 매장별 임직원 적립금 현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="storeEmpAggPntSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="storeEmpAggPntSearchInit_OBJ">
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
	 </div>
</div>

<%-- 그리드 영역 --%>
<div>
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelExportBtn" objCode="storeEmpAggPntExcel_OBJ">
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
  <div id="ofrPop" class="popup_container"></div>
    

    
</div>
<div id="chnlListPopDialog" class="popup_container"></div>
<div id="ofrPop" class="popup_container"></div>

<script type="text/javascript">
var empAggPntGrid;
var chnl_Type_Rid =null;
var chnl_SubType_Cd =null;
var txnDetailCd=null;

var sumobj = {};
var sumobj2 = {};
var sumobj3 ={};

// SUMMARY CUSTOM 계산 
function getCustomSummaryOnline(){
	  sumobj = {};
	$.ifvSyncPostJSON('<ifvm:action name="getStoreEmpAggPntReport2"/>',{
		startDt : $("#startDt").val().replace(/-/g,""),
		endDt : $("#endDt").val().replace(/-/g,""),
		ridOfr : $("#ridOfr").val(),
		chnlTypeCd : "M"
	},
	function(result) {
	if(result.rows.length==0){
		sumobj={a1:0,b1:0,b2:0,b3:0,c1:0,c2:0,c3:0,c4:0,d1:0,d2:0,d3:0,e1:0,e2:0,e3:0,e4:0}
	}else{
	 	sumobj = result.rows[0]; 
		}
	});
	}
 
function getCustomSummaryOffline(){
	  sumobj2 = {};
	$.ifvSyncPostJSON('<ifvm:action name="getStoreEmpAggPntReport2"/>',{
		startDt : $("#startDt").val().replace(/-/g,""),
		endDt : $("#endDt").val().replace(/-/g,""),
		ridOfr : $("#ridOfr").val(),
		chnlTypeCd : "S"
	},
	function(result) {
		if(result.rows.length==0){
			sumobj2={a1:0,b1:0,b2:0,b3:0,c1:0,c2:0,c3:0,c4:0,d1:0,d2:0,d3:0,e1:0,e2:0,e3:0,e4:0}
		}else{
		sumobj2 = result.rows[0]; 
		}
	});
	 
}
 // 온라인합계 + 오프라인 합계
function getCustomSummary(){
	sumobj3.a1 = Number(sumobj.a1)+Number(sumobj2.a1);
	sumobj3.b1 = Number(sumobj.b1)+Number(sumobj2.b1);
	sumobj3.b2 = Number(sumobj.b2)+Number(sumobj2.b2);
	sumobj3.b3 = Number(sumobj.b3)+Number(sumobj2.b3);
	sumobj3.c1 = Number(sumobj.c1)+Number(sumobj2.c1);
	sumobj3.c2 = Number(sumobj.c2)+Number(sumobj2.c2);
	sumobj3.c3 = Number(sumobj.c3)+Number(sumobj2.c3);
	sumobj3.c4 = Number(sumobj.c4)+Number(sumobj2.c4);
	sumobj3.d1 = Number(sumobj.d1)+Number(sumobj2.d1);
	sumobj3.d2 = Number(sumobj.d2)+Number(sumobj2.d2);
	sumobj3.d3 = Number(sumobj.d3)+Number(sumobj2.d3);
	sumobj3.d4 = Number(sumobj.d4)+Number(sumobj2.d4);
	sumobj3.e1 = Number(sumobj.e1)+Number(sumobj2.e1);
	sumobj3.e2 = Number(sumobj.e2)+Number(sumobj2.e2);
	sumobj3.e3 = Number(sumobj.e3)+Number(sumobj2.e3);
	sumobj3.e4 = Number(sumobj.e4)+Number(sumobj2.e4);
}
 
function setCalendar() {
	var startDate = $('#startDt');
	var endDate = $('#endDt');
	//오늘날짜로 초기화
	startDate.val($.ifvGetTodayDate()); 
	endDate.val($.ifvGetTodayDate());
    startDate.val($.ifvGetNewDate('m01', -1).newDateS); //한달전 1일
	endDate.val($.ifvGetNewDate('mEnd').newDateS);     //한달전 말일
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
                data.ridOfr = $("#ridOfr").val();
                return data;
             },  
           showStackedHeader: true,
           stackedHeaderRows: [
         	  
	     		{
		  	  stackedHeaderColumns: 
  			[
  			/* {headerText: "구분",textAlign : 'center',column: "chnlType"},
  			{headerText: "채널번호",textAlign : 'center',column: "chnlNo"},
  			{headerText: "채널명",textAlign : 'center',column: "chnlNm"},
  			{headerText: "기초적립금",textAlign : 'center',column: "a1"}, */
  			{headerText: "",textAlign : 'center',column: "chnlType,chnlNo,chnlNm"},
  			{headerText: "기초적립금",textAlign : 'center',column: "a1,e4,e2"},
   			{headerText: "적립",textAlign : 'center',column: "b1,b2,b3"},
   			{headerText: "사용",textAlign : 'center',column: "c1,c2,c4"},
   			{headerText: "",textAlign : 'center',column: "c3"},
   			{headerText: "소멸",textAlign : 'center',column: "d1,d2,d3"},
   			{headerText: "잔여적립금",textAlign : 'center',column: "e1,e3"} 
   			]
	     		}
	       ],
	       showSummary: true,
	          summaryRows: [{
	              title: "온라인 합계",
	              summaryColumns: [
	             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "a1",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "b1",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "b2",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "b3",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "c1",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "c2",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "c3",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "c4",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "d1",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "d2",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "d3",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "e1",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "e2",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "e3",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "e4",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "e2",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "e3",  format: "{0:n0}"}
	             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "e4",  format: "{0:n0}"}
	             	]
	          },{
	              title: "오프라인 합계",
	              summaryColumns: [
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "a1",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "b1",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "b2",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "b3",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "c1",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "c2",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "c3",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "c4",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "d1",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "d2",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "d3",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "e1",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "e2",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "e3",  format: "{0:n0}"}
		             	,{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency2, displayColumn: "e4",  format: "{0:n0}"}
	                  ]
	          },{
	              title: "합계",
	              summaryColumns: [
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "a1",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "b1",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "b2",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "b3",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "c1",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "c2",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "c3",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "c4",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "d1",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "d2",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "d3",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "e1",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "e2",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "e3",  format: "{0:n0}"},
	            	  {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency3, displayColumn: "e4",  format: "{0:n0}"}

	                  ]
	          }],
           dataUrl : '<ifvm:action name="getStoreEmpAggPntReport"/>',
             columns:[
            	 {
                     field : 'chnlType' ,headerText : '구분', headerTextAlign : 'center', textAlign: 'center', width:'80'
                 }, {
                     field : 'chnlNo' ,headerText : '채널번호', headerTextAlign : 'center', textAlign: 'center', width:'80'
                 }, {
                     field : 'chnlNm' ,headerText : '채널명', headerTextAlign : 'center', textAlign: 'left', width:'120'
                 },
            	 {
                     field : 'a1' ,headerText : '적립금', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                 },{
                     field : 'e4' ,headerText : '마이너스충당', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                 },{
                     field : 'e2' ,headerText : '마이너스적립금', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
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
                   field : 'e1' ,headerText : '적립금', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                },{
                   field : 'e3' ,headerText : '마이너스적립', headerTextAlign : 'center', textAlign: 'right', width:'80',  format: "{0:n0}"
                }
          ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : 'Z2.CHNL_TYPE_CD ,Z2.CHNL_NM',
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


function chnlListPopClose(){
	chnlListPopDialog._destroy();
}

/* 초기화  */
function searchCondInit(){
	setCalendar();
	$("#ofrNm").val("");
	$("#ridOfr").val("");
}

/* 온라인 합계  */
 function currency(args,data){
	return sumobj[args.displayColumn];
} 

/* 오프라인 합계  */
function currency2(args,data){
	return sumobj2[args.displayColumn];
} 

function currency3(args,data){
	return sumobj3[args.displayColumn];
} 


$(document).ready(function() {
	
	setCalendar();
	
	getCustomSummaryOnline(); //온라인 합계
	getCustomSummaryOffline(); //오프라인 합계

	getCustomSummary();
	empAggPntGridList();

	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	
    	empAggPntGridList();
    	getCustomSummaryOnline();  //온라인 합계
    	getCustomSummaryOffline();  //오프라인 합계

    	getCustomSummary();
    });
	
	$("#ofrBtn").click(function(){
		ofrDetailPopup();
	});

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	searchCondInit();
    }); 
    
	//오퍼 조회
	$("#ofrBtn").click(function(){
		ofrDetailPopup();
	});

	//엑셀다운로드
   $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/storeEmpAggPntExcel.do','empAggPntGrid' );
    });
	
	
});
</script>