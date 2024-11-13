<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var responseInfoListPopGrid;  

var isNew = true;

/* 조건 목록 */
function responseInfoListPopGrid(){
	
	var jqGridOption = {
	   	url:'<ifvm:action name="getResponseInfoList"/>',
	    colNames:['<spring:message code="M01260"/>',
	              '<spring:message code="M01259"/>',
	              '<spring:message code="M01261"/>',
	              'id'
	    ],
	    colModel:[
	        { name:'camRspnsNm',index:'mrim.cam_rspns_nm', resizable : false, },
	        { name:'camRspnsCd',index:'mrim.cam_rspns_cd', resizable : false , align : 'center'},	        
	        { name:'spcfChnlRspnsCd',index:'c1.mark_name', resizable : false},
	        { name:'id',resizable : false, hidden : true}
	    ],
	    sortname: 'mrim.cam_rspns_nm',
		sortorder: "asc",
		radio : true,
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M01268"/>',
	    rowList: ['10', '20', '30', '40']
	};
	responseInfoListPopGrid = $("#responseInfoListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	responseInfoListPopGrid();
	
	$("#responseInfoListSelectBtn").on("click", function(){
		if(responseInfoListPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = responseInfoListPopGrid.getCheckedList();
    		$('#parRspnsCd').text(dataArr[0].id).val(dataArr[0].camRspnsCd);
    		responseInfoPopupClose();
    		
    	}
		
	});
	
	$("#responseInfoListCancelBtn").on("click", function(){
		responseInfoPopupClose();
	});
});
</script>

<div id="responseInfoListPopCon">
	<div class="pop_inner_wrap">
		<div id="responseInfoListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="responseInfoListSelectBtn" objCode="responseInfoListPopSelectBtn_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="responseInfoListCancelBtn" objCode="responseInfoListPopCancelBtn_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>