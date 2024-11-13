<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
//grid
var tierListPopGrid; 
var gridIdtierListPopGrid;

function initTierListPopData(){
	var jqGridOption = {
		loadComplete : function(obj){
 		},
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){
			
		},
	    url:'<ifvm:action name="getTierList"/>',
	    colNames:[ 
	               "<spring:message code='L00235'/>",
	               "<spring:message code='L00236'/>",
	               "<spring:message code='L00237'/>",
	               "<spring:message code='L00238'/>",
	               'rid'
	              ],
	    colModel:[
					{name:'tierCd',index:'t1.tier_cd', width:'80px', align:'center', resizable : false},
					{name:'tierNm',index:'t1.tier_nm', width:'100px', resizable : false },
					{name:'createByNm',index:'e1.name', width:'100px', align:'center',resizable : false},
					{name:'createDate',index:'t1.create_date', width:'100px', align:'center',resizable : false},
		            {name:'rid', index:'', resizable : false,  hidden : true,  searchable : false}
	    ],
	    radio : true,
	    sortname: 't1.create_date',
		autowidth : true , sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	
	tierListPopGrid = $("#tierListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdtierListPopGrid = $("#gridIdtierListPopGrid");
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
	initTierListPopData();
	
	//선택 클릭시
    $('#tierListPopSelectBtn').on('click', function(){
    	tierListPopupSelect();
    });
	
	//취소 클릭시
    $('#tierListPopCancelBtn').on('click', function(){
    	tierListPopupClose();
    });
});
</script>

<div id="tierListPopWrap">
	<div class="pop_inner_wrap">
		<div id="tierListPopGrid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="tierListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="tierListPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>