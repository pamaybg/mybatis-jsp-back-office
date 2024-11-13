<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div>
    <div class="page_btn_area" >
        <div class="col-xs-7">
            <span><spring:message code="L01258" /></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
        	<ifvm:inputNew type="button" btnType="plus"	btnFunc="addMbrBlackListPopup.pop" text="L00027"    className="dropHidBtn"/>
        </div>
        <script>
	        addMbrBlackListPopup = {
	        		id  : "mbrBlackListPop",
	        		url : '<ifvm:url name="addBlackListPop"/>',
	        		pop : function(obj){
	        			this.url = '<ifvm:url name="addBlackListPop"/>';
	        			if(obj != null){
	        				this.url += '?rid='+obj.rid;
	        			}
	        			$("#"+this.id).ifvsfPopup({
	           	            enableModal : true,
	           	            enableResize : false,
	           	            contentUrl : this.url,
	           	            contentType : "ajax",
	           	            title : '<spring:message code="L01113"/>', // 부정이력,
	           	            width : '900px'
	           	        });
	        		},
	        		beforeClose : function(obj){
	        			if(obj != null){
	        				mbrBlackList.searchGrid();
	        			}

	        		},
	        		close : function(obj){
	        			if(obj){
	        				this.beforeClose(obj)
	        			}
	        			var _popObj = eval(this.id)
	        			_popObj._destroy();
	        		}
	        }
        </script>
    </div>

    <div id="mbrBlackListGrid" class="white_bg grid_bd0"></div>
</div>
<div id="mbrBlackListPop" class="popup_container"></div>
<script>
gMbrBlackList  = {
		checkedData : null,
		ejGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     recordDoubleClick : function (args) {
		    	 var data = args.data;
		    	 addMbrBlackListPopup.pop(data);
// 		     	var data = mbrBlackList.getRowData()[rowNo-1];
// 		     	console.log(data);
// 		     	gMbrBlackList.checkedData = data;
// 		     	addMbrBlackListPopup.pop(data);
		     },
		     loadComplete : function(result){

		     	if(typeof(gMbrDetail) != "undefined"){
	        		if(gMbrDetail.data.mbrStatCd == "20"){
	        			$(".dropHidBtn").prop("disabled",true);
	        		}
	        	}
		     	window.top.setParentIframeHeight();
		     },
		     
		     dataUrl : '<ifvm:action name="getMbrBlackList"/>',
		     columns : [
		     {
	       		  field : 'regStat', headerText : '<spring:message code="L01069"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'cc1.mark_name' }
	       	  },{
	       		  field : 'regStatCd', headerText : '<spring:message code="L01069"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.reg_stat_cd' }
	       	  },{
	       		  field : 'actnDivName', headerText : '<spring:message code="L01070"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'cc2.mark_name' }
	       	  },{
	       		  field : 'actnDiv', headerText : '<spring:message code="L01070"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.actn_div' }
	       	  },{
	       		  field : 'regDtlRsnMemo', headerText : '<spring:message code="L01071"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.reg_dtl_rsn_memo' }
	       	  },{
	       		  field : 'createDate', headerText : '<spring:message code="L01077"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.create_date' }
	       	  },{
	       		  field : 'createBy', headerText : '<spring:message code="L01078"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'em1.name' }
	       	  },{
	       		  field : 'ridChnl', headerText : '<spring:message code="L01072"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.rid_chnl' }
	       	  },{
	       		  field : 'cardNo', headerText : '<spring:message code="L01073"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.card_no' }
	       	  },{
	       		  field : 'totAcuPoint', headerText : '<spring:message code="L01074"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.tot_acu_point' }
	       	  },{
	       		  field : 'tgtMonth', headerText : '<spring:message code="L01075"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.tgt_month' }
	       	  },{
	       		  field : 'maxChargeExcsPoint', headerText : '<spring:message code="L01076"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.max_charge_excs_point' }
	       	  },{
	       		  field : 'bllstAdmr', headerText : '<spring:message code="L01123"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'em2.name' }
	       	  },{
	       		  field : 'applyStartDate', headerText : '<spring:message code="L01124"/>', headerTextAlign : 'center',
	       		  customAttributes : {
	       			  index : 'lbh.apply_start_date' }
	       	  },{
	       		  field : 'rid', headerText : 'rid',visible: false, 
	       		  customAttributes : {
	       			  index : 'lbh.rid' }
	       	  },{
	       		  field : 'ridMbr', headerText : 'ridMbr', visible: false, 
	       		  customAttributes : {
	       			  index : 'lm.rid' }
	       	  }
		    ],
		    requestGridData : {
		      	  nd   : new Date().getTime(),
		      	  rows : 10,
		      	  sidx : 'lbh.create_date',
		      	  sord : 'desc',
		      	  _search : false
		        },
		        rowList : [10,25,50,100],
		}
}
mbrBlackList = $("#mbrBlackListGrid").ifvsfGrid({ ejGridOption : gMbrBlackList.ejGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>