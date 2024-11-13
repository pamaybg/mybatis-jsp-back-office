<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var fraudEmpGrid;
var v_store_cd;
var isFirst ;

//조회조건 값 리턴
function getFraudEmpParams() {
	
	var reqData = {};
	
    if(isFirst) {
		reqData.startDate    = '2999-12-31';
		isFirst = false;
    } else {
    	reqData.startDate    = $('#startDate').val();
    }

    reqData.endDate      = $('#endDate').val();
    reqData.empNm        = $('#empNm').val();
    reqData.startAcrl    = $('#startAcrl').val();
    reqData.endAcrl      = $('#endAcrl').val();
    reqData.startUse     = $('#startUse').val();
    reqData.endUse       = $('#endUse').val();
    reqData.dropInclude  = $.fn.ifvmIsNotEmpty($("#dropInclude").attr("checked")) ?  "Y" : "N";
    
	return reqData;
}

//등급그룹 목록 조회
function getFraudEmp(){
    var ejGridOption = {
          rowSelected : function(args){
          },
          serializeGridData : function(data) {
              if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.itme = requestitem;
               }
              $.extend(data, getFraudEmpParams());
               return data;
           },

        dataUrl : '<ifvm:action name="getFraudEmpList"/>',
        columns:[
        	 {
                 field : 'empNo' ,headerText : '사번', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'empNo' , sortable: false}/*  */
              },{
                 field : 'empNm' ,headerText : '직원명', headerTextAlign : 'center', textAlign: 'left',
                 customAttributes : {
                    index : 'empNm' , sortable: false}/*  */
              },{
                 field : 'chnlNm' ,headerText : '매장 및 부서', headerTextAlign : 'center', textAlign: 'left',
                 customAttributes : {
                    index : 'chnlNm' , sortable: false}/*  */
              },{
                 field : 'empType', headerText : '재직구분', headerTextAlign : 'center', textAlign: 'left',
                 customAttributes : {
                    index : 'empType' , sortable: false}/* */
              },{
                 field : 'dropDate', headerText : '퇴사일자', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'dropDate' , sortable: false}/*   */
              },{
                 field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'mbrNo' , sortable: false}/* */
              },{
                 field : 'acrlPnt', headerText : '적립포인트', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'acrlPnt' , sortable: false}/*  */
              },{
                 field : 'acrlCnt', headerText : '적립횟수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'acrlCnt' , sortable: false}/*  */
              },{
                 field : 'usePnt', headerText : '사용포인트', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'usePnt' , sortable: false}/*  */
              },{
                 field : 'useCnt', headerText : '사용횟수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'useCnt' , sortable: false}/*  */
              }
        ],
