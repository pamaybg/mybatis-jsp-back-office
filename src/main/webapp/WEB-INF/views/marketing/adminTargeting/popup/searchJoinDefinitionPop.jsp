<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var joinDefinitionList;
var selectId;
var selectChk= false;
var selectNm;
function joinDefinitionList(){
	
	var jqGridOption = {
		onSelectCell : function (data) {
				selectChk = true
				selectId = data.joinDefId;
				selectNm = data.baseNm;
		},
		serializeGridData : function( data ){
			data.subjectAreaId = selectAreaId
		},
		
		 url: '<ifvm:action name="getJoinDefList"/>', 
		    colNames:['<spring:message code="M01155"/>',
		              '<spring:message code="M01166"/>', 
		              '<spring:message code="M01167"/>', 
		              '<spring:message code="M01168"/>', 
		              '<spring:message code="M01129"/>',
		              '<spring:message code="M01131"/>',
		              '<spring:message code="M01132"/>',
		              'joinDefId'
		              ],   
		    colModel:[
		        {name:'subjectAreaNm',index:'mssa.subject_area_nm', resizable : false},
		        {name:'baseNm',index:'mst.tbl_eng_nm', resizable : false}, 
		        {name:'aliasNm',index:'msjd.alias_nm', resizable : false},
		        {name:'outerFlag',index:'outer_flag', resizable : false},
		        {name:'joinDefDesc',index:'join_def_desc', resizable : false},
		        {name:'empName ',index:'em.name', resizable : false},
		        {name:'modiDd',index:'msjd.modify_date', resizable : false},
		        {name:'joinDefId',index:'msjd.id', resizable : false, hidden:true}
		       ],
		    radio:true,
		    sortname: 'mssa.subject_area_nm',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
	};
	joinDefinitionList = $("#joinDefinitionGridCon").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	joinDefinitionList();
	$("#btnjoinSave").on("click", function(){
		if(selectChk){
			$("#joinDefId").text(selectId);
	    	$("#joinDefId").val(selectNm);
	    	fdPopClose();
		}
		else{
			alert('<spring:message code="M00004" />');
		}
		
	});
	
	$("#btnjoinCan").on("click", function(){
		fdPopClose();
	});
});
</script>
<div class="pop_inner_wrap">
	<div id="joinDefinitionGridCon" class="grid_bd0 grid_w660"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnjoinSave">     
		<i class="glyphicon glyphicon-check"></i>    
		<spring:message code="M00282"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnjoinCan">         
        <spring:message code="M00284"/>
    </button> 
</div>