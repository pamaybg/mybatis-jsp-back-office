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

    <div id="mbrClubListGrid" class="white_bg grid_bd0"></div>
</div>
<script>
gMbrClub  = {
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = gChargeListGrid.getRowData()[rowNo-1];
		     },
		     loadComplete : function(result){

		     	window.top.setParentIframeHeight();
		     },
		     url : '<ifvm:action name="getMbrClubList"/>',
		     colNames:[
		               '<spring:message code="L01119"/>',
		               '<spring:message code="L01120"/>',
		               '<spring:message code="L01121"/>',
		               '<spring:message code="L01122"/>',
		             ],
		    colModel:[
		        { name:'chnlNm', 	    index:'lc.chnl_nm', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'activeFlg', 	index:'lcm.active_flg', 	width:'100px', 	align: 'center', 	resizable : true },
		        { name:'regDt', 	    index:'lcm.reg_dt', 		width:'100px', 	align: 'center', 	resizable : true,  formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"}},
		        { name:'delDt', 		index:'lcm.del_dt', 		width:'80px', 	align: 'center', 	resizable : true,  formatter:'date', formatoptions:{newformat:"Y-m-d H:i:s"} },

		    ],
		     sortname: 'lcm.modify_date',
		     autowidth : true ,

		     sortorder: "desc"
		}
}
mbrClubList = $("#mbrClubListGrid").ifvGrid({ jqGridOption : gMbrClub.jqGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>