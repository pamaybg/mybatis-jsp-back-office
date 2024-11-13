<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var loyChannelListPopGrid;
var gridIdloyChannelListPopGrid;

function initLoyChannelListPopData(){
	var jqGridOption = {
		loadComplete : function(obj) {
 		},
		onSelectRow : function(data) {
		},
		serializeGridData : function(data) {
		    data.ouTypeCd = $("#destinationPathInfoPop #ouTypeCd").val();
		    return data;
		},
	    url:'<ifvm:action name="getLoyChannelList"/>',
	    colNames:[
            "<spring:message code='L00630'/>",
            "<spring:message code='L00564'/>",
            "<spring:message code='L00613'/>",
            "<spring:message code='L00627'/>",
            'rid',
            'ouTypeCd',
        ],
	    colModel:[
            { name:'ouTypeCdNm',      index:'c2.mark_name',  resizable : false, align:'center', width:'80px' },
            { name:'chnlNo',          index:'t1.chnl_no',    resizable : false, align:'center', width:'80px' },
            { name:'chnlNm',          index:'t1.chnl_nm',    resizable : false, align:'left',   width:'100px'},
            { name:'mbrbsStatusCdNm', index:'c2.mark_name',  resizable : false, align:'center', width:'60px' },
            { name:'rid',             index:'t1.rid',        resizable : false, hidden : true,  searchable : false},
            { name:'ouTypeCd',        index:'t1.ou_type_cd', resizable : false, hidden : true,  searchable : false},
	    ],
	    radio : true,
	    sortname: 't1.create_date',
		autowidth : true , sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};

	loyChannelListPopGrid = $("#loyChannelListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdloyChannelListPopGrid = $("#gridIdloyChannelListPopGrid");
	gridIdloyChannelListPopGrid.resize();
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
	initLoyChannelListPopData();

	//선택 클릭시
    $('#loyChannelListPopSelectBtn').on('click', function() {
    	loyChannelListPopupSelect();
    });

	//취소 클릭시
    $('#loyChannelListPopCancelBtn').on('click', function() {
    	loyChannelListPopupClose();
    });
});
</script>

<div id="loyChannelListPopWrap">
	<div class="pop_inner_wrap">
		<div id="loyChannelListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="loyChannelListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="loyChannelListPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>