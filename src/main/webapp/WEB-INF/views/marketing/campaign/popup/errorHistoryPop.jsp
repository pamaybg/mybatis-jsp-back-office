<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var errorHistoryPopGrid; 

function errorHistoryPopList(){
	var jqGridOption = {
		loadComplete : function(obj){
			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'errorHistoryPop',
				contentsId : 'errorHistoryPopWrap'
			});
			new ifvm.PopupCenter({
				popupDivId : 'errorHistoryPop'
			});
		},
		serializeGridData : function( data ){
			data.cam_id = cam_id;
			
			return data;
		},
	    url:'<ifvm:action name="getCampaignStatusErrorList"/>',
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
	        {name:'batch_cd',		  index:'m.BATCH_CD', 		  resizable : false},
			{name:'batch_nm',		  index:'d.BATCH_NM', 		  resizable : false},
			{name:'batch_modul_cd',   index:'m.BATCH_MODUL_CD',   resizable : false},
			{name:'batch_modul_nm',   index:'e.BATCH_MODUL_NM',   resizable : false},
			{name:'batch_status_dtl', index:'m.BATCH_STATUS_DTL', resizable : false},
			{name:'err_cd',		      index:'m.ERR_CD', 		  resizable : false},
			{name:'err_sbst',		  index:'m.ERR_SBST', 		  resizable : false},
			{name:'start_dt',		  index:'m.START_DT', 		  resizable : false},
			{name:'end_dt',			  index:'m.END_DT', 	 	  resizable : false},
	    ],
	    sortname: 'end_dt',
		sortorder: "desc",
		tempId : 'ifvGridOriginTemplete'
	};
	errorHistoryPopGrid = $("#errorHistoryPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	errorHistoryPopList();
	
  	//닫기
    $('#errorHistoryPopClose').on('click', function(){
    	errorHistoryPopClose();
    });
});
</script>

<div id="errorHistoryPopWrap">
	<div class="pop_inner_wrap">
		<div id="errorHistoryPopGrid" class="pop900_grid double_row_grid"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_lightGray2" id="errorHistoryPopClose">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>