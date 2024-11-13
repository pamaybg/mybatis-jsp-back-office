<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div>
    <div class="page_btn_area" >
        <div class="col-xs-7"></div>
    </div>
    <div id="mbrPntGiftHistListGrid" class="white_bg grid_bd0"></div>
</div>

<script type="text/javascript">

mbrPntGiftHistList = {
	ejGridOption : {
       	serializeGridData : function(data) {
       	 	data.ridMbr = gMbrDetail.data.rid;
         	return data;
       	},
        dataUrl : '<ifvm:action name="getMbrPntGiftHistList"/>',
        columns:[
        		{
         		  field : 'txnDt', headerText : '거래일시', headerTextAlign : 'center', textAlign : 'center',
         		  customAttributes : {
         			  index : 't1.txnDt' }
         	  },{
         		  field : 'custNm', headerText : '회원명', headerTextAlign : 'center', textAlign : 'center',
         		  customAttributes : {
         			  index : 't1.custNm' }
         	  },{
         		  field : 'mbrNo', headerText : '회원번호', headerTextAlign : 'center', textAlign : 'center',
         		  customAttributes : {
         			  index : 't1.mbrNo' }
         	  },{
         		  field : 'webId', headerText : 'Web Id', headerTextAlign : 'center', textAlign : 'center',
         		  customAttributes : {
         			  index : 't1.webId' }
         	  },{
         		  field : 'mbrStatCdNm', headerText : '회원상태', headerTextAlign : 'center', textAlign : 'center',
         		  customAttributes : {
         			  index : 't1.mbrStatCdNm' }
         	  },{
         		  field : 'pntTxnType1CdNm', headerText : '거래유형', headerTextAlign : 'center', textAlign : 'center',
         		  customAttributes : {
         			  index : 't1.pntTxnType1CdNm' }
         	  },{
         		  field : 'giftPnt', headerText : '포인트', headerTextAlign : 'center', textAlign : ej.TextAlign.Right, format : '{0:n0}',
         		  customAttributes : {
         			  index : 't1.giftPnt' }
         	  },
         ],
         requestGridData : {
        	 nd   : new Date().getTime(),
        	 rows : 10,
        	 sidx : 't1.txnDt',
        	 sord : 'desc',
        	 _search : false
		},
    }
}
mbrPntGiftHistList = $("#mbrPntGiftHistListGrid").ifvsfGrid({ ejGridOption : mbrPntGiftHistList.ejGridOption });
	
$(document).ready(function(){
	window.top.setParentIframeHeight();
});

</script>