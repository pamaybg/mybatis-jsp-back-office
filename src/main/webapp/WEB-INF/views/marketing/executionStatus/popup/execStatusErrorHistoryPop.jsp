<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var errorHistoryPopGrid;

function pushErrorHistoryPopList() {
	var jqGridOption = {
		loadComplete : function(obj) {
			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'errorHistoryPop',
				contentsId : 'errorHistoryPopWrap'
			});
			new ifvm.PopupCenter({
				popupDivId : 'errorHistoryPop'
			});
		},
		serializeGridData : function(data) {
			data.chnlId = chnlId;
			data.id = id;
			data.dataType = dataType;
			return data;
		},
	    url:'<ifvm:action name="getExecutionStatusErrorList"/>',
	    colNames:['<spring:message code="M02696"/>',
            	  '<spring:message code="V00298"/>',	    	
	              '<spring:message code="M01366"/>',
	              '<spring:message code="M01367"/>',
	              '<spring:message code="M01368"/>',
	              '<spring:message code="M02927"/>',
	              '<spring:message code="M01369"/>',
	              '<spring:message code="V00299"/>',
	              '<spring:message code="M01370"/>',
	              '<spring:message code="M03000"/>',
		],
	    colModel:[
	        {name:'mbrNo',		index:'T1.MBR_NO', 	    resizable : false,align:'center'},
	        {name:'deviceUuId',		index:'lcat.DEVICE_UUID', 	    resizable : false,align:'center'},
			{name:'infoUtilYn',   index:'T1.INFO_UTIL_YN',   resizable : false,align:'center'},
			{name:'mktUtilYn',   index:'T1.MKT_UTIL_YN',   resizable : false,align:'center'},
			{name:'smsConsentyn', 	index:'T1.SMS_CONSENT_YN', 	resizable : false, align:'center'},
			{name:'pushConsentyn',		    index:'T1.PUSH_CONSENT_YN', 		    resizable : false, align:'center'},
			{name:'emailConsentyn',		index:'T1.EMAIL_CONSENT_YN', 	    resizable : false,align:'center'},
			{name:'deviceAgreYn',		index:'lcat.DEVICE_AGRE_YN', 	    resizable : false,align:'center'},
			{name:'hpYn',			index:'T1.HP_YN', 	 	    resizable : false,align:'center'},
			{name:'emailYn',			index:'T1.EMAIL_YN', 	 	    resizable : false,align:'center'},
			],
	    sortname: 'T1.MBR_NO',
		sortorder: "desc",
		tempId : 'ifvGridSimpleTemplete2'
	};
	errorHistoryPopGrid = $("#errorHistoryPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	//$(".page").hide()
}

function errorHistoryPopList() {
	var jqGridOption = {
		loadComplete : function(obj) {
			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'errorHistoryPop',
				contentsId : 'errorHistoryPopWrap'
			});
			new ifvm.PopupCenter({
				popupDivId : 'errorHistoryPop'
			});
		},
		serializeGridData : function(data) {
			data.chnlId = chnlId;
			data.id = id;
			data.dataType = dataType;
			return data;
		},
	    url:'<ifvm:action name="getExecutionStatusErrorList"/>',
	    colNames:['<spring:message code="M02696"/>',
	              '<spring:message code="M01366"/>',
	              '<spring:message code="M01367"/>',
	              '<spring:message code="M01368"/>',
	              '<spring:message code="M02927"/>',
	              '<spring:message code="M01369"/>',
	              '<spring:message code="M01370"/>',
	              '<spring:message code="M03000"/>',
		],
	    colModel:[
	        {name:'mbrNo',		index:'T1.MBR_NO', 	    resizable : false,align:'center'},
			{name:'infoUtilYn',   index:'T1.INFO_UTIL_YN',   resizable : false,align:'center'},
			{name:'mktUtilYn',   index:'T1.MKT_UTIL_YN',   resizable : false,align:'center'},
			{name:'smsConsentyn', 	index:'T1.SMS_CONSENT_YN', 	resizable : false, align:'center'},
			{name:'pushConsentyn',		    index:'T1.PUSH_CONSENT_YN', 		    resizable : false, align:'center'},
			{name:'emailConsentyn',		index:'T1.EMAIL_CONSENT_YN', 	    resizable : false,align:'center'},
			{name:'hpYn',			index:'T1.HP_YN', 	 	    resizable : false,align:'center'},
			{name:'emailYn',			index:'T1.EMAIL_YN', 	 	    resizable : false,align:'center'},
			],
	    sortname: 'T1.MBR_NO',
		sortorder: "desc",
		tempId : 'ifvGridSimpleTemplete2'
	};
	errorHistoryPopGrid = $("#errorHistoryPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	//$(".page").hide()
}


$(document).ready(function(){
	if(dataType == 'PUSH'){
		pushErrorHistoryPopList();
	} else {
		errorHistoryPopList();
	}
	
  	//닫기
    $('#errorHistoryPopClose').on('click', function() {
    	campaignresultReasonPopupClose();
    });
});
</script>

<div id="errorHistoryPopWrap">
	<div class="pop_inner_wrap">
		<div id="errorHistoryPopGrid" class="pop900_grid double_row_grid"></div>
	</div>
	<div class="pop_btn_area" style="padding-top: 20px;">
	
	    <button class="btn btn-sm btn_lightGray2" id="errorHistoryPopClose" objcode="errorHistoryPopClose_OBJ">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>