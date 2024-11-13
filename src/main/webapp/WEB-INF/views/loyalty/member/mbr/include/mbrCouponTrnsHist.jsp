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

    <div id="mbrTierHistListGrid" class="white_bg grid_bd0"></div>
</div>
<script>
gMbrTierHist  = {
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
		     url : '<ifvm:action name="getMbrCouponTrnsList"/>',
		     colNames:[
		               '<spring:message code="L02115"/>',
		               '<spring:message code="L02116"/>',
		               '<spring:message code="L02117"/>',
		               '<spring:message code="L02118"/>',
		               '<spring:message code="L02119"/>',
		               '<spring:message code="L02120"/>',
		               '<spring:message code="L02121"/>',
		               '<spring:message code="L02122"/>',

		             ],
		    colModel:[
		        { name:'camNm', 	    index:'t1.CAM_NM', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'coupnNm', 		index:'t3.COUPN_NM', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'coupnUseGdnc1', index:'t3.COUPN_USE_GDNC1', width:'100px', 	align: 'center', 	resizable : true},
		        { name:'useStartDt', 	index:'t3.USE_START_DT', 	width:'80px', 	align: 'center', 	resizable : true, formatter : 'date',	formatoptions:{newformat:"Y-m-d"} },
		        { name:'useEndDt', 		index:'t3.USE_END_DT', 		width:'80px', 	align: 'center', 	resizable : true, formatter : 'date',	formatoptions:{newformat:"Y-m-d"} },
		        { name:'coupnNo', 		index:'t4.coupn_no', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'useYn', 		index:'t4.USE_YN', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'useDt', 		index:'t4.USE_DT', 			width:'80px', 	align: 'center', 	resizable : true, formatter : 'date',	formatoptions:{newformat:"Y-m-d"} }

		    ],
		     sortname: 't4.recp_dt',
		     autowidth : true ,

		     sortorder: "desc"
		}
}
mbrTierHist = $("#mbrTierHistListGrid").ifvGrid({ jqGridOption : gMbrTierHist.jqGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>