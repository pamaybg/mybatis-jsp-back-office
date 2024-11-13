<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 통합회원 유형별 실적현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="mbrPerformanceSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="mbrPerformanceSearchInit_OBJ">
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
			<%-- 	<ifvm:inputNew type="checkBox" id="custTypeOD" 
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
            <button class="btn btn-sm" id="excelExportBtn" objCode="mbrPerformanceExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="mbrPerformGrid" class="white_bg grid_bd0"></div>
    
    <div class="page_btn_area" >
   		<div class="col-xs-7">
		 <span>용어설명</span>
    	</div>
    </div>
<textarea id="desc" class = "descript" maxlength="100" rows="8" readonly = true>
• 첫구매회원 : 통합회원 중 가입 후 첫 구매한 회원 또는 1년동안 구매이력이 없다가 기준일자에 첫구매한 회원
• 활성구매회원 : 통합회원 중 직전 3개월 내 구매이력이 있는 회원
• 일자 : 결제완료 일자
• 구매회원수 : 결제완료를 한 통합 회원의 수
• 구매건수 Or 영수증건수 : 결제완료된 온라인 구매건수 Or 오프라인의 영수증 건수
• 객단가 : 실결제금액/구매회원수
</textarea>
    
</div>
<div id="chnlListPopDialog" class="popup_container"></div>

<style type="text/css">
.descript{
	width : 98%;
	font-size: 13px;
	box-sizing: border-box;
	margin: 10px;
	padding: 10px;

}

#labelTab{
	width: 5%;
}
#chnlTypeTab{
	width: 6%;
}
</style>


<script type="text/javascript">
var mbrPerformGrid;
var chnl_Type_Rid =null;
var chnl_SubType_Cd =null;

var sumobj = {};

