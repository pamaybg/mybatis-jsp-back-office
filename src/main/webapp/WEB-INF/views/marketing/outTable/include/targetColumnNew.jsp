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
	var ejGridOption = {
		recordDoubleClick : function(args){
			var data = args.data;
			//columnPopInit('<spring:message code="M01151" />');
		}, 
		rowSelected : function(args){
			var data = args.data;
			segColumnId = args.data.id;
		},
		serializeGridData : function( data ){
			data.extrTblId = ' '
		},		
// 		loadComplete : function(obj){},
		dataUrl: '<ifvm:action name="getcolumnList"/>',
		columns:[
	      {
      		  field : 'colKorNm', headerText : '<spring:message code="M01146"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'COL_KOR_NM' } //
      	  },{
    		  field : 'colEngNm', headerText : '<spring:message code="M01147"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'COL_ENG_NM' } //
    	  },{
    		  field : 'flagAtribVal', headerText : '<spring:message code="M01276"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'FLAG_ATRIB_VAL' } //
    	  },{
    		  field : 'whereSchMemid', headerText : '<spring:message code="M01277"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'WHERE_SCH_MEMID' } //
    	  },{
    		  field : 'whereSchHp', headerText : '<spring:message code="M01278"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'WHERE_SCH_HP' } //
    	  },{
    		  field : 'whereSchEmail', headerText : '<spring:message code="M01279"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'WHERE_SCH_EMAIL' } //
    	  },{
    		  field : 'attrib01', headerText : '<spring:message code="M01280"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.cond_calmt' } //
    	  },{
    		  field : 'prmsItemMappgCol', headerText : '<spring:message code="M01281"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'MKT_COL_MAPPG' } //
    	  },{
    		  field : 'colTypeDefine', headerText : '<spring:message code="M01288"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.COL_ATRIB_DEF_CD_ID' } //
    	  },{
    		  field : 'encColYn', headerText : '<spring:message code="M03002"/>', headerTextAlign : 'center', textAlign : 'center',
    		  customAttributes : {
    			  index : 'met.ENC_COL_YN' } //
    	  },{
    		  field : 'id', headerText : 'id', visible : false ,
    		  customAttributes : {
    			  index : 'met.id' } //
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
      radio: true,
	  tempId : 'approvalPopTemplete'
	};
	targetColumnList = $("#targetColumnList").ifvsfGrid({ ejGridOption : ejGridOption });
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
function deleteColumnOptionList() {
	var active = 0;

	
		var checkedList = targetColumnList.opt.gridControl.getSelectedRecords();
		
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
					targetColumnList.searchGrid();
// 					targetColumnList.searchGrid( { extrTblId : selectTblId } );
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
	
	//수정
	$("#modifyTargetColumnList").on("click", function(){
		if(segColumnId == null){
			alert('<spring:message code="I00728"/>');
		}else{
			columnPopInit('<spring:message code="M01151" />');
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
		<div class="total_area">{total}</div>	
	<div>
</div>
</script>


<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01145"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addTargetColumnList" objCode="targetColumnNewAdd_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		<button class="btn btn-sm" id='modifyTargetColumnList' objCode="targetColumnNewModify_OBJ">
			<spring:message code="M00283"/>
		</button>
		<button class="btn btn-sm" id="delTargetColumnList" objCode="targetColumnNewDel_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="targetColumnList" class="grid_bd0 grid_scroll10"></div>
