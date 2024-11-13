<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var planGrid;
var planGridDiv;

/**
 * 마케팅 플랜 선택을 위한 채널 목록 조회
 */
function initPlanGrid() {

    var jqGridOption = {
        serializeGridData : function(data) {
            return data;
        },
        onSelectCell : function(data) {
        },
        loadComplete : function(obj) {
        },
        url: '<ifvm:action name="getPlanList"/>',
        colNames:[
                  '<spring:message code="M02291"/>',
                  '<spring:message code="M02292"/>',
                  '<spring:message code="M00756"/>',
                  '<spring:message code="M00607"/>',
                  '<spring:message code="M00883"/>',
                  'id'
                  ],
        colModel:[
            {name:'id',         index:'t1.id',        resizable : false, align:'center'},
            {name:'planNm',     index:'t1.plan_nm',   resizable : false},
            {name:'planPrpsNm', index:'c1.mark_name', resizable : false, align:'center', width: '150px'},
            {name:'planTerm',   index:'',             resizable : false, align:'center', width: '200px', searchable : false},
            {name:'planDesc',   index:'t1.plan_desc', resizable : false},
            {name:'id',         index:'t1.id',        resizable : false, hidden : true, searchable : false}
        ],
        radio: true,
        sortname: 't1.id',
        sortorder: "desc",
        tempId : 'ifvGridOriginTemplete'
    };
    planGrid = $("#planGridDiv").ifvGrid({ jqGridOption : jqGridOption });
    planGridDiv = $("#planGridDiv");
    planGridDiv.resize();
}

$(document).ready(function() {
    
    initPlanGrid();
    
    //선택 클릭시
    $('#planListPopSelectBtn').on('click', function() {
        
        var rowData = {};
        
        if (planGrid.getCheckedGridData().length > 0){
            rowData = planGrid.getCheckedGridData()[0];
        }
        else {
            alert("<spring:message code='L00262'/>");
            return;
        }
        
        if ($.fn.ifvmIsNotEmpty(rowData)) {
            
            //캠페인기본정보에 해당 유형 값 설정
            campaignDefaultInfo.camDefaultInfo.planId = rowData.id;
            $("#planNm").val(rowData.planNm);
            
            //팝업 닫기
            planPopupClose();
        }
    });
    
    //취소 클릭시
    $('#planListPopCancelBtn').on('click', function() {
        planPopupClose();
    });
});
</script>

<div id="planListPopWrap">
    <div class="pop_inner_wrap">
        <div id="planGridDiv"></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="planListPopSelectBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button> 
        <button class="btn btn-sm btn_lightGray2" id="planListPopCancelBtn">         
            <spring:message code="M00441"/>
        </button> 
    </div>
</div>