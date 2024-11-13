<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var purItemDtlPop_objPurItemDtlPopList;

//항목 상세 내역 그리드 출력
function purItemDtlPop_getPurItemList() {

    var jqGridOption = {
        serializeGridData : function(data) {
            data.rid = rid;
        },
        ondblClickRow : function(row) {
        },
        onSelectCell : function(data) {
        },
        loadComplete : function(data) {
        },
        url : '<ifv:action name="getPurItemDtlPopList"/>',
        colNames:[
            '<spring:message code="M02197"/>', // 항목번호
            '<spring:message code="L00164"/>', // 브랜드명
            '<spring:message code="L00291"/>', // 카테고리명
            '<spring:message code="L00293"/>', // 상품명
            '<spring:message code="L00200"/>', // 상품코드
            '<spring:message code="M02066"/>', // 구매금액
            '<spring:message code="M02198"/>', // 구매수량
        ],
        colModel:[
            { name:'itemNum', index:'t1.item_num', resizable: false, align:'center', width:'70px' },
            { name:'brdNm',   index:'t2.brd_nm',   resizable: false, align:'center', width:'70px' },
            { name:'catNm',   index:'t3.cat_nm',   resizable: false, align:'center', width:'100px' },
            { name:'prodNm',  index:'t4.prod_nm',  resizable: false, align:'center', width:'70px' },
            { name:'prodId',  index:'t4.prod_id',  resizable: false, align:'center', width:'70px' },
            { name:'amt',     index:'t1.amt',      resizable: false, align:'center', width:'70px', formatter: numberFormat },
            { name:'vol',     index:'t1.vol',      resizable: false, align:'center', width:'70px' },
        ],
        radio : false,
        sortname : 't1.item_num',
        sortorder : "desc",
        rowList : [ 100000 ],
        tempId : 'ifvGridSimpleTemplete'
    };

    purItemDtlPop_objPurItemDtlPopList = $("#purItemDtlPopList").ifvGrid({
        jqGridOption : jqGridOption
    });
}

//숫자 콤마표시
function numberFormat(cellvalue, options, rowObjec) {
    var value = "";
    if ($.fn.ifvmIsNotEmpty(cellvalue)) {
        value = $.ifvNumberFormat(cellvalue);
    }
    return value;
}

$(document).ready(function() {
    
    purItemDtlPop_getPurItemList();
    
    $("#btnCancel").on('click', function() {
        purItemDtlPop_objPurItemDtlPopList = null;
        popupClose();
    });
});

</script>

<div id='purItemDtlPopFormArea'>
    <div class="pop_inner_wrap">
        <div id="purItemDtlPopList" class="grid_bd0 grid_w980"></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_lightGray2" id="btnCancel">         
            <spring:message code="M00441"/>
        </button>
    </div>
</div>
