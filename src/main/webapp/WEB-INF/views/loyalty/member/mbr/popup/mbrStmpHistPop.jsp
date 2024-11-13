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
<div id="mbrStmpHistDetailGrid" class="white_bg grid_bd0"></div>

<script type="text/javascript">

var ridStmpMbr = '<%=cleanXss(request.getParameter("ridStmpMbr"))%>';
ridStmpMbr = ridStmpMbr === 'null' ? null : ridStmpMbr;

mbrStmpHistDetail = {
	ejGridOption : {
       	serializeGridData : function(data) {
       	 	data.ridStmpMbr = ridStmpMbr;
         	return data;
       	},
        dataUrl : '<ifvm:action name="getMbrStmpHistListDetail"/>',
        columns:[
        		{
         		  field : 'stmpMbrHistStatus', headerText : '구분', headerTextAlign : 'center', textAlign : 'center', width : '70px',
         		  customAttributes : {
         			  index : 'stmpMbrHistStatus' }
         	  },{
         		  field : 'stmpTxnNo', headerText : '스탬프거래번호', headerTextAlign : 'center', textAlign : 'left', width : '150px',
         		  customAttributes : {
         			  index : 'stmpTxnNo' }
         	  },{
         		  field : 'stmpItemNo', headerText : '아이템', headerTextAlign : 'center', textAlign : 'right', width : '70px',
         		  customAttributes : {
         			  index : 'stmpItemNo' }
         	  },{
         		  field : 'regDt', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
         		  customAttributes : {
         			  index : 'regDt' }
         	  },
         ],
         requestGridData : {
        	 nd   : new Date().getTime(),
        	 rows : 10,
        	 sidx : 'regDt',
        	 sord : 'desc',
        	 _search : false
		},
    }
}
mbrStmpHistDetail = $("#mbrStmpHistDetailGrid").ifvsfGrid({ ejGridOption : mbrStmpHistDetail.ejGridOption });
	
$(document).ready(function(){
	window.top.setParentIframeHeight();
});

</script>