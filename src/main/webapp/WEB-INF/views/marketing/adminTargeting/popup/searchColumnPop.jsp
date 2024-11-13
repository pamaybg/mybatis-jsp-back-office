<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var columnList;
var selectId;
var selectNm;
var selectKorNm;
var selectChk = false;

function columnList(){
	
	var jqGridOption = {
			
		onSelectCell : function (data) {
			
			selectChk = true
			selectId = data.segColumnId;
			selectNm = data.colEngNm;
			selectKorNm = data.colKorNm;
		},
		serializeGridData : function( data ){
			data.segTableId = $("#tableId").text() 
			data.tgtLvlId = selectTargetId
		},
		url: '<ifvm:action name="getTargetColumList"/>',
	    colNames:[ '<spring:message code="M00519"/>',
	              '<spring:message code="M01146"/>',
	              '<spring:message code="M01147"/>',
	              '<spring:message code="M01148"/>',
	              '<spring:message code="M01129"/>'
	              ,'segTableId'
	              ,'segColumnId'
	              ],
	    colModel:[{name:'tableNm', index:'mst.tbl_eng_nm', resizable : false},
	              {name:'colKorNm', index:'msc.col_kor_nm', resizable : false},
	              {name:'colEngNm', index:'msc.col_eng_nm', resizable : false},
	              {name:'colTypeCd', index:'cc.code_name', resizable : false},
	              {name:'colDesc', index:'msc.col_desc', resizable : false},
	              {name:'segTableId', index:'msc.seg_table_id', resizable : false, hidden : true},
	              {name:'segColumnId', index:'msc.id', resizable : false, hidden : true}
			      ],  
	    radio : true,
	    sortname: 'mst.tbl_eng_nm',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	    ,emptyRows : true
	};
	columnList = $("#columnGridCon").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	columnList();
	
	setTimeout(function(){ columnList.requestData( { segTableId : $("#tableId").text() } ) ,100});
	

	$("#btnColSave").on('click', function(){
			
	    	if(typeof(joinBtnCehck) != "undefined"){
	    		if(joinBtnCehck == false){
	    			$("#joincolId").text(selectId);
	    	    	$("#joincolId").val(selectNm);
	    	    	joinBtnCehck = true;
	    	    	
	    		}else{
	    			$("#colId").text(selectId);
			    	$("#colId").val(selectNm);
	    		}
	    		fdPopClose();
	    	}else{
	    		$("#colId").text(selectId);
		    	$("#colId").val(selectNm);
		    	$("#fieldEngNm").val(selectKorNm);
		    	fdPopClose();
	    	}
	    	
	    	
	    	
	});
	
	$("#btnColcan").on('click', function(){
		fdPopClose();
	});
});
</script>

<div class="pop_inner_wrap">
	<div id="columnGridCon" class="grid_bd0 grid_w660"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnColSave">     
		<i class="glyphicon glyphicon-check" ></i>    
		<spring:message code="M00282"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnColcan">         
		<spring:message code="M00284"/>
    </button> 
</div>
