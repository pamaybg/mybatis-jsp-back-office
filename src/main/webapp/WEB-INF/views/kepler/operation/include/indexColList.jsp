<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var idxColList;
var idxColId = null;

//타겟 레벨 삭제
function removeIdxColList(){
	var selectData = idxColList.getCheckedGridData();
	
	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			var idxColIdList = [];
			
			for(var i=0; i<selectData.length; i++){
				idxColIdList.push(selectData[i].idxColId);
			}
			$.ifvSyncPostJSON('<ifvm:action name="removeIdxColList"/>',{
				idxColId	: idxColIdList, idxId : idxId
			},function(result) {
				alert('<spring:message code="M00622"/>');
				idxColList.opt.grid.setGridParam({ url: "<ifvm:action name='getIdxColList'/>" });
	 		    idxColList.requestData({ idxId: idxId });
			});
		}
	}
}

//수정
function editIdxColList(){
	if( idxColId == null ){
		alert('<spring:message code="M00004" />');
	}else{
		idxColListPopInit('<spring:message code="M01603" />'); 
	}
}

//조회결과 그리드
function getIndexColList(){
	var jqGridOption = {
		serializeGridData : function( data ){
		},
		ondblClickRow : function(data){
 			var data = idxColList.getRowData()[data-1];
 			idxColId = data.idxColId;
 			idxColListPopInit('<spring:message code="M01603" />'); 
		},
		onSelectCell : function (data) {
		}, 
		loadComplete: function(result) {
		},
	    colNames:[
	              '<spring:message code="M01164"/>', 
	              '<spring:message code="M00324"/>', 
	              '<spring:message code="M01602"/>', 
	              'id'
	              ],
	    colModel:[
	        {name:'colNm',index:'c.col_nm', resizable : false},
	        {name:'orderTypeCd',index:'c1.mark_name', resizable : false},
	        {name:'seq',index:'c.seq', align: 'right', resizable : false},
	        {name:'idxColId', index:'c.id', resizable : false,  hidden : true,  searchable : false}
	    ],
		radio:true,
		sortname: 'c.seq',
		sortorder: "asc",
		tempId : 'approvalPopTemplete'
	};
	idxColList = $("#idxColList").ifvGrid({ jqGridOption : jqGridOption });
}

//팝업.
function idxColListPopInit(title){
	$("#dialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="idxColListPop"/>',
        contentType: "ajax",
        title: title,
        width: 600,
        close : 'tableMstPopClose',
    });
}

$(document).ready(function(){
	getIndexColList();

	 //신규
	$("#addIdxColList").on("click", function(){
			if(idxId != null){
				idxColId = null;
		 		idxColListPopInit('<spring:message code="M01603"/>');
			}else{
				alert('<spring:message code="M00004" />');
			}
	}); 
		
	//수정
	$("#editIdxColList").on("click", function(){
		editIdxColList();
	}); 
	
	//삭제
	$("#removeIdxColList").on("click", function(){
		removeIdxColList();
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
		<span><spring:message code="M01589"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addIdxColList">
			<i class="fa fa-plus"></i>
			<spring:message code="M00274"/>
		</button> 
 		<button class="btn btn-sm" id="editIdxColList">
			<spring:message code="M00259"/>
		</button> 
		<button class="btn btn-sm" id="removeIdxColList">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="idxColList" class="grid_bd0 grid_scroll10"></div>
