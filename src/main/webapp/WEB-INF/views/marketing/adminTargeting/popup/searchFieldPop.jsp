<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var fieldList2;

function fieldList2(){
	
	var jqGridOption = {
			/* onSelectCell : function (data) {
				
				$("#srcFieldId").text(data.fieldId);
		    	$("#srcFieldId").val(data.fieldEngNm);
			}, */
			onSelectRow: function(data) {
				$("#srcFieldId").text(data.fieldId);
		    	$("#srcFieldId").val(data.fieldEngNm);		
			},
			serializeGridData : function( data ){
				data.subjectAreaId = selectSubId
			},
			url: '<ifvm:action name="getFieldList"/>', 
		    colNames:['<spring:message code="M01155"/>',
		             /*  '<spring:message code="M01159"/>', */
		              '<spring:message code="M01231"/>', 
		              '<spring:message code="M01162"/>', 
		              '<spring:message code="M01163"/>',
		              '<spring:message code="M01129"/>',
		              '<spring:message code="M01164"/>',
		             /*  '<spring:message code="M01110"/>'	, */
		              'fieldId'
		              ],      
		    colModel:[
				{name:'subjectAreaNm',index:'subject_area_nm', resizable : false},
				/* {name:'fieldKorNm',index:'msf.field_kor_nm', resizable : false}, */
				{name:'fieldEngNm',index:'msf.field_nm', resizable : false},
		        {name:'calFlag',index:'msf.cal_flag', resizable : false}, 
		        {name:'calDef',index:'msf.cal_def', resizable : false}, 
		        {name:'fieldDesc',index:'msf.field_desc', resizable : false},	
		        {name:'colEngNm',index:'msc.col_eng_nm', resizable : false},
		       /*  {name:'joindef',index:'msjd.joinDefId', resizable : false}, */
		        {name:'fieldId',index:'msf.id', resizable : false, hidden : true}
		       ],
		    radio:true,
		    sortname: 'subject_area_nm',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
		};
	fieldList2 = $("#fieldGridCon2").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	fieldList2();

	
	$('#selectBtn').on('click', function() {
		fdPopClose();
		
	});
		
	$('#cancleBtn').on('click', function() {
		fdPopClose();
		
	});
	
});
</script>

<div class="pop_inner_wrap">
	<div id="fieldGridCon2" class="grid_bd0 grid_w860"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="selectBtn">     
		<i class="glyphicon glyphicon-check"></i>    
		<spring:message code="M00282"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="cancleBtn">         
        <spring:message code="M00284"/>
    </button> 
</div>
