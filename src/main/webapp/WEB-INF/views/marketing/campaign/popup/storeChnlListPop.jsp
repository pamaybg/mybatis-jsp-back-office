<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var storeChnlGrid;
var storeChnlGridDiv;

/** 
 * 채널목록 조회
 */
function getStoreChnlGrid() {
    
    var jqGridOption = {
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            data.camId = store_camId;
            return data;
        },
        loadComplete : function(obj) {
        	//2018.01.25 hy.jun rowList 변경시 스크롤이 생기지 않아 잘리는 문제 해결
        	$("#storeChnlListPopup").css('overflow-y', 'scroll');
        },
        url : '<ifvm:action name="getExceptIdsChannelList"/>',
        colNames:[ 
            '<spring:message code="M02458" />',
            '<spring:message code="M02459" />',
            '<spring:message code="L00616" />',
        ],
        colModel:[
             { name:'chnlNo',   index:'a.chnl_no',    resizable : true, align:'center' },
             { name:'chnlNm',   index:'a.chnl_nm',    resizable : true, align:'center' },
             { name:'stnDivNm', index:'c2.mark_name', resizable : true, align:'center' },
        ],
        sortname : 'a.rid',
        sortorder : "desc",
        multiselect: true, 
        tempId : 'ifvGridOriginTemplete'
    };

    storeChnlGrid = $("#storeChnlGridDiv").ifvGrid({
        jqGridOption : jqGridOption
    });
    storeChnlGridDiv = $("#storeChnlGridDiv");
    storeChnlGridDiv.resize();
}

/**
 * 선택한 채널 스토어에 추가
 */
function saveStoreChnl() {
    
    var storeList = storeChnlGrid.getCheckedList();
    var storeIdList = new Array();
    
    if (storeList.length > 0) {

        for (var i = 0 ; i < storeList.length ; i++) {
            storeIdList[i] = storeList[i].rid;
        }
        
        var data = {
                camId : store_camId,
                storeIdList : storeIdList
        };
        
        $.ifvSyncPostJSON('<ifvm:action name="saveStoreList"/>', data, function(result) {
            if (result.success == true) {
                alert('<spring:message code="M00429"/>');

                initStoreGrid();
                
                // 팝업 종료
                storeChnlListPopupClose();
            }
        });
    }
}

$(document).ready(function() {
    
    getStoreChnlGrid();
    
    // 선택 버튼
    $('#storeAddBtn').on('click', function() {
        saveStoreChnl();
    });
    
    // 닫기 버튼
    $('#storeChnlListPopCancelBtn').on('click', function() {
        storeChnlListPopupClose();
    });
});
    
</script>

<div id="useDeskPopWrap">
    <div class="pop_inner_wrap form-horizontal" id="storeChnlListPop" >
        <div id="storeChnlGridDiv"></div>
    </div>
    
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="storeAddBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M01855"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="storeChnlListPopCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>