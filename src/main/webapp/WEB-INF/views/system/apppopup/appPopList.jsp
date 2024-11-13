<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="page-title">
    <h1>
		<spring:message code="D00001" />
        &gt; <spring:message code="D00058" />
    </h1>
</div>
<div>
	<div class="page_btn_area">
	    <div class="col-xs-5">
	        <span><spring:message code="D00059" /></span>
	    </div>
	    <div class="col-xs-7 searchbtn_r">
			<ifvm:inputNew type="button" id="btnNew" btnFunc="btnNewClick" btnType="plus" text="L00027" objCode="appPopListAdd_OBJ" />
	    </div>
	</div>
	<div id="appPopGrid"></div>
</div>

<script>
var appPopGrid;

function makeAppPopGrid() {
	var jqGridOption = {
			serializeGridData : function( data ){
			},
			ondblClickRow : function (rowNo) {
	        	var data = appPopGrid.getRowData()[rowNo-1];
	        	
	        	appPopDetail(data.rid);
	        },
			loadComplete : function(obj){
			},
		    url: '<ifvm:action name="getAppPopList"/>', 
		    colNames:[
		              '구분',
		              '제목',
		              '작성자',
		              '등록일',
		              '시작일시',
		              '종료일시',
		              '상태',
		              'rid'
		              ],
		              
		    colModel:[
		        {name:'appPopType',index:'appPopType', width:'60px', resizable : false, align: 'left'},
		        {name:'appPopTitle',index:'appPopTitle', width:'120px', resizable : false, align: 'left'},
		        {name:'appPopWriter',index:'appPopWriter', width:'60px', resizable : false, align: 'center'},
		        {name:'createDate',index:'createDate', width:'60px', resizable : false, align: 'center', formatter:'date', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'startDate',index:'startDate', width:'60px', resizable : false, formatter:'date', align: 'center', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'endDate',index:'endDate', width:'60px', resizable : false, formatter:'date', align: 'center', formatoptions:{srcformat:"Y-m-d",newformat:"Y-m-d"}},
		        {name:'appPopStatus',index:'appPopStatus', width:'60px', resizable : false, align: 'center'},
		        {name:'rid',index:'rid', resizable : false, hidden : true, searchable : false}
		    ],
		    autowidth:true,
		    sortname: 'createDate',
			sortorder: "desc",
			tempId : 'ifvGridOriginTemplete'
	};
	
	appPopGrid = $('#appPopGrid').ifvGrid({jqGridOption : jqGridOption});
}

$(document).ready(function() {
	makeAppPopGrid();
});


function btnNewClick() {
	location.href = '<ifvm:url name="appPopDetailUrl"/>';
}

function appPopDetail(id){
	location.href = '<ifvm:url name="appPopDetailUrl"/>' + '?rid=' + id;
}
</script>