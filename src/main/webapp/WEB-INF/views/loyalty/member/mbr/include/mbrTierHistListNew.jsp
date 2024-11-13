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
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     recordDoubleClick : function (args) {
		        	var data =args.data.rid ;
// 		     	var data = gChargeListGrid.getRowData()[rowNo-1];
		     },
		     loadComplete : function(result){

		     	window.top.setParentIframeHeight();
		     },
		     dataUrl : '<ifvm:action name="getEMbrTierHistList"/>',
		     columns:[
		    	 {
		       		  field : 'validStartDt', headerText : '<spring:message code="L01061"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'lth.valid_start_dt' }
		       	  }, {
		       		  field : 'befMemDiv', headerText : '<spring:message code="L01062"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'cc1.mark_name' }
		       	  }, {
		       		  field : 'curMemDiv', headerText : '<spring:message code="L01063"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'cc2.mark_name' }
		       	  }, {
		       		  field : 'ridBefTier', headerText : '<spring:message code="L01064"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'cc3.mark_name' }
		       	  }, {
		       		  field : 'ridCurTier', headerText : '<spring:message code="L01065"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'cc4.mark_name' }
		       	  }, {
		       		  field : 'curTierApplyCnt', headerText : '<spring:message code="L01066"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'lth.cur_tier_apply_bas_cnt' }
		       	  }, {
		       		  field : 'curTierApplyAmt', headerText : '<spring:message code="L01067"/>', headerTextAlign : 'center',
		       		  customAttributes : {
		       			  index : 'lth.cur_tier_apply_bas_amt' }
		       	  },

		     ],
		     
		     requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'lth.modify_date',
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