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
<div id="mbrStmpBnftHistGrid" class="white_bg grid_bd0"></div>

<script type="text/javascript">
var ridStmpMbr = '<%=cleanXss(request.getParameter("ridStmpMbr"))%>';
ridStmpMbr = ridStmpMbr === 'null' ? null : ridStmpMbr;

mbrStmpBnftHist = {
	ejGridOption : {
       	serializeGridData : function(data) {
       	 	data.ridStmpMbr = ridStmpMbr;
         	return data;
       	},
        dataUrl : '<ifvm:action name="getMbrStmpBnftHistList"/>',
        columns:[
        		{
         		  field : 'camNo', headerText : '캠페인번호', headerTextAlign : 'center', textAlign : 'left', width : '100px',
         		  customAttributes : {
         			  index : 'lsmb.CAM_NO' }
         	  },{
         		  field : 'camNm', headerText : '오퍼명', headerTextAlign : 'center', textAlign : 'left', width : '200px',
         		  customAttributes : {
         			  index : 'mcm.CAM_NM' }
         	  },{
         		  field : 'offerTypeCdNm', headerText : '오퍼유형', headerTextAlign : 'center', textAlign : 'center', width : '70px',
         		  customAttributes : {
         			  index : 'c1.MARK_NAME' }
         	  },{
         		  field : 'offerSubTypeCdNm', headerText : '오퍼상세유형', headerTextAlign : 'center', textAlign : 'center', width : '70px',
         		  customAttributes : {
         			  index : 'c2.MARK_NAME' }
         	  },{
         		  field : 'stmpItemNo', headerText : '스탬프번호', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '100px',
         		  customAttributes : {
         			  index : 'lsmb.STMP_ITEM_NO' }
         	  },{
         		  field : 'recpDt', headerText : '지급일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
         		  customAttributes : {
         			  index : 'lci.RECP_DT' }
         	  },{
         		  field : 'stmpBnftAmt', headerText : '금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
         		  customAttributes : {
         			  index : 'mom.SELF_TOT_AMT' }
         	  },{
         		  field : 'useDt', headerText : '수령일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
         		  customAttributes : {
         			  index : 'lci.USE_DT' }
         	  },
         ],
         requestGridData : {
        	 nd   : new Date().getTime(),
        	 rows : 10,
        	 sidx : 'lsmb.modify_date',
        	 sord : 'desc',
        	 _search : false
		},
    }
}
mbrStmpBnftHist = $("#mbrStmpBnftHistGrid").ifvsfGrid({ ejGridOption : mbrStmpBnftHist.ejGridOption });
	
$(document).ready(function(){
	window.top.setParentIframeHeight();
});

</script>