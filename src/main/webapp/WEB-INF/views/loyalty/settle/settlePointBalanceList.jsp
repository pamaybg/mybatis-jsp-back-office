<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var settlePointBalanceGrid;


var v_store_cd;

//등급그룹 목록 조회
function getSettlePointBalance(){
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
        dataUrl : '<ifvm:action name="getSettlePointBalanceList"/>',
        columns:[
             {
                 field : 'yyyymm' ,headerText : '년월', headerTextAlign : 'center', textAlign: 'center',
                 customAttributes : {
                    index : 'yyyymm' , sortable: false}/*  */
              },{
                 field : 'acrl' ,headerText : '당월 적립', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'acrl' , sortable: false}/*  */
              },{
                 field : 'acrlCan', headerText : '적립취소', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'acrlCan' , sortable: false}/*   */
              },{
                 field : 'acrlAvl', headerText : '유효 적립[적립-적립취소]', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'acrlAvl' , sortable: false}/* */
              },{
                 field : 'acrlAcc', headerText : '적립누적', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
                 customAttributes : {
                    index : 'acrlAcc' , sortable: false}/*  */
              },{
                 field : 'rdm', headerText : '당월사용', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'rdm' , sortable: false}/*  */
              },{
                 field : 'rdmCan', headerText : '사용취소', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'rdmCan' , sortable: false}/*  */
              },{
                 field : 'expPnt', headerText : '소멸[익월1일]', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'expPnt' , sortable: false}/*  */
              },{
                 field : 'rdmAvl', headerText : '유효사용[사용-사용취소-소멸]', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                 customAttributes : {
                    index : 'rdmAvl' , sortable: false}/*  */
              },{
                  field : 'rdmAcc', headerText : '사용누적', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                  customAttributes : {
                     index : 'rdmAcc' , sortable: false}/*  */
               },{
                   field : 'balncAcc', headerText : '잔액', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',
                   customAttributes : {
                      index : 'balncAcc' , sortable: false}/*  */
                }
        ],
        /* stackedHeaderRows: [{
            stackedHeaderColumns:[
                { headerText: "매출"    , column: "buyMbr, rciptCnt,rciptAmt,salAmt" ,headerTextAlign : "center" },
                { headerText: "포인트"  , column: "usePnt,savePnt" ,  headerTextAlign : "center" },
                { headerText: "적립포인트" , column: "basicPnt, evtPnt"              ,  headerTextAlign : "center" },
            ]
        }], */
     /*    actionComplete: function(args){
           $(this.getHeaderContent().find(".e-stackedHeaderCell")[1]).css("text-align", "center");
           $(this.getHeaderContent().find(".e-stackedHeaderCell")[2]).css("text-align", "center");
           $(this.getHeaderContent().find(".e-stackedHeaderCell")[3]).css("text-align", "center");
        }, */
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

    settlePointBalanceGrid = $("#settlePointBalanceGrid").ifvsfGrid({ ejGridOption : ejGridOption });
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
   var settlePointBalanceSearchObj = $('#settlePointBalanceSearchCondition').getSubmitData();
   getSettlePointBalance();
}

//엑셀 다운로드
function excelExport() {
   $.ifvExcelDn('/loyalty/settle/settlePointBalanceListExport.do','settlePointBalanceGrid');
}





   $(document).ready(function() {
      //전체 그리드 조회
      getSettlePointBalance();

      //조회
      $('#settlePointBalanceSearchBtn').on('click', function() {
         reqDataSearch();
      });

      //초기화
      $("#settlePointBalanceSearchInitBtn").on('click', function() {
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
        정산 &gt; 잔여 포인트 월별집계
    </h1>
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
    <div id="settlePointBalanceGrid" class="white_bg grid_bd0"></div>
</div>