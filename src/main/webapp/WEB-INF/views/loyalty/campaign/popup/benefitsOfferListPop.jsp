<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>
//grid
var benefitsOfferListPopGrid; 
var gridIdbenefitsOfferListPopGrid;
var newOfferYn = '<%= cleanXss(request.getParameter("newOfferYn")) %>';
	
function benefitsOfferListPopGrid() {
	var colNames = [];
	var colModel = [];
	

	colNames = [
                '#',
                '<spring:message code="M00314"/>',
                '<spring:message code="M00319"/>',
                '<spring:message code="M01896"/>',
                '<spring:message code="M02276"/>',
                '<spring:message code="M02275"/>',
                'offerId',
                'id',
    ];
	colModel = [
	            {name:'offerNo'           ,index:'mof.offer_no' , resizable: false, width:'100px', align:'center'},
	            {name:'offerName'         ,index:'mof.offer_nm' , resizable: false, width:'300px', cellattr: function(){ return 'style="text-overflow:ellipsis;"';}},
	            {name:'offerTypeCd'       ,index:'c2.mark_name' , resizable: false, width:'100px', align:'center'},
	            {name:'offerSubTypeNm'    ,index:'c8.mark_name' , resizable: false, width:'100px', align:'center'},
	            {name:'offerEcnrsDivNm'   ,index:'c9.mark_name' , resizable: false, width:'100px'},
	            {name:'offerUseDeskDivNm' ,index:'c10.mark_name', resizable: false, width:'100px'},
	            {name:'offerId'           ,index:'mof.id'       , resizable: false, hidden : true,  searchable : false},
	            {name:'id'                ,index:'mof.id'       , resizable: false, hidden : true,  searchable : false}
    ];
	
	var jqGridOption = {
        loadComplete : function(obj) {
 		},
		onSelectRow : function (data) {
		},
		serializeGridData : function (data) {
		    // 17.07.11 jh.kim
		    // 활성화된 상태의 오퍼만 조회한다. 
		    data.type = strType;
		    data.offerStatusCd = 1;
		    return data;
		},
	    url:'<ifvm:action name="getListOffer"/>',
	    colNames:colNames,
	    colModel:colModel,
	    radio : true,
	    sortname: 'mof.offer_no',
		sortorder: "desc",
		caption: '<spring:message code="M00338"/>',
		tempId : 'ifvGridOriginTemplete'
	};
	benefitsOfferListPopGrid = $("#benefitsOfferListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
	gridIdbenefitsOfferListPopGrid = $("#gridIdbenefitsOfferListPopGrid");
}

//숫자 콤마표시
function numberFormat2(cellvalue, options, rowObjec) {
	var value = "";
	if (isNotEmpty(cellvalue)) {
		value = $.ifvNumberFormat(cellvalue);
	}
	
	return value;
}

$(document).ready(function() {
    
    benefitsOfferListPopGrid();

    // 선택 클릭시
    $('#benefitsOfferListPopSelectBtn').on('click', function() {
        benefitsOfferListPopSelect();
    });

    // 취소 클릭시
    $('#benefitsOfferListPopCancelBtn').on('click', function() {
        benefitsOfferListPopClose();
    });

});
</script>

<style>
.offerList_size{width:975px;}
</style>

<div id="benefitsOfferListPopCon">
	<div class="pop_inner_wrap">
		<div id="benefitsOfferListPopGrid" class="offerList_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="benefitsOfferListPopSelectBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="benefitsOfferListPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>