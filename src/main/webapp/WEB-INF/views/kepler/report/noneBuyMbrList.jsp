<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var noneBuyMbrGrid;
var v_store_cd;

//등급그룹 목록 조회
function getNoneBuyMbr(){
    var ejGridOption = {
          rowSelected : function(args){
          },
          serializeGridData : function(data) {
              if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.itme = requestitem;
               }
               data.yyyymm =$('#year').val()+$('#month').val();
               data.endyyyymm =$('#endyear').val()+$('#endmonth').val();
               data.ageCd =$('#ageCd').val();
               data.genCd =$('#genCd').val();
               return data;
           },

        dataUrl : '<ifvm:action name="noneBuyMbr"/>',
        columns:[
        	 {
                 field : 'yyyymm' ,headerText : '조회월', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'yyyymm' , sortable: false}/*  */
              },{
                 field : 'dorCnt' ,headerText : '휴면 회원수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'dorCnt' , sortable: false}/*  */
              },{
                 field : 'mbr23m' ,headerText : '23MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr23m' , sortable: false}/*  */
              },{
                 field : 'mbr22m', headerText : '22MM미구매', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr22m' , sortable: false}/* */
              },{
                 field : 'mbr21m', headerText : '21MM미구매', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr21m' , sortable: false}/*   */
              },{
                 field : 'mbr20m', headerText : '20MM미구매', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr20m' , sortable: false}/* */
              },{
                 field : 'mbr19m', headerText : '19MM미구매', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr19m' , sortable: false}/*  */
              },{
                 field : 'mbr18m', headerText : '18MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr18m' , sortable: false}/*  */
              },{
                 field : 'mbr17m', headerText : '17MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr17m' , sortable: false}/*  */
              },{
                 field : 'mbr16m', headerText : '16MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr16m' , sortable: false}/*  */
              },{
                 field : 'mbr15m', headerText : '15MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr15m' , sortable: false}/*  */
              },{
                 field : 'mbr14m', headerText : '14MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr14m' , sortable: false}/*  */
              },{
                  field : 'mbr13m', headerText : '13MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                  customAttributes : {
                     index : 'mbr13m' , sortable: false}/*  */
              },{
                  field : 'mbr12m', headerText : '12MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                  customAttributes : {
                     index : 'mbr12m' , sortable: false}/*  */
              },{
                  field : 'mbr11m', headerText : '11MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                  customAttributes : {
                     index : 'mbr11m' , sortable: false}/*  */
              },{
                   field : 'mbr10m', headerText : '10MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                   customAttributes : {
                     index : 'mbr10m' , sortable: false}/*  */
              },{
                   field : 'mbr9m', headerText : '9MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                   customAttributes : {
                     index : 'mbr9m' , sortable: false}/*  */
              },{
                   field : 'mbr8m', headerText : '8MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                   customAttributes : {
                     index : 'mbr8m' , sortable: false}/*  */
              },{
                  field : 'mbr7m', headerText : '7MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                  customAttributes : {
                     index : 'mbr7m' , sortable: false}/*  */
              },{
                 field : 'mbr6m', headerText : '6MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr6m' , sortable: false}/*  */
              },{
                  field : 'mbr5m', headerText : '5MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                  customAttributes : {
                     index : 'mbr5m' , sortable: false}/*  */
              },{
                  field : 'mbr4m', headerText : '4MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                  customAttributes : {
                     index : 'mbr4m' , sortable: false}/*  */
              },{
                  field : 'mbr3m', headerText : '3MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                  customAttributes : {
                     index : 'mbr3m' , sortable: false}/*  */
              },{
                 field : 'mbr2m', headerText : '2MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'mbr2m' , sortable: false}/*  */
              },{
                  field : 'mbr1m', headerText : '1MM미구매', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                  customAttributes : {
                     index : 'mbr1m' , sortable: false}/*  */
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
        tempId : 'ifvGridSimplePageTemplete3'
    };

    noneBuyMbrGrid = $("#noneBuyMbrGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
   getNoneBuyMbr();
}

//엑셀 다운로드
function excelExport() {
   $.ifvExcelDn('/kepler/report/noneBuyMbrExport.do','noneBuyMbrGrid');
}

function commcodeSetting(){
   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endyear", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endmonth", "SETTLE_MONTH", null, null, true);
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
	   $('#month').val('01');
	   $('#endyear').val(reqYear)
	   $('#endmonth').val(reqMonth);
	}

	$(document).ready(function() {
		commcodeSetting();
    //현제날짜 세팅
		sysdateSet();
      //전체 그리드 조회
      //전체 그리드 조회
      getNoneBuyMbr();

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
        리포트 &gt; 미구매 고객 분석 리포트
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
            <label class="col-xs-2 control-label">조회시작월</label>
             <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="year" names="year" dto="year"/>
            </div>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="month" names="month" dto="month"/>
            </div>
             <label class="col-xs-1 control-label">조회종료월</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="endyear" names="endyear" dto="endyear"/>
            </div>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="endmonth" names="endmonth" dto="endmonth"/>
            </div>
       </div>
       <div class="row qt_border">
<!--             <label class="col-xs-1 control-label">매장명</label> -->
<!--             <div class="col-xs-1 control_content"> -->
<%--             <ifvm:inputNew type="search" id="storeNm" names="storeNm"  dto="storeNm" btnFunc="addrSearchHelpBtn" searchBlurEvent="addrSearchHelpBlur" --%>
<%--                         searchEnterEvent="addrSearchHelpEnter" /> --%>
<%--             <ifvm:inputNew type="hidden"  id="storeCd" names="storeCd" dto="storeCd" disabled="true" /> --%>
<!--             </div> -->
            <label class="col-xs-2 control-label">성별</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="genCd" names="genCd" dto="genCd"/>
            </div>
            <label class="col-xs-2 control-label">연령별</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="ageCd" names="ageCd" dto="ageCd"/>
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
            <button class="btn btn-sm" id="excelExportBtn">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="noneBuyMbrGrid" class="white_bg grid_bd0"></div>
</div>
<!-- <div id="searchStorePop" class="popup_container"></div> -->