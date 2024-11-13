<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var channelUnsentPopGrid; 

function channelUnsentPopGrid(){
	var jqGridOption = {
		serializeGridData : function( data ){
			
		},
	    //url:'<ifvm:action name="getParOffer"/>',
	    colNames:['<spring:message code="M01360"/>',
	              '<spring:message code="M01365"/>', 
	              '<spring:message code="M01366"/>', 
	              '<spring:message code="M01367"/>',
	              '<spring:message code="M01368"/>',
	              '<spring:message code="M01369"/>',
	              '<spring:message code="M01370"/>',
	              '<spring:message code="M01371"/>',
	              '<spring:message code="M01372"/>'
	              ],
	    colModel:[
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false}
	    ],
	    sortname: '',
		sortorder: "desc",
		tempId : 'ifvGridSingleTemplete'
	};
	channelUnsentPopGrid = $("#channelUnsentPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	channelUnsentPopGrid();
	
  	//닫기
    $('#channelUnsentPopClose').on('click', function(){
    	channelUnsentPopClose();
    });
});
</script>

<div id="errorHistoryPopWrap">
	<div class="pop_inner_wrap">
		<div id=channelUnsentPopGrid class="pop900_grid double_header_grid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_lightGray2" id="channelUnsentPopClose">         
	        <spring:message code="M01322"/>
	    </button> 
	</div>
</div>