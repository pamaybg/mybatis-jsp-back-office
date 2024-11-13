<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var offerProductGrid;
var offerProductGridDiv;

var productDtlValidation;
var selProductDtlData;    //수정 데이터

var productType = '';     // E : 수정 , N : 등록
var productDtlPopup;      //할인/교환 상품 등록&수정 팝업

function initProduct() {

    //그리드 설정
    setProductGrid();

    productDtlValidation = $("#productDtlPop").ifvValidation();
}

/**
 * 할인/교환 상품 그리드 그리기
 */
function setProductGrid() {

    //colnames
    var colNames = [];

    //colmodel
    var colModel = [];

    //상품별포인트
    colNames.push("<spring:message code='L00231'/>");
    colNames.push("<spring:message code='L00232'/>");
    colNames.push("<spring:message code='M02285'/>");
    colNames.push("<spring:message code='M02286'/>");
    colNames.push("<spring:message code='M02287'/>");
    colNames.push("<spring:message code='M02442'/>");
    colNames.push("<spring:message code='M02443'/>");
    colNames.push('rid');

    colModel.push({name:'prodId',     index:'', resizable:false, align:'center'});
    colModel.push({name:'prodNm',     index:'', resizable:false, align:'center'});
    colModel.push({name:'posProdCnt', index:'', resizable:false, align:'center'});
    colModel.push({name:'posProdCd',  index:'', resizable:false, align:'center'});
    colModel.push({name:'posBcodeNo', index:'', resizable:false, align:'center'});
    colModel.push({name:'posProdAmt', index:'', resizable:false, align:'center'});
    colModel.push({name:'posChnlCd', index:'', resizable:false, align:'center'});
    colModel.push({name:'rid',        index:'', resizable:false, hidden : true,  searchable : false});

    var jqGridOption = {
        loadComplete : function(obj) {
            //popup 높이 맞추기
            new ifvm.PopupHeight({
                popupDivId : 'dialog',
                contentsId : 'dialogPopupWrap'
            });
        },
        ondblClickRow : function (id) {
        },
        data: offerData.productList,
        datatype: 'clientSide',
        colNames: colNames,
        colModel: colModel,
        rowList : [100000],
        radio: true,
        tempId : 'ifvGridSimpleTemplete',
    };

    offerProductGrid = $("#offerProductGrid").ifvGrid2({ jqGridOption : jqGridOption });
    offerProductGridDiv = $("#offerProductGridDiv");
}

/**
 * 할인/교환 상품 추가 및 수정을 위한 팝업 오픈
 */
function productDtlPopupOpen(type) {

    productType = type;

    if (type == "E") {
        //선택 확인
        var len = offerProductGrid.getRadioSelectedRowId().length;

        if (len > 0) {
            selProductDtlData = offerProductGrid.getSelRadioData();
        }
        else {
            alert("<spring:message code='L00262'/>");
            return false;
        }
    }
    else {
        //초기화
        selProductDtlData = {};
    }

    productDtlPopup = $("#productDtlPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="productDtlPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02280'/>",
        width: 500,
        open: function (args) {
            if (type == "E") {
                initProductDtlPopData(selProductDtlData);
            }
        },
        close : 'productDtlPopClose'
    });
}

/**
 * 할인/교환 상품 수정 팝업 닫기
 */
function productDtlPopClose() {
    productDtlPopup.ejDialog('destroy');
}

/**
 * 할인/교환 상품 그리드에 추가
 */
function productAdd() {
    
    productDtlValidation = $("#productDtlPop").ifvValidation();
    
    if (productDtlValidation.confirm()) {
        var data = {};
        
        data.prodNm  = $.fn.ifvmIsEmptyNull($("#productDtlPopWrap #prodNm").val());
        data.ridProd = $.fn.ifvmIsEmptyNull($("#productDtlPopWrap #ridProd").val());
        data.prodId  = $.fn.ifvmIsEmptyNull($("#productDtlPopWrap #prodId").val());
        
        data.posProdCnt = $.fn.ifvmIsEmptyNull($("#productDtlPopWrap #posProdCnt").val());
        data.posProdCd  = $.fn.ifvmIsEmptyNull($("#productDtlPopWrap #posProdCd").val());
        data.posBcodeNo = $.fn.ifvmIsEmptyNull($("#productDtlPopWrap #posBcodeNo").val());
        data.posChnlCd  = $.fn.ifvmIsEmptyNull($("#productDtlPopWrap #posChnlCd").val());
        data.posProdAmt = $.fn.ifvmIsEmptyNull($("#productDtlPopWrap #posProdAmt").val());

        //수정 or 등록 여부 확인
        if ($.fn.ifvmIsNotEmpty(selProductDtlData)) {

            data.rid  = $.fn.ifvmIsEmptyNull($("#productDtlPopWrap #rid").val());
            selProductDtlData = data;

            //그리드 row 수정
            offerProductGrid.setRowDatas(data);
        }
        else {
            //그리드 row 추가
            offerProductGrid.addLocalTr(data);
        }

        //전역변수에 값 매핑
        offerData.productList = offerProductGrid.getAllRowData();

        // 그리드 재설정
        setProductGrid();

        //close popup
        productDtlPopClose();
    }
}

/**
 * 현재 그리드에 채널이 저장되어있는지 체크 한다
 *
 * @param checkedData
 * @returns
 */
function chkProductList(_checkedData) {
    for (var i = 0; i < offerData.productList.length; i++) {
        var deskData = offerData.productList[i];
        if (deskData.dataStatus != "D"
                && deskData.ridChnl == _checkedData.rid) {
            return true;
        }
    }
    return false;
}

/**
 * 할인/교환 상품 삭제
 */
function productInfoRemove() {

    var checkedList = offerProductGrid.getCheckedList();
    if (checkedList.length > 0) {
        offerProductGrid.delRowData();
    }

    // 전역변수에 값 매핑
    offerData.productList = offerProductGrid.getAllRowData();

    // 그리드 재설정
    setProductGrid();
}

$(document).ready(function() {

    initProduct();

    // 신규
    $('#productNewBtn').on('click', function() {
        productDtlPopupOpen('N');
    });

    // 수정
    $('#productEditBtn').on('click', function() {
        productDtlPopupOpen('E');
    });

    // 삭제
    $("#productRemoveBtn").on('click', function() {
        productInfoRemove();
    });

});

</script>

<div id="loyOfferUseLmtChnlWrap">
    <div class="page_btn_area" id=''>
        <div class="col-xs-12 searchbtn_r">
            <button class="btn btn-sm" id="productNewBtn">
                <spring:message code="M01852"/>
            </button>
            <button class="btn btn-sm" id="productEditBtn">
                <spring:message code="M00259"/>
            </button>
            <button class="btn btn-sm" id='productRemoveBtn'>
                <spring:message code="M01854"/>
            </button>
        </div>
    </div>
    <div id="offerProductGrid" class="white_bg grid_bd0"></div>
</div>
<div id="productDtlPopup"></div>
