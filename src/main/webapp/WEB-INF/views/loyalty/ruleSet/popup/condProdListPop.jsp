<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var condProdPopGrid;

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
	    url:'<ifvm:action name="getProdList"/>',
	    colNames:[
	               "<spring:message code='L00231'/>",
	               "<spring:message code='L00232'/>",
	               "<spring:message code='L00233'/>",
	               "<spring:message code='L00234'/>",
	               "가격",
	               'catId',
	               'rid'
	              ],
	    colModel:[
					{name:'prodId',index:'lp.prod_id', width:'100px', resizable : false },
					{name:'prodNm',index:'lp.prod_nm', width:'80px', align:'center', resizable : false},
					{name:'createByNm',index:'lp.name', width:'100px', align:'center',resizable : false},
					{name:'createDate',index:'lp.create_date', width:'100px', align:'center',resizable : false},
					{name:'prodAmt',index:'lp.prodAmt', width:'100px',  resizable : false, align:'right',formatter:'integer' },
					{name:'catId', index:'', resizable : false,  hidden : true,  searchable : false},
		            {name:'rid', index:'', resizable : false,  hidden : true,  searchable : false}
	    ],
	    radio : true,
	    sortname: 'lp.create_date',
		autowidth : true , sortorder: "desc",
		tempId : 'ifvGridSimpleTemplete'
	};

	condProdPopGrid = $("#condProdPopGrid").ifvGrid({ jqGridOption : jqGridOption });
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
    $('#condProdPopSelectBtn').on('click', function(){
    	condProdListPopupSave();
    });

	//취소 클릭시
    $('#condProdPopCancelBtn').on('click', function(){
    	condProdListPopClose();
    });
});
</script>

<div id="condProdPopWrap">
	<div class="pop_inner_wrap">
		<div id="condProdPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="condProdPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button>
	    <button class="btn btn-sm" id="condProdPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>