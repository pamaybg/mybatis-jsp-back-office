<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script>

function newBtnFun() {
        $("#dialog").ifvsfPopup({
            enableModal : true,
            enableResize : false,
            contentUrl : '<ifvm:url name="getGiftsListPop"/>',
            contentType : "ajax",
            title : '<spring:message code="O00160" />',
            width : 1000,
            maxWidth : 2000,
            maxHeight : 2000,
            close : 'canBtnFun'
        });
}

function delBtnFun() {
    
}

function canBtnFun() {
    dialog._destroy();
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
        dataUrl : '<ifvm:action name="getProdItemList"/>',

        columns : [
            {
                field : 'prodId', headerText : '<spring:message code="E00091"/>', textAlign : 'center', width: 100
                ,headerTextAlign : ej.TextAlign.Center,customAttributes : {searchable: true,index : 'lp.PRODID' }//자재코드 
            }                  
            ,{
                field : 'mmZzItemCd', headerText : '<spring:message code="E00101"/>', textAlign : 'center' , width: 120
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {searchable: true,index : 'lp.MMZZITEMCD' }//아이템코드
            }
            ,{
                field : 'shGoodsName', headerText : '<spring:message code="E00108"/>', textAlign : 'left', width: 400
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {searchable: true,index : 'lp.SHGOODSNAME' }//상품명_제품명 코드
            }
            ,{
                field : 'mmCate1', headerText : '<spring:message code="E00110"/>', textAlign : 'center', width: 140
                ,headerTextAlign : ej.TextAlign.Center  ,customAttributes : {index : 'lp.L_CTG' }//카테고리(대)
            }
            ,{
                field : 'mmCate2', headerText : '<spring:message code="E00111"/>', textAlign : 'center', width: 140
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'lp.M_CTG' }//카테고리(중)
            }
            ,{
                field : 'mmCate3', headerText : '<spring:message code="E00112"/>', textAlign : 'center', width: 140
                ,headerTextAlign : ej.TextAlign.Center ,customAttributes : {index : 'lp.S_CTG' }//카테고리(소)
            }
        ],

        requestGridData : {
          sidx : '1',
          sord : 'desc',

        },
    };

    giftsGrid = $("#giftsGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function () {
    getProdGiftsList();
});
</script>

<div class="page_btn_area">
    <div class="col-xs-7">
        <span><spring:message code="O00159" /></span>
    </div>
    <div class="col-sm-5 searchbtn_r">
            <ifvm:inputNew type="button" id="newBtn" btnType="plus"  btnFunc="newBtnFun"  text="신규" objCode="newBtn_OBJ"/>
            <ifvm:inputNew type="button" id="delBtn"   btnType="minus" btnFunc="delBtnFun"  text="삭제"  objCode="delBtn_OBJ"/>
    </div>
</div>
<div id="giftsGrid"class="white_bg grid_bd0"></div>
<div id="dialog" class="popup_container"></div>
