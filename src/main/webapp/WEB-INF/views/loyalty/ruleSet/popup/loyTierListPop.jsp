<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var loyTierListPopGrid;
var gridIdloyTierListPopGrid;

function initLoyTierListPopData(){
	var jqGridOption = {
		loadComplete : function(obj) {
 		},
		onSelectRow : function(data) {
		},
		serializeGridData : function(data) {
		    data.ouTypeCe = $("#destinationPathInfoPop #ouTypeCd").val();
		    return data;
		},
	    url:'<ifvm:action name="getTierListByGroup"/>',
	    colNames:[
	        "등급 그룹",    /* 등급그룹*/
            "<spring:message code='L00235'/>",    /* 등급 코드 */
            "<spring:message code='L00236'/>",    /* 등급명*/

            'ridTier',
        ],
	    colModel:[
            { name:'tierGrpNm',          index:'t1.tier_grp_nm',    resizable : false, align:'center', width:'80px' },
            { name:'tierCd',     index:'t2.tier_cd',  	 resizable : false, align:'center', width:'80px' },
            { name:'tierNm',          index:'t2.tier_nm',    resizable : false, align:'center', width:'80px' },
            { name:'ridTier',             index:'t2.rid',        resizable : false, hidden : true,  searchable : false},
	    ],
	    radio : true,
	    sortname: 't1.create_date',
		autowidth : true , sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};

	loyTierListPopGrid = $("#loyTierListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdloyTierListPopGrid = $("#gridIdloyTierListPopGrid");
	gridIdloyTierListPopGrid.resize();
}

//숫자 콤마표시
function numberFormat(cellvalue, options, rowObjec) {
	var value = "";
	if (isNotEmpty(cellvalue)) {
		value = $.ifvNumberFormat(cellvalue);
	}

	return value;
}

$(document).ready(function() {
	initLoyTierListPopData();

	//선택 클릭시
    $('#loyTierListPopSelectBtn').on('click', function() {
    	tierInfoPopupSave();
    });

	//취소 클릭시
    $('#loyTierListPopCancelBtn').on('click', function() {
    	tierInfoPopupClose();
    });
});
</script>

<div id="loyTierListPopWrap">
	<div class="pop_inner_wrap">
		<div id="loyTierListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="loyTierListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="loyTierListPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>