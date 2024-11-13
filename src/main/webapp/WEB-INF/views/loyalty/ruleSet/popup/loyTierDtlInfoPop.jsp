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
			},
			loadComplete : function(data){
			},
		    url:'<ifv:action name="getAllTierList"/>',
		    colNames:[
	              /* '<spring:message code="M01440"/>', */
	              	'등급 코드'
	              	,'등급 명'
	              	,'rid'
	              	],
		    colModel:[
		              {name:'tierCd', index:'lt.tier_cd', resizable : false, align:'center'},
		              {name:'tierNm', index:'lt.tier_nm', resizable : false, align:'center'},
		              {name:'rid', index:'lt.rid', hidden : true}
				      ],  
			radio:true,
			sortname: 'lt.seq_no',
			/* autowidth : true ,*/ 
			sortorder: "asc",
			tempId : 'ifvGridOriginTemplete'
		};
		tierGrpDtlPopList = $("#tierGrpDtlPopList").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	tierGrpDtlPopList();
	
	$("#btnSelect").on('click', function(){
		
		if(tierGrpDtlPopList.getCheckedList().length == 0){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = tierGrpDtlPopList.getCheckedList();
    		
    		$("#tierNm").val(dataArr[0].tierNm);
    		$("#tierNm").text(dataArr[0].rid);
    		
    		tierPopupClose();
    	}
	});
	
	$("#btnCancel").on('click', function(){
		tierPopupClose();
	}); 
});
</script>

<div id='tierGrpDtlPopFormArea'>
	<div class="pop_inner_wrap">
		<div id="tierGrpDtlPopList"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="btnSelect">     
			<i class="glyphicon glyphicon-check" ></i>    
			<spring:message code="M00282"/>
		</button> 
		<button class="btn btn-sm btn_lightGray2" id="btnCancel">         
			<spring:message code="M00284"/>
	    </button> 
	</div>
</div>
