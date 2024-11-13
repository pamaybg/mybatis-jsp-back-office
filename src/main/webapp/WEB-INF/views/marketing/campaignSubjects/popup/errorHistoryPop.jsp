<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var errorHistoryPopGrid; 

function errorHistoryPopGrid(){
	var jqGridOption = {
		loadComplete : function(obj){
			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'errorHistoryPop',
				contentsId : 'errorHistoryPopWrap'
			});
			new ifvm.PopupCenter({
				popupDivId : 'errorHistoryPop'
			});
		},
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){
			
		},
	    //url:'<ifvm:action name="getParOffer"/>',
	    colNames:['<spring:message code="M01347"/>',
	              '<spring:message code="M01348"/>', 
	              '<spring:message code="M01349"/>', 
	              '<spring:message code="M01350"/>',
	              '<spring:message code="M01351"/>',
	              '<spring:message code="M01352"/>'
	              ],
	    colModel:[
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false}
	    ],
	    sortname: '',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	errorHistoryPopGrid = $("#errorHistoryPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	errorHistoryPopGrid();
	
  	//닫기
    $('#errorHistoryPopClose').on('click', function(){
    	errorHistoryPopClose();
    });
});
</script>

<div id="errorHistoryPopWrap">
	<div class="pop_inner_wrap">
		<div id="errorHistoryPopGrid" class="pop900_grid double_row_grid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_lightGray2" id="errorHistoryPopClose">         
	        <spring:message code="M01322"/>
	    </button> 
	</div>
</div>