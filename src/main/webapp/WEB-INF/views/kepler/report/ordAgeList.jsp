<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
    	정형 Report &gt; 연령대별 현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="ordAgeListSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="ordAgeListSearchInit_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>


	</div>
	<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
			<label class="col-xs-1 control-label" id="labelTab">년</label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="year" names="year" dto="year" />
			</div>
			<label class="col-xs-1 control-label" id="labelTab">월</label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="month" names="month" dto="month" />
			</div>
			<label class="col-xs-1 control-label">통합회원유형</label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="checkBox" id="custTypeI" 
					label="개인" labelClass="2" conClass="1"/>
			 	<ifvm:inputNew type="checkBox" id="custTypeC" 
					label="법인" labelClass="2" conClass="1"/>
				<ifvm:inputNew type="checkBox" id="custTypeE" 
					label="임직원" labelClass="2" conClass="1"/>
<%-- 				<ifvm:inputNew type="checkBox" id="custTypeOD" 
					label="기타" labelClass="2" conClass="1"/>	 --%>	
			</div>
			<label class="col-xs-1 control-label" id="chnlTypeTab"> 구분 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="chnlType" names="chnlType" dto="chnlType" />
			</div>
			
			<label class="col-xs-1 control-label" > 매장상태 </label>
			<div class="col-xs-1 control_content">
				<ifvm:inputNew type="select" id="chnlStat" names="chnlStat" dto="chnlStat" />
			</div>
			
		</div>
		
		<div class="row qt_border">
			<label class="col-xs-1 control-label" id="labelTab"><spring:message code="매장" /></label>
			<div class="col-xs-2 control_content">
				<div class="input-group">
					<ifvm:input type="text" disabled="true" maxLength="10" id="chnlNm" />
					<span class="input-group-addon" id="btnChnlListPop"> <a id="chnlListBtn"><i class="fa fa-search"></i></a>
					</span>
					<ifvm:input type="hidden" id="rid"/>
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
            <button class="btn btn-sm" id="excelExportBtn" objCode="ordAgeListExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="ordAgeGrid" class="white_bg grid_bd0"></div>
</div>
<div id="chnlListPopDialog" class="popup_container"></div>

<style type="text/css">
#labelTab{
	width: 5%;
}
#chnlTypeTab{
	width: 6%;
}
</style>
<script type="text/javascript">
var ordAgeGrid;
var sumobj  = {};
var chnl_Type_Rid =null;
var chnl_SubType_Cd =null;

