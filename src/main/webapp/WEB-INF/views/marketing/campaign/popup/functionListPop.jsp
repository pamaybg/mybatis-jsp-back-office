<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var functionListGrid;

//로지컬 컴포넌트 목록
function getFunctionListGrid(){
    //그리드 생성
    var jqGridOption = {
        serializeGridData : function( data ){
        	//node 유형
        	data.nodeTypeCd = nodeTypeCd;
        	
        	//rule 유형
        	data.subTypeCd = $("#type").val();
        	
            return data;
        },
        url : '<ifvm:action name="getETFunctionList"/>',
        colNames:[ "<spring:message code='M01890'/>",
                   "<spring:message code='M01892'/>",
                   "<spring:message code='M01893'/>",
                   "<spring:message code='M01894'/>",
                   'rid'
                 ],
        colModel:[
            { name:'subInputScrn', index:'t2.input_scrn', align: 'center', resizable : false },
            { name:'subDesctxt', index:'t2.desctxt', align: 'center', resizable : false },
            { name:'createByNm', index:'e.name', align: 'center', resizable : false },
            { name:'createDate', index:'t2.create_date', align: 'center', resizable : false },
            { name:'rid', index:'', hidden : true }
        ],
        sortname: 't2.create_date',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    functionListGrid = $("#functionListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
    getFunctionListGrid();
	
	//확인 클릭시
    $('#functionListPopConfirmBtn').on('click', function(){
    	functionListPopupSelect();
    });
    
	//닫기 클릭시
    $('#functionListPopCloseBtn').on('click', function(){
    	functionListPopupClose();
    });
});
</script>

<div id="dialogProgPopupWrap">
	<div class="pop_inner_wrap form-horizontal" id="functionListPop" >
        <div id="functionListGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area bd_top0">
	    <button class="btn btn-sm btn_gray" id="functionListPopConfirmBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00804"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="functionListPopCloseBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>