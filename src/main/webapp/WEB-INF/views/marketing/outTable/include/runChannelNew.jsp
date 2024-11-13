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
	var ejGridOption = {
		serializeGridData : function( data ){
			if(requestitem != null && requestitem.length > 0){
				data.item = requestitem;
			}
			return data;
		},
		rowSelected : function (args) {
			selectChnlId = args.data.codeNm;
			ChnlRelList.searchGrid( { chnlId : args.data.codeNm} );
		}, 
		dataUrl:'<ifvm:action name="getoutchannel"/>',
	    columns:[
	    	{
	      		  field : 'markNm', headerText : '<spring:message code="M00463"/>', headerTextAlign : 'center',
	      		  customAttributes : {
	      			  index : 'mark_name' } //
	      	  },{
	      		  field : 'codeNm', headerText : 'codeNm', visible : false ,
	      		  customAttributes : {
       			      searchable : false,
	      			  index : 'code_name' } //
	      	  },{
	      		  field : 'id', headerText : 'id', visible : false ,
	      		  customAttributes : {
	      			  searchable : false,
	      			  index : 'mc.id' } //
	      	  },
	    ],
	    requestGridData : {
	    	  nd   : new Date().getTime(),
	    	  rows : 10,
	    	  sidx : 'create_date',
	    	  sord : 'desc',
	    	  _search : false
	    },
	    radio: true,
		rowList : [100000],
		tempId : 'approvalPopTemplete'
	};
	runChannelList = $("#runChannelList").ifvsfGrid({ ejGridOption : ejGridOption });
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
