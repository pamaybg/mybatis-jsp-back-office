<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
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
<script>
var channelUnsentPopGrid; 
var tgt_dtl_id = '<%= cleanXss(request.getParameter("tgt_dtl_id")) %>';

function channelUnsentPopGrid(){
	var jqGridOption = {
		serializeGridData : function( data ){
			data.tgt_dtl_id = tgt_dtl_id;
			return data;
		},
	    url:'<ifvm:action name="getCampaignNotSendPopList"/>',
	    colNames:['<spring:message code="M01360"/>',
	              '<spring:message code="M01365"/>', 
	              '<spring:message code="M01366"/>', 
	              '<spring:message code="M01367"/>',
	              '<spring:message code="M01368"/>',
	              '<spring:message code="M01369"/>',
	              '<spring:message code="M01370"/>',
	              '<spring:message code="M01371"/>',
	              '<spring:message code="M01372"/>'
	              ],
	    colModel:[
	        {name:'mem_id',index:'a.MEM_ID', resizable : false},
			{name:'fati_chk_del_yn',index:'a.FATI_CHK_DEL_YN', resizable : false},
			{name:'info_util_yn',index:'a.INFO_UTIL_YN', resizable : false},
			{name:'mkt_util_yn',index:'a.MKT_UTIL_YN', resizable : false},
			{name:'sms_consent_yn',index:'a.SMS_CONSENT_YN', resizable : false},
			{name:'email_consent_yn',index:'a.EMAIL_CONSENT_YN', resizable : false},
			{name:'hp_yn',index:'a.HP_YN', resizable : false},
			{name:'email_yn',index:'a.EMAIL_YN', resizable : false},
			{name:'dup_del_yn',index:'a.DUP_DEL_YN', resizable : false}
	    ],
	    sortname: 'dup_del_yn',
		sortorder: "desc",
		tempId : 'ifvGridSingleTemplete'
	};
	channelUnsentPopGrid = $("#channelUnsentPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	channelUnsentPopGrid();
	
  	//닫기
    $('#channelUnsentPopClose').on('click', function(){
    	channelUnsentPopClose();
    });
});
</script>

<div id="errorHistoryPopWrap">
	<div class="pop_inner_wrap">
		<div id=channelUnsentPopGrid class="pop900_grid double_header_grid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_lightGray2" id="channelUnsentPopClose">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>