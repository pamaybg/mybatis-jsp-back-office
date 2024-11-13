<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<div class="page-title">
    <h1>
    	정형 Report &gt; 캠페인 결과
    </h1>
</div>

<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="campaignTotalSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="campaignTotalSearchInit_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>


	</div>
	<div class="form-horizontal underline top_well"	id="reportSearchCondition">
		<div class="row qt_border">
		<label class="col-xs-1 control-label"> 캠페인 시작일자 </label>
		<ifvm:inputNew type="date" id="camSdate" conClass="2" />
		<div style="float: left"> ~ </div>
		<ifvm:inputNew type="date" id="camSdate2" conClass="2" />
    	<label class="col-xs-1 control-label"><spring:message code="캠페인명" /></label>
		<div class="col-xs-3 control_content">
			<div class="input-group">
				<ifvm:input type="text" disabled="true" maxLength="20" id="camNm"/>
				<span class="input-group-addon" id="btnCamListPop"> <a id="camListBtn"><i class="fa fa-search"></i></a>
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
            <button class="btn btn-sm" id="excelExportBtn" objCode="campaignTotalExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="camTotListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="camListPopDialog" class="popup_container"></div>

<script type="text/javascript">
var camTotListGrid;
var sumobj = {};
function getCustomSummary(){
	  sumobj = {};
	$.ifvSyncPostJSON('<ifvm:action name="getCamTotList2"/>',{
		camSdate : $('#camSdate').val(),
        camSdate2 : $('#camSdate2').val(),
        rid : $("#rid").val()
	},
	function(result) {
		sumobj = result.rows[0]; 
});
	}

