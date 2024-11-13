<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var intactTypePopGrid;
var gridIdintactTypePopGrid;

//이벤트 유형 목록 그리드 설정
function intactTypePopGrid(){
	var jqGridOption = {
		loadComplete : function(obj){
 			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'intactTypePop',
				contentsId : 'intactTypePopCon'
			});
 		},
		onSelectRow : function (data) {

		},
		serializeGridData : function( data ){

		},
	    url:'<ifvm:action name="getETIntactTypeList"/>',
	    colNames:[
	               '<spring:message code="M01861"/>',
	               '<spring:message code="M01862"/>',
	               '<spring:message code="M01859"/>',
	               '<spring:message code="M01860"/>',
	               'id'
	              ],
	    colModel:[
					{name:'intactType_1CdNm',index:'c1.mark_name', width:'100px', resizable : false, cellattr: function(){ return 'style="text-overflow:ellipsis;"';}},
					{name:'intactType_2CdNm',index:'c2.mark_name', width:'100px', align:'center',resizable : false},
					{name:'createByNm',index:'e.name', width:'100px', align:'center',resizable : false},
					{name:'createDate',index:'t1.create_date', width:'100px', align:'center',resizable : false, formatter: "date", formatoptions: { newformat: "Y-m-d H:i:s" }},
		            {name:'rid', index:'t1.rid', resizable : false,  hidden : true,  searchable : false}
	    ],
	    radio : true,
	    sortname: 't1.create_date',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	intactTypePopGrid = $("#intactTypePopGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdintactTypePopGrid = $("#gridIdintactTypePopGrid");
}

//숫자 콤마표시
function numberFormat2(cellvalue, options, rowObjec) {
	var value = "";
	if (isNotEmpty(cellvalue)) {
		value = $.ifvNumberFormat(cellvalue);
	}

	return value;
}

$(document).ready(function() {
	intactTypePopGrid();

	//선택 클릭시
    $('#intactTypePopSelectBtn').on('click', function() {
        selectIntactType();
    });

	//취소 클릭시
    $('#intactTypePopCancelBtn').on('click', function(){
    	intactTypePopupClose();
    });
});
</script>

<div id="intactTypePopCon">
	<div class="pop_inner_wrap">
		<div id="intactTypePopGrid" class=""></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="intactTypePopSelectBtn" objCode="intactTypePopSelect_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="intactTypePopCancelBtn" objCode="intactTypePopClose_OBJ">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>