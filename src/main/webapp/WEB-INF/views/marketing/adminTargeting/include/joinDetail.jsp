<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var joinDetailList;
var joinSpecId =null;
detailCheck = true;
var selectId = null;
function joinDetailList(){
	
	var jqGridOption = {
		ondblClickRow : function(data){
			var data = joinDetailList.getRowData()[data-1];
			joinSpecId = data.joinSpecId;	
			setJoinDetailGrid('<spring:message code="M01119"/>');	
		},
	    onSelectRow : function (data) {
	        selectId = data.joinSpecId;
		},
		serializeGridData : function( data ){
			//data.targetLevelId = targetLevelId;
			data.joinDefId	= joinDefId
		},	
		url: '<ifvm:action name="getJoinDetailList"/>', 
	    colNames:['<spring:message code="M00524"/>',
	              '<spring:message code="M01170"/>', 
	              '<spring:message code="M01168"/>', 
	              '<spring:message code="M01129"/>',
	              '<spring:message code="M01131"/>',
	              '<spring:message code="M01132"/>'
	              ,'joinSpecId'
	              ], 
	              
	    colModel:[
			{name:'colEngNm',index:'msc.col_eng_nm', resizable : false},      
			{name:'srcNm',index:'msf.field_nm', resizable : false}, 
			{name:'outerFlag',index:'msjs.outer_flag', resizable : false},
			{name:'joinSpcDesc',index:'msjs.join_spc_desc', resizable : false},
			{name:'empName',index:'em.name', resizable : false},
			{name:'modiDd',index:'msjs.modify_date', resizable : false},
	        {name:'joinSpecId',index:'msjs.id', resizable : false, hidden:true}    
	       ],
	    radio:true,
	    sortname: 'msjs.modify_date',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	joinDetailList = $("#joinDetailGridCon").ifvGrid({ jqGridOption : jqGridOption });
}
/* 
function joinDetailPopClose() {
	$("#test").ejDialog('destroy');
} */

function setJoinDetailGrid(title) {
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="joinDetailPop"/>',
        contentType: "ajax",
        title: title,
        width: 700,
        close : 'adminTargetingPopClose'
    });
}
function deleteJoinDetailOptionList() {
	
	
		var checkedList = joinDetailList.getCheckedList();
		
		
		var listFlowIdList = [];
		if(checkedList.length != 0){
			if(confirm('<spring:message code="M00296"/>')){
				for( var i = 0; i < checkedList.length; i++ ){
					listFlowIdList.push( checkedList[i].joinSpecId);
				}
				$.ifvSyncPostJSON('<ifvm:action name="deleteJoinDetail"/>',{
					joinSpecId : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					joinDetailList.delCheckedRow();
					joinDetailList.requestData( { joinDefId : selectjoinId } );
				});
			}
		}
		else{
			alert('<spring:message code="M00285"/>');
		}
	
}



$(document).ready(function() {
	joinDetailList();
	
	$('#addJoinDetail').on('click', function() {
		joinSpecId = null;
		if(selectjoinId != null){
			setJoinDetailGrid('<spring:message code="M01118"/>');
		}
		else{
			alert('<spring:message code="M00004" />');
		}
	});
	
	$('#removeJoinDetail').on('click', function() {
		deleteJoinDetailOptionList();
		
	});
	
	setTimeout(function(){	
		joinDefinitionList.requestData( { subjectAreaId : null} );
			
	}, 200);
});
</script>
	<div class="page_btn_area">
		<div>
			<div class="col-xs-5">
				<spring:message code="M01111"/>
			</div>
		</div>
		<div class="col-sm-7 searchbtn_r">
			<button id="addJoinDetail" class="btn btn-sm btn_gray">
				<i class="fa fa-plus"></i>
				<spring:message code="M01120"/>
			</button>
			<button id="removeJoinDetail" class="btn btn-sm btn_gray">
				<i class="fa fa-minus"></i>			
				<spring:message code="M00275"/>
			</button>
		</div>
	</div>
	
<div id="joinDetailGridCon" class="grid_bd0"></div>