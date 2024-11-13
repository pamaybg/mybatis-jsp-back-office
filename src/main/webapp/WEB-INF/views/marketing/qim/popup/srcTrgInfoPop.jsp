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
var srcTgtSourceListPopGrid; 
var srcTgtType = '<%= cleanXss(request.getParameter("srcTgtType")) %>';

function srcTgtSourceListPopGrid(){
	var jqGridOption = {
			loadComplete : function(obj){
				new ifvm.PopupHeight({
					popupDivId : 'popupContainer',
					contentsId : 'srcTgtSourceListArea'
				});
				new ifvm.PopupCenter({
					popupDivId : 'popupContainer'
				});
			},
		serializeGridData : function( data ){
			data.rows = 10;
			return data;
		},
 	    url:'<ifvm:action name="getSrcTgtSourceList"/>',
	    colNames:[
	              '<spring:message code="Q02827"/>',  // 소스/타겟 명 
	              '<spring:message code="Q02828"/>',  // 약어 
	              '<spring:message code="I00075"/>',  // 설명 
	              'rid'
	              ],
	    colModel:[
	        {name:'srcTgtNm',	index:'qst.srctgt_nm',     resizable : false},
	        {name:'srcTgtAlias',index:'qst.srctgt_alias', 	  resizable : false},
	        {name:'comment',	index:'qst.comment', resizable : false},
	        {name:'rid',		index:'qst.rid', 		  hidden : true }
	    ],
	    radio:true,
	    sortname: 'qst.create_date',
		sortorder: "desc",
	    tempId : 'ifvGridOriginTemplete',
	    caption: '<spring:message code="Q02907"/>'
	};
	srcTgtSourceListPopGrid = $("#srcTgtSourceListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	srcTgtSourceListPopGrid();
	
	//선택
	$("#addSrcTgtSourceListBtn").on("click", function(){
		if(srcTgtSourceListPopGrid.getCheckedList() == ''){
    		alert('<spring:message code="M00285"/>');
    	}else {
    		var dataArr = srcTgtSourceListPopGrid.getCheckedList();
    		srcTgtSourceListModalSelected(dataArr[0], srcTgtType);
    		popupClose();
    	}
	});
	
	//취소
	$("#cancelSrcTgtSourceListBtn").on("click", function(){
		popupClose();
	});
});
</script>
<div id="srcTgtSourceListArea">
	<div class="pop_inner_wrap">
		<div id="srcTgtSourceListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
		<button class="btn btn-sm btn_gray" id="addSrcTgtSourceListBtn">
			<i class="glyphicon glyphicon-check"></i>             
			<spring:message code="M00282" />
		</button>
		<button class="btn btn-sm btn_lightGray2" id="cancelSrcTgtSourceListBtn">         
	        <spring:message code="M00284"/>
	    </button>  
	</div>
</div>