<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var storeGrid;
var gridIdstoreGrid;

var store_camId = diagram._selectedObject.actualTaskId; // 캠페인ID
var storeChnlListPopup; // 스토어 선택 팝업 

function initStorePopup() {
    cDialog.model.title = "<spring:message code='M02457'/>";
    $("#dialog_title").append("<spring:message code='M02457'/>");
    cDialog.model.width = "500";
    cDialog.model.close = "storePopupClose";
}

/**
 * 선택된 스토어 그리드 출력
 */
function initStoreGrid() {

    var jqGridOption = {
        serializeGridData : function(data) {
            data.camId = store_camId;
            return data;
        },
        loadComplete : function(obj) {
        },
        url: '<ifvm:action name="getStoreList"/>',
        colNames:[
                  '<spring:message code="M02458"/>',
                  '<spring:message code="M02459"/>',
                  '<spring:message code="L00616"/>',
                  'storeId',
                  'id',
        ],
        colModel:[
            {name:'storeNo',  index:'t2.chnl_no',  resizable : false, align:'center' },
            {name:'storeNm',  index:'t2.chnl_nm',  resizable : false, align:'center' },
            {name:'stnDivNm', index:'c1.mark_name', resizable : false, align:'center' },
            {name:'storeId',  index:'t1.store_id', hidden : true },
            {name:'id',       index:'t1.id',       hidden : true },
        ],
        multiselect: true,
        sortname: 't1.id',
        sortorder: "desc"
    };
    storeGrid = $("#storeGridDiv").ifvGrid({ jqGridOption : jqGridOption });
    gridIdstoreGrid = $("#gridIdstoreGridDiv");
    setTimeout(function() {
        storeGrid.resize();
    }, 300);
}

/**
 * 스토어 팝업 종료
 */
function storePopupClose() {
    cDialog._destroy();
}

/**
 * 스토어 선택 팝업 호출
 */
function storeChnlListPopupOpen() {
    
    storeChnlListPopup = $("#storeChnlListPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="storeChnlListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='M02460'/>",
        width: 500,
        close : 'storeChnlListPopupClose'
    });
}
/**
 * 스토어 선택 팝업 닫기
 */
function storeChnlListPopupClose() {
    storeChnlListPopup.ejDialog('destroy');
}

/**
 * 스토어 삭제
 */
function removeStore() {
    
    var storeList = storeGrid.getCheckedList();
    var idList = new Array();
    
    if (storeList.length > 0) {

        for (var i = 0 ; i < storeList.length ; i++) {
            idList[i] = storeList[i].id;
        }
        
        var data = {
                camId : store_camId,
                idList : idList
        };
        
        $.ifvSyncPostJSON('<ifvm:action name="removeStoreList"/>', data, function(result) {
            if (result.success == true) {
                alert('<spring:message code="M00429"/>');
                initStoreGrid();
            }
        });
    }
}


$(document).ready(function() {
    
    initStorePopup();
    
    initStoreGrid();

    // 취소 클릭시
    $('#storeListPopCancelBtn').on('click', function() {
        storePopupClose();
    });

    // 스토어 추가
    $('#storeChnlListPopOpenBtn').on('click', function() {
        storeChnlListPopupOpen();
    });

    // 스토어 삭제
    $('#removeStore').on('click', function() {
        removeStore();
    });

});
    
</script>

<div id="storeListPopWrap">
    <div class="page_btn_area" style="padding-right: 0px;">
        <div class="searchbtn_r">
            <button class="btn btn-sm" id='storeChnlListPopOpenBtn'>
                <spring:message code="C00085"/>
            </button>
            <button class="btn btn-sm" id='removeStore'>
                <spring:message code="L00029"/>
            </button>
        </div>
    </div>
    <div class="pop_inner_wrap">
        <div id="storeGridDiv"></div>
    </div>
</div>

<div class="pop_btn_area">
    <button class="btn btn-sm btn_lightGray2" id="storeListPopCancelBtn">         
        <spring:message code="M00441"/>
    </button> 
</div>
<div id="storeChnlListPopup"></div>