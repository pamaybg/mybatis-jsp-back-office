<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var subjectFieldList;
var fieldId;
pargeCheck = true;

function subjectFieldList(){
	
	var jqGridOption = {
		ondblClickRow : function(id,status){
			
			var data = subjectFieldList.getRowData()[status-1];
			fieldId = data.fieldId
			setSubjectFieldGrid('<spring:message code="M01115"/>');	
		},
		serializeGridData : function( data ){
		},	
	    url: '<ifvm:action name="getFieldList"/>', 
	    colNames:['<spring:message code="M01157"/>',
	              '<spring:message code="M01231"/>', 
	              /* '<spring:message code="M01162"/>', 
	              '<spring:message code="M01163"/>', */
	              '<spring:message code="M01129"/>',
	              '<spring:message code="M01155"/>',
	              '<spring:message code="M01164"/>',
	              '<spring:message code="M01110"/>'	,
	              'colId',
	              'fieldId'
	              ],      
	    colModel:[
			{name:'displaySeq',index:'msf.DISP_ORDER', resizable : false},
			{name:'fieldEngNm',index:' msf.field_nm', resizable : false},
			/* {name:'calFlag',index:'msf.cal_flag', resizable : false},
			{name:'calDef',index:'msf.cal_def', resizable : false},  */
			{name:'fieldDesc',index:'msf.field_desc', resizable : false},	
	        {name:'subjectAreaNm',index:'mssa.subject_area_nm', resizable : false}, 
	        {name:'colEngNm',index:'msc.col_eng_nm', resizable : false},
	        {name:'joinDefId',index:'join_def_id', resizable : false, hidden : true}, 
	        {name:'colId',index:'msf.col_id', resizable : false, hidden : true},
	        {name:'fieldId',index:'msf.id', resizable : false, hidden : true}
	       ],
	    radio:true,
	    sortname: 'msf.DISP_ORDER',
		sortorder: "asc",
		tempId : 'ifvGridOriginTemplete'
	};
	subjectFieldList = $("#subjectFieldGridCon").ifvGrid({ jqGridOption : jqGridOption });
}

function setSubjectFieldGrid(title) {
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="fieldDetail"/>',
        contentType: "ajax",
        title: title,
        width: 700,
        beforeclose: fname,
        close : 'adminTargetingPopClose'
    });
}

function fname(){
	
}

//subjectField list 삭제
function deleteSubjectFieldOptionList() {
	
	
		var checkedList = subjectFieldList.getCheckedList();
		var listFlowIdList = [];
		
		if(checkedList.length != 0){
			if(confirm('<spring:message code="M00296"/>')){
				for( var i = 0; i < checkedList.length; i++ ){
					listFlowIdList.push( checkedList[i].fieldId);
				}
				$.ifvSyncPostJSON('<ifvm:action name="deleteField"/>',{
					fieldId : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					subjectFieldList.delCheckedRow();
				});
			}
		}
		else{
			alert('<spring:message code="M00285"/>');
		}
	
}


$(document).ready(function() {
	subjectFieldList();
	
	$('#addField').on('click', function() {
		//var temp = fieldId
		fieldId = null;
		if(selectAreaId != null){
			setSubjectFieldGrid('<spring:message code="M01114"/>');
		}
		else{
			alert('<spring:message code="M00004" />');
		}
		//fieldId = temp;
	});
	
	$('#removeField').on('click', function() {
		deleteSubjectFieldOptionList();
	});

});
</script>
	<div class="page_btn_area">
		<div>
			<div class="col-xs-5">
				<spring:message code="M01165"/>
			</div>
		</div>
		<div class="col-sm-7 searchbtn_r">
			<button id="addField" class="btn btn-sm btn_gray">
				<i class="fa fa-plus"></i>
				<spring:message code="M01120"/>
			</button>
			<button id="removeField" class="btn btn-sm btn_gray">
				<i class="fa fa-minus"></i>			
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	
<div id="subjectFieldGridCon" class="grid_bd0"></div>
