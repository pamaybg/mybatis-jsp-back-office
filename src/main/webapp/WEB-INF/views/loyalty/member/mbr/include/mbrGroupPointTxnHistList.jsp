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
    <div id="mbrGroupPointTxnHistListGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">
//mbrGroupPointTxnHistList

gMbrGroupPointTxnHistList = {
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = $.ifvGetParam('rid');
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     	var data = mbrBlackList.getRowData()[rowNo-1];
		     	console.log(data);
		     },
		     loadComplete : function(result){

		     },
		     url : '<ifvm:action name="getMbrGroupPointTxnHistList"/>',
		     colNames:[
		               '<spring:message code="L01512"/>',
		               '<spring:message code="L01513"/>',
		               '<spring:message code="L01514"/>',
		               '<spring:message code="L01515"/>',
		               '<spring:message code="L01516"/>',
		               '<spring:message code="L01517"/>',
		               '<spring:message code="L01518"/>',
		               '<spring:message code="L01519"/>',
		               '<spring:message code="L01520"/>',
		               '<spring:message code="L01521"/>',
		               '<spring:message code="L01522"/>',
		               'rid'
		             ],
		    colModel:[
		        { name:'txnNum', 	    index:'lpt.txn_num', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'txnDate', 	    index:'lpt.txn_date', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'pntTxnType1', 	index:'cc1.mark_name', 			width:'100px', 	align: 'center', 	resizable : true },
		        { name:'pntTxnType2', 	index:'cc2.mark_name', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'mbrNo', 		index:'lm.mbr_no', 				width:'100px', 	align: 'center', 	resizable : true },
		        { name:'custNm', 	    index:'lc.cust_nm', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'pntAmt', 	    index:'lpt.pnt_amt', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'prodUnitCost', 	index:'lpt.prod_unit_cost', 	width:'100px', 	align: 'center', 	resizable : true },
		        { name:'prodQty', 	    index:'lpt.prod_qty', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'txnAmt', 		index:'lpt.txn_amt', 			width:'100px', 	align: 'center', 	resizable : true },
		        { name:'groupPnt', 		index:'lpt.group_pnt', 			width:'100px', 	align: 'center', 	resizable : true },
		        { name:'ridMbr', 	   	index:'lpt.rid_mbr', 			hidden:true },
		    ],
		     sortname: 'lpt.create_date',
		     autowidth : true , sortorder: "desc"
		},
		init : function (){
			mbrGroupPointTxnHistList = $("#mbrGroupPointTxnHistListGrid").ifvGrid({ jqGridOption : gMbrGroupPointTxnHistList.jqGridOption });
		},

}
gMbrGroupPointTxnHistList.init();


</script>






