<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
	.ui-jqgrid .ui-jqgrid-bdiv {
		overflow: hidden;
	}
</style>

<script>
var simpleListPopGrid; 
var gridIdSimpleListPopGrid


//캠페인 목록
function getSimpleList(){
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
        url : '<ifvm:action name="getSimpleList"/>',
        colNames:[ 
                   '<spring:message code="M01490" />',
                   '<spring:message code="M00560" />',
                   '<spring:message code="M00184" />',
                   '<spring:message code="M00185" />',
                   'id'
                 ],
        colModel:[
            { name:'targetGroupName', index:'tg.tgt_group_nm', width:'100px', align: 'left', resizable : true },
            { name:'targetGroupDesc', index:'tg.tgt_group_desc', width:'150px', align: 'left', resizable : true },
            { name:'createByName', index:'e.name', width:'80px', align: 'center', resizable : true },
            { name:'createDate', index:'tg.create_date', width:'100px', align: 'center', resizable : true },
            { name:'targetGroupId', index:'tg.id', hidden : true } 
        ],
        sortname: 'tg.create_date',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    simpleListPopGrid = $("#simpleListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdSimpleListPopGrid = $("#gridIdtargetGroupListPopGrid");
}

$(document).ready(function(){
	getSimpleList();
	
	//세그먼트 선택 버튼
	$("#simpleSelectBtn").on("click",function(){
			simpleTargetingMain.simpleTargetingSelect();
	}); 
	
	$("#simpleCancelBtn").on("click", function(){
			simpleTargetingMain.simpleTargetingListPopupClose();
	});
	
});
</script>


<div id="simpleListPop_wrap">
	<div class="pop_inner_wrap">
		<div id="simpleListPopGrid" class="col-xs-11"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="simpleSelectBtn" objCode="simpleSelectBtn_OBJ">  
			<i class="glyphicon glyphicon-check"></i>       
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="simpleCancelBtn" objCode="simpleCancelBtn_OBJ">
			<spring:message code="M00284"/>
		</button>
	</div> 
</div>