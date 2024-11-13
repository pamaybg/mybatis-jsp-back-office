<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
		<spring:message code="D00001" />
        &gt; <spring:message code="D00044" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span><spring:message code="D00045" /></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnNew" btnFunc="btnNewClick" btnType="plus" text="L00027" objCode="appListAdd_OBJ" />
	    </div>
	</div>
	<div id="appGrid"></div>
</div>

<script>
var appGrid;
var validation;

function makeAppGrid() {
	var jqGridOption = {
			serializeGridData : function( data ){
			},
			ondblClickRow : function (rowNo) {
	        	var data = appGrid.getRowData()[rowNo-1];

	        	appDetail(data);
	        },
			loadComplete : function(obj){
			},
		    url: '<ifvm:action name="getAppVerList"/>',
		    colNames:['앱 이름',
		              '<spring:message code="M00009" />',
		              '<spring:message code="D00050" />',
		              '<spring:message code="D00051" />',
		              '<spring:message code="L00069" />',
		              '업데이트일',
		              'id',
		              'serviceId'
		              ],

		    colModel:[
		        {name:'appName',index:'t1.appName', resizable : false, align: 'left'},
		        {name:'storeName',index:'t1.storeName', resizable : false, align: 'left'},
		        {name:'distributeVer',index:'t1.distributeVer', resizable : false, align: 'right'},
		        {name:'minVer',index:'t1.minVer', resizable : false, align: 'right'},
		        {name:'appRegDate',index:'t1.appRegDate', align: 'center', resizable : false, formatter:'date', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'appUpdateDate',index:'t1.appUpdateDate', align: 'center', resizable : false, formatter:'date', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'id',index:'mv.id', resizable : false, hidden : true, searchable : false},
		        {name:'serviceId',index:'mv.app_service_type', resizable : false, hidden : true, searchable : false},
		    ],
		    autowidth:true,
		    sortname: 'appRegDate',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
	};

	appGrid = $('#appGrid').ifvGrid({jqGridOption : jqGridOption});
}

$(document).ready(function() {
	makeAppGrid();
});


function btnNewClick() {
	//팝업띄우기
	$.ifvLoadPop({
		url : '<ifvm:url name="appDetailPopUrl"/>'
		, params : {id : null}
		, close : function(obj) {

	}});
}

function appDetail(data) {
	$.ifvLoadPop({
		url : '<ifvm:url name="appDetailPopUrl"/>'
		, params : {id : data.id, serviceId : data.serviceId}
		, close : function(obj) {

	}});
}

</script>