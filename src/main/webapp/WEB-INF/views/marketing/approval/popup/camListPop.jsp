<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var camListPopGrid; 
var dataId;
var dataNm;
var description;


function camListPopGrid(){
	var jqGridOption = {
		loadComplete : function(obj){
			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'FormNewPop',
				contentsId : 'FormNewPop'
			});
		},
		onSelectRow : function (data) {
			dataId = data.id;
			dataNm = data.camNm;
			description = data.description;
		},
		serializeGridData : function( data ){
			
			return data;
		},
	    url:'<ifvm:action name="getCampaign"/>',
	    colNames:['<spring:message code="M00598"/>',
	              '<spring:message code="M00592"/>', 
	              '<spring:message code="M00593"/>', 
	              '<spring:message code="M00594"/>', 
	              '<spring:message code="M00595"/>',
	              'id'
	              ],
	    colModel:[
	        
	        {name:'camType',index:'c1.MARK_NAME', resizable : false},
	        {name:'camNm',index:'mcm.cam_nm', resizable : false},
	        {name:'statDD',index:'mcm.CAM_START_DD', resizable : false},
	        {name:'endDD',index:'mcm.CAM_END_DD', resizable : false},
	        {name:'camStatus',index:'c3.mark_name', resizable : false},
	        {name:'id', index:'mcm.id', resizable : false,  hidden : true,  searchable : false}
	    ],
	    radio :true,
	    sortname: 'mcm.CAM_START_DD',
		sortorder: "desc",
		caption: '<spring:message code="M00967"/>',
		tempId : 'ifvGridOriginTemplete'
	};
	camListPopGrid = $("#camListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	camListPopGrid();
	
	//저장 클릭시
    $('#camListPopSaveBtn').on('click', function(){
    	
    	if(camListPopGrid.getCheckedGridData() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = camListPopGrid.getCheckedGridData();
    		$("#camId").text(dataId);
    		$("#camId").val(dataNm);
    		$("#camContent").val(description);
        	//$("#parOfferId").text(dataArr[0].id).val(dataArr[0].offerName);
        	FormNewPopClose();	
    	}
    });
	
  	//취소 클릭시
    $('#camListPopCancelBtn').on('click', function(){
    	FormNewPopClose();
    });
});
</script>

<div id="camPopupCon">
	<div class="pop_inner_wrap">
		<div id="camListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="camListPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="camListPopCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>