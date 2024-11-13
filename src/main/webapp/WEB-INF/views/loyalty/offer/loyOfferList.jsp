<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var offerListGrid;

//조회결과 그리드
function setOfferListGrid(){
	
	var jqGridOption = {
		serializeGridData : function (data) {
		    data.type = "LOY";
			if ($.fn.ifvmIsNotEmpty(requestitem)) {
				data.item = requestitem;
			}
			return data;
		},
		ondblClickRow : function (rowNo) {
			var data = offerListGrid.getRowData()[rowNo-1];
			
			goOfferDetail(data.id);
		},
		loadComplete : function(obj) {
		},
	    url: '<ifvm:action name="getLoyOfferMstList"/>',
	    colNames:['<spring:message code="M00313"/>',
	              '<spring:message code="M00314"/>', 
	              //'<spring:message code="M00315"/>', 
	              //'<spring:message code="M00316"/>', 
	              '<spring:message code="M00317"/>',
	              '<spring:message code="M00318"/>',
	              '<spring:message code="M00319"/>',
	              //'<spring:message code="M00320"/>',
	              //'<spring:message code="M00321"/>',
	              //'<spring:message code="M00324"/>',
	              '<spring:message code="M00325"/>',
	              '<spring:message code="M00326"/>',
	              'id'
	              ],
	    colModel:[
	        {name:'offerNo',index:'t1.offer_no', resizable : false},
	        {name:'offerNm',index:'t1.offer_nm', resizable : false},
	        //{name:'aplyStartDd',index:'t1.APLY_START_DD', resizable : false},
	        //{name:'aplyEndDd',index:'t1.APLY_END_DD', resizable : false},
	        {name:'offerStatusNm',index:'c4.mark_name', resizable : false},
	        {name:'offerCostDivNm',index:'c1.mark_name', resizable : false},
	        {name:'offerTypeNm',index:'c2.mark_name', resizable : false},
	        //{name:'dcTypeNm',index:'c3.mark_name', resizable : false},
	        //{name:'dcAmt',index:'mof.DC_AMT', resizable : false},
	        //{name:'offerDesc',index:'mof.OFFER_DESC', resizable : false},
	        {name:'createByNm',index:'e1.name', resizable : false},
	        {name:'createDate',index:'t1.modify_date', resizable : false},
	        {name:'id', index:'t1.id', resizable : false,  hidden : true,  searchable : false}		
	    ],
	    autowidth:true,
	    sortname: 't1.offer_no',
		autowidth : true , sortorder: "desc",
		multiselect: false,
		tempId : 'ifvGridOriginTemplete'
	};
	
	offerListGrid = $("#offerListGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//오퍼 상세 이동
function goOfferDetail(id) {
    qtjs.href('<ifvm:url name="loyOfferDetail"/>' + '?id=' + id);
}

//공통 조회 조건 목록 설정
function offerListSearchInit() {
    $.fn.ifvmSetCommonCondList("offerListSearchList","ANL_SEG_001");
}

//공통 조회 호출
function offerListSearch() {
    $.fn.ifvmSubmitSearchCondition("offerListSearchList", setOfferListGrid);
}

$(document).ready(function() {
    
	//그리드 설정
	setOfferListGrid();
	
	//공통조회조건 설정
	offerListSearchInit();

	//조회
	$("#offerListSearchBtn").on('click', function(){
		offerListSearch();
	});
	
    //초기화
    $("#offerListSearchInitBtn").on('click', function(){
    	offerListSearchInit();
    });

	//저장
	$('#offerNewBtn').on('click', function(){
		qtjs.href('<ifvm:url name="loyOfferDetail"/>');
	});
	
});
</script>

<style>
.well{padding-bottom:5px;}
</style>

<div class="page-title">
	<h1>
		<spring:message code="M00308"/>&gt;  <spring:message code="M00273"/>
	</h1>
</div>

<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="M00310"/></span>
	</div>
	<div class="col-xs-5 searchbtn_r">
		<button class="btn btn-sm" id='offerListSearchBtn'><i class="fa fa-search"></i>
			<spring:message code="M00273"/>
		</button> 
		<button class="btn btn-sm" id='offerListSearchInitBtn'>
			<spring:message code="M00311"/>
		</button> 
	</div>
</div>
<div class="well form-horizontal" id="offerListSearchList" >
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="M00312"/></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="offerNewBtn">         
				<i class="fa fa-plus"></i>    
				<spring:message code="M00274"/>
			</button> 
		</div>
	</div>
	<div id="offerListGrid" class="grid_bd0"></div>
</div>