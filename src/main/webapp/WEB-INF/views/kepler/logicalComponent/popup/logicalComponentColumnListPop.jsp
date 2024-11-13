<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function getColumnMasterListGrid(){
	
	var tblId = diagram.getNode(curClickedTableRelNodeId).addInfo.data.tblMstId;
	
    //그리드 생성
    var jqGridOption = {
        url : '<ifv:action name="getJoinColumnMasterPopupList"/>',
        postData : {tblMstId : tblId},
        colNames:[ '<spring:message code="M01443" />',
                   '<spring:message code="M01442" />',
                   '<spring:message code="M00180" />',
                   'colId'
                 ],
        colModel:[
            { name:'dpNm', index:'acm.dp_Nm', resizable : false },
            { name:'colNm', index:'acm.col_Nm', resizable : false },
            { name:'colType', index:'acm.colType', resizable : false, searchable : false},
            { name:'colId', index:'acm.colId', hidden : true }
        ],
        sortname: 'acm.seq',
        sortorder: "asc",
        rowList: [10, 20],
        tempId : 'ifvGridOriginTemplete'
    };
    
    logicalComponentListGrid = $("#columnListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

function logicalComponentColumnListPop_Init() {
	getColumnMasterListGrid();	
}


function logicalComponentColumnListPop_Handler() {
	
	// 닫기
	$("#btnPopupClose").click(function(){
		logicalComponentPopClose();
	});
	
}

$(document).ready(function(){
	
	logicalComponentColumnListPop_Init();
	logicalComponentColumnListPop_Handler();
	
});
</script>

<div id="contentTypeArea">
	<div class="pop_inner_wrap">
		<div class="form-horizontal underline">
			<div class="row qt_border store_content_top">
				<div class="col-xs-12">
					<div id="columnListGrid" class="col-xs-12 control_content con_size grid_scroll10"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="pop_btn_area">
	    <button id="btnPopupClose" objCode="lCColumnBtnPopupClose_OBJ" class="btn btn-sm btn_lightGray2">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>