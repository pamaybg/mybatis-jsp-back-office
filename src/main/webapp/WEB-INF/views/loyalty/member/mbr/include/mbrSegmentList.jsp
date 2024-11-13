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

    <div id="mbrSegmentListGrid" class="white_bg grid_bd0"></div>
</div>
<script>
gMbrSegment  = {
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.mbrNo = gMbrDetail.data.mbrNo;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = gChargeListGrid.getRowData()[rowNo-1];
		     },
		     loadComplete : function(result){

		     	window.top.setParentIframeHeight();
		     },
		     url : '<ifvm:action name="getMbrSegHistList"/>',
		     colNames:[
		               '<spring:message code="L01061"/>',
		               '<spring:message code="L01108"/>'

		             ],
		    colModel:[
		        { name:'yyyymm', 	    index:'yyyymm', 	width:'80px', 	align: 'center', 	resizable : true },
		        { name:'memsegclassnm', index:'memsegclassnm', 	width:'100px', 	align: 'center', 	resizable : true }

		    ],
		     sortname: 'yyyymm',
		     autowidth : true ,

		     sortorder: "desc"
		}
}
mbrSegmentList = $("#mbrSegmentListGrid").ifvGrid({ jqGridOption : gMbrSegment.jqGridOption });
function onlyDate(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.split(' ')[0];
	}
	else{
		return "";
	}
}
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>