function currency(args,data){
	return sumobj[args.displayColumn];
} 
function getCamTotList(){
    var ejGridOption = {
           serializeGridData : function(data) {
                data.camSdate = $('#camSdate').val();
                data.camSdate2 = $('#camSdate2').val();
                data.rid = $("#rid").val();
                return data;
             },
          showStackedHeader: true,
          stackedHeaderRows: [{ stackedHeaderColumns: 
         		[
         			{headerText: "매출고객(타겟)",textAlign : 'center',column: "tsalMbrCnt,tsalVisitRate,tsalMbrAmt,tsalOrdCnt,tsalPerAmt"}
         		   ,{headerText: "매출고객(대조군)",textAlign : 'center',column: "csalMbrCnt,csalVisitRate,csalMbrAmt,csalOrdCnt,csalPerAmt"}
         		   ,{headerText: "쿠폰사용고객",textAlign : 'center',column: "cpnMbrCnt,cpnUseRate,cpnMbrAmt,cpnOrdCnt,cpnPerAmt"}
         			]
         		}], 
     	  showSummary: true,
	          summaryRows: [{
	              title: "합계",
	              summaryColumns: [
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "trgtCnt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "ctrlCnt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "sendCnt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "sendScssCnt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "tsalOrdCnt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "csalOrdCnt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "cpnOrdCnt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "tsalMbrAmt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "csalMbrAmt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "cpnMbrAmt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "tsalMbrCnt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "tsalVisitRate",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "tsalPerAmt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "csalMbrCnt",  format: "{0:n0}"},
		             	{summaryType: ej.Grid.SummaryType.Custom, customSummaryValue: currency, displayColumn: "cpnMbrCnt",  format: "{0:n0}"},

		             	
		             	]
	          }], 
		             	dataUrl : '<ifvm:action name="getCamTotList"/>',
          columns:[
          	    {
                   field : 'yyyy' ,headerText : '연도', headerTextAlign : 'center', textAlign: 'center',width : '80',
                   customAttributes : {
                      index : 'yyyy' , sortable: false}/*  */
                },{
                   field : 'camExeSeq' ,headerText : '실행차수', headerTextAlign : 'center', textAlign: 'center', width : '80',
                   customAttributes : {
                      index : 'camExeSeq' , sortable: false}/*  */
                },{
                   field : 'week', headerText : '주차', headerTextAlign : 'center', textAlign: 'center', width : '80',
                   customAttributes : {
                      index : 'week' , sortable: false}/* */
                },{
                    field : 'camOrgNm', headerText : '발송팀', headerTextAlign : 'center', textAlign: 'center', width : '80',
                    customAttributes : {
                       index : 'camOrgNm' , sortable: false}/* */
                 },{
                   field : 'camChnlCd', headerText : '발송 채널', headerTextAlign : 'center', textAlign: 'center', width : '80',
                   customAttributes : {
                      index : 'camChnlCd' , sortable: false}/*   */
                },{
                   field : 'camNo', headerText : '캠페인 번호', headerTextAlign : 'center', textAlign: 'center', width : '100',
                   customAttributes : {
                      index : 'camNo' , sortable: false}/* */
                },{
                   field : 'camNm', headerText : '캠페인명', headerTextAlign : 'center', textAlign: 'center', width : '120',
                   customAttributes : {
                      index : 'camNm' , sortable: false}/*  */
                },{
                   field : 'camSdate', headerText : '시작일자', headerTextAlign : 'center', textAlign: 'center', width : '80',
                   customAttributes : {
                      index : 'camSdate' , sortable: false}/*  */
                },{
                    field : 'camEdate', headerText : '종료일자', headerTextAlign : 'center', textAlign: 'center', width : '80',
                    customAttributes : {
                       index : 'camEdate' , sortable: false}/*  */
                },{
                     field : 'trgtCnt', headerText : '타겟수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                     customAttributes : {
                        index : 'trgtCnt' , sortable: false}/*  */
                },{
                    field : 'ctrlCnt', headerText : '대조군수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                    customAttributes : {
                       index : 'ctrlCnt' , sortable: false}/*  */
               },{
                   field : 'sendCnt', headerText : '발송수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                   customAttributes : {
                      index : 'sendCnt' , sortable: false}/*  */
               },{
                  field : 'sendScssCnt', headerText : '발송성공수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                  customAttributes : {
                     index : 'sendScssCnt' , sortable: false}/*  */
               },{
                 field : 'tsalMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                 customAttributes : {
                    index : 'tsalMbrCnt' , sortable: false}/*  */
               },{
                   field : 'tsalVisitRate', headerText : '구매반응율(%)', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}%', width : '80',
                   customAttributes : {
                      index : 'tsalVisitRate' , sortable: false}/*  */
               },{
                   field : 'tsalMbrAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                   customAttributes : {
                      index : 'tsalMbrAmt' , sortable: false}/*  */
               },{
                   field : 'tsalOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                   customAttributes : {
                      index : 'tsalOrdCnt' , sortable: false}/*  */
               },{
                   field : 'tsalPerAmt', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                   customAttributes : {
                      index : 'tsalPerAmt' , sortable: false}/*  */
               },{
                   field : 'csalMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                  customAttributes : {
                     index : 'csalMbrCnt' , sortable: false}/*  */
                },{
                    field : 'csalVisitRate', headerText : '구매반응율(%)', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}%', width : '80',
                    customAttributes : {
                       index : 'csalVisitRate' , sortable: false}/*  */
                },{
                    field : 'csalMbrAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                    customAttributes : {
                       index : 'csalMbrAmt' , sortable: false}/*  */
                },{
                    field : 'csalOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                    customAttributes : {
                       index : 'csalOrdCnt' , sortable: false}/*  */
                },{
                    field : 'csalPerAmt', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                    customAttributes : {
                       index : 'csalPerAmt' , sortable: false}/*  */
                },{
                   field : 'cpnMbrCnt', headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                   customAttributes : {
                      index : 'cpnMbrCnt' , sortable: false}/*  */
                 },{
                     field : 'cpnUseRate', headerText : '쿠폰사용율(%)', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}%', width : '80',
                     customAttributes : {
                        index : 'cpnUseRate' , sortable: false}/*  */
                 },{
                     field : 'cpnMbrAmt', headerText : '실결제금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                     customAttributes : {
                        index : 'cpnMbrAmt' , sortable: false}/*  */
                 },{
                     field : 'cpnOrdCnt', headerText : '구매건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                     customAttributes : {
                        index : 'cpnOrdCnt' , sortable: false}/*  */
                 },{
                     field : 'cpnPerAmt', headerText : '객단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}', width : '80',
                     customAttributes : {
                        index : 'cpnPerAmt' , sortable: false}/*  */
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
      camTotListGrid = $("#camTotListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	
}

function camlListPop(){
	$("#camListPopDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="KprCamListPop"/>',
        contentType: "ajax",
        title: '캠페인 목록',
        width: 650,
        close : 'chnlListPopClose'
    });
	
}
function camListPopClose(){
	
	camListPopDialog._destroy();
}

function searchCondInit(){
	
	var date01 = $('#camSdate');
	var date02 = $('#camSdate2');
	date01.val($.ifvGetTodayDate());
	date02.val($.ifvGetTodayDate());
	
	$("#camNm").val("");
	$("#rid").val("");
	
}


function setDatePicker() {
	var date1 = $('#camSdate');
	var date2 = $('#camSdate2');
	date1.val($.ifvGetTodayDate());
	date2.val($.ifvGetTodayDate());
	date1.ifvDateChecker({});
	date2.ifvDateChecker({});
}


$(document).ready(function() {
	setDatePicker();
	getCamTotList();

	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	getCamTotList();
    	getCustomSummary();
    });

    //초기화
    $("#reportSearchInitBtn").on('click', function(){
    	searchCondInit();
    }); 
    
    
    $('#btnCamListPop').on('click',function(){
    	camlListPop();
    });
    
    
	//엑셀다운로드
    $("#excelExportBtn").on('click', function() {
      	$.ifvExcelDn('/kepler/report/camTotExcelDown.do','camTotListGrid' );
    });
	
	
});
</script>