function getOrdAgeList(page){
//     var page = $.fn.ifvmIsNotEmpty(page) ? page : 1;
    
	var ejGridOption = {
           serializeGridData : function(data) {
        	   if($('#month').val()=="ALLMonth"){
        		   data.monthValue="ALL";
        		   data.yyyy = $('#year').val();
        	   }else{
        		   data.monthValue="NOTALL";
        		   data.yyyymm = $('#year').val()+$('#month').val();
        	   }
                data.chnlType = $('#chnlType').val();
                data.chnlStat = $('#chnlStat').val();
                data.custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
                data.custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
                data.custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
     /*            data.custTypeO = $("#custTypeOD").is(':checked') ? 'O' : '';
                data.custTypeD = $("#custTypeOD").is(':checked') ? 'D' : '';   */
                data.rid = $("#rid").val();
                
                return data;
             },
/*           showStackedHeader: true,
          stackedHeaderRows: [{ stackedHeaderColumns: 
         		[
         			{headerText: "전체",textAlign : 'center',column: "allMbrCnt,allOrdCnt,allSellAmt,allDiscntAmt,allSettleAmt,allAvgSalQty,allAvgSettleAmt,allUnitPirce"}
         		  ,	{headerText: "온라인",textAlign : 'center',column: "onMbrCnt,onOrdCnt,onSellAmt,onDiscntAmt, onSettleAmt,onAvgSalQty,onAvgSettleAmt,onUnitPrice"}
         		  ,	{headerText: "오프라인",textAlign : 'center',column: "offMbrCnt,offOrdCnt,offSellAmt,offDiscntAmt, offSettleAmt,offAvgSalQty,offAvgSettleAmt,offUnitPrice"}
         			]
         		}], */
          showSummary: true,
          summaryRows: [{
              title: "전체",
              summaryColumns: [
            		   {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "purMbrCnt",  format: "{0:n0}"}
                     , {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "sellAmt",    format: "{0:n0}"}
                     , {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "discntAmt",  format: "{0:n0}"}
                     , {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "settleAmt",  format: "{0:n0}"}
                     , {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "ordCnt",     format: "{0:n0}"}
                     , {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "avgSettleAmt",format: "{0:n0}"}
                     , {summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "unitPrice", format: "{0:n0}" }
              ]
          }
          ],
          dataUrl : '<ifvm:action name="getOrdAgeList"/>',
          columns:[
          	    {
                   field : 'ageCd' ,headerText : '연령대', headerTextAlign : 'center', textAlign: 'center',width:'80',
                   customAttributes : {
                      index : 'ageCd' , sortable: false}/*  */
                },{
                    field : 'chnlNm' ,headerText : '거래 매장', headerTextAlign : 'center', textAlign: 'center',width:'180',
                    customAttributes : {
                       index : 'chnlNm' , sortable: false}/*  */
                 },{
                    field : 'purMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'purMbrCnt' , sortable: false}/* */
                 },{
                     field : 'sellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                     customAttributes : {
                        index : 'sellAmt' , sortable: false}/* */
                  },{
                    field : 'discntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'discntAmt' , sortable: false}/*   */
                 },{
                    field : 'settleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'settleAmt' , sortable: false}/* */
                 },{
                    field : 'ordCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'ordCnt' , sortable: false}/*  */
                 },{
                    field : 'avgSettleAmt', headerText : '구매단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'avgSettleAmt' , sortable: false}/*  */
                 },{
                    field : 'unitPrice', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'unitPrice' , sortable: false}/* */
                 }
         ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  sidx : '1 desc ,2',
          	  sord : 'asc',
          	  _search : false,
         },
         isHorizontalScroll:true,
         rowNum : 10,
         rowList : [10,20,25,50,100],
         gridDataInit: true,
         radio: false,
         tempId : 'ifvGridSimplePageTemplete2'
      };
      ordAgeGrid = $("#ordAgeGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

//페이지 구하기
// function getGridPage() {
//     var rtnVal = 1;
//     var page = ordAgeGrid.opt.data.page;
//     var total = 16;

//     if (total % page > 0) {
//         rtnVal = page;
//     }
//     return rtnVal;
// }

 function currency(args,data){
	
	return sumobj[args.displayColumn];
	
} 

 //1회 주문당 구매금액 계산 
function getCustomSummary(){
	  sumobj = {};
	   var custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
	   var custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
	   var custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
/* 	   var custTypeO = $("#custTypeOD").is(':checked') ? 'O' : '';
	   var custTypeD = $("#custTypeOD").is(':checked') ? 'D' : ''; */
 	   var monthVal=null;
	   var yyyy=null;
	   var yyyymm=null;
	   if($('#month').val()=="ALLMonth"){
		   monthVal="ALL";
		   yyyy = $('#year').val();
	   }else{
		   monthVal="NOTALL";
		   yyyymm = $('#year').val()+$('#month').val();
	   }
	$.ifvSyncPostJSON('<ifvm:action name="getOrdAgeList2"/>',{
		  monthValue : monthVal,
	      yyyy : yyyy,
	      yyyymm :yyyymm,
          chnlType : $('#chnlType').val(),
          chnlStat :  $('#chnlStat').val(),
          custTypeI : custTypeI,
          custTypeC : custTypeC,
          custTypeE : custTypeE,
          rid : $("#rid").val()
	},
	function(result) {
		sumobj = result.rows[0]; 
	});
	 
 }

//조회조건 set
function commcodeSetting(){
		//년
	   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
		//월
	   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
		//구분
		
		$("#custTypeI").prop('checked',true);
	   $("#month").append("<option value='ALLMonth'>전체</option>")

	   $.fn.ifvmSetSelectOptionCommCode("chnlType", "LOY_CHNL_TYPE_CD", null, null, true);
	   $("#chnlType").append("<option value='ALL'>전체</option>")
	   $("#chnlType").val("ALL");
	   
	   $.fn.ifvmSetSelectOptionCommCode("chnlStat", "LOY_CHNL_STAT_CD", null, null, true);
	   $("#chnlStat").append("<option value='ALL'>전체</option>")
// 	   $("#chnlStat").val("ALL");

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

function chnlListPop(){
	chnl_Type_Rid=$("#rid").val();
	chnl_SubType_Cd = $("#chnlType").val();

	$("#chnlListPopDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="KprChnlListPop"/>',
        contentType: "ajax",
        title: '매장',
        width: 650,
        close : 'chnlListPopClose'
    });
	
}
function chnlListPopClose(){
	
	chnlListPopDialog._destroy();
}

function searchCondInit(){
	
	sysdateSet();
	$("#custTypeI").prop('checked',true);
	$("#custTypeC").prop('checked',false);
	$("#custTypeE").prop('checked',false);
	$("#chnlNm").val("");
	$("#rid").val("");
	$("#chnlType").val("ALL");
	$("#chnlStat").val("ALL");
	
}
$(document).ready(function() {

	commcodeSetting();
	sysdateSet();
	getOrdAgeList();
	
	
	$('#chnlType').find('[value=P]').hide();
	$('#chnlType').find('[value=E]').hide();
	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	getCustomSummary()
//     	getOrdAgeList(getGridPage());
    	getOrdAgeList();
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
      	$.ifvExcelDn('/kepler/report/ordAgeExcelDown.do','ordAgeGrid' );
    });
	
	
});
</script>