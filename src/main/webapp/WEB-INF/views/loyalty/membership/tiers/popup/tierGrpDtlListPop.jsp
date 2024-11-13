<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var tierGrpDtlPopList;

function tierGrpDtlPopList(){
		var jqGridOption = {
			serializeGridData : function( data ){
				data.ridTierGroup = ridTierGroup;
			},
			ondblClickRow : function(row){
			},
			onSelectCell : function (data) {
			}, 
			loadComplete : function(data){
			},
		    url:'<ifv:action name="getTierListPop"/>',
		    colNames:[
	              	'<spring:message code="M02126" />'
	              	,'<spring:message code="L00235"/>'
	              	,'<spring:message code="L00236"/>'
	              	,'<spring:message code="L00391"/>'
	              	,'<spring:message code="L00393"/>'
	              	,'<spring:message code="M02127" />'
	              	,'rid'
	              	],
		    colModel:[{name:'seqNo', index:'lt.seq_no', resizable : false, align:'center'},
		              {name:'tierCd', index:'lt.tier_cd', resizable : false, align:'center'},
		              {name:'tierNm', index:'lt.tier_nm', resizable : false, align:'center'},
		              {name:'validStartDate', index:'lt.valid_start_date', resizable : false, align:'center' ,formatter:'date',  formatoptions:{newformat:"Y-m-d"}},
		              {name:'validEndDate', index:'lt.valid_end_date', resizable : false, align:'center',formatter:'date',  formatoptions:{newformat:"Y-m-d"}},
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false, align:'center'},
		              {name:'rid', index:'lt.rid', hidden : true}
				      ],  
			radio:true,
			sortname: 'lt.seq_no, lt.valid_start_date',
			sortorder: "asc",
			tempId : 'ifvGridOriginTemplete'
		};
		tierGrpDtlPopList = $("#tierGrpDtlPopList").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	tierGrpDtlPopList();
	
	$("#btnSelect").on('click', function(){
		tierDataArr = null;
		if(tierGrpDtlPopList.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = tierGrpDtlPopList.getCheckedList();
    		tierDataArr = dataArr;
    		tierPopupClose();
    	}
	});
	
	$("#btnCancel").on('click', function(){
		tierDataArr = null;
		tierPopupClose();
	}); 
});
</script>

<div id='tierGrpDtlPopFormArea'>
	<div class="pop_inner_wrap">
		<div id="tierGrpDtlPopList" class="grid_bd0 grid_w660"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="btnSelect" objCode="tierGrpbtnSelect_OBJ">     
			<i class="glyphicon glyphicon-check" ></i>    
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="terGrpbtnCancel_OBJ">         
			<spring:message code="M00284"/>
	    </button> 
	</div>
</div>
