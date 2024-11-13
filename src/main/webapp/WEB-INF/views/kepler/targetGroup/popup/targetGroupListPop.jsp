<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>
	.ui-jqgrid .ui-jqgrid-bdiv {
		position: relative;
		margin: 0em;
		padding: 0;
		overflow: hidden;
		text-align: left;
	}
	.popup_container .pop_inner_wrap {
		overflow: hidden;
	}
</style>
<script>
var targetGroupListPopGrid; 
var gridIdtargetGroupListPopGrid


//캠페인 목록
function getTargetGroupList(){
    var jqGridOption = {
    	serializeGridData : function(data) {
        	if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
			data.authType = authType;
			data.empId = empId;
			data.brandCd = brandCd;
        	data.workflowFlag = "Y";
            return data;
        },
         ondblClickRow : function (rowNo) {
        	//var data = targetGroupListGrid.getRowData()[rowNo-1];
        	//goTargetGroupDetail(data.targetGroupId);
        }, 
        url : '<ifvm:action name="getTargetGroupList"/>',
        colNames:[ 
        		   '<spring:message code="M00677"/>',
                   '<spring:message code="M01490" />',
                   '<spring:message code="M00184" />',
                   '<spring:message code="M00185" />',
                   '<spring:message code="M00546" />',
                   'id'
                 ],
        colModel:[
            { name:'segmentName', index:'sm.seg_nm', width:'150px', align: 'left', resizable : true },
            { name:'targetGroupName', index:'tg.tgt_group_nm', width:'150px', align: 'left', resizable : true },
            { name:'createByName', index:'e.name', width:'100px', align: 'center', resizable : true },
            { name:'createDate', index:'tg.create_date', width:'100px', align: 'center', resizable : true },
            { name:'segmentId', index:'sm.id', hidden : true },
            { name:'targetGroupId', index:'tg.id', hidden : true } 
        ],
        sortname: 'tg.create_date',
        sortorder: "desc",
        radio: true,
        tempId : 'ifvGridOriginTemplete'
    };
    
    targetGroupListPopGrid = $("#targetGroupListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdtargetGroupListPopGrid = $("#gridIdtargetGroupListPopGrid");
}




function searchStorePopData() {
	var targetGroupListPopupData = targetGroupListPopGrid.getCheckedList();
	if(targetGroupListPopupData.length > 0){
		$('#ctrlGroupId').val(targetGroupListPopupData[0].targetGroupId);
		$('#conTrolGroupMethodText').val(targetGroupListPopupData[0].targetGroupName);
		targetGroupList._destroy();
		
	}else{
		alert('<spring:message code="L00066"/>');
	}
}

var searchCheck = "";
$(document).ready(function(){
    getTargetGroupList();
	//세그먼트 선택 버튼
	$("#targetGroupSelectBtn").on("click",function(){
		if(searchCheck == 'y'){
			searchStorePopData();
		}else{
	    	targetGroupMain.targetGroupSelect();
		}
	}); 
	
	$("#targerGroupCancelBtn").on("click", function(){
		if(searchCheck == 'y'){
			searchStorePopClose();
		}else{
	    	targetGroupMain.targetGroupListPopupClose();
		}
	});
	
});
</script>


<div id="targetGroupListPop_wrap">
	<div class="pop_inner_wrap">
		<div id="targetGroupListPopGrid" class="col-xs-12"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="targetGroupSelectBtn" objCode="targetGroupSelectBtn_OBJ">  
			<i class="glyphicon glyphicon-check"></i>       
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="targerGroupCancelBtn" objCode="targerGroupCancelBtn_OBJ">
			<spring:message code="M00284"/>
		</button>
	</div> 
</div>