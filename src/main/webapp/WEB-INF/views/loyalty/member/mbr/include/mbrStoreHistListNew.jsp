<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-5">
        </div>
        <div class="col-xs-7 searchbtn_r">
        </div>
    </div>
    <div id="mbrStoreHistListGrid" class="white_bg grid_bd0"></div>
</div>
 
<div id="pointCouponPop" class="popup_container"></div>

<script type="text/javascript">

var mbrStoreHistList;

var mbrStoreHistObj = { 
		initmbrStoreHistList : function(data) {
		var ejGridOption = {
		    serializeGridData : function(data) {
	       		data.rid = mbr_rid;
	       	},
			loadComplete : function(obj){
	       		window.top.setParentIframeHeight();
			}, 
	        dataUrl : '<ifvm:action name="getmbrStoreHistList"/>',
	        columns:[
	        	  {
	         		  field : 'txnDt', headerText : '<spring:message code="L00604" />', headerTextAlign : 'center', textAlign : 'center', 
	         		  customAttributes : {
	         			  index : 'lst.txn_dt' }/* 거래일시 */
	         	  },{
	         		  field : 'storeType', headerText : '<spring:message code="L02460" />', headerTextAlign : 'center', textAlign : 'center', 
	         		  customAttributes : {
	         			  index : 'ls.store_type' }/* 유형 */
	         	  },{
	         		  field : 'storeEvtNm', headerText : '<spring:message code="L02547" />', headerTextAlign : 'center', textAlign : 'center', 
	         		  customAttributes : {
	         			  index : 'ls.store_evt_nm' }/* glo shop 명 */
	         	  },{
	         		  field : 'pntAmt', headerText : '<spring:message code="L02528" />', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}',
	         		  customAttributes : {
	         			  index : 'lst.pnt_amt' }/* 포인트 금액 */
	         	  },{
	         		  field : 'txnPntType', headerText : '<spring:message code="L02529" />', headerTextAlign : 'center', textAlign : 'center', 
	         		  customAttributes : {
	         			  index : 'lst.txn_pnt_type' }/* 거래포인트 유형 */
	         	  },{
	         		  field : 'txnStatus', headerText : '<spring:message code="L00351" />', headerTextAlign : 'center', textAlign : 'center', 
	         		  customAttributes : {
	         			  index : 'lst.txn_status' }/* 거래상태 */
	         	  },{
	         		  field : 'storeRid', textAlign : 'center', visible : false,
	         		  customAttributes : {
	         			  index : 'lst.rid_mbr' }/* rid_mbr */
	         	  },
	        	  
	         ],
	         requestGridData : {
	        	 nd   : new Date().getTime(),
	        	 rows : 10,
	        	 sidx : 'lst.txn_dt',
	        	 sord : 'desc',
	        	 _search : false
			},
			rowList : [10,25,50,100],
			tempId : 'ifvGridNotSearchTemplete'
	    };

		mbrStoreHistList = $("#mbrStoreHistListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	}
}

$(document).ready(function(){
	mbrStoreHistObj.initmbrStoreHistList(); 
});
</script>