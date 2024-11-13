<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var conditionListPopGrid; 
var conditionDetailPopGrid; 

var isNew = true;

/* 조건 목록 */
function conditionListPopGrid(){
	var jqGridOption = {
		onSelectRow : function (data) {
			conditionGroupName = data.groupName;
			conditionGroupCode = data.groupCode;
			conditionDetailPopGrid.requestData( { groupCode : data.groupCode} );
		},
		loadComplete : function(obj){
			//최초 popup 높이를 잡기 위해서 그리드생성 완료 후 다음 그리드 생성
			if(isNew){
				conditionDetailPopGrid();	
				isNew = false;
			}
		},
	    url:'<ifvm:action name="getDropDownList"/>',
	    colNames:['<spring:message code="M00544"/>',
	              '<spring:message code="M00545"/>'],
	    colModel:[
	        {name:'groupName',index:'group_name', resizable : false},
	        {name:'groupCode',index:'group_code', resizable : false}
	    ],
	    autowidth:true,
	    sortname: 'group_name',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M00543"/>',
	    rowList: '5'
	};
	conditionListPopGrid = $("#conditionListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

/* 조건 상세 */
function conditionDetailPopGrid(){
	var jqGridOption = {
		loadComplete : function(obj){
			//popup 높이 맞추기
			if(isNew == false){
				new ifvm.PopupHeight({
					popupDivId : 'popupContainer',
					contentsId : 'conditionListPopCon'
				});
			}
		},
	    url:'<ifvm:action name="groupDetailList"/>',
	    colNames:['<spring:message code="M00547"/>',
	              '<spring:message code="M00548"/>'],
	    colModel:[
	        {name:'codeName',index:'code_name', resizable : false},
	        {name:'markName',index:'mark_name', resizable : false}
	    ],
	    autowidth:true,
	    sortname: 'create_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M00546"/>',
	    rowList: '5'
	};
	conditionDetailPopGrid = $("#conditionDetailPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	conditionListPopGrid();
	
	$('#conditionPopSelectBtn').on('click', function(){
		$("#droupDownCode").val(conditionGroupCode);
		popupClose();
	});
	
	$('#conditionPopCancelBtn').on('click', function(){
		popupClose();
	});
});
</script>

<div id="conditionListPopCon">
	<div class="pop_inner_wrap">
		<div id="conditionListPopGrid" class="con_size"></div>
		<div id="conditionDetailPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="conditionPopSelectBtn" objCode="conditionListPopSelect_OBJ">  
			<i class="glyphicon glyphicon-check"></i>        
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="conditionPopCancelBtn" objCode="conditionListPopCancel_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>