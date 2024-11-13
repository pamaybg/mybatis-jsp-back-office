<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

function addAttributeGroup() {
	
	var newTempId = $.ifvmGetRowID();
	var text = $("#inputAttributeGroupName").val();
	
	if(text === ""){
		alert("<spring:message code='M01507'/>");
		return;
	}
	
	var isExistsName = false;
	var treeObj = $("#attributeTree").data("ejTreeView");
	treeObj.dataSource().forEach(function(node){
		if(node.parentId === ""){
			if(node.text === text){
				isExistsName = true;
			}
		}
	});
	
	if(isExistsName){
		alert("<spring:message code='M01429'/>");
		return;
	}
	
	var data = {
		     id : newTempId
		    ,text : text
		    ,parentId : ""
		    ,hasChild : true
		    ,expanded : false
		 	,lgcCompId : lgcCompData.lgcCompId
		 	,attributeGroupId : ""
			,tempAttributeGroupId : newTempId 
			,seq : "0"
			,colType : "P"
		}
	treeObj.dataSource().push(data);
	treeObj.refresh();
	logicalComponentPopClose();
}

$(document).ready(function(){
	$("#btnAttributeGroupPopAdd").on("click", function(){
		addAttributeGroup();
	});
	
	$("#inputAttributeGroupName").keydown(function(e){
		var code = e.keyCode||"";
		if(code === 13){
			addAttributeGroup();
		}
	});
});
</script>


<div class="pop_inner_wrap">
	<ifv:input type="text" id="inputAttributeGroupName" maxLength="25" />
</div>
<div class="pop_btn_area">
	<button id="btnAttributeGroupPopAdd" class="btn btn-sm btn_gray" objCode="btnAttributeGroupPopAdd_OBJ">
		<i class="glyphicon glyphicon-check"></i>         
		<spring:message code="M00279"/>
	</button>
</div>