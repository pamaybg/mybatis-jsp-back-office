<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var rtCampErrorHistGrid;

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
			data.camId = camId;
			return data;
		},
	    url:'<ifvm:action name="getRTCampErrorHist"/>',
	    colNames:['<spring:message code="M01347"/>',
	              '<spring:message code="M01348"/>',
	              '<spring:message code="M01349"/>',
	              '<spring:message code="M01350"/>',
	              '<spring:message code="M01659"/>',
	              '<spring:message code="M01351"/>',
	              '<spring:message code="M01352"/>',
	              '<spring:message code="M01343"/>',
	              '<spring:message code="M01344"/>',
		],
	    colModel:[
	        {name:'batchCd',		index:'m.batch_cd', 	    resizable : false},
	        {name:'batchNm',		index:'m.batch_nm', 	    resizable : false},
			{name:'batchModulCd',   index:'m.batch_modul_cd',   resizable : false},
			{name:'batchModulNm',   index:'m.batch_modul_nm',   resizable : false},
			{name:'batchStatusNm', 	index:'m.batch_status_nm', 	resizable : false, align:'center'},
			{name:'errCd',		    index:'m.err_cd', 		    resizable : false, align:'center'},
			{name:'errSbst',		index:'m.err_sbst', 	    resizable : false},
			{name:'startDt',		index:'m.start_dt', 	    resizable : false},
			{name:'endDt',			index:'m.end_dt', 	 	    resizable : false},
	    ],
	    sortname: 'm.end_dt',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	rtCampErrorHistGrid = $("#rtCampErrorHistGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	errorHistoryPopList();

  	//닫기
    $('#errorHistoryPopClose').on('click', function() {
    	errorHistoryPopClose();
    });
});
</script>

<div id="errorHistoryPopWrap">
	<div class="pop_inner_wrap">
		<div id="rtCampErrorHistGrid" class="pop900_grid double_row_grid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_lightGray2" id="errorHistoryPopClose">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>