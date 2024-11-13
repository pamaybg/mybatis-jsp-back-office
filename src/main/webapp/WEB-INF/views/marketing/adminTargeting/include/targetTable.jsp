<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tableList;

talbePageChk = true;
var colmPageChk = false;
var segTableId = null;
var tgtLevId = null;
var targetTableNm = null;
var targetTableId = null;
var selectTblId = null;

//Table List
function tableList(){
	var jqGridOption = {
		ondblClickRow : function(data){
			
			var data = tableList.getRowData()[data-1];
			segTableId = data.segTableId;
			tablePopInit('<spring:message code="M01144" />');
		},
	    onSelectRow : function (data) {
	    	selectTblId = data.segTableId;
	    	if(colmPageChk) 
				targetColumnList.requestData( { segTableId : data.segTableId, tgtLvlId : data.targetLevelId } );
		},
		serializeGridData : function( data ){
			
			if(typeof(columPage) != "undefined"){
				data.pageChk = columPage;
			}
			
		},		
		loadComplete : function(obj){},
		url: '<ifvm:action name="getTargetTableList"/>',
	    colNames:[
	              '<spring:message code="M01136"/>',
	              '<spring:message code="M01137"/>',
	              '<spring:message code="M01138"/>',
	              '<spring:message code="M01129"/>',
	              '<spring:message code="M01122"/>',
	              'id'
	              ,'targetLevelId'
	              ],
	    colModel:[{name:'tblSchemaNm', index:'mst.tbl_schema_nm', resizable : false},
	              {name:'tblKorNm', index:'mst.tbl_kor_nm', resizable : false},
	              {name:'tblEngNm', index:'mst.tbl_eng_nm', resizable : false},
	              {name:'tblDesc', index:'mst.tbl_desc', resizable : false},
	              {name:'targetLevelNm', index:'mstl.target_level_nm', resizable : false},
	              {name:'segTableId', index:'mst.id', resizable : false, hidden : true},
	              {name:'targetLevelId', index:'mst.target_level_id', resizable : false, hidden : true}
			      ],  
		radio:true,
	    sortname: 'mst.create_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	tableList = $("#tableList").ifvGrid({ jqGridOption : jqGridOption });
}

//테이블 목록 팝업
function tablePopInit(title){
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tablePop"/>',
        contentType: "ajax",
        title: title,
        width: 680,
        close : 'adminTargetingPopClose'
    });
}

//table list 삭제
function deleteTableOptionList(fromTbl, toTbl) {
	var active = 0;
	var checkedList = tableList.getCheckedList();
	var listFlowIdList = [];
	
		if(checkedList.length != 0){
			if(confirm('<spring:message code="M00296"/>')){
				for( var i = 0; i < checkedList.length; i++ ){
					listFlowIdList.push( checkedList[i].segTableId );
				}
				
				$.ifvSyncPostJSON('<ifvm:action name="deleteTargetTable"/>',{
					segTableId : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					tableList.requestData( { targetLevelId : selectTargetId, pageChk : columPage } );	
					//tableList.delCheckedRow();
				});
			}
		}
		else{
			alert('<spring:message code="M00285"/>');
		}
	
}

$(document).ready(function(){
	//테이블 목록 그리드
	tableList();

	$("#addTableList").on("click", function(){
		//컬럼페이지인지 체크
		if(colmPageChk){
			segTableId = null;
			tablePopInit('<spring:message code="M01143" />');
		}else{
			if(selectTargetId != null){
				segTableId = null
				tablePopInit('<spring:message code="M01143" />');
			}
			else{
				alert('<spring:message code="M00004" />');
			}
		}
	});

	//삭제
	$("#delTableList").on("click", function(){
		deleteTableOptionList();
	});

});

</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01135" /></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addTableList">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		<button class="btn btn-sm" id="delTableList">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="tableList" class="grid_bd0"></div>

