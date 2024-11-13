<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<style>
#subjectAreaTreeList {display: none; padding-top: 10px;}
#emptyTreeArea {padding-top:10px; display: none; font-size: 12px; text-align:center; color:#999;}
</style>

<script>
var subjectDbId = null;
var delChk = false;

function subjectAreaMapList() {
        var subjectAreaTreeData=null;

        //로지컬컴포넌트 트리 목록 조회
        $.ifvSyncPostJSON('<ifvm:action name="getSubjectAreaMapping"/>', {
            dbInformId: dbInformId 
        },
        function(result) {
           	subjectAreaTreeData = result;
           	
           	//데이터가 있을 경우
           	if(result.length > 0){
           		$('#subjectAreaTreeList').show();
           		$('#emptyTreeArea').hide();
           	} else {
           		$('#subjectAreaTreeList').hide();
           		$('#emptyTreeArea').show();
           	}
        });
    	
    	$("#subjectAreaTreeList").ifvsfTree({
    		allowDragAndDrop: true,
            allowDropChild: false,
            allowDropSibling: true,
            allowDragAndDropAcrossControl: true,
    	    fields: { id: "id"
    	    		, text: "text"
    	    		, parentId: "parentId"
    	    		, dataSource: subjectAreaTreeData
    	    		, seq: "seq"
    	    },
    	    setBtn : {add : false, mod : false, del : true},
    	    nodeSelect: subjectNodeSelect,
    	    nodeDropped: subjectNodeDropped,
    	    template : "#baseTreeTemplate1"
    	});
    	$("#subjectAreaTreeList").data("ejTreeView");
    	$("#subjectAreaTreeList").data("ejTreeView").refresh();
}

//노드 클릭 이벤트
function subjectNodeSelect(args) {
     //삭제 버튼
	var thisElement = $( args.currentElement );
	var deleteBtn = thisElement.find( "[btnId=minus]" );
	/* 고정 주제영역 으로 맵핑정보가 삭제 되면 안됨 */
	if(args.value.trim() == 'Aggregation' || args.value.trim() == 'Dimension'){
		deleteBtn.remove();
	}else{
		$(".plus_minus_btn").on('click', function(){
	   		subjectDbId = args.id;
	   		deleteSubject();
	   	});
	}	
}

//노드 드랍 이벤트
function subjectNodeDropped(args) {
	var tempIdx = 0;
	
	var subjectAreaTreeData = $("#subjectAreaTreeList").data("ejTreeView");
 	var subjectAreaTreeViewDataSource = subjectAreaTreeData.getTreeData();
 	
	if(confirm('<spring:message code="C00071" />')){
		subjectAreaTreeViewDataSource.forEach(function(thisObj, idx){
			$.ifvSyncPostJSON('<ifvm:action name="editSubjectDb"/>',{
				subjectDbId	: thisObj.id, seq: ++tempIdx
			},function(result) {
			}); 
		}); 
	}
}

//삭제 버튼
function deleteSubject() {
	delChk = false;
	
	if( subjectDbId.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(confirm('<spring:message code="M00296"/>')){
			$.ifvSyncPostJSON('<ifvm:action name="subjectDBDelChk"/>',{
				subjectDbId : subjectDbId
		    },function(result) {
				if(result.delFlag == "1"){
					alert("<spring:message code='M01582' />");
					delChk = true;
				}			
			});
			if(delChk == false){
				$.ifvSyncPostJSON('<ifvm:action name="removeSubjectDb"/>',{
					subjectDbId	: subjectDbId
				},function(result) {
					alert("<spring:message code='M00622'/>");
					subjectAreaMapList();
				});
			}
		}
	}
}

// 추가팝업 호출
function subjectAreaPopInit(title){
	$("#adminTargetingPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="subjectAreaPop"/>',
        contentType: "ajax",
        title: title,
        width: 710,
        close : 'adminTargetingPopClose'
    });
}

$(document).ready(function(){
	subjectAreaMapList();
	
	$("#addsubjectAreaMapList").on("click", function(){
		if(dbInformId != null){
 			subjectAreaPopInit('<spring:message code="M01599" />'); 
		}
		else{
			alert('<spring:message code="M00004" />');
		}
	});
});

</script>
	
<div class="page_btn_area">
	<div class="col-xs-7">
 		<span><spring:message code="M01155"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id="addsubjectAreaMapList" objCode="addsubjectAreaMapList_OBJ">
			<i class="fa fa-plus"></i>
			<spring:message code="M01120"/>
		</button> 
	</div>
</div>
<div id="subjectAreaTreeList"  class="analysis_tree"></div>
<div id="emptyTreeArea"><spring:message code="M01581"/></div>
