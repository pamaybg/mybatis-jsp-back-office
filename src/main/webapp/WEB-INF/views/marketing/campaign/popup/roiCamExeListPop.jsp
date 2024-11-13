<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var camExeItemGrid;

/**
 * 마케팅 플랜 선택을 위한 채널 목록 조회
 */
function initCamExeItemGrid() {

    var jqGridOption = {
        serializeGridData : function(data) {
            data.camId = campaignRoiGoalData.camId;
            return data;
        },
        onSelectCell : function(data) {
        },
        loadComplete : function(obj) {
        },
        url: '<ifvm:action name="getCampaignExeItemList"/>',
        colNames:[
                  '<spring:message code="M00859"/>',
                  '<spring:message code="M01338"/>',
                  '<spring:message code="M01339"/>',
                  '<spring:message code="M02800"/>',
                  'id'
                  ],
        colModel:[
            {name:'exeDt',         index:'t2.exe_dt', 			resizable: false, align:'center', formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
            {name:'exeSeq',        index:'t2.exe_seq', 			resizable: false, align:'center', width: '100px'},
            {name:'exeTgtAmt',     index:'t2.exe_tgt_amt', 		resizable: false, align:'center', width: '100px', formatter: numberFormat},
            {name:'exeTgtSendCnt', index:'t2.exe_tgt_send_cnt', resizable: false, align:'center', width: '100px', formatter: numberFormat, searchable: false},
            {name:'id',            index:'t2.id',               resizable: false, searchable: false, hidden: true}
        ],
        radio: true,
        sortname: 't2.exe_dt',
        sortorder: "asc",
        tempId : 'ifvGridOriginTemplete'
    };
    camExeItemGrid = $("#camExeItemGridDiv").ifvGrid({ jqGridOption : jqGridOption });
    gridIdcamExeItemGrid = $("#camExeItemGridDiv");
    gridIdcamExeItemGrid.resize();
}

//숫자 콤마표시
function numberFormat(cellvalue) {
	var value = "";
	if ($.fn.ifvmIsNotEmpty(cellvalue)) {
		value = $.fn.ifvmNumberWithCommas(cellvalue);
	}
	return value;
}

$(document).ready(function() {

    initCamExeItemGrid();

    // 닫기버튼
    $('#roiCamExeListPopCloseBtn').on('click', function() {
        campaignExeItemPopClose();
    });

    //선택버튼
    $('#camExeItemSelectBtn').on('click', function() {

        var len = camExeItemGrid.getCheckedGridData().length;

        if (len > 0) {
            if (confirm('선택하신 실행 정보로 분석 데이터를 추가합니다.')) {
	            addCampaignRoiGoalCalcRslt(camExeItemGrid.getCheckedGridData()[0].id);
	            campaignExeItemPopClose();
            }
        }
        else {
            alert('<spring:message code="L00066"/>');
        }
    });

});

</script>

<div id="camExeItemListPopWrap">
    <div class="pop_inner_wrap">
        <div id="camExeItemGridDiv"></div>
    </div>
    <div class="pop_btn_area">

        <button class="btn btn-sm btn_gray" id="camExeItemSelectBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button>

        <button class="btn btn-sm btn_lightGray2" id="roiCamExeListPopCloseBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>