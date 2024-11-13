<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var runChannelList;
var segColumnId = null;
var selectChnlId = null;


//조회결과 그리드
function runChannelList(){
	var jqGridOption = {
		serializeGridData : function( data ){
			if(requestitem != null && requestitem.length > 0){
				data.item = requestitem;
			}
			return data;
		},
		ondblClickRow : function(row){
		},
		onSelectCell : function (data) {
			selectChnlId = data.codeNm;
			ChnlRelList.requestData( { chnlId : data.codeNm} );
		}, 
	    url:'<ifvm:action name="getoutchannel"/>',
	    colNames:[
	              '<spring:message code="M00463"/>',
	              'codeNm',
	              'id'
	              ],
	    colModel:[
	        {name:'markNm',index:'mark_name', resizable : false},
	        {name:'codeNm',index:'code_name', resizable : false,  hidden : true,  searchable : false},
	        {name:'id', index:'mc.id', resizable : false,  hidden : true,  searchable : false}
	    ],
		radio:true,
		rowList : [100000],
		sortname: 'create_date',
		sortorder: "desc",
		tempId : 'approvalPopTemplete'
	};
	runChannelList = $("#runChannelList").ifvGrid({ jqGridOption : jqGridOption });
}



$(document).ready(function(){

	runChannelList();
});

</script>
	
<script id="approvalPopTemplete" type="text/ifvGrid-tmpl">
<div class="ifv_grid_templete">
	{title}
	<div class="grid_con">
		{grid}
	</div>
	<div class="page">
		<div class="total_area">{total}</div>	
	<div>
</div>
</script>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M01284"/></span>
	</div>


</div>
<div id="runChannelList" class="grid_bd0"></div>
