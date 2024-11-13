<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
public String cleanXss(String str){ 
	
	if(str != null){
		str = str.replaceAll("<","&lt;"); 
		str = str.replaceAll(">","&gt;"); 
	}
	return str; 
}
%>

<div id="famOfferListGrid" class="white_bg grid_bd0"></div>

<script type="text/javascript">

var famOfferListGrid;
var ridMbr = '<%= cleanXss(request.getParameter("ridMbr")) %>';

$(document).ready(function() {
    getFamOfferListSearch();
});

/**
 */
function getFamOfferListSearch() {
    var ejGridOption = {
        serializeGridData : function(data) {
            data.ridMbr = ridMbr ;
            return data;
        },
        loadComplete : function(obj) {
        },
        dataUrl : '<ifvm:action name="getfamOfferList"/>',
        columns : [
	        // 
	        {
         		  field : 'bnftDate', headerText : '<spring:message code="M00958"/>', headerTextAlign : 'center',textAlign : 'center',
         		  customAttributes : {
         			  index : 'a.BNFT_DATE' }
         	  },{
           		  field : 'camNm', headerText : '<spring:message code="M02213"/>', headerTextAlign : 'center',textAlign : 'left',
           		  customAttributes : {
           			  index : 'b.CAM_NM' }
           	  },{
           		  field : 'acrlPnt', headerText : '프로모션 적립 포인트', headerTextAlign : 'center',textAlign : 'right',format : '{0:n0}',
           		  customAttributes : {
           			  index : 'a.ACRL_PNT'}
           	  },{
           		  field : 'txnSum', headerText : '누적 구매 금액', headerTextAlign : 'center',textAlign : 'right',format : '{0:n0}', 
           		  customAttributes : {
           			  index : 'a.TXN_SUM'}
           	  },{
           		  field : 'txnCnt', headerText : '누적 구매 금액 횟수', headerTextAlign : 'center',textAlign : 'right',format : '{0:n0}',
           		  customAttributes : {
           			  index : 't1.TXN_CNT'}
           	  },{
           		  field : 'ridFam', headerText : 'ridFam', headerTextAlign : '',visible: false,
           		  customAttributes : {
           			  index : 'a.RID_MBR'}
           	  },{
           		  field : 'txnYm', headerText : 'txnYm', headerTextAlign : '',visible: false,
           		  customAttributes : {
           			  index : 'a.TXN_YM'}
           	  }
        ],
        requestGridData : {
            nd : new Date().getTime(),
            rows : 10,
            sidx : 'a.BNFT_DATE',
            sord : 'desc',
            _search : false
        },
        rowList : [ 10, 25, 50, 100 ],
        radio : true
    };
    famOfferListGrid = $("#famOfferListGrid").ifvsfGrid({
        ejGridOption : ejGridOption
    });
}

</script>


