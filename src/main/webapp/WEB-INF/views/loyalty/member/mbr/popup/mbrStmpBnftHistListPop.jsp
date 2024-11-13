<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div id="mbrStmpBnftHistListGrid" class="white_bg grid_bd0"></div>
<%!
public String cleanXss(String str){ 
	
	if(str != null){
		str = str.replaceAll("<","&lt;"); 
		str = str.replaceAll(">","&gt;"); 
	}
	return str; 
}
%>
<script type="text/javascript">

var ridStmpMbr = '<%=cleanXss(request.getParameter("ridStmpMbr"))%>';
ridStmpMbr = ridStmpMbr === 'null' ? null : ridStmpMbr;

mbrStmpBnftHistList = {
	ejGridOption : {
       	serializeGridData : function(data) {
       	 	data.ridStmpMbr = ridStmpMbr;
         	return data;
       	},
        dataUrl : '<ifvm:action name="getMbrStmpHistList"/>',
        columns:[
        		{
         		  field : 'stmpNo', headerText : '스탬프번호', headerTextAlign : 'center', textAlign : 'left', width : '100px',
         		  customAttributes : {
         			  index : 'stmpNo' }
         	  },{
         		  field : 'stmpNm', headerText : '스탬프명', headerTextAlign : 'center', textAlign : 'left', width : '300px',
         		  customAttributes : {
         			  index : 'stmpNm' }
         	  },{
         		  field : 'regDt', headerText : '참여일시', headerTextAlign : 'center', textAlign : 'center', width : '100px',
         		  customAttributes : {
         			  index : 'regDt' }
         	  },{
         		  field : 'stmpItemNo', headerText : '스탬프수', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
         		  customAttributes : {
         			  index : 'stmpItemNo' }
         	  },{
         		  field : 'stmpBnftAmt', headerText : '혜택금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
         		  customAttributes : {
         			  index : 'stmpBnftAmt' }
         	  },{
         		  field : 'stmpMbrStatus', headerText : '상태', headerTextAlign : 'center', textAlign : 'center', width : '70px',
         		  customAttributes : {
         			  index : 'stmpMbrStatus' }
         	  },{
         		  field : 'purAmt', headerText : '누적금액', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
         		  customAttributes : {
         			  index : 'purAmt' }
         	  },{
         		  field : 'purCnt', headerText : '구매횟수', headerTextAlign : 'center', textAlign : 'right', format : '{0:n0}', width : '70px',
         		  customAttributes : {
         			  index : 'purCnt' }
         	  },{
         		  field : 'ridStmp', headerText : 'ridStmp', headerTextAlign : 'center', textAlign : 'center', visible: false,
         		  customAttributes : {
         			  index : 'ridStmp' }
         	  },{
         		  field : 'ridStmpMbr', headerText : 'ridStmpMbr', headerTextAlign : 'center', textAlign : 'center', visible: false,
         		  customAttributes : {
         			  index : 'ridStmpMbr' }
         	  },{
         		  field : 'ridStmpBnft', headerText : 'ridStmpBnft', headerTextAlign : 'center', textAlign : 'center', visible: false,
         		  customAttributes : {
         			  index : 'ridStmpBnft' }
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
mbrStmpBnftHistList = $("#mbrStmpBnftHistListGrid").ifvsfGrid({ ejGridOption : mbrStmpBnftHistList.ejGridOption });

$(document).ready(function(){
	window.top.setParentIframeHeight();
});

</script>