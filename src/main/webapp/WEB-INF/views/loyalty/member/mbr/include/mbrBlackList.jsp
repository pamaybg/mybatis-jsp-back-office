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
	        				mbrBlackList.requestData();
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
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = gMbrDetail.data.rid;
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = mbrBlackList.getRowData()[rowNo-1];
		     	gMbrBlackList.checkedData = data;
		     	addMbrBlackListPopup.pop(data);
		     },
		     loadComplete : function(result){

		     	if(typeof(gMbrDetail) != "undefined"){
	        		if(gMbrDetail.data.mbrStatCd == "20"){
	        			$(".dropHidBtn").prop("disabled",true);
	        		}
	        	}
		     	window.top.setParentIframeHeight();
		     },
		     url : '<ifvm:action name="getMbrBlackList"/>',
		     colNames:[
		               '<spring:message code="L01069"/>',
		               '<spring:message code="L01069"/>',
		               '<spring:message code="L01070"/>',
		               '<spring:message code="L01070"/>',
		               '<spring:message code="L01071"/>',
		               '<spring:message code="L01077"/>',
		               '<spring:message code="L01078"/>',
		               '<spring:message code="L01072"/>',
		               '<spring:message code="L01073"/>',
		               '<spring:message code="L01074"/>',
		               '<spring:message code="L01075"/>',
		               '<spring:message code="L01076"/>',
		               '<spring:message code="L01123"/>',
		               '<spring:message code="L01124"/>',
		               'rid',
		               'ridMbr'
		             ],
		    colModel:[
		        { name:'regStat', 	    	index:'cc1.mark_name', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'regStatCd', 	    index:'lbh.reg_stat_cd', 			width:'80px', 	align: 'center', 	resizable : true, 	hidden:true },
		        { name:'actnDivName', 		index:'cc2.mark_name', 				width:'100px', 	align: 'center', 	resizable : true },
		        { name:'actnDiv', 	    	index:'lbh.actn_div', 				width:'80px', 	align: 'center', 	resizable : true, 	hidden:true },
		        { name:'regDtlRsnMemo', 	index:'lbh.reg_dtl_rsn_memo', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'createDate', 		index:'lbh.create_date', 			width:'80px', 	align: 'center', 	resizable : true ,  formatter:'date', formatoptions:{newformat:"Y-m-d"}},
		        { name:'createBy', 	    	index:'em1.name', 					width:'50px', 	align: 'center', 	resizable : true },
		        { name:'ridChnl', 			index:'lbh.rid_chnl', 				width:'100px', 	align: 'center', 	resizable : true },
		        { name:'cardNo', 	    	index:'lbh.card_no', 				width:'100px', 	align: 'center', 	resizable : true },
		        { name:'totAcuPoint', 		index:'lbh.tot_acu_point', 			width:'80px', 	align: 'right', 	resizable : true ,formatter:'integer'},
		        { name:'tgtMonth', 	    	index:'lbh.tgt_month', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'maxChargeExcsPoint',index:'lbh.max_charge_excs_point', 	width:'100px', 	align: 'right', 	resizable : true ,formatter:'integer'},
		        { name:'bllstAdmr', 	    index:'em2.name', 					width:'50px', 	align: 'center', 	resizable : true },
		        { name:'applyStartDate', 	index:'lbh.apply_start_date', 		width:'80px', 	align: 'center', 	resizable : true ,  formatter:'date', formatoptions:{newformat:"Y-m-d"}},
		        { name:'rid', 	   			index:'lbh.rid', 					hidden:true },
		        { name:'ridMbr', 	   		index:'lm.rid', 					hidden:true },

		    ],
		     sortname: 'lbh.create_date',
		     autowidth : true ,

		     sortorder: "desc"
		}
}
mbrBlackList = $("#mbrBlackListGrid").ifvGrid({ jqGridOption : gMbrBlackList.jqGridOption });
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>