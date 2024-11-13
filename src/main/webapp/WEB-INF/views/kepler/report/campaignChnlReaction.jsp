<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var campaignChnlReactionGrid;

//등급그룹 목록 조회
function getCampaignChnlReaction(){
    var ejGridOption = {
          rowSelected : function(args){
          },
          serializeGridData : function(data) {
              if ($.fn.ifvmIsNotEmpty(requestitem)) {
                   data.itme = requestitem;
               }
               data.yyyymm =$('#year').val()+$('#month').val();
               data.endyyyymm =$('#endyear').val()+$('#endmonth').val();
               return data;
           },

        dataUrl : '<ifvm:action name="campaignChnReaction"/>',
        columns:[ 
        	 {
                 field : 'camNm' ,headerText : '캠페인명', headerTextAlign : 'center', textAlign: 'left',
                 customAttributes : {
                    index : 'camNm' , sortable: false}/*  */
              },{
                 field : 'camTerm' ,headerText : '기간', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'camTerm' , sortable: false}/*  */
              },{
                 field : 'chnlTypeCd' ,headerText : '채널유형', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'chnlTypeCd' , sortable: false}/*  */
              },{
                 field : 'extraCnt', headerText : '전체 대상자수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'extraCnt' , sortable: false}/* */
              },{
                 field : 'chnlCnt', headerText : '채널전송 건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'chnlCnt' , sortable: false}/*   */
              },{
                 field : 'respCnt', headerText : '반응건수', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'respCnt' , sortable: false}/* */
              },{
                 field : 'responRate', headerText : '반응율', headerTextAlign : 'center', textAlign: 'right',
                 customAttributes : {
                    index : 'responRate' , sortable: false}/*  */
              },{
                 field : 'openCnt', headerText : '오픈수', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'openCnt' , sortable: false}/*  */
              }
        ],
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
    
    campaignChnlReactionGrid = $("#campaignChnlReactionGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
   getCampaignChnlReaction();
} 

//엑셀 다운로드 
function excelExport() {
   $.ifvExcelDn('/kepler/report/campaignChnReactionExport.do','campaignChnlReactionGrid');
}

function commcodeSetting(){
   $.fn.ifvmSetSelectOptionCommCode("year", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("month", "SETTLE_MONTH", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endyear", "REPORT_YEAR", null, null, true);
   $.fn.ifvmSetSelectOptionCommCode("endmonth", "SETTLE_MONTH", null, null, true);
   }

   function sysdateSet(){
	   var d= new Date();
	   var reqYear =String(d.getFullYear());
	   var reqMonth =d.getMonth()+1;
	   var endMonth =d.getMonth()+1;
	   reqMonth=reqMonth>=10?reqMonth:'0'+reqMonth;
	   endMonth=endMonth>=10?endMonth:'0'+endMonth;
	   $('#year').val(reqYear);
	   $('#month').val(reqMonth);
	   $('#endyear').val(reqYear)
	   $('#endmonth').val(endMonth);
	}	

	$(document).ready(function() {
		commcodeSetting();
   	  //현제날짜 세팅
		sysdateSet();
      //전체 그리드 조회
      getCampaignChnlReaction();

      //조회
      $('#reportSearchBtn').on('click', function() {
         reqDataSearch();
      });

      //초기화
      $("#reportSearchInitBtn").on('click', function() {
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
        캠페인 리포트
        &gt; 캠페인 채널 반응
    </h1>
</div>
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="reportSearchBtn" objCode="reportSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135" />
            </button> 
            <button class="btn btn-sm" id="reportSearchInitBtn" objCode="reportSearchInitBtn_OBJ">
                <spring:message code="M00278" />
            </button> 
        </div>
    </div>
    <div class="form-horizontal underline top_well" id="reportSearchCondition">
       <div class="row qt_border">
            <label class="col-xs-1 control-label">캠페인 종료년월</label>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="year" names="year" dto="year"/>
            </div>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="month" names="month" dto="month"/>
            </div>
            <div class="col-xs-1 swung_dash">~</div>
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="endyear" names="endyear" dto="endyear"/>
            </div>								 
            <div class="col-xs-1 control_content">
               <ifvm:inputNew type="select"  id="endmonth" names="endmonth" dto="endmonth"/>
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
            <button class="btn btn-sm" id="excelExportBtn" objCode="excelExportBtn_OBJ">
                <spring:message code="M01218" />
            </button>
        </div>
    </div>
    <div id="campaignChnlReactionGrid" class="white_bg grid_bd0"></div> 
</div>
