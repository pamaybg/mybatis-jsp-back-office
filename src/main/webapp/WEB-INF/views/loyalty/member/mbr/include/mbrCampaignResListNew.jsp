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

    <div id="mbrCampaignResListGrid" class="white_bg grid_bd0"></div>
</div>
<script>
gMbrCampaignRes  = {
		ejGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = mbr_rid;
		    	 return data;
		     },
// 		     recordDoubleClick : function (args) {
// 		     	/* var data = gChargeListGrid.getRowData()[rowNo-1]; */
// 		     },
		     loadComplete : function(result){
//
		     	window.top.setParentIframeHeight();
		     },
		     dataUrl : '<ifvm:action name="getMbrCampaignResList"/>',
		     columns : [
		    	 {
		    		  field : 'camNm', headerText : '<spring:message code="L01093"/>', headerTextAlign : 'center',
		    		  customAttributes : {
		    			  index : 'b.CAM_NM' }
		    	  },{
		    		  field : 'camType', headerText : '<spring:message code="L01094"/>', headerTextAlign : 'center',
		    		  customAttributes : {
		    			  index : 'b.OLD_CAM_SUB_TYPE_CD' }
		    	  },{
		    		  field : 'startDt', headerText : '<spring:message code="L01096"/>', headerTextAlign : 'center', format : "{0:MM/dd/yyyy}",  enableGroupByFormat: true ,
		    		  customAttributes : {
		    			  index : 'b.CAM_START_DD' }
		    	  },{
		    		  field : 'endDt', headerText : '<spring:message code="L01097"/>', headerTextAlign : 'center', format : "{0:MM/dd/yyyy}",  enableGroupByFormat: true ,
		    		  customAttributes : {
		    			  index : 'b.CAM_END_DD' }
		    	  },{
		    		  field : 'chnlType', headerText : '<spring:message code="L01098"/>', headerTextAlign : 'center',
		    		  customAttributes : {
		    			  index : 'a.RESP_TYPE_CD_NM' }
		    	  },{
		    		  field : 'recStatus', headerText : '<spring:message code="L01099"/>', headerTextAlign : 'center',
		    		  customAttributes : {
		    			  index : 'a.COMM_METHOD_NM' }
		    	  },{
		    		  field : 'emailOpenYn', headerText : '<spring:message code="L01100"/>', headerTextAlign : 'center',
		    		  customAttributes : {
		    			  index : 'a.OFCR_DIR_FLG' }
		    	  },{
		    		  field : 'respDt', headerText : '<spring:message code="L01101"/>', headerTextAlign : 'center', format : "{0:MM/dd/yyyy}",  enableGroupByFormat: true ,
		    		  customAttributes : {
		    			  index : 'a.ASGN_DT' }
		    	  },{
		    		  field : 'failDesc', headerText : '<spring:message code="L01102"/>', headerTextAlign : 'center',
		    		  customAttributes : {
		    			  index : 'a.DESC_TEXT' }
		    	  }	
		    ],
		    requestGridData : {
		    	  nd   : new Date().getTime(),
		    	  rows : 10,
		    	  sidx : 'b.modify_date',
		    	  sord : 'desc',
		    	  _search : false
		      },
		      rowList : [10,25,50,100]
		}
}
mbrCampaignRes = $("#mbrCampaignResListGrid").ifvsfGrid({ ejGridOption : gMbrCampaignRes.ejGridOption });

$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>