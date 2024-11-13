<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var dataAuthInfoGrid;

//조직정보 리스트
function dataAuthInfoGrid(){
	var jqGridOption = {
		serializeGridData : function( data ){
			data.authId = authId;
		},
	    url: '<ifvm:action name="getDivisionAddListModal"/>', 
	    colNames:[
	              '<spring:message code="M00555"/>',
	              '<spring:message code="M00336"/>', 
	              '<spring:message code="L00479"/>', 
	              '<spring:message code="L00478"/>',
	              '<spring:message code="L00480"/>',
	              '<spring:message code="L00481"/>',
	              'rid'
	              ], 
	    colModel:[
	        {name:'divNm',     index:'cd1.div_nm',      resizable : false,  searchable : true, align :'center'},
	        {name:'divNo',     index:'cd1.div_no',      resizable : false,  searchable : true, align :'center'},
	        {name:'divLvl',    index:'cd1.div_lvl',     resizable : false,  searchable : true, align :'center'},
	        {name:'divTypeCd', index:'cc1.mark_name',   resizable : false,  searchable : true, align :'center'},
	        {name:'ridParDiv', index:'cd2.div_nm',      resizable : false,  searchable : true, align :'center'},
	        {name:'divStatus', index:'cc2.mark_name',   resizable : false,  searchable : true, align :'center'},
	        {name:'rid',       index:'cd1.rid',         hidden : true}
	    ],
	    radio:true,
	    sortname: 'cd1.div_no',
		sortorder: "asc",
		tempId : 'ifvGridOriginTemplete' 
	};
	dataAuthInfoGrid = $("#dataAuthInfoGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	dataAuthInfoGrid();
	
	//선택 클릭시
    $('#selectBtn').on('click', function(){
    	
    	if(authId != null && authId != ''){
    		if(dataAuthInfoGrid.getCheckedGridData() == ''){
        		alert('<spring:message code="L00117"/>');
        	}else{
        		if(confirm('<spring:message code="I02052"/>')){
        			
        		var ridDivision = dataAuthInfoGrid.getCheckedGridData()[0].rid;
   				 $.ifvSyncPostJSON('<ifvm:action name="addDivisionList"/>',
   			 		{
   					 ridDivision: ridDivision
   					 , authId : authId
   					},function(result){
   			 			divisionAddListInit();
   			 			popupClose();
   			        });
   			 	} 
        	}
    	}else{
    		alert('<spring:message code="I02103"/>');		
    	}
    });
	
  	//취소 클릭시
    $('#cancelBtn').on('click', function(){
    	popupClose();
    });
});
</script>
	<%-- <div class="modal-content">
		<div class="modal-header" >
			<button type="button" class="close" onclick="javascript:$.modalClose();">&times;</button>
   			<h4 class="modal-title"><spring:message code="L00483" /></h4>
		</div>
		 
		<div class="modal-body" >
			<div class="row">
				<div id="dataAuthInfoGrid" class=""></div>
			</div>
		</div>
		<center>
			<button class="btn btn-sm btn_gray" id="selectBtn">
		        <i class="glyphicon glyphicon-check"></i>
				<spring:message code="L00123"/>
		    </button>
		     
		    <button class="btn btn-sm btn_lightGray2" id="cancelBtn">
		    <spring:message code="L00124"/>         
		    </button>
		</center>
	</div> --%>
<div id="pop_main_div">
	<div class="pop_inner_wrap">
		<div id="dataAuthInfoGrid" class=""></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="selectBtn">
	        <i class="glyphicon glyphicon-check"></i>
			<spring:message code="L00123"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="cancelBtn">
	    <spring:message code="L00124"/>         
	    </button> 
	</div>
</div>
