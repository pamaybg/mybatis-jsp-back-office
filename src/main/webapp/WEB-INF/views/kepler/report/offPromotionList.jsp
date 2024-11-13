<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 오프라인 프로모션 매출 현황
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="offPromotionSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="offPromotionSearchInit_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>


	</div>
	<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
		  <label class="col-xs-1 control-label"> 일자 </label>
			<ifvm:inputNew type="date" id="sellDate1" conClass="2" />
			<div style="float: left"> ~ </div>
			<ifvm:inputNew type="date" id="sellDate2" conClass="2" />
			
		</div>
		<div class="row qt_border">
		  <label class="col-xs-1 control-label"> 채널명</label>
		  <div class="col-xs-2 control_content">
			<ifvm:inputNew type="select" id="chnlType" names ="chnlType" dto = "chnlType"/>
		  </div>  
		  <label class="col-xs-1 control-label"><spring:message code="매장명" /></label>
		  <div class="col-xs-2 control_content">
			<div class="input-group">
			  <ifvm:input type="text" disabled="true" maxLength="10" id="chnlNm" />
				<span class="input-group-addon" id="btnChnlListPop"> <a id="chnlListBtn"><i class="fa fa-search"></i></a>
				</span>
			  <ifvm:input type="hidden" id="rid"/>
			</div>
		  </div>
		  <label class="col-xs-1 control-label"><spring:message code="프로모션명" /></label>
		  <div class="col-xs-2 control_content">
			 <div class="input-group">
					<ifvm:input type="text" disabled="true" maxLength="10" id="promNm" />
					<span class="input-group-addon" id="btnPromListPop"> <a id="promListBtn"><i class="fa fa-search"></i></a>
					</span>
					<ifvm:input type="hidden" id="ridProm"/>
				</div>
			</div>
		</div>
	</div>
</div>

<%-- 그리드 영역 --%>
<div class ="well">
    <div class="page_btn_area" >

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="excelExportBtn" objCode="offPromotionExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="offPromListGrid" class="white_bg grid_bd0"></div>
</div>
    
<div id="chnlListPopDialog" class="popup_container"></div>
<div id="promListPopDialog" class="popup_container"></div>
   
   
<script type="text/javascript">
var offPromListGrid;
var chnl_SubType_Cd =null;
var chnl_Type_Rid =null;
var sumobj = {};

function getCustomSummary(){
	  sumobj = {};
	$.ifvSyncPostJSON('<ifvm:action name="getOffPromList2"/>',{
  		sellDate1 : $('#sellDate1').val(),
   		sellDate2 : $('#sellDate2').val(),
   	    rid : $("#rid").val(),
        ridProm : $('#ridProm').val(),
        chnlType : $('#chnlType').val()
	},
	function(result) {
		sumobj = result.rows[0]; 
});
	}

