<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifv" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var camMstPopList;

function camMstPopList(){
		var jqGridOption = {
			serializeGridData : function( data ){
				data.camType = camType;
			},
			ondblClickRow : function(row){
			},
			onSelectCell : function (data) {
			}, 
			loadComplete : function(data){
			},
		    url:'<ifv:action name="getCamMstListPop"/>',
		    colNames:[ 
	              /* '<spring:message code="M01440"/>', */
	              	'<spring:message code="L00269"/>'
	              	,'<spring:message code="L00419"/>'
	              	,'<spring:message code="M00314"/>'
	              	,'<spring:message code="L00158"/>'
	              	,'<spring:message code="L00272"/>'
	              	,'<spring:message code="L00273"/>'
	              	,'id'
	              	],
		    colModel:[{name:'camNm', index:'mcm.CAM_NM', width: "140px"},
		              {name:'camTypeNm', index:'c1.MARK_NAME', width: "90px"},
		              {name:'offerNm', index:'mom.OFFER_NM', width: "140px"},
		              {name:'promSubTypeNm', index:'c2.MARK_NAME', width: "100px"},
		              {name:'camStartDd', index:'mcm.CAM_START_DD', width: "70px", align:'center'},
		              {name:'camEndDd', index:'mcm.CAM_END_DD', width: "70px", align:'center'},
		              {name:'id', index:'mcm.ID', hidden : true}
				      ],  
			radio:true,
			sortname: 'mcm.CREATE_DATE',
			autowidth : true , sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
		};
		camMstPopList = $("#camMstPopList").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function() {
	camMstPopList();
	
	$("#btnSelect").on('click', function(){
		if(camMstPopList.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = camMstPopList.getCheckedList();
    		$("#camNm").val(dataArr[0].camNm).text(dataArr[0].id);
    		tiersPopClose();
    	}
	});
	
	$("#btnCancel").on('click', function(){
		tiersPopClose();
	}); 
});
</script>

<div id='camMstPopFormArea'>
	<div class="pop_inner_wrap">
		<div id="camMstPopList" class="grid_bd0 grid_w660"></div>
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
