<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var pointList;
var pointData = {
		point:[]	
}

function getPointList(){

	$.ifvSyncPostJSON('<ifvm:action name="getMemList"/>',{ memNm : memNm,  hhpNo : hhpNo, cardNo : cardNo }
	,function(result) {
		if ($.fn.ifvmIsNotEmpty(result)){
			if ($.fn.ifvmIsNotEmpty(result.cust)){
				pointData = result;	
			}else{
				pointData.point = [];
			}
		}
	});
	memList();
	
}

function pointList(){
		var jqGridOption = {
			serializeGridData : function( data ){
				data.memNm = memNm;
				data.hhpNo = hhpNo;
				data.cardNo = cardNo;
			},
			ondblClickRow : function(row){
			},
			onSelectCell : function (data) {
			}, 
			loadComplete : function(data){
			},
		    //url:'<ifvm:action name="getpointList"/>',
		    datatype: 'clientSide',
	        data : pointData.point,
		    colNames:[
	              /* '<spring:message code="M01440"/>', */
	              	'<spring:message code="L00354"/>'
	              	,'<spring:message code="L00356"/>'
	              	,'<spring:message code="L00350"/>'
	              	,'<spring:message code="L00353"/>'
	              	,'<spring:message code="L00352"/>'
	              	,'<spring:message code="L00381"/>'
	              	,'<spring:message code="L00355"/>'
	              	,'<spring:message code="L00422"/>'
	              	,'<spring:message code="L00351"/>'
	              	,'<spring:message code="M00966"/>'
	              	,'<spring:message code="L00376"/>'
	              	,'<spring:message code="L00375"/>'
	              	,'<spring:message code="L00384"/>'
	              	,'<spring:message code="L00385"/>'
	              	,'<spring:message code="L00322"/>'
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
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
		              {name:'tierCdStatNm', index:'c.MARK_NAME', resizable : false},
		              {name:'rid', index:'lt.rid', hidden : true}
				      ],  
			radio:true,
			tempId : 'ifvGridOriginTemplete'
		};
	pointList = $("#pointList").ifvGrid({ jqGridOption : jqGridOption });
}

$(document).ready(function(){
	pointList();
});

</script>

<div id="pointList" class="white_bg grid_bd0"></div>

