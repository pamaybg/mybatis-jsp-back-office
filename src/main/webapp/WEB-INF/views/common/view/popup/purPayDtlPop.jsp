<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var purPayDtlPop_objPurPayDtlPopList;

//결제정보 내역 그리드 출력
function purPayDtlPop_getPurPayList() {

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
        url : '<ifv:action name="getPurPayDtlPopList"/>',
        colNames:[
            '<spring:message code="M02199"/>', // 결제방법
            '<spring:message code="M02085"/>', // 결제금액
            '<spring:message code="M02111"/>', // 카드유형
            '<spring:message code="M02204"/>', // 카드번호
            'rid',
        ],
        colModel:[
            { name:'payMethdCdNm', index:'c2.mark_name', resizable: false, align:'center', width:'70px' },
            { name:'amt'         , index:'t1.amt'      , resizable: false, align:'center', width:'70px', formatter: numberFormat },
            { name:'cardNm'      , index:'c1.mark_name', resizable: false, align:'center', width:'70px' },
            { name:'cardNo'      , index:'t1.card_no'  , resizable: false, align:'center', width:'70px' },
            { name:'rid'         , index:'t1.rid'      , hidden : true } ,
        ],
        sortname : 't1.rid',
        sortorder : "desc",
        rowList : [ 100000 ],
        radio : true,
        tempId : 'ifvGridSimpleTemplete'
    };

    purPayDtlPop_objPurPayDtlPopList = $("#purPayDtlPopList").ifvGrid({
        jqGridOption : jqGridOption
    });
}

//마스크해제
function purPayDtlPop_clearPurPayMaskAction() {

    var v_rid;
    if ($.fn.ifvmIsNotEmpty(purPayDtlPop_objPurPayDtlPopList.getCheckedGridData()[0])) {
        v_rid = purPayDtlPop_objPurPayDtlPopList.getCheckedGridData()[0].rid;
    }
    else {
        alert('<spring:message code="M02219"/>');
    }

    if ($.fn.ifvmIsNotEmpty(v_rid)) {

        $.ifvSyncPostJSON('<ifv:action name="clearMaskPurPayDtl"/>', {
            rid : v_rid
        }, function(result) {
            var rowid = purPayDtlPop_objPurPayDtlPopList.getRadioSelectedRowId();
            purPayDtlPop_objPurPayDtlPopList.opt.grid.setCell(rowid, 'cardNo', result.cardNo); //카드번호 셋팅
        });

    }
}

//숫자 콤마표시
function numberFormat(cellvalue, options, rowObjec) {
    var value = "";
    if ($.fn.ifvmIsNotEmpty(cellvalue)) {
        value = $.ifvNumberFormat(cellvalue);
    }
    return value;
}
function checkButtnAuth(){
	var isAuth = false;
	var authArr = $.ifvmGetAuthInfo().authList;
	for(var i = 0 ; i < authArr.length ; i++){
		var authObj = authArr[i];
		var authName = authObj.authName;
		if(authName == 'E10010') isAuth = true;
	}
	if(!isAuth){
		$("#btnPurPayMasking").remove();
	}

}
$(document).ready(function() {
	//마스킹해제 권한 체크
	//checkButtnAuth();

    purPayDtlPop_getPurPayList();

    $("#btnCancel").on('click', function() {
        purPayDtlPop_objPurPayDtlPopList = null;
        popupClose();
    });

    $("#btnPurPayMasking").on('click', function() {
        purPayDtlPop_clearPurPayMaskAction();
    });

});

</script>

<div id='purPayDtlPopFormArea'>

<div class="page_btn_area" id="headForm">
    <div class="searchbtn_r">
        <button class="btn btn-sm" id="btnPurPayMasking"><spring:message code="L00326"/></button>
    </div>
</div>

    <div class="pop_inner_wrap">
        <div id="purPayDtlPopList" class="grid_bd0 grid_w980"></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_lightGray2" id="btnCancel">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>
