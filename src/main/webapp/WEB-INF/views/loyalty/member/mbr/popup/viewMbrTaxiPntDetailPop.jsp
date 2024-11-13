<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline" id="certiPhoneWrp" style="padding: 0;">
	<div id="viewMbrTaxiPtnPopGrid" class="white_bg grid_bd0"></div>
	<div class="pop_btn_area">
	    <ifvm:inputNew type="button" text="L00913" btnFunc="mbrTaxiPntDetailPopup.close" className="btn_lightGray2"/>
	</div>
</div>
<script>
gViewMbrTaxiPntPop = {
		jqGridOption : 	{
		     serializeGridData : function( data ){
		    	 data.rid = $.ifvGetParam('rid');
		    	 data.ridConfNcst = mbrTaxiPntHistList.getCheckedList()[0].confNcst
		    	 return data;
		     },
		     ondblClickRow : function (rowNo) {
		     },
		     loadComplete : function(result){

		     },
		     url : '<ifvm:action name="getMbrTaxiPntDetailList"/>',
		     colNames:[
		               '<spring:message code="L01349"/>',
		               '<spring:message code="L01350"/>',
		               '<spring:message code="L01351"/>',
		               '<spring:message code="L01352"/>',
		               '<spring:message code="L01353"/>',
		               '<spring:message code="L01354"/>',
		               '<spring:message code="L01355"/>',
		               '<spring:message code="L01356"/>',
		               '<spring:message code="L01357"/>',
		               '<spring:message code="L01358"/>',
		               '<spring:message code="L01359"/>',
		               '<spring:message code="L01360"/>',
		               '<spring:message code="L01361"/>',
		               '<spring:message code="L01362"/>',
		               '<spring:message code="L00995"/>',
		               '<spring:message code="L01029"/>',
		               'rid'
		             ],
		    colModel:[
		        { name:'calcuMonthGroup', 	index:'tdp.calcu_month_group', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'calcuDtGroup', 	    index:'tdp.calcu_dt_group', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'chnlNo', 			index:'lc.chnl_no', 				width:'100px', 	align: 'center', 	resizable : true },
		        { name:'mbrbsCdadd', 	    index:'lc.mbrbs_cdadd', 			width:'80px', 	align: 'center', 	resizable : true },
		        { name:'taxiConvPoint', 	index:'tdp.taxi_conv_point', 		width:'100px', 	align: 'center', 	resizable : true , formatter:'integer'},
		        { name:'stnPartakePoint', 	index:'tdp.stn_partake_point', 		width:'80px', 	align: 'center', 	resizable : true , formatter:'integer'},
		        { name:'apdPoint', 	    	index:'tdp.apd_point', 				width:'80px', 	align: 'center', 	resizable : true , formatter:'integer'},
		        { name:'realChargAmt', 		index:'tdp.real_charg_amt', 		width:'100px', 	align: 'center', 	resizable : true , formatter:'integer'},
		        { name:'chargAmt', 	    	index:'tdp.charg_amt', 				width:'100px', 	align: 'center', 	resizable : true , formatter:'integer'},
		        { name:'totalCalcuAmt', 	index:'tdp.total_calcu_amt', 		width:'80px', 	align: 'center', 	resizable : true , formatter:'integer'},
		        { name:'prvdCalcuAmt', 	    index:'tdp.prvd_calcu_amt', 		width:'80px', 	align: 'center', 	resizable : true , formatter:'integer'},
		        { name:'stblCalcuAmt', 	    index:'tdp.stbl_calcu_amt', 		width:'80px', 	align: 'center', 	resizable : true , formatter:'integer'},
		        { name:'pntTxnType2Cd', 	index:'lpt.pnt_txn_type_2_cd', 		width:'80px', 	align: 'center', 	resizable : true },
		        { name:'apprDt', 	    	index:'lpt.appr_dt', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'apprNo', 			index:'lpt.appr_no', 				width:'80px', 	align: 'center', 	resizable : true },
		        { name:'pntAmt', 	    	index:'lpt.pntAmt', 				width:'80px', 	align: 'center', 	resizable : true , formatter:'integer'},
		        { name:'rid', 	   			index:'tdp.rid', 					hidden:true },

		    ],
		     sortname: 'tdp.RID_TAXI_CONV',
		     width : "990px",
		     autowidth : true ,
		     
		     sortorder: "desc"
		}
}
//mbrTaxiPntPopList = $("#viewMbrTaxiPtnPopGrid").ifvGrid({ jqGridOption : gViewMbrTaxiPntPop.jqGridOption });
</script>