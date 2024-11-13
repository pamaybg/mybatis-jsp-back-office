<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var levelJoinList;
var lvlJoinId = null;
levelJoinChk = true;

//Target Level List
function levelJoinList(){
	var jqGridOption = {
		ondblClickRow : function(data){
			var data = levelJoinList.getRowData()[data-1];
			lvlJoinId = data.lvlJoinId;
			targetLevelJoinPopInit('<spring:message code="M01151" />');
		},
		/* onSelectRow : function(data){
			lvlJoinId = data.lvlJoinId;
		}, */
		serializeGridData : function( data ){
			data.targetLevelId = targetLevelId;
		},	 
		loadComplete : function(obj){},
		url: '<ifvm:action name="getLvlJoinlList"/>',
	    colNames:[
	              '<spring:message code="M01138" />',
	              '<spring:message code="M01176" />',
	              '<spring:message code="M01177" />',
	              '<spring:message code="M01178" />',
	              'tblLvlId',
	              'lvlJoinId'
	              ],
	    colModel:[
	              {name:'tblEngNm', index:'msf.tbl_eng_nm', resizable : false},
	              {name:'colEngNm', index:'msc.col_eng_nm', resizable : false},
	              {name:'outerFg', index:'mstjd.outer_flag', resizable : false},
	              {name:'mainFg', index:'mstjd.main_tbl_flag', resizable : false},
	              {name:'tblLvlId', index:'mstjd.target_level_id', resizable : false, hidden : true},
	              {name:'lvlJoinId', index:'mstjd.id', resizable : false, hidden : true}
			      ],  
		radio:true,
	    sortname: 'msc.modify_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	levelJoinList = $("#levelJoinList").ifvGrid({ jqGridOption : jqGridOption });
}

//list 삭제
function deleteList() {
	
	
		var checkedList = levelJoinList.getCheckedList();
		
		
		var listFlowIdList = [];
		if(checkedList.length != 0){
			if(confirm('<spring:message code="M00296"/>')){
				for( var i = 0; i < checkedList.length; i++ ){
					listFlowIdList.push( checkedList[i].lvlJoinId);
				}
				$.ifvSyncPostJSON('<ifvm:action name="removeLevJoin"/>',{
					listFlowIdList : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					levelJoinList.requestData( { targetLevelId : selectTargetId} );
					//levelJoinList.delCheckedRow();
				});
			}
		}
		else{
			alert('<spring:message code="M00285"/>');
		}
	
}


function targetLevelJoinPopInit(title){
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="levljoinDetailPop"/>',
        contentType: "ajax",
        title: title,
        width: 700,
        close : 'adminTargetingPopClose'
    });
}


$(document).ready(function(){

	levelJoinList();
	
	$("#addTargetColumnList").on("click", function(){
		lvlJoinId = null;
		if(selectTargetId != null){
			targetLevelJoinPopInit('<spring:message code="M01150" />');
		}
		else{
			alert('<spring:message code="M00004" />');
		}
	});
	$("#delList").on("click", function(){
		deleteList();
	});
	
});  

</script>
	

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01184"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addTargetColumnList">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		<button class="btn btn-sm"  id="delList">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="levelJoinList" class="grid_bd0"></div>
