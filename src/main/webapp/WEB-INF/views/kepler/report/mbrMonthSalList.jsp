<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var mbrMonthSalGrid;
var v_store_cd;

//등급그룹 목록 조회
function mbrMonthSal(){
    var ejGridOption = {
          rowSelected : function(args){
          },
          serializeGridData : function(data) {
              if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.itme = requestitem;
               }
               var d= new Date();
        	   var reqYear =String(d.getFullYear());
        	   var reqMonth =d.getMonth()+1;
        	   var reqDate = String(d.getDate()-1);
        	   reqMonth=reqMonth>=10?reqMonth:'0'+reqMonth;
        	   var reqDate2 = $('#year').val()+$('#month').val();

        	   if(reqYear+reqMonth == reqDate2){
        	   	  data.toMonth=reqYear+reqMonth+reqDate;
        	   }else{
        		  data.agoMonth =$('#year').val()+$('#month').val();
        	   }
               data.yyyymm =$('#year').val()+$('#month').val();
               data.endyyyymm =$('#endyear').val()+$('#endmonth').val();
               data.storeCd =$('#storeCd').val();
               data.ageCd =$('#ageCd').val();
               data.genCd =$('#genCd').val();
//                data.typeCd=$('#typeCd').val();
               return data;
           },
        dataUrl : '<ifvm:action name="mbrMonthSalList"/>',
        allowCellMerging: true,
        columns:[
        	 {
                 field : 'seq' ,headerText : '', textAlign: 'center', visible: false,
                 customAttributes : {
                    index : 'seq' , sortable: false}/*  */
              },{
                 field : 'typea' ,headerText : '', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'typea' , sortable: false}/*  */
              },{
                 field : 'typeb' ,headerText : '', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'typea' , sortable: false}/*  */
              },{
                 field : 'month0m', headerText : '당월', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'month0m' , sortable: false}/* */
              },{
                 field : 'month1m', headerText : '전월', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'month1m' , sortable: false}/*   */
              },{
                 field : 'month1mRate', headerText : '전월 비교 비율', headerTextAlign : 'center', textAlign: 'right', /* format : '{0:n0}', */
                 customAttributes : {
                    index : 'month1mRate' , sortable: false}/* */
              },{
                 field : 'month12m', headerText : '전년도 동월', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'month12m' , sortable: false}/*  */
              },{
                 field : 'month12mRate', headerText : '전년도 동월 비율', headerTextAlign : 'center', textAlign: 'right',/* format : '{0:n0}', */
                 customAttributes : {
                    index : 'month12mRate' , sortable: false}/*  */
              }
        ],
        requestGridData : {
              nd   : new Date().getTime(),
              rows : 10,
              _search : false
       },
       mergeCellInfo: function (args) {
		    if (args.data.seq == '1') {
		        if (args.column.field == "typea")  {
		        	 args.merge(1, 18);
		        }
		    }else if (args.data.seq == '19') {
		        if (args.column.field == "typea")  {
		        	 args.merge(1,18);
		        }
		    }else if (args.data.seq == '37') {
		        if (args.column.field == "typea")  {
		        	 args.merge(1,32);
		        }
		    }
       },
        gridDataInit : true,
       allowCellMerging : true,
        tempId : 'ifvOnlyGridTemplate'
    };
    mbrMonthSalGrid = $("#mbrMonthSalGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
   mbrMonthSal();
}

//엑셀 다운로드
function excelExport() {
   $.ifvExcelDn('/kepler/report/mbrMonthSalListExport.do','mbrMonthSalGrid');
}

function commcodeSetting(){
   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endyear", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endmonth", "SETTLE_MONTH", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("genCd", "LOY_GEN_CD", null, null, true);
//    $.fn.ifvmSetSelectOptionCommCode("typeCd", "REPORT_TBL", null, null, null);
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
      mbrMonthSal();
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
        리포트 &gt; 회원분류,월별 매출 리포트
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
<!--                  <label class="col-xs-1 control-label"> -->
<!--               단가</label> -->
<!--             <div class="col-xs-1 control_content"> -->
<%--                <ifvm:inputNew type="select"  id="typeCd" names="typeCd" dto="typeCd"/> --%>
<!--             </div> -->
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
    <div id="mbrMonthSalGrid" class="white_bg grid_bd0"></div>
</div>
<div id="searchStorePop" class="popup_container"></div>