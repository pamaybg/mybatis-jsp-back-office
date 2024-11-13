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
        	serializeGridData : function(data) {
            	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }
                data.authType = authType;
                data.empId = empId;
                data.brandCd = brandCd;
                return data;
            },
        url:'<ifvm:action name="copytgtImportData"/>',
        colNames:[ 
            '<spring:message code="M01490" />',
            '<spring:message code="M00560" />',
            '<spring:message code="M00184" />',
            '<spring:message code="M00185" />',
            'id'
          ],
	    colModel:[
	       { name:'targetGroupName', index:'tg.tgt_group_nm', width:'150px', align: 'left', resizable : true },
	       { name:'targetGroupDesc', index:'tg.tgt_group_desc', width:'150px', align: 'left', resizable : true },
	       { name:'createByName', index:'e.name', width:'100px', align: 'center', resizable : true },
	       { name:'createDate', index:'tg.create_date', width:'100px', align: 'center', resizable : true },
	       { name:'targetGroupId', index:'tg.id', hidden : true } 
	    ],
        sortname: 'tg.create_date',
        sortorder: "desc",
        radio : true,
        tempId : 'ifvGridOriginTemplete',
    };
    importListPopGrid = $("#importListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdimportListPopGrid = $("#gridIdimportListPopGrid");
}

$(document).ready(function() {

    getImportListPopGrid();

    // 선택 버튼
    $('#importListSelectBtn').on('click', function() {
        targetImportMain.importListSelect();
    });
    // 취소버튼
    $('#importListCancelBtn').on('click', function() {
        targetImportMain.importListPopupClose();
    });
}); 

</script>

<div id="importListPopWrap">
    <div class="pop_inner_wrap">
        <div id="importListPopGrid" ></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="importListSelectBtn" objCode="importListSelectBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="importListCancelBtn" objCode="importListCancelBtn_OBJ">         
            <spring:message code="M00284"/>
        </button> 
    </div>
</div>