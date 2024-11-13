<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style type="text/css">
  .descript{
    width : 98%;
    height: 10%;
    font-size: 13px;
    box-sizing: border-box;
    margin: 10px;
    padding: 10px;

  }
  #mbrTxnHist {
     min-height : 0px;
  }

  /*#buyDetailPopup_title {
    width : 1620px;
    max-width: 1620px;
  }*/

</style>

<div class ="row white_bg">
  <div id="buyDetailSelectGrid" class="white_bg grid_bd0"></div>
</div>
<div id="mbrTxnHist" class="white_bg grid_bd0"></div>
<div class="page_btn_area" >
  <div class="col-xs-9">
    <span>용어설명</span>
  </div>
</div>

<textarea id="desc" class = "descript" maxlength="100" rows="6" readonly = true>
• 정상가총액 : 정상가 * 수량
• 실결제금액 : 정상가총액  - 총할인금액
</textarea>

<div id="contsListPopWrap">
  <div class="pop_btn_area">
    <!-- 닫기 -->
    <button class="btn btn-sm btn_lightGray2" id="cancelBtn" objCode="purDetailPopCancel_OBJ">
      <spring:message code="M00441"/>
    </button>
  </div>
</div>
<script>
  function buyDetailSelect(){
    var ejGridOption = {
      serializeGridData : function(data) {
        data.rid = rid;
        return data;
      },
      dataUrl : '<ifvm:action name="purDetailSelect"/>',
      columns : [
        {
          field : 'prodId', headerText : '상품코드',  headerTextAlign: 'center', textAlign : 'center', width: '10%',customAttributes :{index : 'lp.PROD_ID',sortable: false}
        },{
          field : 'prodNm', headerText : '상품명',  headerTextAlign: 'center', textAlign : 'center', width: '20%',customAttributes :{index : 'lp.PROD_NM',sortable: false}
        },{
          field : 'colorCd', headerText : '컬러',  headerTextAlign: 'center', textAlign : 'center', width: '7%',customAttributes :{index : 'lod.COLOR_CD',sortable: false}
        },{
          field : 'sizeCd', headerText : '사이즈',  headerTextAlign: 'center', textAlign : 'center', width: '5%',customAttributes :{index : 'lod.SIZE_CD',sortable: false}
        },{
          field : 'csmPrc', headerText : '정상가',  headerTextAlign: 'center', textAlign : 'center', width: '8%',  format : '{0:n0}',customAttributes :{index : 'lod.CSM_PRC',sortable: false}
        },{
          field : 'saleQty', headerText : '수량',  headerTextAlign: 'center', textAlign : 'center', width: '5%',  format : '{0:n0}',customAttributes :{index : 'lod.SALE_QTY',sortable: false}
        },{
          field : 'sellAmt', headerText : '정상가총액',  headerTextAlign: 'center', textAlign : 'center', width: '8%',  format : '{0:n0}',customAttributes :{index : 'sellAmt',sortable: false}
        },{
          field : 'actAmt', headerText : '실결제금액',  headerTextAlign: 'center', textAlign : 'center', width: '8%',  format : '{0:n0}',customAttributes :{index : 'actAmt',sortable: false}
        },{
          field : 'discntAmt', headerText : '총할인금액',  headerTextAlign: 'center', textAlign : 'center', width: '8%',  format : '{0:n0}',customAttributes :{index : 'discntAmt',sortable: false}
        },{
          field : 'rdmPoint', headerText : '사용적립금',  headerTextAlign: 'center', textAlign : 'center', width: '8%',  format : '{0:n0}',customAttributes :{index : 'lod.MIL_USE_AMT',sortable: false}
        },

      ],
      requestGridData : {
        sidx : 'lp.PROD_ID',
        sord : 'asc'
      },

      // gridDataInit: true,
      // isHorizontalScroll : true,
      // allowResizing: true,
      tempId : 'ifvGridSimplePageTemplete'

    };

    buyDetailSelectGrid = $("#buyDetailSelectGrid").ifvsfGrid({ ejGridOption : ejGridOption });
  }

  $(document).ready(function(){
    buyDetailSelect();
    $("#cancelBtn").click(function(){
      buyDetailPopClose();
    });
  });
</script>