function getMbrPerformList(){
    var ejGridOption = {
           serializeGridData : function(data) {
        	   if($('#month').val()=="ALLMonth"){
        		   data.monthValue="ALL";
        		   data.yyyy = $('#year').val();
        	   }else{
        		   data.monthValue="NOTALL";
        		   data.yyyymm = $('#year').val()+$('#month').val();
        	   }
                data.yyyymm = $('#year').val()+$('#month').val();
                data.chnlType = $('#chnlType').val();
                data.chnlStat = $('#chnlStat').val();
                data.custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
                data.custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
                data.custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
          /*       data.custTypeO = $("#custTypeOD").is(':checked') ? 'O' : '';
                data.custTypeD = $("#custTypeOD").is(':checked') ? 'D' : '';     */
                data.rid = $("#rid").val();
                return data;
             },
          showStackedHeader: true,
          stackedHeaderRows: [{ stackedHeaderColumns: 
         		[
         			{headerText: "첫구매회원",textAlign : 'center',column: "newMbrCnt,newSellAmt,newDiscntAmt,newSettleAmt,newOrdCnt,newAvgOrdVal"},
         			{headerText: "활성구매회원",textAlign : 'center',column: "existMbrCnt,existSellAmt,existDiscntAmt,existSettleAmt,existOrdCnt,existAvgOrdVal"},
         			/* {headerText: "Laped",textAlign : 'center',column: "lapedMbrCnt,lapedSellAmt,lapedDiscntAmt,lapedSettleAmt,lapedOrdCnt,lapedAvgOrdVal"},
         			{headerText: "Gone-Away",textAlign : 'center',column: "gawayMbrCnt,gawaySellAmt,gawayDiscntAmt,gawaySettleAmt,gawayOrdCnt,gawayAvgOrdVal"} */
         			]
         		}],
          showSummary: true,
          summaryRows: [{
              title: "월 합계",
              summaryColumns: [
            	  {summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "newMbrCnt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "newSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "newDiscntAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "newSettleAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "newOrdCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "newAvgOrdVal", format: "{0:n0}" }
                 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "existMbrCnt",  format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "existSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "existDiscntAmt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "existSettleAmt",  format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "existOrdCnt",  format: "{0:n0}"}
              	 ,{summaryType: ej.Grid.SummaryType.Custom,  customSummaryValue: currency , displayColumn: "existAvgOrdVal", format: "{0:n0}" }
                  	/*  ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "lapedMbrCnt", dataMember: "lapedMbrCnt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "lapedSellAmt",dataMember: "lapedSellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "lapedDiscntAmt", dataMember: "lapedDiscntAmt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "lapedSettleAmt", dataMember: "lapedSettleAmt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "lapedOrdCnt", dataMember: "lapedOrdCnt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "lapedAvgOrdVal", dataMember: "lapedAvgOrdVal", format: "{0:n0}" }
              
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "gawayMbrCnt", dataMember: "gawayMbrCnt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "gawaySellAmt",dataMember: "gawaySellAmt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "gawayDiscntAmt", dataMember: "gawayDiscntAmt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "gawaySettleAmt", dataMember: "gawaySettleAmt", format: "{0:n0}" }
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "gawayOrdCnt", dataMember: "gawayOrdCnt", format: "{0:n0}"}
            	 ,{summaryType: ej.Grid.SummaryType.Sum, displayColumn: "gawayAvgOrdVal", dataMember: "gawayAvgOrdVal", format: "{0:n0}" } */
              
              ]
          }
          ],
          dataUrl : '<ifvm:action name="getMbrPerformList"/>',
          
          columns:[
          	    {
                   field : 'yyyymmdd' ,headerText : '일자', headerTextAlign : 'center', textAlign: 'center', width:'80',
                   customAttributes : {
                      index : 'yyyymmdd' , sortable: false}/*  */
                },{
                   field : 'chnlNm' ,headerText : '거래 매장', headerTextAlign : 'center', textAlign: 'center', width:'80',width:'240',
                   customAttributes : {
                      index : 'chnlNm' , sortable: false}/*  */
                },{
                   field : 'newMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'newMbrCnt' , sortable: false}/* */
                },{
                   field : 'newSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'newSellAmt' , sortable: false}/*   */
                },{
                   field : 'newDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'newDiscntAmt' , sortable: false}/* */
                },{
                   field : 'newSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'newSettleAmt' , sortable: false}/*  */
                },{
                   field : 'newOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'newOrdCnt' , sortable: false}/*  */
                },{
                    field : 'newAvgOrdVal', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'newAvgOrdVal' , sortable: false}/*  */
                },{
                    field : 'existMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                    customAttributes : {
                       index : 'existMbrCnt' , sortable: false}/* */
                },{
                   field : 'existSellAmt', headerText : '판매금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'existSellAmt' , sortable: false}/*   */
                },{
                   field : 'existDiscntAmt', headerText : '할인금액', headerTextAlign : 'center', textAlign: 'right',  format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'existDiscntAmt' , sortable: false}/* */
                },{
                   field : 'existSettleAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width:'80',
                   customAttributes : {
                      index : 'existSettleAmt' , sortable: false}/*  */
                },{
                   field : 'existOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                   customAttributes : {
                      index : 'existOrdCnt' , sortable: false}/*  */
                },{
                    field : 'existAvgOrdVal', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'existAvgOrdVal' , sortable: false}/*  */
                }
          ],
          requestGridData : {
          	  nd   : new Date().getTime(),
          	  rows : 10,
          	  sidx : '1 desc ,2',
          	  sord : 'asc',
          	  _search : false,
         },
         isHorizontalScroll:true,
         rowList : [10,25,50,100],
         gridDataInit: true,
         radio: false,
         tempId : 'ifvGridSimplePageTemplete2'
      };
      mbrPerformGrid = $("#mbrPerformGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}


//조회조건 set
function commcodeSetting(){
		//년
	   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
		//월
	   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
		//구분
	   $("#month").append("<option value='ALLMonth'>전체</option>")

		$("#custTypeI").prop('checked',true);
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
	$("#custTypeI").prop('checked',false);
	$("#custTypeC").prop('checked',false);
	$("#custTypeE").prop('checked',false);
	//$("#custTypeOD").prop('checked',false);
	$("#chnlNm").val("");
	$("#rid").val("");
	$("#chnlType").val("ALL");
	$("#chnlStat").val("ALL");
	
}

 function currency(args,data){
	
	return sumobj[args.displayColumn];
	
} 
// SUMMARY CUSTOM 계산 
function getCustomSummary(){
	  sumobj = {};
	   var custTypeI = $("#custTypeI").is(':checked') ? 'I' : '';
	   var custTypeC = $("#custTypeC").is(':checked') ? 'C' : '';
	   var custTypeE = $("#custTypeE").is(':checked') ? 'E' : '';
	   
/* 	   var custTypeO = $("#custTypeOD").is(':checked') ? 'O' : '';
	   var custTypeD = $("#custTypeOD").is(':checked') ? 'D' : '';   */

	$.ifvSyncPostJSON('<ifvm:action name="getMbrPerformList2"/>',{
		  yyyymm : $('#year').val()+$('#month').val(),
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

function currency(args,data){
	return sumobj[args.displayColumn];
} 

$(document).ready(function() {
	
	commcodeSetting();
	sysdateSet();
	getMbrPerformList();
	
	
	$('#chnlType').find('[value=P]').hide();
	$('#chnlType').find('[value=E]').hide();
	//조회
    $('#reportSearchBtn').on('click', function(){
    	getMbrPerformList();
    	getCustomSummary();
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
      	$.ifvExcelDn('/kepler/report/mbrPerformExelDown.do','mbrPerformGrid' );
    });
	
	
});
</script>