<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

//선택한 테이블 Id
var selectTableId = null;
var selectTableNm = null;
var selectType = null;
var selectTypeCode = null;

//수정 페이지 Id
var outTableId = null;

//Table List
function tableList(){
	
	var jqGridOption = {
		ondblClickRow : function(data){
			var data = tableList.getRowData()[data-1];
			outTableId = data.id;
			tablePopInit('<spring:message code="M01144" />');
		},
	    onSelectRow : function (data) {
	    	selectTableId = data.id;
	    	selectTableNm = data.tblEngNm
	    	if(data.typeCode == "FATIGUE"){
	    		selectTypeCode = "FATIGUE";
	    		selectType =  'MKT_CAM_CHNL_TYPE_CD';
	    	}
	    	else if(data.typeCode == "SEND_ATTRIBUTE"){
	    		selectType = 'MEM_TRAN_INFO';
	    		selectTypeCode = "SEND_ATTRIBUTE";
	    	}
	    	else{
	    		selectType = null;
	    		selectTypeCode = null;
	    	}
	    
			targetColumnList.requestData( { extrTblId : data.id} );
		},
		serializeGridData : function( data ){
			data.targetLevelId = ' '
		},		
	
		url: '<ifvm:action name="getTableList"/>',
	    colNames:[
	              '<spring:message code="M01136"/>',
	              '<spring:message code="M01137"/>',
	              '<spring:message code="M01138"/>',
	              '<spring:message code="M01275"/>',
	              '<spring:message code="M01129"/>',
	              'typeCode',
	              'id'
	              ,'targetLevelId'
	              ],
	    colModel:[{name:'tblSchemaNm',  index:'met.tbl_schema_nm', resizable : false},
	              {name:'tblKorNm', 	index:'met.tbl_kor_nm', resizable : false},
	              {name:'tblEngNm', 	index:'met.tbl_eng_nm', resizable : false},
	              {name:'type',     	index:'met.type', resizable : false},
	              {name:'tblDesc', 		index:'met.tbl_desc', resizable : false},
	              {name:'typeCode', 	index:'c1.code_name', resizable : false},
	              {name:'id', 			index:'met.id', resizable : false, hidden : true},
	              {name:'targetLevelId',index:'met.target_level_id', resizable : false, hidden : true}
			      ],  			
		radio:true,
		sortname: 'met.create_date',
		sortorder: "desc",
		tempId : 'approvalPopTemplete'
	};
	tableList = $("#tableList").ifvGrid({ jqGridOption : jqGridOption });
}

//테이블 목록 팝업
function tablePopInit(title){
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="outtablePop"/>',
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
					listFlowIdList.push( checkedList[i].id );
				}
				
				$.ifvSyncPostJSON('<ifvm:action name="removeOutTbl"/>',{
					outTableId : listFlowIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					tableList.delCheckedRow();
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
		
			if(selectTargetId != null){
				outTableId = null
				tablePopInit('<spring:message code="M01143" />');
			}
			else{
				alert('<spring:message code="M00004" />');
			}
			
	});

	//삭제
	$("#delTableList").on("click", function(){
		deleteTableOptionList();
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
            {page}
            <div class="total_area">{total}</div>   
        <div>
    </div>
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
<div id="tableList" class="grid_bd0 grid_scroll10"></div>

