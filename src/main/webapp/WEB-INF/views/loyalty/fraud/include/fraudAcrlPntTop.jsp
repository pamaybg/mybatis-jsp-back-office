<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var fraudEmpGrid;
var v_store_cd;

//등급그룹 목록 조회
function getFraudAcrlPntTop(){
    var ejGridOption = {
          rowSelected : function(args){
          },
          serializeGridData : function(data) {
              if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.itme = requestitem;
               }
              data.yyyymm    = $('#year').val() +""+$('#month').val();

               return data;
           },

        dataUrl : '<ifvm:action name="getFraudAcrlPntTopList"/>',
        columns:[
        	 {
                 field : 'mbrNo' ,headerText : '회원번호', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'mbrNo' , sortable: false}/*  */
              },{
                 field : 'custNm' ,headerText : '회원명', headerTextAlign : 'center', textAlign: 'left',
                 customAttributes : {
                    index : 'custNm' , sortable: false}/*  */
              },{
                 field : 'txnAmt' ,headerText : '구매금액', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'txnAmt' , sortable: false}/*  */
              },{
                 field : 'pntAmt', headerText : '적립포인트', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'pntAmt' , sortable: false}/* */
              },{
                 field : 'acrlCnt', headerText : '적립횟수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'acrlCnt' , sortable: false}/*   */
              }
        ],
//         stackedHeaderRows: [{
//             stackedHeaderColumns:[
//                { headerText: "매출"      , column: "buyMbr, buyPnt, rciptPnt,rciptAmt,salAmt" ,headerTextAlign : "center" },
//                 { headerText: "구매 회원수", column: "membership,sotreMbr,mbrWp"  ,  headerTextAlign : "center" },
//                 { headerText: "포인트"   , column: "usePnt, savePnt, dropPnt"   ,  headerTextAlign : "center" },
//                 { headerText: "적립 포인트"  , column: "basicPnt, evtPnt"              ,  headerTextAlign : "center" },
//             ]
//         }],
//         actionComplete: function(args){
//          $(this.getHeaderContent().find(".e-stackedHeaderCell")[1]).css("text-align", "center");
//            $(this.getHeaderContent().find(".e-stackedHeaderCell")[2]).css("text-align", "center");
//            $(this.getHeaderContent().find(".e-stackedHeaderCell")[3]).css("text-align", "center");
//            $(this.getHeaderContent().find(".e-stackedHeaderCell")[4]).css("text-align", "center");
//         },
        requestGridData : {
              nd   : new Date().getTime(),
              rows : 10,
              _search : false
       },
        showStackedHeader:true,
        gridDataInit : true,
       allowCellMerging : true,
        tempId : 'ifvGridSimplePageTemplete'
    };

    fraudEmpGrid = $("#fraudAcrlPntTopGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회조건 필수값 체크
function validationCheck(table){
   var validationVal =  false;
   $(".SearchCondition .searchTextVal option:selected").filter(function(){
      if($(this).attr('jointgtclm') == table){
         if($(this).parents('.SearchCondition').css("display") !="none"){
            if($.fn.ifvmIsNotEmpty( $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())){
               validationVal = true;
            }
         }
      }
   })
   return validationVal;
}

function setCalendar() {
	 var txnDt = $('#txnDt');

	 txnDt.val($.ifvGetTodayDate());

	 txnDt.ifvDateChecker({
		  maxDate : txnDt
		 });

}

//공통 조회 호출
function reqDataSearch() {
   var reportSearchObj = $('#reportSearchCondition').getSubmitData();
   getFraudAcrlPntTop();
}


function commcodeSetting(){
	$.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
	$.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
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
	//setCalendar();
    //현제날짜 세팅
	sysdateSet();
      //전체 그리드 조회
      //전체 그리드 조회
      getFraudAcrlPntTop();

      //조회
      $('#reportSearchBtn').on('click', function() {
         reqDataSearch();
      });

      //초기화
      $("#reportSearchInitBtn").on('click', function() {
         v_store_cd=null;
         commcodeSetting();
      });

     /*  //엑셀 다운로드
      $("#excelExportBtn").on('click', function() {
         excelExport();
      }); */
   });
</script>


<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="fraudPntreportSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="fraudPntreportSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="form-horizontal underline top_well" id="reportSearchCondition">
       <div class="row qt_border">
            <label class="col-xs-1 control-label">조회년월</label>
                <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="year" names="year" dto="year"/>
            </div>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="month" names="month" dto="month"/>
            </div>


       </div>

   </div>
<!--     <div class="well form-horizontal well_bt5" id="SearchList" > </div>-->
</div>

<div>
    <div class="page_btn_area" id =''>

        <div class="col-xs-7">
            <span><spring:message code="M00277" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
         <ifvm:inputNew type="button"   btnType="download"  text="M01218"  btnFunc="fnIfvExcelDownload('fraudAcrlPntTopGrid')" objCode="fraudPntExcel_OBJ"/>
          <%--   <button class="btn btn-sm" id="excelExportBtn" btnFunc="fnIfvExcelDownload2('fraudEmpGrid')">
          
                <spring:message code="M01218" />
            </button> --%>
        </div>
    </div>
    <div id="fraudAcrlPntTopGrid" class="white_bg grid_bd0"></div>
</div>
<!-- <div id="searchStorePop" class="popup_container"></div> -->