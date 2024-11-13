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
		ejGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.mbrNo = gMbrDetail.data.mbrNo;
		    	 return data;
		     },
		     recordDoubleClick : function (args) {
		    	var data = args.data.rid;
// 		     	var data = gChargeListGrid.getRowData()[rowNo-1];
		     },
		     loadComplete : function(result){

		     	window.top.setParentIframeHeight();
		     },
		     dataUrl : '<ifvm:action name="getMbrCouponTrnsList"/>',
		     columns:[
		    	 {
		       		  field : 'camNm', headerText : '<spring:message code="L02115"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 't1.CAM_NM' }
		       	  },{
		       		  field : 'coupnNm', headerText : '<spring:message code="L02116"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 't3.COUPN_NM' }
		       	  },{
		       		  field : 'coupnUseGdnc1', headerText : '<spring:message code="L02117"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 't3.COUPN_USE_GDNC1' }
		       	  },{
		       		  field : 'useStartDt', headerText : '<spring:message code="L02118"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 't3.USE_START_DT' }
		       	  },{
		       		  field : 'useEndDt', headerText : '<spring:message code="L02119"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 't3.USE_END_DT' }
		       	  },{
		       		  field : 'coupnNo', headerText : '<spring:message code="L02120"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 't4.coupn_no' }
		       	  },{
		       		  field : 'useYn', headerText : '<spring:message code="L02121"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 't4.USE_YN' }
		       	  },{
		       		  field : 'useDt', headerText : '<spring:message code="L02122"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 't4.USE_DT' }
		       	  }
		    ],
		    requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 't4.recp_dt',
		      	  sord : 'desc',
		      	  _search : false
		        },
		        rowList : [10,25,50,100],
		        radio: true
		}
}
mbrTierHist = $("#mbrTierHistListGrid").ifvsfGrid({ ejGridOption : gMbrTierHist.ejGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>