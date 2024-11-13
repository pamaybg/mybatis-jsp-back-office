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
<div id="mbrStmpTxnHistListGrid" class="white_bg grid_bd0"></div>

<script type="text/javascript">

var ridStmp = '<%=cleanXss(request.getParameter("ridStmp"))%>';
ridStmp = ridStmp === 'null' ? null : ridStmp;

mbrStmpTxnHistList = {
	ejGridOption : {
       	serializeGridData : function(data) {
       	 	data.ridStmp = ridStmp;
       	 data.ridMbr = gMbrDetail.data.rid;
         	return data;
       	},
        dataUrl : '<ifvm:action name="getMbrStmpTxnList"/>',
        columns:[
        		{
         		  field : 'stmpTxnNo', headerText : '스탬프거래번호', headerTextAlign : 'center', textAlign : 'left', width : '120px',
         		  customAttributes : {
         			  index : 'lst.STMP_TXN_NO' }
         	  },{
         		  field : 'chnlNo', headerText : '채널번호', headerTextAlign : 'center', textAlign : 'left', width : '70px',
         		  customAttributes : {
         			  index : 'lc.CHNL_NO' }
         	  },{
         		  field : 'chnlNm', headerText : '채널명', headerTextAlign : 'center', textAlign : 'left', width : '100px',
         		  customAttributes : {
         			  index : 'lc.CHNL_NM' }
         	  },{
         		  field : 'purAmt', headerText : '거래금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
         		  customAttributes : {
         			  index : 'lst.PUR_AMT' }
         	  },{
         		  field : 'regDt', headerText : '거래일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
         		  customAttributes : {
         			  index : 'lst.REG_DT' }
         	  },{
         		  field : 'stmpTxnStatusNm', headerText : '거래유형', headerTextAlign : 'center', textAlign : 'center', width : '70px',
         		  customAttributes : {
         			  index : 'c1.MARK_NAME' }
         	  },{
         		  field : 'rcptNo', headerText : '영수증번호', headerTextAlign : 'center', textAlign : 'center', width : '100px',
         		  customAttributes : {
         			  index : 'lpt.RCPT_NO' }
         	  },{
         		  field : 'orgRcptNo', headerText : '원거래 영수증번호', headerTextAlign : 'center', textAlign : 'center', width : '100px',
         		  customAttributes : {
         			  index : 'lpt2.RCPT_NO' }
         	  },{
         		  field : 'apprDt', headerText : '승인일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
         		  customAttributes : {
         			  index : 'lpt.APPR_DT' }
         	  },{
         		  field : 'stmpItemNo', headerText : '스탬프번호', headerTextAlign : 'center', textAlign : 'right', width : '70px',
         		  customAttributes : {
         			  index : 'lsmh.STMP_ITEM_NO' }
         	  },
         ],
         requestGridData : {
        	 nd   : new Date().getTime(),
        	 rows : 10,
        	 sidx : 'lsmh.modify_date',
        	 sord : 'desc',
        	 _search : false
		},
    }
}
mbrStmpTxnHistList = $("#mbrStmpTxnHistListGrid").ifvsfGrid({ ejGridOption : mbrStmpTxnHistList.ejGridOption });
	
$(document).ready(function(){
	window.top.setParentIframeHeight();
});

</script>