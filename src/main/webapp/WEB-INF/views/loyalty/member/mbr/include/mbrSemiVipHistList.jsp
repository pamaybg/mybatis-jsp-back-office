<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
        </div>
        <div class="col-xs-5 searchbtn_r">
        </div>

    </div>

    <div id="mbrSemiVipHiatListGrid" class="white_bg grid_bd0"></div>
</div>
<script>
gMbrSemiVipHistList  = {
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		    	 var data = mbrSemiVipHistList.getRowData()[rowNo-1];
			     	console.log(data);
		     },
		     loadComplete : function(result){

		     	window.top.setParentIframeHeight();
		     },
		     url : '<ifvm:action name="getMbrSemiVipHistList"/>',
		     colNames:[
		               '<spring:message code="L01996"/>',
		               '<spring:message code="L01997"/>',
		               '<spring:message code="L01998"/>',
		               '<spring:message code="L01999"/>',
		               'rid'
		             ],
		    colModel:[
		        { name:'createDate', 	index:'lvh.CREATE_DATE', 	width:'80px', 	align: 'center', 	resizable : true,  formatter:'date', formatoptions:{newformat:"Y-m-d"} },
		        { name:'startDt', 		index:'lvh.START_DT', 		width:'100px', 	align: 'center', 	resizable : true,  formatter:'date', formatoptions:{newformat:"Y-m-d"} },
		        { name:'endDt', 		index:'lvh.END_DT', 		width:'100px', 	align: 'center', 	resizable : true,  formatter:'date', formatoptions:{newformat:"Y-m-d"} },
		        { name:'expireDt', 		index:'lvh.EXPIRE_DT', 		width:'80px', 	align: 'center', 	resizable : true,  formatter:'date', formatoptions:{newformat:"Y-m-d"} },
		        { name:'rid', 			index:'lvh.rid', 				hidden : true},
		    ],
		     sortname: 'lvh.create_date',
		     autowidth : true ,
		     sortorder: "desc",
		     shrinkToFit: false
		}
}

mbrSemiVipHistList = $("#mbrSemiVipHiatListGrid").ifvGrid({ jqGridOption : gMbrSemiVipHistList.jqGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>