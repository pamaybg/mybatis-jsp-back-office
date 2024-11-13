<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div id="pop_main_div_mbr">
   <div>
       <div class="page_btn_area">
           <div class="col-xs-7">
               <span>매장조회</span>
           </div>
           <div class="col-xs-5 searchbtn_r">
               <button class="btn btn-sm" id="mbrTransFerSearchBtn"><i class="fa fa-search"></i>
                   <spring:message code="M00135" />
               </button>
               <button class="btn btn-sm" id="mbrTransFerSearchInitBtn">
                   <spring:message code="M00278" />
               </button>
           </div>
       </div>
       <div class="well form-horizontal well_bt5" id="searchList" ></div>
   </div>
   <div>
       <div class="page_btn_area" >
           <div class="col-xs-7">
               <span><spring:message code="M00277" /></span>
           </div>
           <div class="col-xs-5 searchbtn_r">
           </div>
       </div>
       <div id="storeaListGrid" class="white_bg grid_bd0"></div>
   </div>
   <div id="emptyDialog" class="popup_container"></div>
   <div class="pop_btn_area">
      <ifvm:inputNew type="button" btnType="save"   text="C00038"  id="choiceMbrBtn" btnFunc="choiceMbrFn"/>
      <ifvm:inputNew type="button"   text="M00441"  id="cancelmbrTransFerBtn" btnFunc="searchStorePopClose"/>
   </div>
</div>
<div id="transferPointConfirmPopup" class="popup_container"></div><!-- 팝업 -->

<script type="text/javascript">
var storeaListGrid;
function getStoreList(){
    var ejGridOption = {
        serializeGridData : function(data) {
           if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        dataUrl : '<ifvm:action name="getSelectStoreCd"/>',
        columns:[
            {
                 field : 'storeNm', headerText : '매장명', headerTextAlign : 'center', textAlign : 'center',
                 customAttributes : {
                    sortable : false,
                    index : 'storeNm' }
              }, {
                 field : 'storeCd', headerText : '매장코드', headerTextAlign : 'center', textAlign : 'center',
                 customAttributes : {
                    index : 'storeCd' }
              }
        ],
        requestGridData : {
              nd   : new Date().getTime(),
              rows : 10,
              _search : false
           },
           rowList : [10,25,50,100],
           radio: true,
           gridDataInit: false,
            tempId : 'ifvGridSimplePageTemplete'
     };
    storeaListGrid = $("#storeaListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}
//공통 조회 목록 설정
function searchInit(gridId) {
    $.fn.ifvmSetCommonCondList("searchList","D_REPORT_03",gridId);
}
//팝업닫기
function searchStorePopClose() {
   searchStorePop._destroy();
}
//공통 조회 호출
function storeSerch() {
    $.fn.ifvmSubmitSearchCondition("searchList",function(bool){
      bool ? alert('최소 1개의 조회조건을 입력해주세요.') : storeaListGrid.searchGrid({item: requestitem});
   });
}

function choiceMbrFn(){
    if ($.fn.ifvmIsNotEmpty(storeaListGrid.opt.gridControl.getSelectedRecords()[0])) {
       v_store_cd =storeaListGrid.opt.gridControl.getSelectedRecords()[0].storeCd;
       store_nm=storeaListGrid.opt.gridControl.getSelectedRecords()[0].storeNm;
       $('#storeCd').val(v_store_cd);
       $('#storeNm').val(store_nm);
       searchStorePopClose();
    }
    else {
        alert('<spring:message code="M02219"/>');
    }
}

$(document).ready(function() {
    //공통 조회 조건 목록 설정
    searchInit();


    getStoreList();

    //조회
    $('#mbrTransFerSearchBtn').on('click', function(){
        storeSerch();
    });
    //초기화
    $("#mbrTransFerSearchInitBtn").on('click', function(){
        searchInit('storeaListGrid');
    });
//     $.ifvEnterSetting(["#searchList input"], function(){
//        storeSerch();
//    });
});
</script>