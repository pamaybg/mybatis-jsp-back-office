<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style type="text/css">
	#targetGroupColumnListGrid{
		padding-top: 5px;
		padding-bottom: 5px;
	}
</style>

<script id="costTotalTemplate" type="text/ifvGrid-tmpl">
    <div class="ifv_grid_templete">
        <div class="grid_con">
            {grid}
        </div>
    </div>
</script>

<script>
//grid
var targetGroupColumnListGrid;
var targetGroupColumnListData;

//타겟그룹 컬럼 목록
function getTargetGroupColumnList(){
    
    var targetGroupId = targetGroup.targetGroupId;
    
    var targetGroupColList = [];
    
    //타겟그룹 대상자 컬럼 목록 조회
    $.ifvSyncPostJSON('<ifvm:action name="getSimpleTargetGroupColumnAllList"/>', {
        targetGroupId: targetGroupId
    },
    function(result) {
        if (result.length > 0) {
        	targetGroupColList = result;
        }
    });
    
    //그리드 생성
    var jqGridOption = {
            loadComplete : function(obj){
                targetGroupColumnListData = obj.rows;
     		},
            data: targetGroupColList,
            datatype: 'clientSide',
            colNames:[ 
                       '<spring:message code="M01164" />',
                     ],
            colModel:[
                { name:'displayName', index:'displayName', resizable : false, width: 300},
            ],
            multiselect: true,
            tempId : 'ifvGridSimpleTemplete',
            rowList : [100000],
    };
    
    targetGroupColumnListGrid = $("#targetGroupColumnListGrid").ifvGrid({ jqGridOption : jqGridOption });
    
    $("#targetGroupColumnListGrid .total_area").remove();
    //체크박스 설정
    setRowChecked();
}

//체크박스 설정
function setRowChecked() {
    var list = targetGroupColumnListData;
    var checkIdxList = [];
    $.each(list, function(index, col) {
        if (col.targetGroupColUseFlag == "1") {
        	checkIdxList.push(index+1);
        	col.targetGroupColUseFlag = "0";
        }
    });
    
    targetGroupColumnListGrid.setCheckRow(checkIdxList);
}

//타겟그룹 컬럼 저장
function saveTargetGroupColumn() {
    var requestData = {};
    $.each(targetGroupColumnListGrid.getCheckedRowIds(), function(index, rowid) {
       var idx = Number(rowid) - 1;
       targetGroupColumnListData[idx].targetGroupColUseFlag = "1";
    });
    
    requestData.targetGroupColList = targetGroupColumnListData;
    
    //세그먼트 등록
    $.ifvSyncPostJSON('<ifvm:action name="saveTargetGroupColumn"/>', requestData,
    function(result) {
        //대상자 목록 조회
		getTargetGroupTargetListFlag(true);

        //팝업 닫기
        simpleTargetColumnSetPopupClose();
    });
}

$(document).ready(function() {
    getTargetGroupColumnList();
	
	//확인 클릭시
    $('#targetGroupColumnSetPopAddBtn').on('click', function(){
        saveTargetGroupColumn();
    });
    
	//닫기 클릭시
    $('#targetGroupColumnSetPopCloseBtn').on('click', function(){
    	simpleTargetColumnSetPopupClose();
    });
});
</script>

<div id="simpleTargetColumnSetPopupWrap">
	<div class="pop_inner_wrap form-horizontal" id="targetGroupColumnSetPop" >
        <div id="targetGroupColumnListGrid" class="con_size grid_scroll10" style="width:350px;"></div>
	</div>
	<div class="pop_btn_area bd_top0">
	    <button class="btn btn-sm btn_gray" style ="color : white;" id="targetGroupColumnSetPopAddBtn" objCode="targetGroupColumnSetPopAddBtn_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00804"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" style ="color : white;" id="targetGroupColumnSetPopCloseBtn" objCode="targetGroupColumnSetPopCloseBtn_OBJ">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>