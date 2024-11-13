<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function getUsedSegRptListGrid(){
	
    //그리드 생성
    var jqGridOption = {
        url : '<ifv:action name="getSegRptUsedList"/>',
        postData : {lgcCompId : lgcCompData.lgcCompId},
        colNames:[ '<spring:message code="M01682"/>',
                   '<spring:message code="M01683"/>',
                   'id'
                 ],
        colModel:[
            { name:'objType', index:'objType', resizable : false },
            { name:'objNm', index:'objNm', resizable : false },
            { name:'objId', index:'objId', hidden : true }
        ],
        sortname: 'obj.CREATE_DATE',
        sortorder: "desc",
        rowList: [5, 10],
        tempId : 'ifvGridOriginTemplete'
    };
    
    logicalComponentListGrid = $("#segRptUsedList").ifvGrid({ jqGridOption : jqGridOption });
}

function logicalComponentPop_Init() {
	getUsedSegRptListGrid();	
}


function logicalComponentPop_Handler() {
	
	// 닫기
	$("#btnPopupClose").click(function(){
		logicalComponentPopClose();
	});
	
}

$(document).ready(function(){
	
	logicalComponentPop_Init();
	logicalComponentPop_Handler();
	
});
</script>

<div id="contentTypeArea">
	<div class="pop_inner_wrap">
		<div class="form-horizontal underline">
			<div class="row qt_border store_content_top">
				<div class="col-xs-12">
					<div id="segRptUsedList" class="col-xs-12 control_content con_size grid_scroll10"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="pop_btn_area">
	    <button id="btnPopupClose" class="btn btn-sm btn_lightGray2" objCode="lcsbtnPopupClose_OBJ">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>