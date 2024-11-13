<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var columnList;
var selectId;

function columnList(){
		var jqGridOption = {
			serializeGridData : function( data ){
				data.chnlId = selectChnlId;
			},
			ondblClickRow : function(row){
			},
			onSelectCell : function (data) {
				selectId = data.id
			}, 

		    url:'<ifvm:action name="getpermissionList"/>',
		    colNames:[
		              '<spring:message code="M01146"/>',
		              '<spring:message code="M01147"/>',
		              '<spring:message code="M01148"/>',
		              '<spring:message code="M01276"/>',
		              'id'
		              ],
		    colModel:[{name:'colKorNm', index:'COL_KOR_NM', resizable : false},
		              {name:'colEngNm', index:'COL_ENG_NM', resizable : false},
		              {name:'colTypeCd', index:'c2.mark_name', resizable : false}, 
		              {name:'flagAtribVal', index:'mec.FLAG_ATRIB_VAL', resizable : false},  
		              {name:'id', index:'met.id', resizable : false,hidden:true},
				      ],  
			radio:true,
			sortname: 'met.modify_date',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
		};
	columnList = $("#columnGridCon").ifvGrid({ jqGridOption : jqGridOption });
}


//채널 관계 저장
function setChnlrel(){
	
	var obj = {};
	
	validation = $("#targetTablePopFormArea").ifvValidation();
	
	if(validation.confirm() == true){

		obj.chnlId = selectChnlId;
		obj.columnId = selectId;
		
		$.ifvSyncPostJSON('<ifvm:action name="setChnlRel"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			ChnlRelList.searchGrid( { chnlId : selectChnlId } );
		});
		selectId = null;
		adminTargetingPopClose();
	}
	
}

$(document).ready(function() {
	columnList();
	$("#btnColSave").on('click', function(){
		if(selectId != null) setChnlrel()
		else alert('<spring:message code="M00499"/>')
	    	
	});
	
	$("#btnColcan").on('click', function(){
		adminTargetingPopClose();
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
