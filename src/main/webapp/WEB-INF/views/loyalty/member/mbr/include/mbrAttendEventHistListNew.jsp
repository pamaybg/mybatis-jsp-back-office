<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div id="mbrAttendEventHistoryListGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">

var mbrAttendEventHistoryList;

var mbrAttendEventHistoryObj = {
	//출석 이벤트 그리드
	initMbrAttendEventHistoryList : function(data) {
		var ejGridOption = {
	       	serializeGridData : function(data) {
	       		data.ridMbr = mbr_rid;
	       		return data;
	       	},
	        dataUrl : '<ifvm:action name="getMbrAttendEventHistoryList"/>',
	        columns:[
	        		{
	         		  field : 'pstDt', headerText : '<spring:message code="L02436"/>', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'lpme.PST_DT' }//일자
	         	  },{
	         		  field : 'modifyDate', headerText : '<spring:message code="L02524"/>', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'lpme.MODIFY_DATE' }//이벤트 일시
	         	  },{
	         		  field : 'pntAmt', headerText : '<spring:message code="L00592"/>', headerTextAlign : 'center',textAlign: 'right', format : '{0:n0}',
	         		  customAttributes : {
	         			  index : 'lpme.PNT_AMT' }//적립포인트
	         	  },{
	         		  field : 'txnUniqNo', headerText : '<spring:message code="L00933"/>', headerTextAlign : 'center', textAlign : 'center',
	         		  customAttributes : {
	         			  index : 'lpme.TXN_UNIQ_NO' }//거래번호
	         	  }
	         ],
	         requestGridData : {
	        	 nd   : new Date().getTime(),
	        	 rows : 10,
	        	 sidx : 'lpme.MODIFY_DATE',
	        	 sord : 'desc',
	        	 _search : false
			},
			rowList : [10,25,50,100],
			tempId : 'ifvGridNotSearchTemplete'
	    };

		mbrAttendEventHistoryList = $("#mbrAttendEventHistoryListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
	}
}

$(document).ready(function(){
	mbrAttendEventHistoryObj.initMbrAttendEventHistoryList();
});

</script>