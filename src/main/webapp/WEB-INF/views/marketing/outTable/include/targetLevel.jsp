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
	var selectData = targetLevelList.getCheckedGridData();
	
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
	var jqGridOption = {
		ondblClickRow : function(data){
			var data = targetLevelList.getRowData()[data-1];
			targetLevelId = data.id;
			targetLevelPopInit('<spring:message code="M01134" />');
		},
        onSelectRow : function (data) {
        	selectTargetId = data.id;
        	selectTargetNm = data.targetLevelNm;
        	
			tableList.requestData( { targetLevelId : data.id} );	
			targetColumnList.requestData( { extrTblId : ' '} );
		},
		serializeGridData : function( data ){
			
		},		
		loadComplete : function(obj){
		},
		url: '<ifvm:action name="getTgtLevelList"/>',
	    colNames:[
	              '<spring:message code="M01122"/>',
	              '<spring:message code="M01123"/>',
	              '<spring:message code="M01124"/>',
	              '<spring:message code="M01125"/>',
	              '<spring:message code="M01126"/>',
	              '<spring:message code="M01127"/>',
	              '<spring:message code="M01129"/>',
	              'id'
	              ],
	    colModel:[{name:'targetLevelNm', index:'met.target_level_nm', resizable : false},
	              {name:'conDbType', index:'c1.mark_name', resizable : false},
	              {name:'dbNm', index:'met.db_nm', resizable : false},
	              {name:'conIp', index:'met.con_ip', resizable : false},
	              {name:'conPort', index:' met.con_port', resizable : false},
	              {name:'conId', index:'met.con_id', resizable : false},
	              {name:'targetDesc', index:'met.target_desc', resizable : false},
	              {name:'id', index:'met.id', resizable : false, hidden : true}
			      ],  
		radio:true,
	    sortname: 'met.create_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	targetLevelList = $("#targetLevelList").ifvGrid({ jqGridOption : jqGridOption });
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
});

</script>
	

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01121"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addTargetLevelList">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
		<button class="btn btn-sm" id="removeTargetLevelList">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="targetLevelList" class="grid_bd0"></div>

