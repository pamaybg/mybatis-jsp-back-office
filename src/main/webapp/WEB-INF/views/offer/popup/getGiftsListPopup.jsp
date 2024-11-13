<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script>
var rid;

function newBtnFun () {
        if(giftsProdGrid.opt.gridControl.getSelectedRecords().length==0){
            alert('<spring:message code="O00066"/>');
        }else{
            var url = '<ifvm:action name="addOfferJoinProd"/>';
            var offerRid = ifvGlobal["offerRid"];
            var varData = null;
            varData = {
                    ridOfr : offerRid,
                    ridProdM : prodRid,
                    prodUseType : "PN"
            };
            
            //등록처리
            $.ifvSyncPostJSON(url, varData, function(result) {
                if ($.fn.ifvmIsNotEmpty(result)) {
                    alert("<spring:message code="O00069" />");
                }
            }, function(result) {
                if (result.message)
                    alert(result.message);
                else
                    alert("<spring:message code="O00070" />");
            });
            
            $("#popupContainer_closebutton").trigger('click');
            var offerJoinProdGrid = new OfferJoinProdList();
            offerJoinProdGrid.init();
        }
}

function getProdGiftsList(){

    var ejGridOption = {
        serializeGridData : function(data) {
            data.prodGrpRid = ifvGlobal["offerRid"];
            return data;
        },
        rowSelected : function(args){
            rid = args.data.rid;
        },
        dataUrl : '<ifvm:action name="getGiftsPopList"/>',

        columns : [
            {
                field : 'prodId', headerText : '<spring:message code="E00091"/>', textAlign : 'center', width: 100
                ,headerTextAlign : ej.TextAlign.Center,customAttributes : {searchable: true,index : 'lp.PRODID' }//자재코드 
            }                  
            ,{
                field : 'mmZzstdItemCd', headerText : '<spring:message code="E00100"/>', textAlign : 'center', width: 120
                    ,headerTextAlign : ej.TextAlign.Center,customAttributes : {searchable: true,index : 'lp.MMZZSTDITEMCD' }//표준아이템코드
            }
            ,{
                field : 'mmZzItemCd', headerText : '<spring:message code="E00101"/>', textAlign : 'center' , width: 120
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {searchable: true,index : 'lp.MMZZITEMCD' }//아이템코드
            
            }
            ,{
                field : 'mmZzRepCd1', headerText : '<spring:message code="E00102"/>', textAlign : 'center' , width: 120
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'lp.MMZZREPCD1' }//수요할당코드
            }
            ,{
                field : 'mmZzRepCd2', headerText : '<spring:message code="E00103"/>', textAlign : 'center' , width: 100
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {searchable: true,index : 'lp.MMZZREPCD2' }//대체코드
            }
            ,{
                field : 'mmSkuCd', headerText : '<spring:message code="E00104"/>', textAlign : 'center' , width: 120
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'lp.MMSKUCD' }//SKU채널코드
            }
            ,{
                field : 'prodNm', headerText : '<spring:message code="E00105"/>', textAlign : 'left', width: 400
                ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {searchable: true,index : 'lp.PRODNM' }//자재이름
            }
            ,{
                field : 'shGoodsCode', headerText : '<spring:message code="E00107"/>', textAlign : 'center', width: 100
                ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {searchable: true,index : 'lp.SHGOODSCODE' }//상품코드
            }
            ,{
                field : 'shGoodsName', headerText : '<spring:message code="E00108"/>', textAlign : 'left', width: 400
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {searchable: true,index : 'lp.SHGOODSNAME' }//상품명_제품명 코드
            }
            ,{
                field : 'mmCate1', headerText : '<spring:message code="E00110"/>', textAlign : 'center', width: 140
                ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'lp.LCTG' }//카테고리(대)
            }
            ,{
                field : 'mmCate2', headerText : '<spring:message code="E00111"/>', textAlign : 'center', width: 140
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'lp.MCTG' }//카테고리(중)
            }
            ,{
                field : 'mmCate3', headerText : '<spring:message code="E00112"/>', textAlign : 'center', width: 140
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'lp.SCTG' }//카테고리(소)
            }
        ],

        requestGridData : {
          sidx : '1',
          sord : 'desc'
        },
        isHorizontalScroll : true
    };

    giftsProdGrid = $("#giftsProdGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function () {
    getProdGiftsList();
    $('#selectBtn').on('click', function() {
        newBtnFun();
    });
    //취소 클릭시
    $('#cancelBtn').on('click', function() {
        dialog._destroy();
    });
});
</script>
<div id="giftsProdGrid"class="white_bg grid_bd0"></div>

<div id="contsListPopWrap">
    <div class="pop_btn_area">
<!--         선택 -->
        <button class="btn btn-sm btn_gray" id="selectBtn">
            <spring:message code="M00282"/>
        </button>
        <!-- 닫기 --> 
        <button class="btn btn-sm btn_lightGray2" id="cancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>
