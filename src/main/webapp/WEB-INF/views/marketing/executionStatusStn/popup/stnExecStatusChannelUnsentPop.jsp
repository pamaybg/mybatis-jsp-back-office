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
<script>

var execStatusChannelUnSendGrid; 
var tgtDtlId = '<%= cleanXss(request.getParameter("tgtDtlId")) %>';

/**
 * 캠페인 채널 미전송 사유 목록
 */
function getExecStatusChannelUnSendGrid() {
	var jqGridOption = {
		serializeGridData: function(data) {
			data.tgtDtlId = tgtDtlId;
			return data;
		},
	    url: '<ifvm:action name="getStnExecutionStatusNotSendList"/>',
	    colNames: [
             '<spring:message code="M01360"/>',
             '<spring:message code="M01365"/>', 
             '<spring:message code="M01366"/>', 
             '<spring:message code="M01367"/>',
             '<spring:message code="M01368"/>',
             '<spring:message code="M01369"/>',
             '<spring:message code="M01370"/>',
             '<spring:message code="M01371"/>',
             '<spring:message code="M01372"/>',
		],
	    colModel: [
	        {name:'memId', 		 	index:'t1.mem_id', 			 resizable: false, align: 'center'},
			{name:'fatiChkDelYn', 	index:'t1.fati_chk_del_yn',  resizable: false, align: 'center'},
			{name:'infoUtilYn',	 	index:'t1.info_util_yn', 	 resizable: false, align: 'center'},
			{name:'mktUtilYn',	 	index:'t1.mkt_util_yn', 	 resizable: false, align: 'center'},
			{name:'smsConsentYn',	index:'t1.sms_consent_yn', 	 resizable: false, align: 'center'},
			{name:'emailConsentYn',	index:'t1.email_consent_yn', resizable: false, align: 'center'},
			{name:'hpYn',			index:'t1.hp_yn', 			 resizable: false, align: 'center'},
			{name:'emailYn',	   	index:'t1.email_yn', 		 resizable: false, align: 'center'},
			{name:'dupDelYn',		index:'t1.dup_del_yn', 		 resizable: false, align: 'center'},
	    ],
	    sortname: 't1.dup_del_yn',
		sortorder: "desc",
		radio: false,
		tempId : 'ifvGridOriginTemplete',
	};
	
	execStatusChannelUnSendGrid = $("#execStatusChannelUnSendGrid").ifvGrid({
	    jqGridOption : jqGridOption
	});
}

$(document).ready(function() {
    getExecStatusChannelUnSendGrid();
	
  	//닫기
    $('#channelUnsentPopCloseBtn').on('click', function() {
    	channelUnsentPopClose();
    });
});
</script>

<div id="errorHistoryPopWrap">
	<div class="pop_inner_wrap">
		<div id="execStatusChannelUnSendGrid" class="pop900_grid double_header_grid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_lightGray2" id="channelUnsentPopCloseBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>