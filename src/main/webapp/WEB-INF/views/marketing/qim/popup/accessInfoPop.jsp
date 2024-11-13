<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
var accessInfoListPopGrid;
var rscType = '<%= cleanXss(request.getParameter("rscType")) %>';

function accessInfoListPopGrid(){
	
	var jqGridOption = {
			loadComplete : function(obj){
				new ifvm.PopupHeight({
					popupDivId : 'popupContainer',
					contentsId : 'accessInfoListArea'
				});
				new ifvm.PopupCenter({
					popupDivId : 'popupContainer'
				});
			},
		serializeGridData : function( data ){
			data.rows = 10;
			data.useYn = 1;
			
			if ($.fn.ifvmIsNotEmpty(rscType)) {
				if (rscType != 'null')
					data.rscType = rscType;
			}
			
			return data;
		},
 	    url:'<ifvm:action name="getAccessInfoList"/>',
	    colNames:[
	              '<spring:message code="I02046"/>',  // 유형 -->
	              '<spring:message code="Q02846"/>',  // 리스트명 -->
	              '<spring:message code="Q02859"/>',  // DB Type -->
	              '<spring:message code="Q02860"/>',  // 호스트 주소 -->
	              '<spring:message code="Q02861"/>',  //Port -->
	              '<spring:message code="Q02862"/>',  // 스키마 -->
	              '<spring:message code="Q02863"/>'], //UserName-->
	    colModel:[
	        {name:'rscType',index:'c1.mark_name', resizable : false},
	        {name:'rscNm',index:'qr.rsc_nm', resizable : false},
	        {name:'dbType',index:'c2.mark_name', resizable : false},
	        {name:'hostAddr',index:'qr.host_addr', resizable : false},
	        {name:'port',index:'qr.port', resizable : false},
	        {name:'dbSchema',index:'qr.dbSchema', resizable : false},
	        {name:'userName',index:'qr.login_id', resizable : false}
	    ],
	    radio:true,
	    sortname: 'qr.create_date, qr.rid',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="M00529"/>'
	};
	accessInfoListPopGrid = $("#accessInfoListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	
	accessInfoListPopGrid();
	
	//선택
	$("#addAccessInfoListBtn").on("click", function(){
		if(accessInfoListPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = accessInfoListPopGrid.getCheckedList();
    		accessInfoListModalSelected(dataArr[0]);
    		popupClose();
    	}
	});
	
	//취소
	$("#cancelAccessInfoListBtn").on("click", function(){
		popupClose();
	});
	
});
</script>

<div id="accessInfoListArea">
	<div class="pop_inner_wrap">
		<div id="accessInfoListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="addAccessInfoListBtn">
			<i class="glyphicon glyphicon-check"></i>             
			<spring:message code="M00282" />
		</button>
		<button class="btn btn-sm btn_lightGray2" id="cancelAccessInfoListBtn">         
	        <spring:message code="M00284"/>
	    </button>  
	</div>
</div>