<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var areaList;
var selectId;
var selectNm;
var selectChk = false;

function areaList(){
	var jqGridOption = {
		onSelectRow : function (data) {
			
			selectId = data.subjectAreaId;
			selectNm = data.subjectAreaNm;	
			selectAreaId = data.subjectAreaId
			selectChk = true;

		},
	    url: '<ifvm:action name="getSubjectAreaList"/>', 
	    colNames:['<spring:message code="M01155"/>',
	              '<spring:message code="M01156"/>', 
	              '<spring:message code="M01105"/>', 
	              '<spring:message code="M01129"/>',
	              '<spring:message code="M01131"/>',
	              '<spring:message code="M01132"/>'
	              ,'subjectAreaId'
	              ],
	    colModel:[
	        {name:'subjectAreaNm',index:'mssa.subject_area_nm', resizable : false},
	        {name:'baseTblNm',index:'mst.tbl_eng_nm', resizable : false},
	        {name:'targetLevelNm',index:'mstl.target_level_nm', resizable : false},
	        {name:'subjectDesc',index:'mssa.subject_desc', resizable : false},
	        {name:'empName',index:'em.name', resizable : false},
	        {name:'modiDd',index:'mssa.modify_date', resizable : false},
	        {name:'subjectAreaId',index:'mssa.id', resizable : false, hidden : true}
	       ],	    
	    radio : true,
	    sortname: 'mssa.subject_area_nm',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	areaList = $("#columnGridCon").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	areaList();
	$("#btnSelect").on("click", function(){
		if(selectChk){
			$("#subjectAreaId").text(selectId);
			$("#subjectAreaId2").val(selectNm);
			fdPopClose();
		}
		else{
			alert('<spring:message code="M00004" />');
		}
	});
	$("#btnCancel").on("click", function(){
		fdPopClose();
	});
});
</script>

<div class="pop_inner_wrap">
	<div id="columnGridCon" class="grid_bd0 grid_w660"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSelect">     
		<i class="glyphicon glyphicon-check"></i>    
		<spring:message code="M00282"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCancel">         
		<spring:message code="M00284"/>
    </button> 
</div>
