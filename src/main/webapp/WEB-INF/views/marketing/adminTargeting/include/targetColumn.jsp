<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var targetColumnList;
var segColumnId = null;
colmPageChk = true;

//Target Level List
function targetColumnList(){
	var jqGridOption = {
		ondblClickRow : function(data){
			var data = targetColumnList.getRowData()[data-1];
			segColumnId = data.segColumnId;
			columnPopInit('<spring:message code="M01151" />');
		},
		serializeGridData : function( data ){
		},		
		loadComplete : function(obj){},
		url: '<ifvm:action name="getTargetColumList"/>',
	    colNames:[
	              '<spring:message code="M01146"/>',
	              '<spring:message code="M01147"/>',
	              '<spring:message code="M01148"/>',
	              '<spring:message code="M01129"/>'
	              ,'segTableId'
	              ,'segColumnId'
	              ],
	    colModel:[{name:'colKorNm', index:'msc.col_kor_nm', resizable : false},
	              {name:'colEngNm', index:'msc.col_eng_nm', resizable : false},
	              {name:'colTypeCd', index:'cc.code_name', resizable : false},
	              {name:'colDesc', index:'msc.col_desc', resizable : false},
	              {name:'segTableId', index:'msc.seg_table_id', resizable : false, hidden : true},
	              {name:'segColumnId', index:'msc.id', resizable : false, hidden : true}
			      ],  
		radio:true,
	    sortname: 'msc.modify_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	targetColumnList = $("#targetColumnList").ifvGrid({ jqGridOption : jqGridOption });
}

function columnPopInit(title){
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="columnPop"/>',
        contentType: "ajax",
        title: title,
        width: 630,
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
					listFlowIdList.push( checkedList[i].segColumnId );
				}
				$.ifvSyncPostJSON('<ifvm:action name="deleteTargetColum"/>',{
					segColumnId : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					targetColumnList.delCheckedRow();
					targetColumnList.requestData( { segTableId : selectTblId } );
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
		if(selectTblId != null){
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
	setTimeout(function(){	
			tableList.requestData({targetLevelId : null});
	}, 200);

});

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
<div id="targetColumnList" class="grid_bd0"></div>