<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var targetSqlListPopGrid;
var gridIdtargetSqlListPopGrid;

/**
 * 타겟SQL 목록 조회
 */
function getTargetSqlPopGrid() {
    var jqGridOption = {
        serializeGridData: function(data) {
            return data;
        },
        onSelectRow : function(data) {
        },
        loadComplete : function(obj) {
        },
        url: '<ifvm:action name="getTargetSqlList"/>',
	    colNames:[
	              '<spring:message code="M01490"/>',
	              '<spring:message code="M00184"/>',
	              '<spring:message code="M00185"/>',
	              'dbInformId',
	              'extrYn'
		],
	    colModel:[
	              {name:'targetGroupName', 	index:'tg.tgt_group_nm', resizable : false},
	              {name:'createByName', 	index:'e.name', 		 resizable : false},
	              {name:'createDate', 		index:'tg.create_date',  resizable : false},
	              {name:'targetGroupId', 	index:'tg.id', 			 hidden : true},
	              {name:'extrYn', 	        index:'tg.extr_yn', 			 hidden : true}
        ],
	    sortname: 'tg.create_date',
		sortorder: "desc",
        radio : true,
        tempId : 'ifvGridOriginTemplete'
    };
    targetSqlListPopGrid = $("#targetSqlListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
    gridIdtargetSqlListPopGrid = $("#gridIdtargetSqlListPopGrid");
    gridIdtargetSqlListPopGrid.resize();
}

$(document).ready(function() {

    getTargetSqlPopGrid();

    // 선택 버튼
    $('#targetSqlSelectBtn').on('click', function() {
    	targetSqlMain.targetSqlSelect();
    });
    // 취소버튼
    $('#targetSqlSelectCancelBtn').on('click', function() {
    	targetSqlMain.targetSqlListPopupClose();
    });
});

</script>

<div id="targetSqlistPopWrap">
    <div class="pop_inner_wrap">
        <div id="targetSqlListPopGrid" ></div>
    </div>
    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="targetSqlSelectBtn" objCode="targetSqlSelectBtn_OBJ">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="targetSqlSelectCancelBtn" objCode="targetSqlSelectCancelBtn_OBJ">
            <spring:message code="M00284"/>
        </button>
    </div>
</div>