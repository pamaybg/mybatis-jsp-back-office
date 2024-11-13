<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var offerListPopGrid; 

function offerListPopGrid() {
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
			data.id = offerid;
			return data;
		},
	    url:'<ifvm:action name="getParOffer"/>',
	    colNames:['<spring:message code="M00314"/>',
	              '<spring:message code="M00317"/>', 
	              '<spring:message code="M00340"/>', 
	              '<spring:message code="M00341"/>', 
	              '<spring:message code="M00313"/>',
	              'offerType',
	              'offerSubType',
	              'id'
	              ],
	    colModel:[
	        
	        {name:'offerName',index:'mof.offer_nm', resizable : false},
	        {name:'commStatus',index:'c1.mark_name', resizable : false},
	        {name:'applyStrDate',index:'mof.APLY_START_DD', resizable : false},
	        {name:'applyEndDate',index:'mof.APLY_END_DD', resizable : false},
	        {name:'offerNo',index:'mof.offer_no', resizable : false},
	        {name:'offerType', index:'mof.offer_type_cd', resizable : false,  hidden : true,  searchable : false},
	        {name:'offerSubType', index:'mof.offer_sub_type_cd', resizable : false,  hidden : true,  searchable : false},
	        {name:'id', index:'mof.id', resizable : false,  hidden : true,  searchable : false}
	    ],
	    radio :true,
	    sortname: 'mof.modify_date',
		sortorder: "desc",
		caption: '<spring:message code="M00338"/>',
		tempId : 'ifvGridOriginTemplete'
	};
	offerListPopGrid = $("#offerListPopGrid").ifvGrid({ jqGridOption : jqGridOption });
}


$(document).ready(function() {
    
    offerListPopGrid();

    // 저장 클릭시
    $('#offerListPopSaveBtn').on('click', function() {

        if (offerListPopGrid.getCheckedGridData() == '') {
            alert('<spring:message code="M00285"/>');
        }
        else {
            var dataArr = offerListPopGrid.getCheckedGridData();
            $("#parOfferId").text(dataArr[0].id).val(dataArr[0].offerName);
            $("#inputOfferNm").text(dataArr[0].offerNo).val(dataArr[0].offerName);
            $("#inputOfferType").text(dataArr[0].offerType).val(dataArr[0].offerSubType);
            formNewPopClose();
        }
    });

    // 취소 클릭시inputOfferNm
    $('#offerListPopCancelBtn').on('click', function() {
        formNewPopClose();
    });
});

</script>

<div id="offerListPopCon">
	<div class="pop_inner_wrap">
		<div id="offerListPopGrid" class="con_size"></div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="offerListPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M00282"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="offerListPopCancelBtn">         
	        <spring:message code="M00284"/>
	    </button> 
	</div>
</div>