<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var memList;
var memData = {
		cust:[]	
}

function getMemList(){

	$.ifvSyncPostJSON('<ifvm:action name="getMemList"/>',{ memNm : memNm,  hhpNo : hhpNo, cardNo : cardNo }
	,function(result) {
		if ($.fn.ifvmIsNotEmpty(result)){
			if ($.fn.ifvmIsNotEmpty(result.cust)){
				memData = result;	
			}else{
				memData.cust = [];
			}
		}
	});
	memList();
	
}

function memList(){
		var jqGridOption = {
			serializeGridData : function( data ){
			},
			ondblClickRow : function(row){
			},
			onSelectCell : function (data) {
			}, 
			loadComplete : function(data){
			},
		    //url:'<ifvm:action name="getMemList"/>',
		    datatype: 'clientSide',
	        data : memData.cust,
		    colNames:[
	              /* '<spring:message code="M01440"/>', */
	              	'<spring:message code="L00435"/>'
	              	,'<spring:message code="M02062" />'
	              	,'<spring:message code="L00343"/>'
	              	,'<spring:message code="L00342"/>'
	              	,'<spring:message code="M02063" />'
	              	,'<spring:message code="L00312"/>'
	              	,'<spring:message code="L00434"/>'
	              	,'<spring:message code="L00433"/>'
	              	,'<spring:message code="L00311"/>'
	              	,'<spring:message code="L00324"/>'
	              	],
		    colModel:[{name:'seqNo', index:'lt.seq_no', resizable : false},
		              {name:'tierCd', index:'lt.tier_cd', resizable : false},
		              {name:'tierNm', index:'lt.tier_nm', resizable : false},
		              {name:'validStartDate', index:'lt.valid_start_date', resizable : false},
		              {name:'validEndDate', index:'lt.valid_end_date', resizable : false},
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
		              {name:'rid', index:'lt.rid', hidden : true}
				      ],  
			radio:true,
			tempId : 'ifvGridOriginTemplete'
		};
	memList = $("#memList").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	//getMemList();
	memList();
});

</script>

<div id="memList" class="white_bg grid_bd0"></div>

