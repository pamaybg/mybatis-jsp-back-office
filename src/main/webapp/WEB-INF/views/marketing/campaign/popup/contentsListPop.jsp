<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var contentsListPopGrid;
var userDiv = $.ifvmGetUserInfo().orgNumber;

function contentsListPopGrid(){
	
	var chnlType = $("#chnlType").val();
	//var contentsType = $("#contentsType").val();

	var colNameArry = new Array();
	var colModelArry = new Array();
    colNameArry.push('<spring:message code="M00375"/>'); //채널유형
	colNameArry.push('<spring:message code="M03024"/>'); //컨텐츠 번호
    colNameArry.push('<spring:message code="M00376"/>'); //컨텐츠명
    colModelArry.push({name:'contentsChannel',  index:'c1.mark_name',  width : 90, resizable : false});
	colModelArry.push({name:'contsNo', 			index:'mc.CONTS_NO',  	width : 95, resizable : false});
    colModelArry.push({name:'contentsName',     index:'mc.CONTS_NM',   width : 200,  resizable : false});
    
	//SMS의 경우 제목 없음. 
	if (chnlType != 'SMS' 
	        && chnlType != 'RECEIPT') {
    	colNameArry.push('<spring:message code="M00377"/>');
        colModelArry.push({name:'title',            index:'mc.CONTS_TITLE',  width : 250,  resizable : false});
	}
    colNameArry.push('<spring:message code="M00379"/>'); //등록자 
    colNameArry.push('<spring:message code="M00380"/>'); //등록일자
    colNameArry.push('path');
    colNameArry.push('id');
    colNameArry.push('contentsTypeCode');
    colNameArry.push('rid'); //오퍼 rid
	colModelArry.push({name:'createBy',         index:'e1.name',        width : 80,resizable : false});
	colModelArry.push({name:'createDate',       index:'mc.CREATE_DATE', width : 80,resizable : false});
	colModelArry.push({name:'path',             index:'c6.ATTRIB01',    resizable : false , hidden : true,  searchable : false});
	colModelArry.push({name:'id',               index:'mc.id',          resizable : false,  hidden : true,  searchable : false});
	colModelArry.push({name:'contentsTypeCode', index:'c1.code_name',   resizable : false,  hidden : true,  searchable : false});
	colModelArry.push({name:'rid'		       , index:'mc.rid',   resizable : false,    hidden : true, searchable : false});//오퍼 rid
	
	var jqGridOption = {
		loadComplete : function(obj){
			new ifvm.PopupHeight({
				popupDivId : 'loadContentsPopup',
				contentsId : 'contentsListArea'
			});
		},
		serializeGridData : function(data){
			if($.fn.ifvmIsNotEmpty(chnlType)){
				data.chnlType = chnlType;
				data.userDiv = userDiv;
			}
			/* if($.fn.ifvmIsNotEmpty(contentsType)){
                data.contentsType = contentsType;
            } */
			return data;
		},
		onSelectRow : function (data) {
		},
	    url:'<ifvm:action name="getContent"/>',
		postData : {authType : authType, brdCd: brandCd, empId: $.ifvmGetUserInfo().id, empType: empType},
	    colNames: colNameArry,
	    colModel: colModelArry,
	    radio:true,
	    sortname: 'mc.CREATE_DATE',
		sortorder: 'asc',
		caption: '<spring:message code="M00372"/>',
		tempId : 'ifvGridOriginTemplete'
	};
	contentsListPopGrid = $("#contentsListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	contentsListPopGrid();
	
	//선택
	$("#contentsListSelectBtn").on("click", function(){
		if(contentsListPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}
		else {
    		var dataArr = contentsListPopGrid.getCheckedList();
			changeContents(dataArr[0]);
			loadContentCheck = true;
    		loadPopupClose();
    	}
	});
	
	//취소
	$("#contentsListCancelBtn").on("click", function(){
		loadPopupClose();
	});
	
});
</script>

<div id="contentsListArea">
	<div class="pop_inner_wrap">
		<div id="contentsListPopGrid" class="con_size_2"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="contentsListSelectBtn" objCode="contentsListSelectBtn_OBJ">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="contentsListCancelBtn" objCode="contentsListCancelBtn_OBJ">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>