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
		     	console.log(data);
		     },
		     loadComplete : function(result){

		     	window.top.setParentIframeHeight();
		     },
		     url : '<ifvm:action name="getMbrInsurHistList"/>',
		     colNames:[
		               '<spring:message code="L01308"/>',
		               '<spring:message code="L01309"/>',
		               '<spring:message code="L01310"/>',
		               '<spring:message code="L01311"/>',
		               '<spring:message code="L01312"/>',
		               '<spring:message code="L01313"/>',
		               '<spring:message code="L01314"/>',
		               '<spring:message code="L01315"/>',
		               '<spring:message code="L01316"/>',
		               '<spring:message code="L01317"/>',
		               '<spring:message code="L01318"/>',
		               '<spring:message code="L01319"/>',
		               '<spring:message code="L01320"/>',
		               '<spring:message code="L01321"/>',
		               'rid'
		             ],
		    colModel:[
		        { name:'insuType', 	    	index:'lic.insu_type', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'policyNumas', 	    index:'lic.policy_num', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'eduMemberTypeCd', 	index:'lic.edu_member_type_cd', 	width:'120px', 	align: 'center', 	resizable : true },
		        { name:'startDt', 	    	index:'lic.start_dt', 				width:'80px', 	align: 'center', 	resizable : true , formatter : dateSeq},
		        { name:'endDt', 			index:'lic.end_dt', 				width:'80px', 	align: 'center', 	resizable : true , formatter : dateSeq},
		        { name:'cancelDt', 			index:'lic.cancel_dt', 				width:'80px', 	align: 'center', 	resizable : true , formatter : dateSeq},
		        { name:'conMbrNo', 	    	index:'lm1.mbr_no', 				width:'90px', 	align: 'center', 	resizable : true },
		        { name:'contractName', 		index:'lic.contract_name', 			width:'100px', 	align: 'center', 	resizable : true },
		        { name:'insMbrNo', 	    	index:'lm2.mbr_no', 				width:'100px', 	align: 'center', 	resizable : true },
		        { name:'insureName', 		index:'lic.insure_name', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'insureGetYn', 	    index:'lic.insure_get_yn', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'ligPromoMemSeq',	index:'lic.lig_promo_mem_seq', 		width:'100px', 	align: 'center', 	resizable : true },
		        { name:'comments1', 	    index:'lic.comments1', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'comments2', 		index:'lic.comments2', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'rid', 	   			index:'lic.rid', 					hidden:true },

		    ],
		     sortname: 'lic.modify_date',
		     autowidth : true ,

		     sortorder: "desc"
		}
}
mbrBlackList = $("#mbrBlackListGrid").ifvGrid({ jqGridOption : gMbrBlackList.jqGridOption });
function dateSeq(cellvalue, options, rowObject){
	if(cellvalue){
		return cellvalue.replace(/(\d{4})(\d{2})(\d{2})/, '$1-$2-$3');
	}
	else{
		return "";
	}
}
$(document).ready(function(){
	window.top.setParentIframeHeight();
});
</script>