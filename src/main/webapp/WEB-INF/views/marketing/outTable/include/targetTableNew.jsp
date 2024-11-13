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
	
	var ejGridOption = {
/* 		recordDoubleClick : function(args){
			var data = args.data;
			outTableId = data.id;
			tablePopInit('<spring:message code="M01144" />');
		}, */
		rowSelected : function (args) {
			outTableId = args.data.id;
	    	selectTableId = args.data.id;
	    	selectTableNm = args.data.tblEngNm
	    	if(args.data.typeCode == "FATIGUE"){
	    		selectTypeCode = "FATIGUE";
	    		selectType =  'MKT_CAM_CHNL_TYPE_CD';
	    	}
	    	else if(args.data.typeCode == "SEND_ATTRIBUTE"){
	    		selectType = 'MEM_TRAN_INFO';
	    		selectTypeCode = "SEND_ATTRIBUTE";
	    	}
	    	else{
	    		selectType = null;
	    		selectTypeCode = null;
	    	}
	    
	    	targetColumnList.searchGrid({ extrTblId : args.data.id} );
		},
		serializeGridData : function( data ){
			data.targetLevelId = ' '
		},		
	
		dataUrl: '<ifvm:action name="getTableList"/>',
		columns:[
	    	{
      		  field : 'tblSchemaNm', headerText : '<spring:message code="M01136"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'met.tbl_schema_nm' , searchable: true} //
      	  },{
    		  field : 'tblKorNm', headerText : '<spring:message code="M01137"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.tbl_kor_nm' , searchable: true} //
    	  },{
    		  field : 'tblEngNm', headerText : '<spring:message code="M01138"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.tbl_eng_nm' , searchable: true} //
    	  },{
    		  field : 'type', headerText : '<spring:message code="M01275"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.type' , searchable: true} //
    	  },{
    		  field : 'tblDesc', headerText : '<spring:message code="M01129"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.tbl_desc' } //
    	  },{
    		  field : 'typeCode', headerText : 'typeCode', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.type' } //
    	  },{
    		  field : 'id', headerText : 'id', visible : false,
    		  customAttributes : {
    			  index : 'met.id' } //
    	  },{
    		  field : 'targetLevelId', headerText : 'targetLevelId', visible : false,
    		  customAttributes : {
    			  index : 'met.target_level_id' } //
    	  },
        ],  
        requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 'met.create_date',
	    	  sord : 'desc',
	    	  _search : false
	      },
	      rowList : [10,25,50,100],
//	       gridDataInit: false,
	      radio: true,
		  tempId : 'approvalPopTemplete'
	};
	tableList = $("#tableList").ifvsfGrid({ ejGridOption : ejGridOption });
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
function deleteTableOptionList() {
	var active = 0;
	var checkedList = tableList.opt.gridControl.getSelectedRecords();
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
					tableList.searchGrid();
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
	
	//수정
	$("#modifyTableList").on("click", function(){
		if(outTableId == null){
			alert('<spring:message code="I00728"/>');
		}else{
			tablePopInit('<spring:message code="M01144" />');
		}
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
		<button class="btn btn-sm" id="addTableList" objCode="targetTableNewAdd_OBJ" >
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button>
		<button class="btn btn-sm" id='modifyTableList' objCode="targetTableNewModify_OBJ">
			<spring:message code="M00283"/>
		</button>
		<button class="btn btn-sm" id="delTableList" objCode="targetTableNewDel_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="tableList" class="grid_bd0 grid_scroll10"></div>

