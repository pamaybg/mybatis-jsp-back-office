<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var storeListPopGrid;  

/* 조건 목록 */
function storeListPopGrid(){
	var jqGridOption = {
		onSelectRow : function (data) {
			
		},
		loadComplete : function(obj){
			/* new ifvm.PopupHeight({
				popupDivId : 'popupContainer',
				contentsId : 'storeListPopCon'
			});
			new ifvm.PopupCenter({
				popupDivId : 'popupContainer'
			}); */
		},
	   	url:'<ifvm:action name="MKTSelectEmployeePopUp"/>',
	    colNames:[
	              '<spring:message code="M00558"/>',
	              '<spring:message code="M00559"/>',
	              '<spring:message code="M00560"/>'
	    ],
	    colModel:[
	        { name:'storeName',index:'cd1.div_nm', resizable : false},
	        { name:'markName',index:'cd1.div_type_cd', resizable : false},	        
	        { name:'description',index:'cd2.div_status', resizable : false}
	    ],
	    sortname: 'cd1.div_nm',
		sortorder: "ASC",
		radio : true,
	    tempId : 'ifvGridOriginTemplete',
	};
	storeListPopGrid = $("#storeListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	storeListPopGrid();
	
	$("#storeListSelectBtn").on("click", function(){
		if(storeListPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = storeListPopGrid.getCheckedList();
    		$.ifvPostJSON('<ifvm:action name="setCurrentdivision"/>',{
				  //storeId : dataArr[0].rid,
				   storeName : dataArr[0].storeName
				//, storeType : dataArr[0].storeType
				//, storeMarkType : dataArr[0].markName
			}
			,function(result) {
				//부모창에서 정의
				storeListModalSelected(dataArr[0]);
	    		deptPopupClose();
			});
    	}
	});
	
	$("#storeListCancelBtn").on("click", function(){
		deptPopupClose();
	});
});
</script>

<div id="storeListPopCon">
	<div class="pop_inner_wrap">
		<div id="storeListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="storeListSelectBtn" objCode="storeListPopSelectBtn_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="storeListCancelBtn" objCode="storeListPopCancelBtn_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>