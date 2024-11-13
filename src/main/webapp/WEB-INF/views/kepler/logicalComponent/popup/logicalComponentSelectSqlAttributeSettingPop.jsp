<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function setAttributePop(){
	var curModifyTarget = curContextMenuTarget;
	var curText = removeSubfixKeyVal(curContextMenuTarget.data.sqlValue); 
	$("#inputAttributeSql").val(curText);	

}

function editAttribute() {
	
	var eNodeId = curContextMenuTarget.data.id;
	var eNodeText = $("#inputAttributeSql").val();
	var eOldText = removeSubfixKeyVal(curContextMenuTarget.data.sqlValue);
	var eColType = curContextMenuTarget.data.colType;
	
	// 설정 된 키가 있는지 확인
	var curNodeIdx = -1;
	var isSegKey = false;
	var isDateKey = false;
	var treeObj = $("#attributeTree").data("ejTreeView");
	treeObj.getTreeData().forEach(function(node, nodeIdx){
		if(eNodeId === node.id){
			isSegKey = (node.segKeyYn === "1") ? true : false;
			isDateKey = (node.dateKeyYn === "1") ? true : false;
			curNodeIdx = nodeIdx;
		}
	});
	
	// 빈 값 체크
	var isEmpty = (eNodeText === '');
	
	// 길이 체크
	var isLengthOver = (eNodeText.length > 25);
	
	// 필드명 중복 체크
	var isExistsName = false;
	treeObj.getTreeData().forEach(function(node){
		if(eColType === node.colType){
			if(eNodeId !== node.id){
				if(removeSubfixKeyVal(node.sqlValue) === eNodeText){
					isExistsName = true;
				}
			}
		}
	});
	
	// 중복 존재시
	if(isExistsName || isLengthOver || isEmpty){
		// 이름 되돌려놓기
		var newTreeData = new Array();
		treeObj.getTreeData().forEach(function(node, nodeIdx){
			if(eNodeId === node.id){
				if(isSegKey){
					node.sqlValue = eOldText + SUBFIX_SEG_KEY;
				} else if(isDateKey){
					node.sqlValue = eOldText + SUBFIX_DATE_KEY;
				} else {
					node.sqlValue = eOldText;							
				}
			}
			
			newTreeData.push(node);
		});
		treeObj.dataSource(newTreeData);
		treeObj.expandAll();
		treeObj.refresh();

	}
	
	// 수정 종료전 처리
	var newTreeData = treeObj.getTreeData();
	
	// 세그먼트인 경우 다시 붙이기
	if(isSegKey){
		newTreeData[curNodeIdx].sqlValue = eNodeText + SUBFIX_SEG_KEY
	} 
	// 기준일자인 경우 다시 붙이기
	else if (isDateKey){
		newTreeData[curNodeIdx].sqlValue = eNodeText + SUBFIX_DATE_KEY
	} else {
		newTreeData[curNodeIdx].sqlValue = eNodeText;
	}
		
	
	treeObj.dataSource(newTreeData);
	treeObj.expandAll();
	treeObj.refresh();
	logicalComponentPopClose();
}


$(document).ready(function() {
	
	setAttributePop();

	$("#btnEditAttributeName").on("click", function(){
		editAttribute();
	});
	$("#btnEditAttributeNameCancel").on("click", function(){
		logicalComponentPopClose();
	});
	$("#inputAttributeSql").keydown(function(e){
		var code = e.keyCode||"";
		if(code === 13){
			editAttribute();
		}
	});
	
});


</script>

<div class="pop_inner_wrap" style="padding-bottom:10px">
	<p style="color: #B40404">※조회 SQL의 값(COL_VALUE), 설명(COL_NM) 으로 Alias 로 지정 해야 합니다.</p>
		<ifv:input type="textarea" id="inputAttributeSql" rows="8"/>
</div>
<div class="pop_btn_area">
	<button id="btnEditAttributeName" class="btn btn-sm btn_gray" objCode="settingBtnEditAttributeName_OBJ">
		<i class="glyphicon glyphicon-check"></i>         
		<spring:message code="M00280"/>
	</button>
	<button id="btnEditAttributeNameCancel" class="btn btn-sm btn_lightGray2 cancel" objCode="settingBtnEditAttributeNameCancel_OBJ">
		<spring:message code="M00171"/>
	</button>
</div>