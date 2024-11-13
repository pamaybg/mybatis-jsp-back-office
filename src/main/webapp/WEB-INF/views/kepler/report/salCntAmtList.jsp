<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var salCntAmtGrid;
var v_store_cd;

//등급그룹 목록 조회
function salCntAmtMbr(){
    var ejGridOption = {
          rowSelected : function(args){
          },
          serializeGridData : function(data) {
              if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.itme = requestitem;
               }
               data.yyyymm =$('#year').val()+$('#month').val();
               data.endyyyymm =$('#endyear').val()+$('#endmonth').val();
               data.storeCd =$('#storeCd').val();
               data.ageCd =$('#ageCd').val();
               data.typeCd=$('#typeCd').val();
               data.genCd =$('#genCd').val();
               return data;
           },
        dataUrl : '<ifvm:action name="salCntAmtList"/>',
        columns:[
        	 {
                 field : 'price' ,headerText : '단가', headerTextAlign : 'center', textAlign: 'center',width : '80px',
                 customAttributes : {
                    index : 'price' , sortable: false}/*  */
              },{
                 field : 'cnt0m' ,headerText : '0회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt0m' , sortable: false}/*  */
              },{
                 field : 'cnt1m' ,headerText : '1회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt1m' , sortable: false}/*  */
              },{
                 field : 'cnt2m' ,headerText : '2회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt2m' , sortable: false}/*  */
              },{
                 field : 'cnt3m', headerText : '3회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt3m' , sortable: false}/* */
              },{
                 field : 'cnt4m', headerText : '4회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt4m' , sortable: false}/*   */
              },{
                 field : 'cnt5m', headerText : '5회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt5m' , sortable: false}/* */
              },{
                 field : 'cnt6m', headerText : '6회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt6m' , sortable: false}/*  */
              },{
                 field : 'cnt7m', headerText : '7회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt7m' , sortable: false}/*  */
              },{
                 field : 'cnt8m', headerText : '8회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt8m' , sortable: false}/*  */
              },{
                 field : 'cnt9m', headerText : '9회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt9m' , sortable: false}/*  */
              },{
                 field : 'cnt10m', headerText : '10회이상', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'cnt10m' , sortable: false}/*  */
              },{
                 field : 'rcit0m' ,headerText : '0회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit0m' , sortable: false}/*  */
              },{
                 field : 'rcit1m' ,headerText : '1회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit1m' , sortable: false}/*  */
              },{
                 field : 'rcit2m' ,headerText : '2회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit2m' , sortable: false}/*  */
              },{
                 field : 'rcit3m', headerText : '3회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit3m' , sortable: false}/* */
              },{
                 field : 'rcit4m', headerText : '4회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit4m' , sortable: false}/*   */
              },{
                 field : 'rcit5m', headerText : '5회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit5m' , sortable: false}/* */
              },{
                 field : 'rcit6m', headerText : '6회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit6m' , sortable: false}/*  */
              },{
                 field : 'rcit7m', headerText : '7회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit7m' , sortable: false}/*  */
              },{
                 field : 'rcit8m', headerText : '8회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit8m' , sortable: false}/*  */
              },{
                 field : 'rcit9m', headerText : '9회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit9m' , sortable: false}/*  */
              },{
                 field : 'rcit10m', headerText : '10회이상', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'rcit10m' , sortable: false}/*  */
              },{
                  field : 'buy0m' ,headerText : '0회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'buy0m' , sortable: false}/*  */
              },{
                  field : 'buy1m' ,headerText : '1회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'buy1m' , sortable: false}/*  */
              },{
                 field : 'buy2m' ,headerText : '2회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'buy2m' , sortable: false}/*  */
              },{
                 field : 'buy3m', headerText : '3회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'buy3m' , sortable: false}/* */
              },{
                 field : 'buy4m', headerText : '4회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'buy4m' , sortable: false}/*   */
              },{
                 field : 'buy5m', headerText : '5회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'buy5m' , sortable: false}/* */
              },{
                 field : 'buy6m', headerText : '6회', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'buy6m' , sortable: false}/*  */
              },{
                 field : 'buy7m', headerText : '7회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'buy7m' , sortable: false}/*  */
              },{
                 field : 'buy8m', headerText : '8회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'buy8m' , sortable: false}/*  */
              },{
                 field : 'buy9m', headerText : '9회', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'buy9m' , sortable: false}/*  */
              },{
                 field : 'buy10m', headerText : '10회이상', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'buy10m' , sortable: false}/*  */
              }
        ],
        stackedHeaderRows: [{
            stackedHeaderColumns:[
               { headerText: "구매횟수"     , column: "cnt0m,cnt1m,cnt2m,cnt3m,cnt4m,cnt5m,cnt6m,cnt7m,cnt8m,cnt9m,cnt10m" ,headerTextAlign : "center" },
               { headerText: "영수증건수"     , column: "rcit0m,rcit1m,rcit2m,rcit3m,rcit4m,rcit5m,rcit6m,rcit7m,rcit8m,rcit9m,rcit10m" ,headerTextAlign : "center" },
               { headerText: "구매금액"     , column: "buy0m,buy1m,buy2m,buy3m,buy4m,buy5m,buy6m,buy7m,buy8m,buy9m,buy10m" ,headerTextAlign : "center" },
            ]
        }],
        actionComplete: function(args){
         $(this.getHeaderContent().find(".e-stackedHeaderCell")[1]).css("text-align", "center");
         $(this.getHeaderContent().find(".e-stackedHeaderCell")[2]).css("text-align", "center");
         $(this.getHeaderContent().find(".e-stackedHeaderCell")[3]).css("text-align", "center");
        },
        requestGridData : {
              nd   : new Date().getTime(),
              rows : 10,
              _search : false
       },
       isHorizontalScroll:true,
       showStackedHeader:true,
       gridDataInit : true,
       allowCellMerging : true,
        tempId : 'ifvOnlyGridTemplate'
    };

    salCntAmtGrid = $("#salCntAmtGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
   salCntAmtMbr();
}

//엑셀 다운로드
function excelExport() {
   $.ifvExcelDn('/kepler/report/salCntAmtListExport.do','salCntAmtGrid');
}

function commcodeSetting(){
   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endyear", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endmonth", "SETTLE_MONTH", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("genCd", "LOY_GEN_CD", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("typeCd", "REPORT_TBL", null, null, true);
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
		commcodeSetting();
    //공통 조회 조건 목록 설정
    //현제날짜 세팅
		sysdateSet();

      //전체 그리드 조회
      salCntAmtMbr();

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
        리포트 &gt;구매횟수,시간대 리포트
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
                 <label class="col-xs-1 control-label">
              단가</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="typeCd" names="typeCd" dto="typeCd"/>
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
    <div id="salCntAmtGrid" class="white_bg grid_bd0"></div>
</div>
<div id="searchStorePop" class="popup_container"></div>