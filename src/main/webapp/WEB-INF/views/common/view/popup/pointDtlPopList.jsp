<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var pointDtlPopList;
//포인트 상세 내역 그리드 출력
function pointDtlPopList() {

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
        url : '<ifv:action name="getPointDtlPopupList"/>',
        colNames:[
            '<spring:message code="M00592"/>', // 캠페인명
            '<spring:message code="M01870"/>', // 오퍼명
            '<spring:message code="M01872"/>', // 오퍼유형명
            '<spring:message code="L00537"/>', // 유효기간 시작일자
            '<spring:message code="L00538"/>', // 유효기간 종료일자
            '<spring:message code="M02102"/>', // 포인트
            '<spring:message code="L00540"/>', // 선물가능여부
        ],
        colModel:[
            { name:'camNm',           index:'t2.cam_nm',           resizable : true, width:'90px'  },
            { name:'offerNm',         index:'t3.offer_nm',         resizable : true, width:'70px'  },
            { name:'offerTypeCdNm',   index:'c1.mark_name',        resizable : true, width:'100px' },
            { name:'validStartDate',  index:'t1.valid_start_date', resizable : true, align:'center', width:'70px' },
            { name:'validEndDate',    index:'t1.valid_end_date',   resizable : true, align:'center', width:'70px' },
            { name:'acrlAmt',         index:'t1.acrl_amt',         resizable : true, align:'center', width:'70px' },
            { name:'giftPntYn',       index:'t1.gift_pnt_yn',      resizable : true, align:'center', width:'70px', formatter: setGiftPntValue },
        ],
        radio : false,
        sortname : 't2.cam_nm',
        sortorder : "desc",
        rowList : [ 100000 ],
        tempId : 'ifvGridSimpleTemplete'
    };

    pointDtlPopList = $("#pointDtlPopList").ifvGrid({
        jqGridOption : jqGridOption
    });
}

//선물가능여부 출력
function setGiftPntValue (cellValue, options, rowdata) { 
    return cellValue == null && cellValue == "Y" ? '<spring:message code="L00541"/>' : '<spring:message code="L00539"/>';
}

$(document).ready(function() {
    pointDtlPopList();
    $("#btnSelect").on('click', function() {
        pointDataArr = null;
        if (pointDtlPopList.getCheckedList() == '') {
            alert('<spring:message code="M00285"/>');
        }
        else {
            var dataArr = pointDtlPopList.getCheckedList();
            // $("#pointNm").val(dataArr[0].pointNm).text(dataArr[0].rid);
            pointDataArr = dataArr;
            pointPopupClose();
        }
    });

    $("#btnCancel").on('click', function() {
        pointDataArr = null;
        pointDtlPopClose();
    });
});
</script>

<div id='pointDtlPopFormArea'>
	<div class="pop_inner_wrap">
		<div id="pointDtlPopList" class="grid_bd0 grid_w980"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_lightGray2" id="btnCancel">         
			<spring:message code="M00441"/>
	    </button>
	</div>
</div>
