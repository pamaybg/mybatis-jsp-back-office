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

    <div id="mbrTaxiHistListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="mbrTaxiHistListPop" class="popup_container"></div>
<script>
gMbrTaxiHistList  = {
		checkedData : null,
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = mbrTaxiHistList.getRowData()[rowNo-1];
		     	console.log(data);
		     	gMbrTaxiHistList.checkedData = data;
		     },
		     loadComplete : function(result){

		     	window.top.setParentIframeHeight();
		     },
		     url : '<ifvm:action name="getMbrTaxiHistList"/>',
		     colNames:[
		               '<spring:message code="L01333"/>',
		               '<spring:message code="L01334"/>',
		               '<spring:message code="L01335"/>',
		               'rid'
		             ],
		    colModel:[
		        { name:'convSbst', 	    index:'tch.conv_sbst', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'convDt', 	    index:'tch.conv_dt', 			width:'80px', 	align: 'center', 	resizable : true ,  formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
		        { name:'createBy', 		index:'em1.name', 				width:'100px', 	align: 'center', 	resizable : true },
		        { name:'rid', 	   		index:'tch.rid', 					width:'50px', 	align: 'center', 	resizable : true, 	hidden:true },

		    ],
		     sortname: 'tch.create_date',
		     autowidth : true ,

		     sortorder: "desc"
		}
}
mbrTaxiHistList = $("#mbrTaxiHistListGrid").ifvGrid({ jqGridOption : gMbrTaxiHistList.jqGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>