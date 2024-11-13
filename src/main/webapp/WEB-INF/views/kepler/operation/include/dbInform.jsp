<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var dbInformList;
var dbGubn = null;
var delChk = false;

//더블 클릭 -> 수정 페이지 이동 시 사용
var dbInformId = null;

//클릭으로 인한 선택값 -> 선택 시 테이블쪽에 넘길 값 세팅
var selectDbInformId = null;
var selectDbInformNm = null;

//타겟 레벨 삭제
function removeDbInforms(){
	var selectData = dbInformList.getCheckedGridData();
	delChk = false;
	
	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			var dbInformIdList = [];
			
			for(var i=0; i<selectData.length; i++){
				dbInformIdList.push(selectData[i].dbInformId);
			}
			$.ifvSyncPostJSON('<ifvm:action name="dbInformDelChk"/>',{
				dbInformId1 : dbInformIdList
		    },function(result) {
				if(result.delFlag == "1"){
					alert('<spring:message code="M01556"/>');
					delChk = true;
				}			
			});
			if(delChk == false){
				$.ifvSyncPostJSON('<ifvm:action name="removeDbInform"/>',{
					dbInformId	: dbInformIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					dbInformListInit();
				});
			}
		}
	}
	
}
//타겟 레벨 수정
function editDbInforms(){
	if( dbInformId == null ){
		alert('<spring:message code="M00004" />');
	}else{
		dbGubun = "U";
 		dbInformPopInit('<spring:message code="M01554" />');  
	}
	
}

//Target Level List
function dbInformListInit(){
	var jqGridOption = {
		ondblClickRow : function(data){
  			var data = dbInformList.getRowData()[data-1];
			dbInformId = data.dbInformId;
			dbGubun = "U";
 			dbInformPopInit('<spring:message code="M01554" />'); 
		},
        onSelectRow : function (data) {
        	var selectData = dbInformList.getCheckedGridData();
    		for(var i=0; i<selectData.length; i++){
    			dbInformId  = selectData[i].dbInformId;
			}
		},
		serializeGridData : function( data ){
		},		
		loadComplete : function(obj){
		},
		url: '<ifvm:action name="getDbInformList"/>',
	    colNames:[
	              '<spring:message code="M01440"/>',
	              '<spring:message code="M00508"/>',
	              '<spring:message code="M01125"/>',
	              '<spring:message code="M01126"/>',
	              '<spring:message code="M01127"/>',
	              '<spring:message code="M00471"/>',
	              '<spring:message code="M00324"/>',
	              'id' 
	              ],
	    colModel:[{name:'serviceNm', index:'d.service_nm', resizable : false},
	              {name:'conDbType', index:'c.mark_name', resizable : false},
	              {name:'conIp', index:'d.con_ip', resizable : false},
	              {name:'conPort', index:'d.con_port', resizable : false},
	              {name:'conId', index:' d.con_id', resizable : false},
	              {name:'conUrl', index:'d.con_url', resizable : false},
	              {name:'dbDesc', index:'d.db_desc', resizable : false},
	              {name:'dbInformId', index:'d.id', hidden : true}
			      ],  
		radio:true,
	    sortname: 'd.create_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	dbInformList = $("#dbInformList").ifvGrid({ jqGridOption : jqGridOption });
}

//팝업.
function dbInformPopInit(title){
	$("#adminTargetingPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="dbRegistPop"/>',
        contentType: "ajax",
        title: title,
        width: 650,
        close : 'adminTargetingPopClose',
    });
}


$(document).ready(function(){
	dbInformListInit();
	
	//타겟 레벨 추가
	$("#addDbInformList").on("click", function(){
		dbInformId = null;
		dbGubun = "I";
 		dbInformPopInit('<spring:message code="M01133"/>');
	}); 
	
	//타겟 레벨 수정
	$("#editDbInformList").on("click", function(){
		editDbInforms();
	}); 
	
	//타겟 레벨 삭제
	$("#removeDbInformList").on("click", function(){
		removeDbInforms();
	}); 
});

</script>
	

<div class="page_btn_area">
	<div class="col-xs-7">
		<%-- <span><spring:message code="M01121"/></span> --%>
		 <span><spring:message code="M01555"/></span> 
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addDbInformList">
			<i class="fa fa-plus"></i>
			<spring:message code="M00136"/>
		</button> 
 		<button class="btn btn-sm" id="editDbInformList">
			<spring:message code="M00259"/>
		</button>  
		<button class="btn btn-sm" id="removeDbInformList">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="dbInformList" class="grid_bd0"></div>

