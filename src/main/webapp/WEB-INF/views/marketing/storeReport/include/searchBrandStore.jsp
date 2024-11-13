<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<button class="btn btn-sm" id="findStore" objCode="reportBrandStoreSearch_OBJ">
	<i class="fa fa-search"></i><spring:message code="000222" />
</button>
<span id="brandNameText" class="control_content"></span>
<span id="shopCodeText" class="control_content"></span>
<div style="float: right"><p id="searchNoti"></p></div>
<div id="popupContainer" class="popup_container"></div>

<script type="text/javascript">
var pageName;
var storeName;
var shopCode;
var shopName;
var brandCode;
var brandName;
var shopCnt;
var ridBrand;
var now;
var ajaxCount = 0;
var notiStartDate = '2019-01-01'
var durationYear = 4;

$(document).ready(function() {
	textInit();
	$('#findStore').on('click', function() {
		$("#popupContainer").ifvsfPopup({
			enableModal : true,
			enableResize: false,
			contentUrl: '<ifvm:url name="brandStoreListPop"/>',
			contentType: "ajax",
			title: '<spring:message code="000218"/>',
			width: 1000,
			close : 'brandStoreListPopupClose'
		});
	});

});

function textInit(){
	var text = "데이터 시작 시점 : "+ notiStartDate
			+ "<br>조회 가능 기간 : 현 시점으로부터 " + durationYear + "년 전까지"
	$('#searchNoti').html(text);
	if(ifvmUserInfo.orgNumber === 'ADMIN'){
		if($.fn.ifvmIsNotEmpty(brandName)) $('#brandNameText').text(brandName);
		if($.fn.ifvmIsNotEmpty(shopCode)) $('#shopCodeText').text(shopCode);
	}
}

function setShopCnt(martType, regionType, shopTypeCode) {
	//브랜드 조회용 매장수 조회
	$.ifvSyncPostJSON('<ifvm:action name="getShopCnt"/>', {
		brandCode: brandCode,
		martType: martType,
		regionType: regionType,
		shopTypeCode: shopTypeCode
		//, shopCode: shopCode
	}, function (response) {
		shopCnt = response;
	});
}

function setBrandCode(){
	//매장코드 조회
	$.ifvSyncPostJSON('<ifvm:action name="getBrandCode"/>', {
		empId: ifvmUserInfo.empId
	}, function (response) {
		ridBrand = response.ridBrand;
		brandCode = response.brandCode;
		brandName = response.brandName;
		$('#brandName').html(brandName + ' 평균');
	});
}


function beforeSend(){
	now = new Date();
	ajaxCount = 0;
	// console.log('쿼리 시작');

	$('body').append($('<div>').addClass('loading').text('조회중'));
	//$(".loading").attr("style", "z-index:99999999999;");
	$.setProgressZindex();
}

function complete(label, total, completeFunc){
	var endDate = new Date();
	var timeSet = endDate-now;
	ajaxCount++;

	// var mm = Math.floor((timeSet % (1000 * 60 * 60)) / (1000 * 60));
	// var ss = Math.floor((timeSet % (1000 * 60)) / 1000);
	// console.log(ajaxCount+ '. ' + label + " : " + mm +"분 "+ ss +"초" );
	if(ajaxCount > total-1) {
		$('.loading').remove();
		// console.log('쿼리 종료');
		if(!$.fn.ifvmIsEmpty(completeFunc)) completeFunc();
	}
}


// 매장용 리포트 메뉴 조회 이력 추가
function addStoreReportHist(groupCode) {
	$.ifvPostJSON('<ifvm:action name="addStoreReportHist"/>', {
		programNo : groupCode
	}, function(result) {
	});
}
</script>
