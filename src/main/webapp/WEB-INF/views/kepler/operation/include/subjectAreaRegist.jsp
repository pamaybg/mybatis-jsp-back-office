<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var delChk = false;

//더블 클릭 -> 수정 페이지 이동 시 사용
var subjectAreaId = null;
var subjectAreaNm = null;

//타겟 레벨 삭제
function removeSubjectAreas(){
	var selectData = subjectAreaRegistList.getCheckedGridData();
	delChk = false;

	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			var subjectAreaIdList = [];
			
			for(var i=0; i<selectData.length; i++){
				subjectAreaIdList.push(selectData[i].subjectAreaId);
				subjectAreaNm = selectData[i].subjectAreaNm
			}
			/* 고정 주제영역으로 코드값은 프로젝트에 따라 변경 가능하여 명으로 조건처리 */
			if(subjectAreaNm == 'Dimension' || subjectAreaNm == 'Aggregation' || subjectAreaNm=='일반'){
				alert('<spring:message code="M01648" />');
				return;
			}
			$.ifvSyncPostJSON('<ifvm:action name="subjectAreaDelChk"/>',{
				subjectAreaId1 : subjectAreaIdList
		    },function(result) {
				if(result.delFlag == "1"){
					alert("<spring:message code='M01582'/>");
					delChk = true;
				}			
			});
			if(delChk == false){
				$.ifvSyncPostJSON('<ifvm:action name="removeSubjectAreaRegist"/>',{
					subjectAreaId	: subjectAreaIdList
				},function(result) {
					alert('<spring:message code="M00622"/>');
					subjectAreaListInit();
				});
			}
		}
	}
	
}
//타겟 레벨 수정
function editSubjectAreas(){
	if( subjectAreaId == null ){
		alert('<spring:message code="M00004" />');
	}else{
		subjectAreaPopInit('<spring:message code="M01597" />');
	}
	
}

//Target Level List
function subjectAreaListInit(){
	var jqGridOption = {
		ondblClickRow : function(data){
  			var data = subjectAreaRegistList.getRowData()[data-1];
 			subjectAreaId = data.subjectAreaId;
 			subjectAreaPopInit('<spring:message code="M01597" />'); 
		},
        onSelectRow : function (data) {
        	var selectData = subjectAreaRegistList.getCheckedGridData();
    		for(var i=0; i<selectData.length; i++){
    			subjectAreaId  = selectData[i].subjectAreaId;
			}
		},
		serializeGridData : function(data){
		},		
		loadComplete : function(obj){
		},
		url: '<ifvm:action name="getSubjectAreaRegistList"/>',
	    colNames:[
	              '<spring:message code="M01596"/>',
	              '<spring:message code="M01598"/>',
	              'id' 
	              ],
	    colModel:[{name:'subjectAreaNm', index:'s.subject_area_nm', resizable : false},
	              {name:'subjectDesc', index:'s.subject_desc', resizable : false},
	              {name:'subjectAreaId', index:'s.id', hidden : true},
			      ],  
		radio:true,
	    sortname: 's.create_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	subjectAreaRegistList = $("#subjectAreaRegistList").ifvGrid({ jqGridOption : jqGridOption });
	gridIdsubjectAreaRegistList = $("#gridIdsubjectAreaRegistList");
}

//팝업.
function subjectAreaPopInit(title){
	$("#adminTargetingPop").ejDialog({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="subjectAreaRegistPop"/>',
        contentType: "ajax",
        title: title,
        width: 600,
        close : 'adminTargetingPopClose',
    });
}


$(document).ready(function(){
	subjectAreaListInit();
	
	//타겟 레벨 추가
	$("#addSubjectAreaList").on("click", function(){
		subjectAreaId = null;
		subjectAreaPopInit('<spring:message code="M01597" />');
		$("#gridIdsubjectAreaRegistList").trigger('reloadGrid');
	}); 
	
	//타겟 레벨 수정
	$("#editSubjectAreaList").on("click", function(){
		editSubjectAreas();
	}); 
	
	//타겟 레벨 삭제
	$("#removeSubjectAreaList").on("click", function(){
		removeSubjectAreas();
	}); 
});

</script>
	

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01595"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addSubjectAreaList">
			<i class="fa fa-plus"></i>
			<spring:message code="M00136"/>
		</button> 
 		<button class="btn btn-sm" id="editSubjectAreaList">
			<spring:message code="M00259"/>
		</button> 
		<button class="btn btn-sm" id="removeSubjectAreaList">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="subjectAreaRegistList" class="grid_bd0"></div>

