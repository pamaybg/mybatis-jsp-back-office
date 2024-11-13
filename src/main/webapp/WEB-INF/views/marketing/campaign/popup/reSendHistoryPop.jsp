<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
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
var resendHistoryPopGrid; 
var camId = '<%= cleanXss(request.getParameter("camId")) %>';

function resendHistoryPopGrid(){
	var jqGridOption = {
		serializeGridData : function( data ){
			data.camId = camId;
			return data;
		},
	    url:'<ifvm:action name="chnlReSendHistory"/>',
	    colNames:['<spring:message code="M01360" />',
	              '<spring:message code="M01660" />', 
	              '<spring:message code="M01661" />'
	              ],
	    colModel:[
	        {name:'memId',index:'mesl.recv_mem_id', resizable : false},
			{name:'sendDate',index:'mesl.bat_send_proc_time', resizable : false},
			{name:'empId',index:'em.name', resizable : false}
	    ],
	    sortname: 'mesl.create_date',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	resendHistoryPopGrid = $("#resendHistoryPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	resendHistoryPopGrid();
	
  	//닫기
    $('#resendHistoryPopClose').on('click', function(){
    	resendHistoryPopClose();
    });
});
</script>

<div id="errorHistoryPopWrap">
	<div class="pop_inner_wrap">
		<div id=resendHistoryPopGrid class="pop900_grid double_header_grid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_lightGray2" id="resendHistoryPopClose">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>