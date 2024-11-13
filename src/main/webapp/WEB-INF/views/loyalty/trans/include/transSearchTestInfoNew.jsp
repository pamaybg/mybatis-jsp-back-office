<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var testInfoList;
<%-- var defaultArchive =  '<%= request.getParameter("defaultArchive") %>'; --%>

//스탬프 거래리스트
function getTransSearchTestList(){
    var ejGridOption = {

       serializeGridData : function( data ){
    	   data.rid=testViewList_rid;
    	   return data;
        },
        dataUrl : '<ifvm:action name="getTransSearchTestList"/>',
        columns:[
        	 {
        		  field : 'acrlDate', headerText : '<spring:message code="Q02913"/>', headerTextAlign : 'center', textAlign: 'center',
        		  customAttributes : {
        			  index : 'acrl.ACRL_DATE' } //적립일
        	  },{
         		  field : 'apprNo', headerText : '<spring:message code="Q02914"/>', headerTextAlign : 'center', textAlign: 'center',
         		  customAttributes : {
         			  index : 'acrl_txn.appr_no' } //적립승인 번호
         	  }, {
          		  field : 'acrlAmt', headerText : '<spring:message code="Q02915"/>', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
          		  customAttributes : {
          			  index : 'acrl.ACRL_AMT' } //적립금액
          	  }, {
          		  field : 'rdmAmt', headerText : '<spring:message code="Q02916"/>', headerTextAlign : 'center', textAlign: 'right', format : '{0:n0}',
          		  customAttributes : {
          			  index : 'rdm.RDM_AMT' } //차감금액
          	  }, {
          		  field : 'offerNo', headerText : '<spring:message code="M00313"/>', headerTextAlign : 'center', textAlign: 'center',
          		  customAttributes : {
          			  index : 'acrl.OFFER_NO' } //오퍼번호
          	  }, {
          		  field : 'offeerNm', headerText : '<spring:message code="M00314"/>', headerTextAlign : 'center',
          		  customAttributes : {
          			  index : 'offer.OFFER_NM' } // 오퍼명
          	  }
     	],
     	requestGridData : {
      	  nd   : new Date().getTime(),
      	  rows : 10,
      	  sidx : 'rdm.rid',
      	  sord : 'desc',
      	  _search : false
        },
        rowList : [10,25,50,100],
    };

    testInfoList = $("#transtestInfoListGrid").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function() {
	getTransSearchTestList();
});

</script>

<div>
        <div class="col-xs-5 searchbtn_r">
        </div>
    <div id="transtestInfoListGrid" class="white_bg grid_bd0"></div>
</div>

<div id="stampTxnDetailDialog" class="popup_container"></div>
