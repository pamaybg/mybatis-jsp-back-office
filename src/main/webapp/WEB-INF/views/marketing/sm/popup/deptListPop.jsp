<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var deptListPopGrid;  

var isNew = true;

/* 조건 목록 */
function deptListPopGrid(){
	var jqGridOption = {
		onSelectRow : function (data) {
			
		},
		loadComplete : function(obj){
			new ifvm.PopupHeight({
				popupDivId : 'popupContainer',
				contentsId : 'deptListPopCon'
			});
			new ifvm.PopupCenter({
				popupDivId : 'popupContainer'
			});
		},
	   	url:'<ifvm:action name="getDeptList"/>',
	    colNames:['<spring:message code="M00558"/>',
	              '<spring:message code="M00559"/>',
	              '<spring:message code="M00560"/>',
	              'id'
	    ],
	    colModel:[
	        { name:'deptName',index:'a.name', resizable : false, },
	        { name:'deptType',index:'cc.mark_name', resizable : false , align : 'center'},	        
	        { name:'description',index:'a.description', resizable : false},
	        { name:'id',resizable : false, hidden : true}
	    ],
	    sortname: 'a.name',
		sortorder: "asc",
		radio : true,
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M00561"/>',
	    rowList: ['10', '20', '30', '40']
	};
	deptListPopGrid = $("#deptListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	deptListPopGrid();
	
	$("#deptListSelectBtn").on("click", function(){
		if(deptListPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = deptListPopGrid.getCheckedList();
    		$('#baseDept').text(dataArr[0].id).val(dataArr[0].deptName);
    		deptPopupClose();
    		
    	}
		
	});
	
	$("#deptListCancelBtn").on("click", function(){
		deptPopupClose();
	});
});
</script>

<div id="deptListPopCon">
	<div class="pop_inner_wrap">
		<div id="deptListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="deptListSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="deptListCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>