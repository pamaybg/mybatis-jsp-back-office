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
    	정형 Report &gt; 임직원적립금거래(사용)
    </h1>
</div>
<%-- 조회조건 영역 --%>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="empAggUsePntSearch_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="empAggUsePntSearchInit_OBJ">
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
            <button class="btn btn-sm" id="excelExportBtn" objCode="empAggUsePntExcel_OBJ">
                <spring:message code="M01218" />
            </button>
        </div> 
    </div>
    <div id="empAggPntGrid" class="white_bg grid_bd0"></div>
   		
 
   
</div>
<div id="chnlListPopDialog" class="popup_container"></div>
  <div id="ofrPop" class="popup_container"></div>




<script type="text/javascript">
var empAggPntGrid;
var txnDetailCd=null;
var offSetFlag =null;
var sumobj = {};

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
            dataUrl : '<ifvm:action name="getEmpAggUsePntReport"/>',
             columns:[
            	 {
                     field : 'txnDt' ,headerText : '일자', headerTextAlign : 'center', textAlign: 'center', width:'110'
                 },{
                     field : 'companyNm' ,headerText : '회사명', headerTextAlign : 'center', textAlign: 'center', width:'80'
                 },{
                     field : 'teamNm' ,headerText : '부서명', headerTextAlign : 'center', textAlign: 'center', width:'90'
                 }, {
                     field : 'empNo' ,headerText : '사번', headerTextAlign : 'center', textAlign: 'center', width:'100'
                 },{
                     field : 'custNm' ,headerText : '이름', headerTextAlign : 'center', textAlign: 'center', width:'80'
                 },{
                     field : 'chnlNm' ,headerText : '채널명', headerTextAlign : 'center', textAlign: 'center', width:'140'
                 },{
                     field : 'rceptNo' ,headerText : '주문(영수증)번호', headerTextAlign : 'center', textAlign: 'center', width:'160'
                 },{
                     field : 'txnDesc' ,headerText : '거래명', headerTextAlign : 'center', textAlign: 'left', width:'300'
                 },{
                     field : 'ofrNm' ,headerText : '오퍼명', headerTextAlign : 'center', textAlign: 'left', width:'200'
                 }, {
                     field : 'txnDtlTypeNm' ,headerText : '거래상세유형', headerTextAlign : 'center', textAlign: 'center', width:'100'
                 }, {
                     field : 'parRceptNo' ,headerText : '원거래영수증', headerTextAlign : 'center', textAlign: 'center', width:'180'
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
	//getCustomSummary();
	empAggPntGridList();
	
	//조회
    $('#reportSearchBtn').on('click', function(){
    	//getCustomSummary();
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
      	$.ifvExcelDn('/kepler/report/empAggUsePntReportExcel.do','empAggPntGrid' );
    });
	 
	
});
</script>