//         stackedHeaderRows: [{
//             stackedHeaderColumns:[
//                { headerText: "매출"      , column: "buyMbr, buyCnt, rciptCnt,rciptAmt,salAmt" ,headerTextAlign : "center" },
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

    fraudEmpGrid = $("#fraudEmpGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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

//공통 조회 호출
function reqDataSearch() {
//    var reportSearchObj = $('#reportSearchCondition').getSubmitData();
//    $.fn.ifvmSubmitSearchCondition("reportSearchCondition");
//    getFraudEmp();
	var reqData = {};
	reqData.item = requestitem;
	$.extend(reqData, getFraudEmpParams());
	
	fraudEmpGrid.searchGrid(reqData);
}

//엑셀 다운로드
function excelExport() {
   $.ifvExcelDn('/kepler/report/fraudEmpExport.do','fraudEmpGrid');
}

function setCalendar() {
	 var startDate = $('#startDate');
	 var endDate = $('#endDate');
	 //오늘날짜

	 startDate.val($.ifvGetNewDate('m', -1).newDateS);
	 //오늘부터 한달 뒤
	 endDate.val($.ifvGetTodayDate());

	 //설정
	 startDate.ifvDateChecker({
	  maxDate : endDate
	 });

	 endDate.ifvDateChecker({
	  minDate : startDate
	 });

	 var annDate = $('#eventAnnDate');
	 annDate.val($.ifvGetTodayDate());
	 annDate.ifvDateChecker({});
}


function commcodeSetting(){
   /* $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endyear", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endmonth", "SETTLE_MONTH", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("genCd", "LOY_GEN_CD", null, null, null); */
   /* $("#storeNm").val("");
   $("#storeCd").val(""); */


   /* if($("#ageCd option").length==0){

	   $.ifvSyncPostJSON('<ifvm:action name="getSelectAgeCd"/>', {
	      }, function(result) {
	         $("#ageCd").append("<option value=''></option>")
	         for (var i = 0; i < result.ageList.length; i++) {
	            var ageList = result.ageList;
	             $("#ageCd").append("<option value="+ageList[i].ageCd+">"+ageList[i].ageNm+ "</option>");
	             }
	   });
   }else{
	   $("#ageCd").val("");
   }
 */

   }

   function addrSearchHelpBlur() {
   }
   function addrSearchHelpBtn() {
      searchStorePopInit();
   }
   function addrSearchHelpEnter() {
      searchStorePopInit();
   }
   function searchStorePopInit() {
      $("#searchStorePop").ifvsfPopup({
         enableModal : true,
         enableResize : false,
         contentUrl : '<ifvm:url name="searchStorePop"/>',
         contentType : "ajax",
         title : "매장검색",
         width : '1400px',
         close : 'searchStorePopClose',
      });
   }
   function searchStorePopClose() {
      searchStorePop._destroy();
   }

   /* function sysdateSet(){
	   var d= new Date();
	   var reqYear =String(d.getFullYear());
	   var reqMonth =d.getMonth()+1;
	   reqMonth=reqMonth>=10?reqMonth:'0'+reqMonth;
	   $('#year').val(reqYear);
	   $('#month').val(reqMonth);
	   $('#endyear').val(reqYear)
	   $('#endmonth').val(reqMonth);
	}
 */
	$(document).ready(function() {
		/* commcodeSetting(); */
		setCalendar();
		isFirst =true;
    //현제날짜 세팅
	/* 	sysdateSet(); */
      //전체 그리드 조회
      //전체 그리드 조회
      getFraudEmp();

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
            <button class="btn btn-sm" id="reportSearchBtn" objCode="fraudEmpreportSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button>
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="fraudEmpreportSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button>
        </div>
    </div>
    <div class="form-horizontal underline top_well" id="reportSearchCondition">
       <div class="row qt_border">
            <label class="col-xs-1 control-label">적립 조회 기간</label>
             <div class="col-xs-4 control_content">
               <ifvm:inputNew type="dateTerm"  startId="startDate" startDto="startDate" endId="endDate" endDto="endDate"/>

            </div>

            <label class="col-xs-1 control-label">직원명</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="text"  id="empNm" names="empNm" dto="empNm"/>
            </div>

            <label class="col-xs-1 control-label">
	         	퇴사자 포함</label>
	         <div class="col-xs-1 control_content">
	            <label class="checkbox-inline"> <ifvm:input type="checkbox" id="dropInclude" />
	            </label>
	         </div>
       </div>
       <div class="row qt_border">

            <label class="col-xs-1 control-label">적립금액 범위</label>
             <div class="col-xs-2 control_content">
               <ifvm:inputNew type="number"  id="startAcrl" names="startAcrl" dto="startAcrl"/>
            </div>
			<div class="col-xs-1 swung_dash">~</div>
            <div class="col-xs-2 control_content">
               <ifvm:inputNew type="number"  id="endAcrl" names="endAcrl" dto="endAcrl"/>
            </div>

             <label class="col-xs-1 control-label">사용금액 범위</label>
             <div class="col-xs-2 control_content">
               <ifvm:inputNew type="number"  id="startUse" names="startUse" dto="startUse"/>
            </div>
			<div class="col-xs-1 swung_dash">~</div>
            <div class="col-xs-2 control_content">
               <ifvm:inputNew type="number"  id="endUse" names="endUse" dto="endUse"/>
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
         <ifvm:inputNew type="button"   btnType="download"  text="M01218"  btnFunc="fnIfvExcelDownload('fraudEmpGrid')" objCode="fraudEmpExcel_OBJ"/>
          <%--   <button class="btn btn-sm" id="excelExportBtn" btnFunc="fnIfvExcelDownload2('fraudEmpGrid')">
                <spring:message code="M01218" />
            </button> --%>
        </div>
    </div>
    <div id="fraudEmpGrid" class="white_bg grid_bd0"></div>
</div>
<!-- <div id="searchStorePop" class="popup_container"></div> -->