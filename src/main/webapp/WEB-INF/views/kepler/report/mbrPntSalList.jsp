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
        dataUrl : '<ifvm:action name="mbrPntSaveUseList"/>',
        columns:[
             {
                 field : 'yyyymm' ,headerText : '일자', headerTextAlign : 'center', textAlign: 'center',width : '80px',
                 customAttributes : {
                    index : 'yyyymm' , sortable: false}/*  */
              },
              /*포인트 보유 금액 */
              {
            	field : 'pntAmt0' ,headerText : '0', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                customAttributes : {
                 index : 'pntAmt0' , sortable: false}/*  */
           	  },{
                 field : 'pntAmt1000' ,headerText : '~1000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt1000' , sortable: false}/*  */
              },{
                 field : 'pntAmt2000', headerText : '~2000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt2000' , sortable: false}/*   */
              },{
                 field : 'pntAmt3000', headerText : '~3000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt3000' , sortable: false}/* */
              },{
                 field : 'pntAmt4000', headerText : '~4000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt4000' , sortable: false}/*  */
              },{
                 field : 'pntAmt5000', headerText : '~5000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt5000' , sortable: false}/*  */
              },{
                 field : 'pntAmt6000', headerText : '~6000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt6000' , sortable: false}/*  */
              },{
                 field : 'pntAmt7000', headerText : '~7000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt7000' , sortable: false}/*  */
              },{
                  field : 'pntAmt8000' ,headerText : '~8000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntAmt8000' , sortable: false}/*  */
              },{
                 field : 'pntAmt9000', headerText : '~9000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt9000' , sortable: false}/*   */
              },{
                 field : 'pntAmt10000', headerText : '~10000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt10000' , sortable: false}/* */
              },{
                 field : 'pntAmt11000', headerText : '~11000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt11000' , sortable: false}/*  */
              },{
                 field : 'pntAmt12000', headerText : '~12000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt12000' , sortable: false}/*  */
              },{
                 field : 'pntAmt13000', headerText : '~13000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt13000' , sortable: false}/*  */
              },{
                 field : 'pntAmt14000', headerText : '~14000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt14000' , sortable: false}/*  */
              },{
                 field : 'pntAmt15000', headerText : '~15000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt15000' , sortable: false}/* */
              },{
                 field : 'pntAmt15000u', headerText : '15000~20000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntAmt15000u' , sortable: false}/*  */
              },{
                  field : 'pntAmt20000d' ,headerText : '20000~', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntAmt20000d' , sortable: false}/*  */
              },
              /*포인트 사용 금액 */
              {
                 field : 'pntUse0' ,headerText : '0', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse0' , sortable: false}/*  */
              },{
                 field : 'pntUse1000' ,headerText : '~1000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse1000' , sortable: false}/*  */
              },{
                 field : 'pntUse2000', headerText : '~2000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse2000' , sortable: false}/*   */
              },{
                 field : 'pntUse3000', headerText : '~3000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse3000' , sortable: false}/* */
              },{
                 field : 'pntUse4000', headerText : '~4000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse4000' , sortable: false}/*  */
              },{
                 field : 'pntUse5000', headerText : '~5000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse5000' , sortable: false}/*  */
              },{
                 field : 'pntUse6000', headerText : '~6000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse6000' , sortable: false}/*  */
              },{
                 field : 'pntUse7000', headerText : '~7000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse7000' , sortable: false}/*  */
              },{
                  field : 'pntUse8000' ,headerText : '~8000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntUse8000' , sortable: false}/*  */
              },{
                 field : 'pntUse9000', headerText : '~9000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse9000' , sortable: false}/*   */
              },{
                 field : 'pntUse10000', headerText : '~10000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse10000' , sortable: false}/* */
              },{
                 field : 'pntUse11000', headerText : '~11000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse11000' , sortable: false}/*  */
              },{
                 field : 'pntUse12000', headerText : '~12000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse12000' , sortable: false}/*  */
              },{
                 field : 'pntUse13000', headerText : '~13000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse13000' , sortable: false}/*  */
              },{
                 field : 'pntUse14000', headerText : '~14000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse14000' , sortable: false}/*  */
              },{
                 field : 'pntUse15000', headerText : '~15000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse15000' , sortable: false}/* */
              },{
                 field : 'pntUse15000u', headerText : '15000~20000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntUse15000u' , sortable: false}/*  */
              },{
                  field : 'pntUse20000d' ,headerText : '20000~', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntUse20000d' , sortable: false}/*  */
              },
              /*구매 금액 기준회원수*/
                {
                 field : 'pntBuyMbr0' ,headerText : '0', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr0' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr1000' ,headerText : '~1000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr1000' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr2000', headerText : '~2000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr2000' , sortable: false}/*   */
              },{
                 field : 'pntBuyMbr3000', headerText : '~3000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr3000' , sortable: false}/* */
              },{
                 field : 'pntBuyMbr4000', headerText : '~4000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr4000' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr5000', headerText : '~5000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr5000' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr6000', headerText : '~6000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr6000' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr7000', headerText : '~7000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr7000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr8000' ,headerText : '~8000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr8000' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr9000', headerText : '~9000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr9000' , sortable: false}/*   */
              },{
                 field : 'pntBuyMbr10000', headerText : '~10000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr10000' , sortable: false}/* */
              },{
                 field : 'pntBuyMbr11000', headerText : '~11000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr11000' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr12000', headerText : '~12000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr12000' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr13000', headerText : '~13000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr13000' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr14000', headerText : '~14000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr14000' , sortable: false}/*  */
              },{
                 field : 'pntBuyMbr15000', headerText : '~15000', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr15000' , sortable: false}/* */
              },{
                 field : 'pntBuyMbr16000', headerText : '~16000', headerTextAlign : 'center', textAlign: 'right',format : '{0:n0}',width : '80px',
                 customAttributes : {
                    index : 'pntBuyMbr16000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr17000' ,headerText : '~17000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr17000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr18000' ,headerText : '~18000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr18000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr19000' ,headerText : '~19000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr19000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr20000' ,headerText : '~20000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr20000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr21000' ,headerText : '~21000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr21000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr22000' ,headerText : '~22000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr22000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr23000' ,headerText : '~23000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr23000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr24000' ,headerText : '~24000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr24000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr25000' ,headerText : '~25000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr25000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr26000' ,headerText : '~26000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr26000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr27000' ,headerText : '~27000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr27000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr28000' ,headerText : '~28000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr28000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr29000' ,headerText : '~29000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr29000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr30000' ,headerText : '30000', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr30000' , sortable: false}/*  */
              },{
                  field : 'pntBuyMbr30000u' ,headerText : '30000~', headerTextAlign : 'center', textAlign: 'center',format : '{0:n0}',width : '80px',
                  customAttributes : {
                     index : 'pntBuyMbr30000u' , sortable: false}/*  */
              }
        ],
        stackedHeaderRows: [{
            stackedHeaderColumns:[
                { headerText: "포인트 보유금액별"    ,
                	  column: "pntAmt0,pntAmt1000,pntAmt2000,pntAmt3000,pntAmt4000,pntAmt5000,pntAmt6000,pntAmt7000,pntAmt8000,pntAmt9000,pntAmt10000,pntAmt11000,pntAmt12000,pntAmt13000,pntAmt14000,pntAmt15000,pntAmt15000u,pntAmt20000d"
                	,headerTextAlign : "center" },
                { headerText: "포인트 사용금액별"  ,
                	  column: "pntUse0,pntUse1000,pntUse2000,pntUse3000,pntUse4000,pntUse5000,pntUse6000,pntUse7000,pntUse8000,pntUse9000,pntUse10000,pntUse11000,pntUse12000,pntUse13000,pntUse14000,pntUse15000,pntUse15000u,pntUse20000d" ,
                	  headerTextAlign : "center" },
                { headerText: "구매금액 기준 회원수" ,
                	  column: "pntBuyMbr0,pntBuyMbr1000,pntBuyMbr2000,pntBuyMbr3000,pntBuyMbr4000,pntBuyMbr5000,pntBuyMbr6000,pntBuyMbr7000,pntBuyMbr8000,pntBuyMbr9000,pntBuyMbr10000,pntBuyMbr11000,pntBuyMbr12000,pntBuyMbr13000,pntBuyMbr14000,pntBuyMbr15000,pntBuyMbr16000,pntBuyMbr17000,pntBuyMbr18000,pntBuyMbr19000,pntBuyMbr20000,pntBuyMbr21000,pntBuyMbr22000,pntBuyMbr23000,pntBuyMbr24000,pntBuyMbr25000,pntBuyMbr26000,pntBuyMbr27000,pntBuyMbr28000,pntBuyMbr29000,pntBuyMbr30000,pntBuyMbr30000u" ,
                	headerTextAlign : "center" },
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
       isHorizontalScroll:true,
        showStackedHeader:true,
        gridDataInit : true,
       allowCellMerging : true,
        tempId : 'ifvGridSimplePageTemplete3'
    };

    timesSalGrid = $("#timesSalGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

//공통 조회조건 필수값 체크
// function validationCheck(table){
//    var validationVal =  false;
//    $(".SearchCondition .searchTextVal option:selected").filter(function(){
//       if($(this).attr('jointgtclm') == table){
//          if($(this).parents('.SearchCondition').css("display") !="none"){
//             if($.fn.ifvmIsNotEmpty( $(this).parents('.SearchCondition').find('.changeTypeAreaCode  select').val())){
//                validationVal = true;
//             }
//          }
//       }
//    })
//    return validationVal;
// }

//공통 조회 호출
function reqDataSearch() {
   var reportSearchObj = $('#reportSearchCondition').getSubmitData();
   getTimesSal();
}

//엑셀 다운로드
function excelExport() {
   $.ifvExcelDn('/kepler/report/mbrPntSaveUseExport.do','timesSalGrid');
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
        리포트 &gt; 포인트 보유,사용
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