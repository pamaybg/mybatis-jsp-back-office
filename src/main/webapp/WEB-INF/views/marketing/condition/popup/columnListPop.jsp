<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var columnListPopGrid; 

function columnListPopGrid(){
	
	var selectedTableId;
	
	if(targetColumFlag == 'joinSrc'){
		selectedTableId = baseTableId;
	}
	else if(targetColumFlag == 'target'){
		selectedTableId = baseTableId;
	}
	else if(targetColumFlag == 'joinSrcCol'){
		selectedTableId = targetTableId;
	}
	else{
		selectedTableId = targetTableId;
	}
	
	var jqGridOption = {
		loadComplete : function(obj){
			new ifvm.PopupHeight({
				popupDivId : 'popupContainer',
				contentsId : 'columnListArea'
			});
		},
		serializeGridData : function( data ){
			//data.rows = 10;
			data.tableId = selectedTableId;
			return data;
		},
	    url:'<ifvm:action name="getSrcColumList"/>',
	    colNames:['<spring:message code="M00538"/>',
	              '<spring:message code="M00539"/>',
	              '<spring:message code="M00540"/>'],
	    colModel:[
	        {name:'colName',index:'col_eng_nm', resizable : false},
	        {name:'colCode',index:'col_kor_nm', resizable : false},
	        {name:'colDesc',index:'srch_cond_desc', resizable : false}
	    ],
	    radio:true,
	    sortname: 'col_eng_nm, id',
		sortorder: "",
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M00537"/>'
	};
	columnListPopGrid = $("#columnListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	columnListPopGrid();
	
	//선택
	$("#columnListSelectBtn").on("click", function(){
		if(columnListPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = columnListPopGrid.getCheckedList();
    		colListModalSelected(dataArr[0]);
    		popupClose();
    	}
	});
	
	//취소
	$("#columnListCancelBtn").on("click", function(){
		popupClose();
	});
});
</script>

<div id="columnListArea">
	<div class="pop_inner_wrap">
		<div id="columnListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">marketing/condition/popup/columnListPop
		<button class="btn btn-sm btn_gray" id="columnListSelectBtn" objCode="columnListPopSelect_OBJ">  
			<i class="glyphicon glyphicon-check"></i>        
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="columnListCancelBtn" objCode="columnListPopCancel_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>