<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var loyProdCategoryListPopGrid; 
var gridIdloyProdCategoryListPopGrid;

function initLoyProdCategoryListPopData(){
	var jqGridOption = {
		loadComplete : function(obj){
 		},
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){
			if (typeof getRidBrdCat == "function") {
				var ridBrdCat = getRidBrdCat();
				data.ridBrdCat = ridBrdCat;
			}
		},
	    url:'<ifvm:action name="getLoyProdCategoryList"/>',
	    colNames:[ 
	               "<spring:message code='L00226'/>",
	               "<spring:message code='L00227'/>",
	               "<spring:message code='L00228'/>",
	               "<spring:message code='L00229'/>",
	               'rid'
	              ],
	    colModel:[
					{name:'catId',index:'t1.cat_id', width:'80px', align:'center', resizable : false},
					{name:'catNm',index:'t1.cat_nm', width:'100px', resizable : false },
					{name:'createByNm',index:'e1.name', width:'100px', align:'center',resizable : false},
					{name:'createDate',index:'t1.create_date', width:'100px', align:'center',resizable : false},
		            {name:'rid', index:'', resizable : false,  hidden : true,  searchable : false}
	    ],
	    radio : true,
	    sortname: 't1.create_date',
		autowidth : true , sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	
	loyProdCategoryListPopGrid = $("#loyProdCategoryListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdloyProdCategoryListPopGrid = $("#gridIdloyProdCategoryListPopGrid");
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
	initLoyProdCategoryListPopData();
	
	//선택 클릭시
    $('#loyProdCategoryListPopSelectBtn').on('click', function(){
    	loyProdCategoryListPopupSelect();
    });
	
	//취소 클릭시
    $('#loyProdCategoryListPopCancelBtn').on('click', function(){
    	loyProdCategoryListPopupClose();
    });
});
</script>

<div id="loyProdCategoryListPopWrap">
	<div class="pop_inner_wrap">
		<div id="loyProdCategoryListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="loyProdCategoryListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="loyProdCategoryListPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>