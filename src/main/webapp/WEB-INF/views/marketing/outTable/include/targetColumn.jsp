<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var targetColumnList;
var segColumnId = null;


//Target Level List
function targetColumnList(){
	var jqGridOption = {
		ondblClickRow : function(data){
			var data = targetColumnList.getRowData()[data-1];
			segColumnId = data.id;
			columnPopInit('<spring:message code="M01151" />');
		},
		serializeGridData : function( data ){
			data.extrTblId = ' '
		},		
		loadComplete : function(obj){},
		url: '<ifvm:action name="getcolumnList"/>',
	    colNames:[
	              '<spring:message code="M01146"/>',
	              '<spring:message code="M01147"/>',
	              /* '<spring:message code="M01148"/>', */
	              '<spring:message code="M01276"/>',
	              '<spring:message code="M01277"/>',
	              '<spring:message code="M01278"/>',
	              '<spring:message code="M01279"/>',
	              '<spring:message code="M01280"/>',
	              '<spring:message code="M01281"/>',
	              '<spring:message code="M01288"/>',
	              '<spring:message code="M03002"/>',
	              'id'
	              ],
	    colModel:[{name:'colKorNm', index:'COL_KOR_NM', resizable : false},
	              {name:'colEngNm', index:'COL_ENG_NM', resizable : false},
	              /* {name:'colTypeCd', index:'c1.mark_name', resizable : false},  */
	              {name:'flagAtribVal', index:'FLAG_ATRIB_VAL', resizable : false}, 
	              {name:'whereSchMemid', index:'WHERE_SCH_MEMID', resizable : false},
	              {name:'whereSchHp', index:'WHERE_SCH_HP', resizable : false},
	              {name:'whereSchEmail', index:'WHERE_SCH_EMAIL', resizable : false},
	              {name:'attrib01', index:'met.cond_calmt', resizable : false},
	              {name:'prmsItemMappgCol', index:'MKT_COL_MAPPG', resizable : false},
	              {name:'colTypeDefine', index:'c2.mark_name', resizable : false},
	              {name:'encColYn', index:'met.ENC_COL_YN', resizable : false},
	              {name:'id', index:'met.id', resizable : false,hidden:true},
			      ],  
		radio:true,
		sortname: 'met.create_date',
		sortorder: "desc",
		tempId : 'approvalPopTemplete'
	};
	targetColumnList = $("#targetColumnList").ifvGrid({ jqGridOption : jqGridOption });
}

function columnPopInit(title){
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="outcolumnPop"/>',
        contentType: "ajax",
        title: title,
        width: 800,
        close : 'adminTargetingPopClose'
    });
}

//column list 삭제
function deleteColumnOptionList(fromTbl, toTbl) {
	var active = 0;

	
		var checkedList = targetColumnList.getCheckedList();
		
		var listFlowIdList = [];
		if(checkedList.length != 0){
			if(confirm('<spring:message code="M00296"/>')){
				for( var i = 0; i < checkedList.length; i++ ){
					listFlowIdList.push( checkedList[i].id );
				}
				$.ifvSyncPostJSON('<ifvm:action name="removeOutColumn"/>',{
					outColumnId : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					targetColumnList.delCheckedRow();
					targetColumnList.requestData( { extrTblId : selectTblId } );
				});	
			}
		}
		else{
			alert('<spring:message code="M00285"/>');
		}
	
}


$(document).ready(function(){
	colmPageChk = true;
	targetColumnList();
	$("#addTargetColumnList").on("click", function(){
		//var temp = segColumnId;
		segColumnId = null;
		if(selectTableId != null){
			columnPopInit('<spring:message code="M01150" />');
		}
		else{
			alert('<spring:message code="M00004" />');
		}
		//segColumnId = temp;
	});

	$("#delTargetColumnList").on("click", function(){
		deleteColumnOptionList();
	});
	
});

</script>
	
<script id="approvalPopTemplete" type="text/ifvGrid-tmpl">
<div class="ifv_grid_templete">
	{title}
	<div class="grid_con">
		{grid}
	</div>
	<div class="page">
		<div class="total_area">{total}</div>	
	<div>
</div>
</script>


<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01145"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addTargetColumnList">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		<button class="btn btn-sm" id="delTargetColumnList">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="targetColumnList" class="grid_bd0 grid_scroll10"></div>
