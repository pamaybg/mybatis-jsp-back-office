<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tableListPopGrid; 

function tableListPopGrid(){
	var jqGridOption = {
		loadComplete : function(obj){
			new ifvm.PopupHeight({
				popupDivId : 'popupContainer',
				contentsId : 'tableListArea'
			});
		},
	    url:'<ifvm:action name="getBaseTableList"/>',
	    colNames:[//id, 
	              '<spring:message code="M00519"/>',
	              '<spring:message code="M00535"/>'],
	    colModel:[
			//{name:'id',hidden : true, key : true, resizable : false},
	        {name:'tableName',index:'tbl_eng_nm', resizable : false},
	        {name:'tableCode',index:'tbl_kor_nm', resizable : false}
	    ],
	    radio:true,
	    sortname: 'tbl_eng_nm, id',
		sortorder: "",
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M00534"/>'
	};
	tableListPopGrid = $("#tableListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	tableListPopGrid();
	
	$("#tableListSelectBtn").on("click", function(){
		if(tableListPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = tableListPopGrid.getCheckedList();
    		tableListModalSelected(dataArr[0]);
    		popupClose();
    	}
	});
	
	$("#tableListCancelBtn").on("click", function(){
		popupClose();
	});
});
</script>

<div id="tableListArea">
	<div class="pop_inner_wrap">
		<div id="tableListPopGrid" class="con_size"></div>
	</div>
	
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="tableListSelectBtn" objCode="tableListPopSelect_OBJ">  
			<i class="glyphicon glyphicon-check"></i>        
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="tableListCancelBtn" objCode="tableListPopCancel_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>