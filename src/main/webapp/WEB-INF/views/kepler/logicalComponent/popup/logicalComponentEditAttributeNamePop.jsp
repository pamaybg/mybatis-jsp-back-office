<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
function setAttributePop(){
	var curModifyTarget = curContextMenuTarget;
	var curText = removeSubfixKeyVal(curContextMenuTarget.data.text); 
	$("#inputAttributeName").val(curText);
}

function editAttribute() {
	
	var eNodeId = curContextMenuTarget.data.id;
	var eNodeText = $("#inputAttributeName").val();
	var eOldText = removeSubfixKeyVal(curContextMenuTarget.data.text);
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
				if(removeSubfixKeyVal(node.text) === eNodeText){
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
					node.text = eOldText + SUBFIX_SEG_KEY;
				} else if(isDateKey){
					node.text = eOldText + SUBFIX_DATE_KEY;
				} else {
					node.text = eOldText;							
				}
			}
			
			newTreeData.push(node);
		});
		treeObj.dataSource(newTreeData);
		treeObj.expandAll();
		treeObj.refresh();
		
		// Alert 처리
		if(isLengthOver){
			var msg = "<spring:message code='M01468'/>";
			msg.replace("[]", "[25]")
			alert(msg);
			return;
		}
		if(isExistsName){
			alert("<spring:message code='M01468'/>");
			return;
		}
		if(isEmpty){
			alert("<spring:message code='M01687'/>");
			return;
		}
	}
	
	// 수정 종료전 처리
	var newTreeData = treeObj.getTreeData();
	
	// 세그먼트인 경우 다시 붙이기
	if(isSegKey){
		newTreeData[curNodeIdx].text = eNodeText + SUBFIX_SEG_KEY
	} 
	// 기준일자인 경우 다시 붙이기
	else if (isDateKey){
		newTreeData[curNodeIdx].text = eNodeText + SUBFIX_DATE_KEY
	} else {
		newTreeData[curNodeIdx].text = eNodeText;
	}
		
	
	treeObj.dataSource(newTreeData);
	treeObj.expandAll();
	treeObj.refresh();
	logicalComponentPopClose();
}

$(document).ready(function(){
	setAttributePop();
	
	$("#btnEditAttributeName").on("click", function(){
		editAttribute();
	});
	
	$("#btnEditAttributeNameCancel").on("click", function(){
		logicalComponentPopClose();
	});
	
	$("#inputAttributeName").keydown(function(e){
		var code = e.keyCode||"";
		if(code === 13){
			editAttribute();
		}
	});
});
</script>


<div class="pop_inner_wrap" style="padding-bottom:10px">
	<ifv:input type="text" id="inputAttributeName" maxLength="25"/>
</div>
<div class="pop_btn_area">
	<button id="btnEditAttributeName" class="btn btn-sm btn_gray" objCode="btnEditAttributeName_OBJ">
		<i class="glyphicon glyphicon-check"></i>         
		<spring:message code="M00259"/>
	</button>
	<button id="btnEditAttributeNameCancel" class="btn btn-sm btn_lightGray2 cancel"objCode="btnEditAttributeNameCancel_OBJ">
		<spring:message code="M00171"/>
	</button>
</div>