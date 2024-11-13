<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var subjectAreaList;
var subjectAreaId = null;
var targetLevelId = null;
var targetLevelNm = null;
var subjectAreaNm = null;
var pargeCheck = false; 
var defpageCheck = false;
var selectAreaId = null;
var selectTargetId;
var selectbaseTblId;

function subjectAreaList(){
	
	var jqGridOption = {
		ondblClickRow : function(data){
			
			var data = subjectAreaList.getRowData()[data-1];
			subjectAreaId = data.subjectAreaId;
			selectTargetId = null;
			setSubjectAreaGrid('<spring:message code="M01113"/>');
		},
		serializeGridData : function( data ){
		},
		onSelectRow : function (data) {
			segTableId = data.baseTblId;
			selectAreaId = data.subjectAreaId;
			subjectAreaNm = data.subjectAreaNm;
			selectTargetId = data.selectTgtId;
			selectbaseTblId = data.baseTblId
	    	if(pargeCheck)
	    		subjectFieldList.requestData( { subjectAreaId : data.subjectAreaId } );
	    	if(defpageCheck)
	    		joinDefinitionList.requestData( { subjectAreaId : data.subjectAreaId } );
		},
	    url: '<ifvm:action name="getSubjectAreaList"/>',   
	    colNames:['<spring:message code="M01157"/>',
	              '<spring:message code="M01155"/>',
	              '<spring:message code="M01156"/>', 
	              '<spring:message code="M01105"/>', 
	              '<spring:message code="M01129"/>',
	              '<spring:message code="M01131"/>',
	              '<spring:message code="M01132"/>'
	              ,'subjectAreaId'
	              ,'selectTgtId'
	              ,'baseTblId'
	              ],
	    colModel:[
			{name:'displaySeq',index:'mssa.DISP_ORDER', resizable : false},
	        {name:'subjectAreaNm',index:'mssa.subject_area_nm', resizable : false},
	        {name:'baseTblNm',index:'mst.tbl_eng_nm', resizable : false},
	        {name:'targetLevelNm',index:'mstl.target_level_nm', resizable : false},
	        {name:'subjectDesc',index:'mssa.subject_desc', resizable : false},
	        {name:'empName',index:'em.name', resizable : false},
	        {name:'modiDd',index:'mssa.modify_date', resizable : false},
	        {name:'subjectAreaId',index:'mssa.id', resizable : false, hidden : true},
	        {name:'selectTgtId',index:'mssa.target_level_id', resizable : false, hidden : true},
	        {name:'baseTblId',index:'mssa.base_tbl_id', resizable : false, hidden : true}
	       ],	    
	    radio:true,
	    sortname: 'mssa.target_level_id',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	subjectAreaList = $("#subjectAreaGridCon").ifvGrid({ jqGridOption : jqGridOption });
}

function setSubjectAreaGrid(title) {
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="subjectDetail"/>',
        contentType: "ajax",
        title: title,
        width: 700,
        close : 'adminTargetingPopClose'
    });
}

//subjectArea list 삭제
function deleteSubjectAreaOptionList() {
	
	
		var checkedList = subjectAreaList.getCheckedList();
		
		
		var listFlowIdList = [];
		
		if(checkedList.length != 0){
			if(confirm('<spring:message code="M00296"/>')){
				for( var i = 0; i < checkedList.length; i++ ){
					listFlowIdList.push( checkedList[i].subjectAreaId);
				}
				$.ifvSyncPostJSON('<ifvm:action name="deleteSubjectArea"/>',{
					subjectAreaId : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					subjectAreaList.delCheckedRow();
				});
			}
		}
		else{
			alert('<spring:message code="M00285"/>');
		}
	
}


$(document).ready(function() {

	subjectAreaList();
	
	$('#addSubject').on('click', function() {
		//var temp = subjectAreaId;
		subjectAreaId = null;
		selectTargetId = null;
		//setSubjectAreaGrid('<spring:message code="M01150" />');
		setSubjectAreaGrid('<spring:message code="M01112"/>');
		//subjectAreaId = temp;
	});
	
	$('#removeSubject').on('click', function() {
		deleteSubjectAreaOptionList();
	});

	/* setTimeout(function(){	
		if(pargeCheck || defpageCheck){
			$("#addSubject").attr('disabled', 'true');
			$("#removeSubject").attr('disabled', 'true');
		}
	}, 100); */
	
	 
	
});
</script>
	<div class="page_btn_area">
		<div>
			<div class="col-xs-5">
				<spring:message code="M01158"/>
			</div>
		</div>
		<div class="col-sm-7 searchbtn_r">
			<button id="addSubject" class="btn btn-sm btn_gray">
				<i class="fa fa-plus"></i>
				<spring:message code="M01120"/>
			</button>
			<button id="removeSubject" class="btn btn-sm btn_gray">  
				<i class="fa fa-minus"></i>			
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	
<div id="subjectAreaGridCon" class="grid_bd0"></div>