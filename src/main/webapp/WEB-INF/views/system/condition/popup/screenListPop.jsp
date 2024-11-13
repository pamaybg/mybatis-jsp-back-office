<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var screenListPopGrid; 

function screenListPopGrid(){
	var jqGridOption = {
			loadComplete : function(obj){
				new ifvm.PopupHeight({
					popupDivId : 'popupContainer',
					contentsId : 'screenListArea'
				});
				new ifvm.PopupCenter({
					popupDivId : 'popupContainer'
				});
			},
		serializeGridData : function( data ){
			data.rows = 10;
			return data;
		},
	    url:'<ifvm:action name="menuList"/>',
	    colNames:[
	              '<spring:message code="M00530"/>',
	              '<spring:message code="M00531"/>',
	              '<spring:message code="M00532"/>'],
	    colModel:[
	        {name:'menuName',index:'p.pgm_nm', resizable : false},
	        {name:'menuId',index:'p.pgm_no', resizable : false},
	        {name:'menuLevel',index:'cc.mark_name', resizable : false}
	    ],
	    radio:true,
	    sortname: 'p.create_date, p.id',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete4',
	    caption: '<spring:message code="M00529"/>'
	};
	screenListPopGrid = $("#screenListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	screenListPopGrid();
	
	//선택
	$("#addScreenListBtn").on("click", function(){
		if(screenListPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = screenListPopGrid.getCheckedList();
    		screenListModalSelected(dataArr[0]);
    		popupClose();
    	}
	});
	
	//취소
	$("#cancelScreenListBtn").on("click", function(){
		popupClose();
	});
});
</script>

<div id="screenListArea">
	<div class="pop_inner_wrap">
		<div id="screenListPopGrid" class="con_size"></div>
	
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="addScreenListBtn" objCode="screenListPopSelect_OBJ">
			<i class="glyphicon glyphicon-check"></i>             
			<spring:message code="M00282" />
		</button>
		<button class="btn btn-sm btn_lightGray2" id="cancelScreenListBtn" objCode="screenListPopCancel_OBJ">         
	        <spring:message code="M00284"/>
	    </button>  
	</div>
</div>