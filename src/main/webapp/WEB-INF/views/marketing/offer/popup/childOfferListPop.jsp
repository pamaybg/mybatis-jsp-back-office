<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var childOfferGrid;
var childOfferGridDiv;

/**
 * 오퍼목록 조회
 */
function getChildOfferList() {

    var jqGridOption = {
        ondblClickRow : function(data) {
            var data = childOfferList.getRowData()[data - 1];
            rid = data.rid;
        },
        onSelectRow : function(data) {
        },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj) {
        },
        url : '<ifvm:action name="getChildOfferList"/>',
        colNames:[
            '<spring:message code="E00005" />',
            'childOfferId',
            'offerNo',
            'offerTypeCd',
            'offerSubTypeCd'
        ],
        colModel:[
             { name:'offerNm'			, index:'t1.offerNm', resizable : true, align:'center', width:'100px' },
             { name:'childOfferId'		, index:'t1.childOfferId',     	hidden : true },
             { name:'offerNo'			, index:'t1.offerNo',			hidden : true },
             { name:'offerTypeCd'		, index:'t1.offerTypeCd',     	hidden : true },
             { name:'offerSubTypeCd'	, index:'t1.offerSubTypeCd',    hidden : true },
        ],
        sortname : 't1.id',
        sortorder : "desc",
        radio: true
    };

    childOfferGrid = $("#childOfferListGrid").ifvGrid({
        jqGridOption : jqGridOption
    });
    childOfferGridDiv = $("#childOfferListGrid");
    childOfferGridDiv.resize();
}

$(document).ready(function() {

    getChildOfferList() ;

    // 선택
    $("#childOfferSelectBtn").on("click", function() {
        selectChildOffer();
    });

    // 취소
    $("#childOfferListPopCancelBtn").on("click", function() {
    	childOfferListPopClose();
    });

});

</script>

<div id="childOfferListPopWrap">
    <div class="pop_inner_wrap form-horizontal" id="childOfferListPop" >
        <div id="childOfferListGrid"></div>
    </div>

    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="childOfferSelectBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="childOfferListPopCancelBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>
