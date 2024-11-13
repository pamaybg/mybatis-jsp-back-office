<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var loyProdListPopGrid;
var gridIdloyProdListPopGrid;

function initLoyProdListPopData(){
	var jqGridOption = {
		loadComplete : function(obj) {
 		},
		onSelectRow : function (data) {
		},
		serializeGridData : function( data ){
			if (typeof getRidBrdCatAndRidProdCat == "function") {
				var getRid = getRidBrdCatAndRidProdCat();
				data.ridBrdCat = getRid.ridBrdCat;
				data.ridProdCat = getRid.ridProdCat;
			}
		},
	    url:'<ifvm:action name="getLoyProdList"/>',
	    colNames:[
	               "<spring:message code='L00230'/>",
	               "<spring:message code='L00231'/>",
	               "<spring:message code='L00232'/>",
	               "<spring:message code='L00233'/>",
	               "<spring:message code='L00234'/>",
	               'catId',
	               'rid'
	              ],
	    colModel:[
					{name:'catId',index:'t2.cat_cd', width:'80px', align:'center', resizable : false},
					{name:'prodId',index:'t1.prod_id', width:'100px', resizable : false },
					{name:'prodNm',index:'t1.prod_nm', width:'80px', align:'center', resizable : false},
					{name:'createByNm',index:'e1.name', width:'100px', align:'center',resizable : false},
					{name:'createDate',index:'t1.create_date', width:'100px', align:'center',resizable : false},
					{name:'catId', index:'', resizable : false,  hidden : true,  searchable : false},
		            {name:'rid', index:'', resizable : false,  hidden : true,  searchable : false}
	    ],
	    radio : true,
	    sortname: 't1.create_date',
		autowidth : true , sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};

	loyProdListPopGrid = $("#loyProdListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdloyProdListPopGrid = $("#gridIdloyProdListPopGrid");
	gridIdloyProdListPopGrid.resize();
}

//숫자 콤마표시
function numberFormat(cellvalue, options, rowObjec) {
	var value = "";
	if (isNotEmpty(cellvalue)) {
		value = $.ifvNumberFormat(cellvalue);
	}
	return value;
}


$(document).ready(function(){
	initLoyProdListPopData();

	//선택 클릭시
    $('#loyProdListPopSelectBtn').on('click', function(){
    	loyProdListPopupSelect();
    });

	//취소 클릭시
    $('#loyProdListPopCancelBtn').on('click', function(){
    	loyProdListPopupClose();
    });
});
</script>

<div id="loyProdListPopWrap">
	<div class="pop_inner_wrap">
		<div id="loyProdListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="loyProdListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="loyProdListPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>