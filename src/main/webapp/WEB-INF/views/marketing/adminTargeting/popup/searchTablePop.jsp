<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
targetLevelChk = true;
var selectTableId;
var selecttblKorNm;
var selectLvlId;
var selectTgtLvlNm;
var selecttblEngNm;
var selectTgtLvlNm;
var segTableId;

//Table List
function tablePopList(){
	var jqGridOption = {
	    onSelectRow : function (data) {
	    	selectTableId = data.segTableId;
	    	segTableId = data.segTableId;
	    	selecttblKorNm = data.tblKorNm;
	    	selectTgtLvlNm = data.targetLevelNm;
	    	selecttblEngNm = data.tblEngNm;
	    	targetLevelId = data.targetLevelId;
		},
		serializeGridData : function( data ){
			data.targetLevelId = selectTargetId,
			data.pageChk = 'true';
		},		
		loadComplete : function(obj){},
		url: '<ifvm:action name="getTargetTableList"/>',
	    colNames:[
	              '<spring:message code="M01136"/>',
	              '<spring:message code="M01137"/>',
	              '<spring:message code="M01138"/>',
	              '<spring:message code="M01129"/>',
	              '<spring:message code="M01122"/>',
	              'id'
	              ,'targetLevelId'
	              ],
	    colModel:[{name:'tblSchemaNm', index:'mst.tbl_schema_nm', resizable : false},
	              {name:'tblKorNm', index:'mst.tbl_kor_nm', resizable : false},
	              {name:'tblEngNm', index:'mst.tbl_eng_nm', resizable : false},
	              {name:'tblDesc', index:'mst.tbl_desc', resizable : false},
	              {name:'targetLevelNm', index:'mstl.target_level_nm', resizable : false},
	              {name:'segTableId', index:'mst.id', resizable : false, hidden : true},
	              {name:'targetLevelId', index:'mst.target_level_id', resizable : false, hidden : true}
			      ],  
	    radio : true,
	    sortname: 'mst.tbl_schema_nm',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete'
	};
	tablePopList = $("#columnGridCon").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	tablePopList();
	if(typeof(subjectChk) != "undefined"){
		setTimeout(function(){tablePopList.requestData( { targetLevelId : selectTargetId } ), 100 })
	}
	$('#btnSelect').on('click', function() {
		
	if(typeof(subjectChk) != "undefined"){
 	   $("#baseTblId").text(selectTableId);
 	   $("#baseTblId").val(selecttblKorNm);
 	   $("#targetLevelId").val(selectTgtLvlNm);
	}
 	   

 	if(targetLevelChk)
 	{
 	   $("#tableId").val(selecttblEngNm);
	   $("#tableId").text(selectTableId); 
 	}
 
	   fdPopClose();
	});
	$('#btnCancel').on('click', function() {
		fdPopClose();
	});

});
</script>

<div class="pop_inner_wrap">
	<div id="columnGridCon" class="grid_bd0 grid_w660"></div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSelect">     
		<i class="glyphicon glyphicon-check"></i>    
		<spring:message code="M00282"/>
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCancel">         
		<spring:message code="M00284"/>
    </button> 
</div>
