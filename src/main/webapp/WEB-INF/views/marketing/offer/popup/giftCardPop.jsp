<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var couponPopGrid; 

function couponPopGrid(){
	var jqGridOption = {
		loadComplete : function(obj){
			//popup 높이 맞추기
			new ifvm.PopupHeight({
				popupDivId : 'offerPopupCon',
				contentsId : 'offerListPopCon'
			});
		},
		onSelectRow : function (data) {
			
		},
		serializeGridData : function( data ){
			
		},
	    //url:'<ifvm:action name="getParOffer"/>',
	    colNames:['<spring:message code="M00346"/>',
	              '<spring:message code="M00347"/>', 
	              '<spring:message code="M00348"/>', 
	              '<spring:message code="M00349"/>'
	              ],
	    colModel:[
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	        {name:'',index:'', resizable : false},
	    ],
	    radio :true,
	    sortname: '',
		sortorder: "desc",
		caption: '<spring:message code="M00350"/>',
		tempId : 'ifvGridOriginTemplete'
	};
	couponPopGrid = $("#couponPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function(){
	couponPopGrid();
	
	
  	//취소 클릭시
    $('#couponPopCancelBtn').on('click', function(){
    	formNewPopClose();
    });
});
</script>

<div id="offerListPopCon">
	<div class="pop_inner_wrap">
		<div id="couponPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="couponPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="couponPopCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>