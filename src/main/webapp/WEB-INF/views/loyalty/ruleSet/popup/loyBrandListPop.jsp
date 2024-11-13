<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var loyBrandListPopGrid; 
var gridIdloyBrandListPopGrid;

function initLoyBrandListPopData(){
	var jqGridOption = {
		loadComplete : function(obj){
 		},
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){
			
		},
	    url:'<ifvm:action name="getLoyBrdCategoryList"/>',
	    colNames:[ 
	               "<spring:message code='L00218'/>",
	               "<spring:message code='L00219'/>",
	               "<spring:message code='L00220'/>",
	               "<spring:message code='L00221'/>",
	               'rid'
	              ],
	    colModel:[
					{name:'brdNm',index:'t1.brd_nm', width:'80px', align:'center', resizable : false},
					{name:'brdDesctxt',index:'t1.brd_desctxt', width:'100px', resizable : false },
					{name:'createByNm',index:'e1.name', width:'100px', align:'center',resizable : false},
					{name:'createDate',index:'t1.create_date', width:'100px', align:'center',resizable : false},
		            {name:'rid', index:'', resizable : false,  hidden : true,  searchable : false}
	    ],
	    radio : true,
	    sortname: 't1.create_date',
		autowidth : true , sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	
	loyBrandListPopGrid = $("#loyBrandListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdloyBrandListPopGrid = $("#gridIdloyBrandListPopGrid");
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
	initLoyBrandListPopData();
	
	//선택 클릭시
    $('#loyBrandListPopSelectBtn').on('click', function(){
    	loyBrandListPopupSelect();
    });
	
	//취소 클릭시
    $('#loyBrandListPopCancelBtn').on('click', function(){
    	loyBrandListPopupClose();
    });
});
</script>

<div id="loyBrandListPopWrap">
	<div class="pop_inner_wrap">
		<div id="loyBrandListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="loyBrandListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="loyBrandListPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>