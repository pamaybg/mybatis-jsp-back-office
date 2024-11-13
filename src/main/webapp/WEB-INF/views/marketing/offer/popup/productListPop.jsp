<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var productListPopGrid; 
var productListPopGridDiv;

function initLoyProdListPopData() {
    
	var jqGridOption = {
		loadComplete : function(obj) {
 		},
		onSelectRow : function(data) {
		},
		serializeGridData : function(data) {
		},
	    url:'<ifvm:action name="getProductList"/>',
	    colNames:[
	               "<spring:message code='L00231'/>",
	               "<spring:message code='L00232'/>",
	               'rid'
	    ],
	    colModel:[
				   {name:'prodId' , index:'lp.prod_id', resizable : false, align:'center', width:'150px'},
				   {name:'prodNm' , index:'lp.prod_nm', resizable : false, align:'left'},
	               {name:'rid'    , index:'lp.rid'    , hidden : true}
	    ],
	    radio : true,
	    sortname: 'lp.create_date',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	
	productListPopGrid = $("#productListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	productListPopGridDiv = $("#productListPopGridDiv");
	productListPopGridDiv.resize();
}

$(document).ready(function(){
    
	initLoyProdListPopData();
	
	//선택 클릭시
    $('#productListPopSelectBtn').on('click', function(){
    	productListPopupSelect();
    });
	
	//취소 클릭시
    $('#productListPopCancelBtn').on('click', function(){
    	productListPopupClose();
    });
});
</script>

<div id="productListPopWrap">
	<div class="pop_inner_wrap">
		<div id="productListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="productListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="productListPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>