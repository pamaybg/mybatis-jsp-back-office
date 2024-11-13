<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var subjectMapList;
var subjectAreaId;
var gridIdsubjectMapList;

function subjectMapList(){
		var jqGridOption = {
			serializeGridData : function( data ){
				data.dbInformId = dbInformId;
			},
			ondblClickRow : function(row){
			},
			onSelectCell : function (data) {
				subjectAreaId = data.subjectAreaId;
			}, 
			loadComplete : function(data){
 				var idArry = $("#gridIdsubjectMapList").getDataIDs();
				for(var i=0 ; i < idArry.length; i++){
					// 해당 id의 row 데이터를 가져옴
					var ret =  $("#gridIdsubjectMapList").getRowData(idArry[i]); 
				    //해당 row의 특정 컬럼 값이 Dimension, Aggregation 이면 multiselect checkbox disabled 처리
					if("Dimension" == ret.subjectAreaNm || "Aggregation" == ret.subjectAreaNm){
						//해당 row의 checkbox disabled 처리 "jqg_gridIdsubjectMapList_" 이 부분은 grid에서 자동 생성
						$("#jqg_gridIdsubjectMapList_"+idArry[i]).attr("disabled", true);
						//해당 row의 checkbox chkecked 처리 "jqg_gridIdsubjectMapList_" 이 부분은 grid에서 자동 생성
						$("#jqg_gridIdsubjectMapList_"+idArry[i]).attr("checked", true);
					}
				} 
			},
			onSelectAll: function(aRowids,status) { 
				// 전체선택 해지시
				if(status == false){
					// disabled Data정보 추출
					var cbs = $("tr.jqgrow > td > input.cbox:disabled", $("#gridIdsubjectMapList")[0]);
					// 체크박스 유지
					cbs.attr("checked","true");
					
					$("#gridIdsubjectMapList")[0].p.selarrrow = $("#gridIdsubjectMapList").find("tr.jqgrow:has(td > input.cbox:checked)").map(function() { return this.id; }).get();
				} 
			},
		    url:'<ifvm:action name="getSubjectAreaPop"/>',
		    colNames:[
		              '<spring:message code="M01596"/>',
		              '<spring:message code="M01598"/>',
		              'id'
		              ],
		    colModel:[{name:'subjectAreaNm', index:'s.subject_area_nm', resizable : false},
		              {name:'subjectDesc', index:'s.subject_desc', resizable : false}, 
		              {name:'subjectAreaId', index:'s.id', resizable : false,hidden:true},
				      ],  
			multiselect:true,
			sortname: 's.modify_date',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
		};
	subjectMapList = $("#subjectMapList").ifvGrid({ jqGridOption : jqGridOption });
	gridIdsubjectMapList = $("#gridIdsubjectMapList");
}

// multiselect Data 배열로 담는처리
function multiselectData(){
	var params = new Array();  
	var idArry = $("#gridIdsubjectMapList").jqGrid('getDataIDs'); //grid의 id 값을 배열로 가져옴
	  
	for (var i = 0; i < idArry.length; i++) { //row id수만큼 실행           
		if($("input:checkbox[id='jqg_gridIdsubjectMapList_"+idArry[i]+"']").is(":checked")){ //checkbox checked 여부 판단
			var rowdata = $("#gridIdsubjectMapList").getRowData(idArry[i]); // 해당 id의 row 데이터를 가져옴
			 
			// checked 된 row의 데이터를 그대로 배열에 담는 경우
			params.push(rowdata); //배열에 맵처럼 담김         
		}
	}
	return params;
}

//채널 관계 저장
function setMapping(){
	var obj = {};	
	var selectData = multiselectData(); 
	validation = $("#dbInformPopFormArea").ifvValidation();  

	if( selectData.length == 0 ){
		alert('<spring:message code="M00004" />');
	}else{
		if(validation.confirm() == true){
	
			for(var i=0; i<selectData.length; i++){
				obj.subjectAreaId = selectData[i].subjectAreaId;
				obj.dbInformId = dbInformId;
				// 맵핑정보 유무 확인
				$.ifvSyncPostJSON('<ifvm:action name="getMapping"/>',obj
				,function(result) {
					if(result.cnt > 0){
						// 맵핑정보 기록이 있으면 수정
						$.ifvSyncPostJSON('<ifvm:action name="editMapping"/>',obj
						,function(result) {});
					}else{
						// 맵핑정보 기록이 없으면 신규
						$.ifvSyncPostJSON('<ifvm:action name="setMapping"/>',obj
						,function(result) {});
					}
				});
			}
			alert('<spring:message code="M00623"/>');
			subjectAreaMapList(); 
			adminTargetingPopClose();
	 	}
	} 
}

$(document).ready(function() {
	subjectMapList();
	$("#btnColSave").on('click', function(){
		setMapping();
	});
	
	$("#btnColcan").on('click', function(){
		adminTargetingPopClose();
	});
});
</script>
<div id='dbInformPopFormArea'>
	<div class="pop_inner_wrap">
		<div id="subjectMapList" class="grid_bd0 grid_w660"></div>
	</div>
</div>

<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnColSave" objCode="btnColSave_OBJ">
		<i class="glyphicon glyphicon-check" ></i>    
		<spring:message code="M00211"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnColcan" objCode="btnColcan_OBJ">
		<spring:message code="C00040"/>
    </button> 
</div>
