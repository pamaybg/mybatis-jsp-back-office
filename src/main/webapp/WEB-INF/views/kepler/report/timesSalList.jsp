<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var timesSalGrid;
var v_store_cd;

//등급그룹 목록 조회
function getTimesSal(){
    var ejGridOption = {
          rowSelected : function(args){
          },
          serializeGridData : function(data) {
              if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.itme = requestitem;
               }
               data.storeCd =$('#storeCd').val();
               data.ageCd =$('#ageCd').val();
               data.yyyymm =$('#year').val()+$('#month').val();
               data.genCd =$('#genCd').val();
               return data;
           },
        dataUrl : '<ifvm:action name="timesSalList"/>',
        columns:[
             {
                 field : 'times' ,headerText : '시간', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',
                 customAttributes : {
                    index : 'times' , sortable: false}/*  */
              },{
                 field : 'buyMbr' ,headerText : '구매회원수', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',
                 customAttributes : {
                    index : 'buyMbr' , sortable: false}/*  */
              },{
                 field : 'rciptCnt', headerText : '영수증 건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'rciptCnt' , sortable: false}/*   */
              },{
                 field : 'rciptAmt', headerText : '영수증 건단가', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'rciptAmt' , sortable: false}/* */
              },{
                 field : 'salAmt', headerText : '매출 금액', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'salAmt' , sortable: false}/*  */
              },{
                 field : 'usePnt', headerText : '사용포인트', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'usePnt' , sortable: false}/*  */
              },{
                 field : 'savePnt', headerText : '적립포인트', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'savePnt' , sortable: false}/*  */
              },{
                 field : 'basicPnt', headerText : '기본포인트', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'basicPnt' , sortable: false}/*  */
              },{
                 field : 'evtPnt', headerText : '이벤트포인트', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'evtPnt' , sortable: false}/*  */
              }
        ],
        stackedHeaderRows: [{
            stackedHeaderColumns:[
                { headerText: "매출"    , column: "buyMbr, rciptCnt,rciptAmt,salAmt" ,headerTextAlign : "center" },
                { headerText: "포인트"  , column: "usePnt,savePnt" ,  headerTextAlign : "center" },
                { headerText: "적립포인트" , column: "basicPnt, evtPnt"              ,  headerTextAlign : "center" },
            ]
        }],
        actionComplete: function(args){
           $(this.getHeaderContent().find(".e-stackedHeaderCell")[1]).css("text-align", "center");
           $(this.getHeaderContent().find(".e-stackedHeaderCell")[2]).css("text-align", "center");
           $(this.getHeaderContent().find(".e-stackedHeaderCell")[3]).css("text-align", "center");
        },
        requestGridData : {
              nd   : new Date().getTime(),
              rows : 10000,
              _search : false
       },
        showStackedHeader:true,
        gridDataInit : true,
       allowCellMerging : true,
        tempId : 'ifvGridSimplePageTemplete3'
    };

    timesSalGrid = $("#timesSalGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
   var reportSearchObj = $('#reportSearchCondition').getSubmitData();
   getTimesSal();
}

//엑셀 다운로드
function excelExport() {
   $.ifvExcelDn('/kepler/report/timesSalListExport.do','timesSalGrid');
}

function commcodeSetting(){
   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("genCd", "LOY_GEN_CD", null, null, true);
   $("#storeNm").val("");
   $("#storeCd").val("");
   if($("#ageCd option").length==0){

	   $.ifvSyncPostJSON('<ifvm:action name="getSelectAgeCd"/>', {
	      }, function(result) {
	         $("#ageCd").append("<option value=''>전체</option>")
	         for (var i = 0; i < result.ageList.length; i++) {
	            var ageList = result.ageList;
	             $("#ageCd").append("<option value="+ageList[i].ageCd+">"+ageList[i].ageNm+ "</option>");
	             }
	   });
   }else{
	   $("#ageCd").val("");
   }


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

   function sysdateSet(){
	   var d= new Date();
	   var reqYear =String(d.getFullYear());
	   var reqMonth =d.getMonth()+1;
	   reqMonth=reqMonth>=10?reqMonth:'0'+reqMonth;
	   $('#year').val(reqYear);
	   $('#month').val(reqMonth);
   }
   $(document).ready(function() {
	  //공통 조회 조건 목록 설정
	  commcodeSetting();
	  //현제날짜 세팅
	  sysdateSet();
      //전체 그리드 조회
      getTimesSal();

      //조회
      $('#reportSearchBtn').on('click', function() {
         reqDataSearch();
      });

      //초기화
      $("#reportSearchInitBtn").on('click', function() {
         v_store_cd=null;
         commcodeSetting();
      });

      //엑셀 다운로드
      $("#excelExportBtn").on('click', function() {
         excelExport();
      });
   });
</script>

<div class="page-title">
    <h1>
        리포트 &gt; 시간대 매출 리포트</span>
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
            <label class="col-xs-1 control-label">
            매장명</label>
            <div class="col-xs-1 control_content">
            <ifvm:inputNew type="search" id="storeNm" names="storeNm"  dto="storeNm" btnFunc="addrSearchHelpBtn" searchBlurEvent="addrSearchHelpBlur"
                        searchEnterEvent="addrSearchHelpEnter" />
            <ifvm:inputNew type="hidden"  id="storeCd" names="storeCd" dto="storeCd" disabled="true" />
            </div>
            <label class="col-xs-1 control-label">
            성별</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="genCd" names="genCd" dto="genCd"/>
            </div>
            <label class="col-xs-1 control-label">
            연령별</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="ageCd" names="ageCd" dto="ageCd"/>
            </div>
      </div>
   </div>
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
    <div id="timesSalGrid" class="white_bg grid_bd0"></div>
</div>
<div id="searchStorePop" class="popup_container"></div>