function currency(args,data){
	return sumobj[args.displayColumn];
} 
function getOffPromList(){
    var ejGridOption = {
           serializeGridData : function(data) {
       	   		data.sellDate1 = $('#sellDate1').val();
    	   		data.sellDate2 = $('#sellDate2').val();
    	   	
                data.rid = $("#rid").val();
                data.ridProm = $('#ridProm').val();
                
                data.chnlType = $('#chnlType').val();
                
                return data;
             },  showStackedHeader: true,
             stackedHeaderRows: [
           	  
         	    {
         	  	  stackedHeaderColumns: 
          		[   
          			{headerText: "영수건수", textAlign : 'center',column: "allOrdCnt,intgOrdCnt,m2OrdCnt"}
          			]
          		},
          		],
          showSummary: true,
          summaryRows: [{
              title: "합계",
              summaryColumns: [
	             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "allOrdCnt",  format: "{0:n0}"},
	             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "intgOrdCnt",  format: "{0:n0}"},
	             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "m2OrdCnt",  format: "{0:n0}"},
	             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "totSaleAmt",  format: "{0:n0}"},
	             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "saleAmt",  format: "{0:n0}"},
	             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "ordCnt",  format: "{0:n0}"}
              ]
          }],
          dataUrl : '<ifvm:action name="getOffPromList"/>',
          columns:[
        	    {
                  field : 'chnlType' ,headerText : '채널명', headerTextAlign : 'center', textAlign: 'center',width:'80',
                  customAttributes : {
                     index : 'chnlType' , sortable: false}/*  */
               },{
                   field : 'chnlNm' ,headerText : '매장명', headerTextAlign : 'center', textAlign: 'center',width:'80',
                   customAttributes : {
                      index : 'chnlNm' , sortable: false}/*  */
                },{
                   field : 'promNm', headerText : '프로모션명', headerTextAlign : 'center', textAlign: 'center', width:'80',
                   customAttributes : {
                      index : 'promNm' , sortable: false}/* */
                },{
                   field : 'promDate', headerText : '일자', headerTextAlign : 'center', textAlign: 'center', width:'80',
                   customAttributes : {
                      index : 'promDate' , sortable: false}/*   */
                },{
                    field : 'prodId', headerText : '상품코드', headerTextAlign : 'center', textAlign: 'center', width:'80',
                    customAttributes : {
                       index : 'prodId' , sortable: false}/*   */
                 },{
                     field : 'prodNm', headerText : '상품명', headerTextAlign : 'center', textAlign: 'center', width:'80',
                     customAttributes : {
                        index : 'prodNm' , sortable: false}/*   */
                  },{
                   field : 'ctgLNm', headerText : '대분류', headerTextAlign : 'center', textAlign: 'center',  width:'80',
                   customAttributes : {
                      index : 'ctgLNm' , sortable: false}/* */
                },{
                   field : 'ctgMNm', headerText : '중분류', headerTextAlign : 'center', textAlign: 'center', width:'80',
                   customAttributes : {
                      index : 'ctgMNm' , sortable: false}/*  */
                },{
                   field : 'ctgSNm', headerText : '소분류', headerTextAlign : 'center', textAlign: 'center',  width:'80',
                   customAttributes : {
                      index : 'ctgSNm' , sortable: false}/*  */
                },{
                    field : 'allOrdCnt', headerText : '전체', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width:'80',
                    customAttributes : {
                       index : 'allOrdCnt' , sortable: false}/*  */
                },{
                     field : 'intgOrdCnt', headerText : '통합회원', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',  width:'80',
                     customAttributes : {
                        index : 'intgOrdCnt' , sortable: false}/*  */
                },{
                    field : 'm2OrdCnt', headerText : '미전환회원 ', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',  width:'80',
                    customAttributes : {
                       index : 'm2OrdCnt' , sortable: false}/*  */
                },{
                   field : 'totSaleAmt', headerText : '총매출액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',  width:'80',
                   customAttributes : {
                      index : 'totSaleAmt' , sortable: false}/*  */
                },{
                    field : 'saleAmt', headerText : '순매출액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',  width:'80',
                    customAttributes : {
                       index : 'saleAmt' , sortable: false}/*  */
                 },{
                     field : 'ordCnt', headerText : '수량', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',  width:'80',
                     customAttributes : {
                        index : 'ordCnt' , sortable: false}/*  */
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
      offPromListGrid = $("#offPromListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
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

function promListPop(){
	$("#promListPopDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="KprPromListPop"/>',
        contentType: "ajax",
        title: '프로모션',
        width: 650,
        close : 'promListPopClose'
    });
	
}
function promListPopClose(){
	
	promListPopDialog._destroy();
}


function searchCondInit(){
	
	var date01 = $('#sellDate1');
	var date02 = $('#sellDate2');
	date01.val($.ifvGetTodayDate());
	date02.val($.ifvGetTodayDate());
	
	$("#chnlNm").val("");
	$("#rid").val("");
	$("#promNm").val("");
	$("#ridProm").val("");
	$("#chnlType").val("ALL");
	
}

function setDatePicker() {
	
	var date1 = $('#sellDate1');
	var date2 = $('#sellDate2');
	date1.val($.ifvGetTodayDate());
	date2.val($.ifvGetTodayDate());
	date1.ifvDateChecker({});
	date2.ifvDateChecker({});
}

//조회조건 set
function commcodeSetting(){
	  
	$("#chnlType").append("<option value='ALL'>전체</option>")
	$("#chnlType").append("<option value='S1'>직영</option>")
	$("#chnlType").append("<option value='S2'>가맹</option>")
	$("#chnlType").val("ALL");
}



$(document).ready(function() {
	
	setDatePicker();
	getOffPromList();
	getCustomSummary();
	commcodeSetting();
	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	getOffPromList();
    	getCustomSummary();
    });

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	searchCondInit();
    }); 
    
    
    $('#btnChnlListPop').on('click',function(){
    	chnlListPop();
    });
    
    
    $('#btnPromListPop').on('click',function(){
    	promListPop();
    });
    
    
	//엑셀다운로드
    $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/offPromExcelDown.do','offPromListGrid' );
    });
	
	
});
</script>