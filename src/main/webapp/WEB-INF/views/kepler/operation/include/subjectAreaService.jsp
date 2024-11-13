<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var dbInformId = null;

//조회결과 그리드
function serviceDbList(){
	var ejGridOption = {
// 		serializeGridData : function( data ){
// /* 			if(requestitem != null && requestitem.length > 0){
// 				data.item = requestitem;
// 			}
// 			return data; */
// 		},
		rowSelected : function (args) {
			dbInformId = args.data.dbInformId;
			subjectAreaMapList();
		}, 
		dataUrl:'<ifvm:action name="getDbInformList"/>',
	    columns:[
	    	{
	      		  field : 'serviceNm', headerText : '<spring:message code="M01440"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'd.service_nm' }/* */
	      	  },{
	      		  field : 'dbInformId', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			 searchable : false,
	      			  index : 'd.id' }/* */
	      	  },
	    ],
	    requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 'd.create_date',
	    	  sord : 'desc',
	    	  _search : false
	      },
	    rowList : [10,25,50,100],
	    radio: true,
		tempId : 'approvalPopTemplete'
	};
	serviceDbList = $("#serviceDbList").ifvsfGrid({ ejGridOption : ejGridOption });
}

$(document).ready(function(){
	serviceDbList();
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
 		<span><spring:message code="M01579"/></span> 
	</div>
</div>
<div id="serviceDbList" class="grid_bd0 grid_scroll10"></div>
