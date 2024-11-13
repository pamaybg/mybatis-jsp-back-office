<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var importListPopGrid;
var gridIdimportListPopGrid;

/**
 * Import
 */
function getImportListPopGrid() {
    var jqGridOption = {
//         serializeGridData: function(data) {
//             data.camId = camId;
//             return data;
//         },
        onSelectRow : function(data) {
        },
        loadComplete : function(obj) {
        },
        url:'<ifvm:action name="getChargingStationImportList"/>',
        colNames:[
                  '<spring:message code="L00155"/>',
                  '<spring:message code="L00269"/>',
                  '<spring:message code="M02438"/>',
                  '<spring:message code="L01078"/>',
                  '<spring:message code="L01077"/>',
                  'camId',
                  'hadId',
        ],
        colModel:[
            { name:'fileType',   index:'cc4.code_name',   resizable : false, width: '80px'},
            { name:'camNm',      index:'cam.cam_nm',      resizable : false},            
            { name:'segName',    index:'mth.seg_nm',      resizable : false},
            { name:'createByNm', index:'em.name',         resizable : false, width: '100px'},
            { name:'createDate', index:'mth.create_date', resizable : false},
            { name:'camId',      index:'mth.cam_id', resizable : false, hidden : true, searchable : false},
            { name:'hadId',      index:'mth.id',     resizable : false, hidden : true, searchable : false},
        ],
        sortname: 'mth.id',
        sortorder: "desc",
        radio : true,
    };
    importListPopGrid = $("#importListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdimportListPopGrid = $("#gridIdimportListPopGrid");
    gridIdimportListPopGrid.resize();
}

$(document).ready(function() {

    getImportListPopGrid();

    // 선택 버튼
    $('#importListSelectBtn').on('click', function() {
        importListSelect();
    });
    // 취소버튼
    $('#importListCancelBtn').on('click', function() {
        importListPopupClose();
    });
});

</script>

<div id="importListPopWrap">
    <div class="pop_inner_wrap">
        <div id="importListPopGrid" ></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="importListSelectBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="importListCancelBtn">         
            <spring:message code="M00284"/>
        </button> 
    </div>
</div>