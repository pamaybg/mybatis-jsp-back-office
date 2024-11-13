<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var targetLevelList;

//더블 클릭 -> 수정 페이지 이동 시 사용
var targetLevelId = null;


//클릭으로 인한 선택값 -> 선택 시 테이블쪽에 넘길 값 세팅
var selectTargetId = null;
var selectTargetNm = null;

//타겟 레벨 삭제
function removeTargetLevels(){
	var selectData = targetLevelList.opt.gridControl.getSelectedRecords();
	
	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			var targetLevelIdList = [];
			
			for(var i=0; i<selectData.length; i++){
				targetLevelIdList.push(selectData[i].id);
			}
			
			$.ifvSyncPostJSON('<ifvm:action name="removeOutTgtLvl"/>',{
				targetLevelId	: targetLevelIdList
			},function(result) {
				alert('<spring:message code="M00622"/>');
				targetLevelListInit();
			});
		}
	}
	
}

//Target Level List
function targetLevelListInit(){
	var ejGridOption = {
/* 		recordDoubleClick : function(args){
			var data = args.data;
			targetLevelId = data.id;
			targetLevelPopInit('<spring:message code="M01134" />');
		}, */
		rowSelected : function (args) {
        	selectTargetId = args.data.id;
        	selectTargetNm = args.data.targetLevelNm;
        	
			tableList.searchGrid( { targetLevelId : args.data.id} );
			targetColumnList.searchGrid( { extrTblId : ' '} );
			
			targetLevelId = args.data.id;
			
		},
// 		serializeGridData : function( data ){
			
// 		},		
// 		loadComplete : function(obj){
// 		},
		dataUrl: '<ifvm:action name="getTgtLevelList"/>',
		columns:[
	    	{
      		  field : 'targetLevelNm', headerText : '<spring:message code="M01122"/>', headerTextAlign : 'center',
      		  customAttributes : {
      			  index : 'met.target_level_nm' } //
      	  },{
    		  field : 'secretNm', headerText : '<spring:message code="M02893"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.AWS_SECRET_NM' } //
    	  },{
    		  field : 'conDbType', headerText : '<spring:message code="M01123"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'c1.mark_name' } //
    	  },{
    		  field : 'dbNm', headerText : '<spring:message code="M01124"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.db_nm' } //
    	  },{
    		  field : 'conIp', headerText : '<spring:message code="M01125"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.con_ip' } //
    	  },{
    		  field : 'conPort', headerText : '<spring:message code="M01126"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.con_port' } //
    	  },{
    		  field : 'conId', headerText : '<spring:message code="M01127"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.con_id' } //
    	  },{
    		  field : 'targetDesc', headerText : '<spring:message code="M01129"/>', headerTextAlign : 'center',
    		  customAttributes : {
    			  index : 'met.target_desc' } //
    	  },{
    		  field : 'id', headerText : 'id', visible : false,
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
	 tempId : 'ifvGridNoneLeftTemplete'
	};
	targetLevelList = $("#targetLevelList").ifvsfGrid({ ejGridOption : ejGridOption });
}

//팝업.
function targetLevelPopInit(title){
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="outtargetLevelPop"/>',
        contentType: "ajax",
        title: title,
        width: 650,
        close : 'adminTargetingPopClose',
    });
}


$(document).ready(function(){
	targetLevelListInit();
	
	//타겟 레벨 추가
	$("#addTargetLevelList").on("click", function(){
		targetLevelId = null;
		targetLevelPopInit('<spring:message code="M01133"/>');
	}); 
	
	//타겟 레벨 삭제
	$("#removeTargetLevelList").on("click", function(){
		removeTargetLevels();
	});
	
	//타겟 레벨 수정
	$("#modifyTargetLevelList").on("click", function(){
		if(targetLevelId == null){
			alert('<spring:message code="I00728"/>');
		}else{
			targetLevelPopInit('<spring:message code="M01134" />');
		}
	});
});

</script>
	

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01121"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addTargetLevelList" objCode="targetLevelListNewAdd_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		<button class="btn btn-sm" id='modifyTargetLevelList' objCode="targetLevelListNewModify_OBJ">
			<spring:message code="M00283"/>
		</button>
		<button class="btn btn-sm" id="removeTargetLevelList" objCode="targetLevelListNewDel_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="targetLevelList" class="grid_bd0"></div>

