<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">

var gradeGrid;
var gradeGridDiv;

/**
 * 채널목록 조회
 */
function getGradeList() {

    var jqGridOption = {
        ondblClickRow : function(data) {
            var data = channelList.getRowData()[data - 1];
            rid = data.rid;
        },
        onSelectRow : function(data) {
        },
        serializeGridData : function(data) {
            if ($.fn.ifvmIsNotEmpty(requestitem)) {
                data.item = requestitem;
            }
            return data;
        },
        loadComplete : function(obj) {
        },
        url : '<ifvm:action name="getTierListByGroup"/>',
        colNames:[
            '<spring:message code="L00235" />',
            '<spring:message code="L00236" />',
            'ridTier',
        ],
        colModel:[
             { name:'tierCd',  index:'t2.tier_cd', resizable : true, align:'center', width:'100px' },
             { name:'tierNm',  index:'t2.tier_nm', resizable : true, align:'center', width:'100px' },
             { name:'ridTier', index:'t2.rid',     hidden : true },
        ],
        sortname : 't2.rid',
        sortorder : "desc",
        radio: true
    };

    gradeGrid = $("#channelListGrid").ifvGrid({
        jqGridOption : jqGridOption
    });
    gradeGridDiv = $("#channelListGrid");
    gradeGridDiv.resize();
}

$(document).ready(function() {

    getGradeList() ;

    // 선택
    $("#gradeSelectBtn").on("click", function() {
        selectGrade();
    });

    // 취소
    $("#gradeListPopCancelBtn").on("click", function() {
        gradeListPopClose();
    });

});

</script>

<div id="gradeListPopWrap">
    <div class="pop_inner_wrap form-horizontal" id="gradeListPop" >
        <div id="channelListGrid"></div>
    </div>

    <div class="pop_btn_area">
        <button class="btn btn-sm btn_gray" id="gradeSelectBtn">
            <i class="glyphicon glyphicon-check"></i>
            <spring:message code="M00282"/>
        </button>
        <button class="btn btn-sm btn_lightGray2" id="gradeListPopCancelBtn">
            <spring:message code="M00441"/>
        </button>
    </div>
</div>
