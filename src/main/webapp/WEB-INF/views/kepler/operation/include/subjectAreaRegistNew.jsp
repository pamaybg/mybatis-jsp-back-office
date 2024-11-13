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
	var selectData = subjectAreaRegistList.opt.gridControl.getSelectedRecords();
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
	if( subjectAreaRegistList.opt.gridControl.getSelectedRecords() == null ){
		alert('<spring:message code="M00004" />');
	}else{
		subjectAreaPopInit('<spring:message code="M01597" />');
	}
	
}

//Target Level List
function subjectAreaListInit(){
	var ejGridOption = {
		recordDoubleClick : function(args){
  			var data = args.data;
 			subjectAreaId = data.subjectAreaId;
 			subjectAreaPopInit('<spring:message code="M01597" />'); 
		},
        rowSelected : function (args) {
			var data = args.data;

			subjectAreaId  = data.subjectAreaId;
		},
		dataUrl: '<ifvm:action name="getSubjectAreaRegistList"/>',
	    columns:[
	    	{
	      		  field : 'subjectAreaNm', headerText : '<spring:message code="M01596"/>', customAttributes : {searchable : true}

	      	  },{
	      		  field : 'subjectDesc', headerText : '<spring:message code="M01598"/>', customAttributes : {searchable : true}

	      	  },{
	      		  field : 'subjectAreaId', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			  index : 's.id' }/* */
	      	  }
	      ],
	      requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 's.create_date',
	    	  sord : 'desc',
	    	  _search : false
	      },
	      rowList : [10,25,50,100],
	      radio: true,
	    	tempId : 'ifvGridOriginTemplete'
	};
	subjectAreaRegistList = $("#subjectAreaRegistList").ifvsfGrid({ ejGridOption : ejGridOption });
	gridIdsubjectAreaRegistList = $("#gridIdsubjectAreaRegistList");
}

//팝업.
function subjectAreaPopInit(title){
	$("#adminTargetingPop").ifvsfPopup({
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
		if(subjectAreaRegistList.opt.gridControl.getSelectedRecords()[0] != null && subjectAreaRegistList.opt.gridControl.getSelectedRecords()[0] != '') {
			editSubjectAreas();
		} else {
			alert("목록을 선택해주세요.")
		}
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
		<button class="btn btn-sm" id="addSubjectAreaList" objCode="addSubjectAreaList_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M00136"/>
		</button> 
 		<button class="btn btn-sm" id="editSubjectAreaList" objCode="editSubjectAreaList_OBJ">
			<spring:message code="M00259"/>
		</button> 
		<button class="btn btn-sm" id="removeSubjectAreaList" objCode="removeSubjectAreaList_OBJ">
			<i class="fa fa-minus"></i>
			<spring:message code="M00275"/>
		</button> 
	</div>
</div>
<div id="subjectAreaRegistList" class="grid_bd0"></div>

