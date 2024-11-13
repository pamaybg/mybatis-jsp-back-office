<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
		<spring:message code="D00030" />
        &gt; <spring:message code="L00030" />
    </h1>
</div>

<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span><spring:message code="D00031" /></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnNew" btnFunc="btnNewClick" btnType="plus" text="L00027" objCode="eventListAdd_OBJ" />
	    </div>
	</div>
	<div id="eventGrid"></div>
</div>

<script>
var eventGrid;

function makeEventGrid() {
	var jqGridOption = {
			ondblClickRow : function (rowNo) {
	        	var data = eventGrid.getRowData()[rowNo-1];
	        	eventDetail(data.rid);
	        },
			loadComplete : function(obj){
				for(var i=0; i<obj.rows.length; i++){
					if(obj.rows[i].eventShowStatus == "일시중지"){
						$('tr#'+(i+1)).css('background-color', '#E6E6E6');
					}
				}
			},
		    url: '<ifvm:action name="getEventList"/>',
		    colNames:['<spring:message code="C00125" />',
		              '<spring:message code="M00237" />',
		              '순번',
		              '<spring:message code="D00036" />',
		              '<spring:message code="D00037" />',
		              '<spring:message code="M01732" />',
		              'app팝업여부',
		              '<spring:message code="M00184" />',
		              '<spring:message code="M00222" />',
		              '수정일',
		              '<spring:message code="D00038" />',
		              '<spring:message code="M01731" />',
		              'rid'
		              ],

		    colModel:[
		        {name:'eventStatus',index:'t1.eventStatus', resizable : false, width:'70px', align: 'center'},
		        {name:'event_lang',index:'t1.event_lang', resizable : false, width:'70px', align: 'center'},
		        {name:'seq',index:'t1.seq', resizable : false, width:'70px', align: 'center'},
		        {name:'eventName',index:'t1.eventName', resizable : false, width:'320px', align: 'left'},
		        {name:'eventPeriod',index:'t1.eventPeriod', width:'170px', align: 'center',resizable : false},
		        {name:'eventShowCnt',index:'t1.eventShowCnt', resizable : false, width:'60px', align: 'center'},
		        {name:'appPopYn',index:'t1.APP_POP_FLAG', resizable : false, width:'100px', align: 'center'},
		        {name:'eventWriter',index:'t1.eventWriter', resizable : false, width:'170px', align: 'center'},
		        {name:'eventRegDate',index:'t1.eventRegDate', resizable : false, formatter:'date', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}, width:'110px', align: 'center'},
		        {name:'eventModDate',index:'t1.eventModDate', resizable : false, formatter:'date', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}, width:'110px', align: 'center'},
		        {name:'eventPrizewinnerDate',index:'t1.eventPrizewinnerDate', resizable : false, formatter:'date', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}, width:'170px', align: 'center'},
		        {name:'eventShowStatus',index:'t1.eventShowStatus', resizable : false , width:'100px', align: 'center'},
		        {name:'rid',index:'t1.rid', resizable : false, hidden : true, searchable : false},
		    ],
		    sortname: 't1.seq',
			sortorder: "asc",
			tempId : 'ifvGridOriginTemplete'
	};

	eventGrid = $('#eventGrid').ifvGrid({jqGridOption : jqGridOption});
}

$(document).ready(function() {
	makeEventGrid();
});

function btnNewClick() {
	location.href = '<ifvm:url name="eventDetailUrl"/>';
}

function eventDetail(id){
	location.href = '<ifvm:url name="eventDetailUrl"/>' + '?id=' + id;
}

</script>