<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var joinDefinitionList;
var joinDefId;
defpageCheck = true;
var detailCheck = false;
var selectjoinId = null;
var segTableId;
var selectSubId;
var selectTargetId;

function joinDefinitionList(){
	var jqGridOption = {
		ondblClickRow : function(data){
			var data = joinDefinitionList.getRowData()[data-1];
			joinDefId = data.joinDefId;
			setJoinDefinitionGrid('<spring:message code="M01117"/>');	
		},
		onSelectRow: function(data) {
			selectjoinId = data.joinDefId;	
			selectSubId = data.subjectId
			selectNm = data.baseNm; 
			segTableId = data.baseId
			selectTargetId = data.tgtLvlId
			if(detailCheck)
				joinDetailList.requestData({ joinDefId : data.joinDefId });
		},
		serializeGridData : function( data ){
			data.subjectAreaId = '  '
		},
	    url: '<ifvm:action name="getJoinDefList"/>', 
	    colNames:['<spring:message code="M01155"/>',
	              '<spring:message code="M01166"/>', 

	              '<spring:message code="M01168"/>', 
	              '<spring:message code="M01129"/>',
	              '<spring:message code="M01131"/>',
	              '<spring:message code="M01132"/>',
	              'joinDefId',
	              'baseId',
	              'subjectId',
	              'tgtLvlId'
	              ],   
	    colModel:[ 
	        {name:'subjectAreaNm',index:'mssa.subject_area_nm', resizable : false},
	        {name:'baseNm',index:'mst.tbl_eng_nm', resizable : false},
	
	        {name:'outerFlag',index:'outer_flag', resizable : false},
	        {name:'joinDefDesc',index:'join_def_desc', resizable : false},
	        {name:'empName',index:'em.name', resizable : false},
	        {name:'modiDd',index:'msjd.modify_date', resizable : false},
	        {name:'joinDefId',index:'msjd.id', resizable : false, hidden:true},
	        {name:'baseId',index:'mst.id', resizable : false, hidden:true},
	        {name:'subjectId',index:'mssa.id', resizable : false, hidden:true},
	        {name:'tgtLvlId',index:'target_level_id', resizable : false, hidden:true}
	       ],
	    radio : true,
	    sortname: 'msjd.modify_date',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	
	joinDefinitionList = $("#joinDefinitionGridCon").ifvGrid({ jqGridOption : jqGridOption });
}

function setJoinDefinitionGrid(title) {
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="joinDefinitionDetail"/>',
        contentType: "ajax",
        title: title,
        width: 700,
        close : 'adminTargetingPopClose'
    });
}

//joinDefinition list 삭제
function deleteDefinitionOptionList() {
		var checkedList = joinDefinitionList.getCheckedList();
		var listFlowIdList = [];
		
		if(checkedList.length != 0){
			if(confirm('<spring:message code="M00296"/>')){
				for( var i = 0; i < checkedList.length; i++ ){
					listFlowIdList.push( checkedList[i].joinDefId);
				}
				$.ifvSyncPostJSON('<ifvm:action name="deleteJoinDef"/>',{
					joinDefId : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					joinDefinitionList.delCheckedRow();
					if(selectAreaId != null) joinDefinitionList.requestData( { subjectAreaId : selectAreaId } );
					if(selectAreaId != null) joinDefinitionList.requestData();
				});	
			}
		}
		else{
			alert('<spring:message code="M00285"/>');
		}
	
}

$(document).ready(function() {
	joinDefinitionList();
	$('#addJoinDefinition').on('click', function() {
		joinDefId = null;
		if(detailCheck){
			selectAreaId = null;
			setJoinDefinitionGrid('<spring:message code="M01116"/>');
		}else{
			if(selectAreaId != null){
				setJoinDefinitionGrid('<spring:message code="M01116"/>');
			}
			else{
				alert('<spring:message code="M00004" />');
			}
		}
	});

	$('#removeJoinDefinition').on('click', function() {
		deleteDefinitionOptionList(); 
	});	
	

});
</script>
	<div class="page_btn_area">
		<div>
			<div class="col-xs-5">
				<spring:message code="M01110"/>
			</div>
		</div>  
		<div class="col-sm-7 searchbtn_r">
			<button id="addJoinDefinition" class="btn btn-sm btn_gray">
				<i class="fa fa-plus"></i>
				<spring:message code="M01120"/>
			</button>
			<button id="removeJoinDefinition" class="btn btn-sm btn_gray">
				<i class="fa fa-minus"></i>			
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	
<div id="joinDefinitionGridCon" class="grid_bd0"></div>