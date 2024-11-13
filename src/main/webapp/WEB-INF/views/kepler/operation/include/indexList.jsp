<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var idxList;
var idxId = null;
var idxId1 = null;

//타겟 레벨 삭제
function removeIdxList(){
	var selectData = idxList.getCheckedGridData();
	
	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			var IdxIdList = [];
			
			for(var i=0; i<selectData.length; i++){
				IdxIdList.push(selectData[i].idxId);
			}
			$.ifvSyncPostJSON('<ifvm:action name="removeIdxColList"/>',{
				idxId1	: IdxIdList
			},function(result) {
	 			idxColList.opt.grid.setGridParam({ url: "<ifvm:action name='getIdxColList'/>" });
	 		    idxColList.requestData({idxId : null});
			});
			$.ifvSyncPostJSON('<ifvm:action name="removeIdxList"/>',{
				idxId	: IdxIdList, tableId :  tableId
			},function(result) {
				alert('<spring:message code="M00622"/>');
				getIdxList();
			});
		}
	}
}
//수정
function editIdxList(){
	if( idxId == null ){
		alert('<spring:message code="M00004" />');
	}else{
		idxListPopInit('<spring:message code="M01588" />');
	}
}

//조회결과 그리드
function getIdxList(){
	var jqGridOption = {
		serializeGridData : function( data ){
			data.tableId = tableId;
		},
		ondblClickRow : function(data){
 			var data = idxList.getRowData()[data-1];
 			idxId = data.idxId;
			idxListPopInit('<spring:message code="M01588" />');
		},
		onSelectCell : function (data) {
			idxNm = data.idxNm;
			tblSpaceNm = data.tblSpaceNm;
			unqYn = data.unqYn;
 			idxId = data.idxId;
 			idxColList.opt.grid.setGridParam({ url: "<ifvm:action name='getIdxColList'/>" });
 		    idxColList.requestData({ idxId: idxId });
		}, 
		loadComplete: function(result) {
			idxList.setWidth(idxList.width());
		},
	    url:'<ifvm:action name="getIdxList"/>',
	    colNames:[
	              '<spring:message code="M01590"/>', 
	              '<spring:message code="M01593"/>', 
	              '<spring:message code="M01569"/>', 
	              'id'
	              ],
	    colModel:[
	        {name:'idxNm',index:'m.IDX_NM', resizable : false},
	        {name:'tblSpaceNm',index:'m.TBL_SPACE_NM', resizable : false},
	        {name:'unqYn',index:'m.UNQ_YN', align: 'center', resizable : false},
	        {name:'idxId', index:'m.ID', resizable : false,  hidden : true,  searchable : false}
	    ],
		radio:true,
		sortname: 'm.create_date',
		sortorder: "desc",
		tempId : 'approvalPopTemplete'
	};
	idxList = $("#idxList").ifvGrid({ jqGridOption : jqGridOption });
}

//팝업.
function idxListPopInit(title){
	$("#dialog").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="idxListPop"/>',
        contentType: "ajax",
        title: title,
        width: 600,
        close : 'tableMstPopClose',
    });
}

$(document).ready(function(){
	getIdxList();
	
	//신규
	$("#addIdxList").on("click", function(){
		idxId = null;
		idxListPopInit('<spring:message code="M01588"/>');
	}); 
	
	//수정
	$("#editIdxList").on("click", function(){
		editIdxList();
	}); 
	
	//삭제
	$("#removeIdxList").on("click", function(){
		removeIdxList();
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
 		<span><spring:message code="M01587"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addIdxList">
			<i class="fa fa-plus"></i>
			<spring:message code="M00274"/>
		</button> 
 		<button class="btn btn-sm" id="editIdxList">
			<spring:message code="M00259"/>
		</button> 
		<button class="btn btn-sm" id="removeIdxList">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="idxList" class="grid_bd0 grid_scroll10"></div>
