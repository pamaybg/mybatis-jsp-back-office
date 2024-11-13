<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var offerGrid; 

function initOfferListGrid() {
    var jqGridOption = {
            serializeGridData : function( data ){
				data.chnlNo = chnlNo;
                return data;
            },
            url:'<ifvm:action name="getChnlOfferList"/>',
            colNames:['<spring:message code="M02171"/>',
                      '<spring:message code="M02114"/>',
                      'offerId',
                      'offerTypeCd',
                      'createDate'
                      ],
            colModel:[
                {name:'offerTypeCdMarkName',index:'c1.mark_name', align:'center'}, 
                {name:'offerNm',index:'mom.offer_nm', align:'center'},
                
                {name:'offerId',index:'mom.id', hidden:true},
                {name:'offerTypeCd',index:'c1.code_name', hidden:true},
                {name:'createDate',index:'mom.create_date', hidden:true},
            ],
            radio : true,
            sortname: 'mom.create_date',
            sortorder: 'desc',
            tempId : 'ifvGridOriginTemplete'
        };
    offerGrid = $("#offerPopupGrid").ifvGrid({ jqGridOption : jqGridOption });
}

//선택한 오퍼 부모창 세팅
function setOffer() {
	var checkList = offerGrid.getCheckedList();
	if(checkList[0] != null && checkList[0].offerId != null && checkList[0].offerId != '') {
		$("#txtOfferName").val(checkList[0].offerNm);
		$("#txtOfferName").text(checkList[0].offerNm);
		
		$("#txtChargingAmount").val(checkList[0].lowstSettlAmt);
		$("#txtChargingAmount").text(checkList[0].lowstSettlAmt);
		
		$("#txtDiscountAmount").val(checkList[0].dcAmt);
		$("#txtDiscountAmount").text(checkList[0].dcAmt);
		
		$("#discountType").val(checkList[0].dcTypeCd);
		
		offerData.offerId = checkList[0].offerId;
		offerData.offerTypeCd = checkList[0].offerTypeCd;
		
		offerData.coupnId = checkList[0].coupnId;
		
		setDiscountCon();
		
		//부모창 세팅 후 팝업 닫기
		$("#offerListPopupCancelBtn").trigger('click');
	} else {
		alert('<spring:message code="M00004"/>');
	}
}

//확인
$("#offerListPopupSaveBtn").on("click", function(){ 
	setOffer();
});

//닫기 
$("#offerListPopupCancelBtn").on("click", function(){
	offerListPopupClose();
});

$(document).ready(function(){
	initOfferListGrid();
	
    if(camStatusCd != 'W' 
		&& (camStatusCd == 'A' //활성
			|| camStatusCd == 'I' //비활성
			|| camStatusCd == 'S' //중지
			|| camStatusCd == 'C' //취소
			|| camStatusCd == 'E' //완료
			|| camStatusCd == '010' //결재진행중
			|| camStatusCd == '090' //승인완료 
			|| camStatusCd == '091')) {
		$("#offerListPopupSaveBtn").hide();
	}
});
</script>

<style>
.left_bold {font-weight:bold; text-align: left !important;}
</style>

<div id="dialogPopupWrap">
	<div class="pop_inner_wrap form-horizontal">
		<div class="row" id="offerPopupGrid"/>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="offerListPopupSaveBtn"> <!-- 확인 -->
	        <spring:message code="C00126" />
	    </button>
	    <button class="btn btn-sm" id="offerListPopupCancelBtn"> <!-- 닫기 -->
	        <spring:message code="L00913"/>
	    </button> 
	</div>
</div>