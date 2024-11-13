<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
    </div>
    <div id="mbrEventHistListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="mbrEventHistListPop" class="popup_container"></div>
<script>
gMbrEventHistList  = {
		checkedData : null,
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.mbrNo = gMbrDetail.data.mbrNo;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = mbrEventHistList.getRowData()[rowNo-1];
		     	console.log(data);
		     },
		     loadComplete : function(result){


		     	window.top.setParentIframeHeight();
		     },
		     url : '<ifvm:action name="getMbrEventHistList"/>',
		     colNames:[
		               '<spring:message code="L01048"/>',
		               '<spring:message code="L01049"/>',
		               '<spring:message code="L01050"/>',
		               '<spring:message code="L01051"/>',
		               '<spring:message code="L01052"/>',
		               '<spring:message code="L01053"/>',
		               '<spring:message code="L01054"/>',
		               '<spring:message code="L01055"/>',
		               '<spring:message code="L01056"/>',
		               '<spring:message code="L01057"/>',
		               '<spring:message code="L01058"/>',
		               '<spring:message code="L01059"/>',
		             ],
		    colModel:[
		        { name:'EV_Number', 	    index:'EV_Number', 					width:'80px', 	align: 'center', 	resizable : true, 	 },
		        { name:'EV_Name', 	    	index:'EV_Name', 					width:'200px', 	align: 'center', 	resizable : true },
		        { name:'EV_Type',			index:'EV_Type', 					width:'80px', 	align: 'center', 	resizable : true },
		        { name:'EV_Status', 	    index:'EV_Status', 					width:'80px', 	align: 'center', 	resizable : true },
		        { name:'EV_StartDT', 		index:'EV_StartDT', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'EV_EndDT', 			index:'EV_EndDT', 					width:'80px', 	align: 'center', 	resizable : true },
		        { name:'EntryCnt', 	    	index:'EntryCnt', 					width:'80px', 	align: 'center', 	resizable : true },
		        { name:'EV_WonYN', 			index:'EV_WonYN', 					width:'100px', 	align: 'center', 	resizable : true },
		        { name:'WinnerType', 	    index:'WinnerType', 				width:'100px', 	align: 'center', 	resizable : true },
		        { name:'EV_WonDT', 			index:'EV_WonDT', 					width:'80px', 	align: 'center', 	resizable : true },
		        { name:'ApplicationChannel',index:'ApplicationChannel', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'ApplicationDateTime',index:'ApplicationDateTime', 		width:'80px', 	align: 'center', 	resizable : true },

		    ],
		     sortname: 'lbh.modify_date',
		     autowidth : true ,
		     sortorder: "desc",
		     shrinkToFit: false
		}
}
mbrEventHistList = $("#mbrEventHistListGrid").ifvGrid({ jqGridOption : gMbrEventHistList.jqGridOption });
//$("#mbrEventHistListGrid").ifvGrid({ jqGridOption : {} });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});


</script>