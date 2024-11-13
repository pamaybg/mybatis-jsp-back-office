<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var loyOfferUseLmtProdInfoPopValidation;

function initLoyOfferUseLmtProdInfoPop() {
	//채널유형
	$.fn.ifvmSetSelectOptionCommCode("basGrpCd", "LOY_BAS_GRP_CD", null, null, true);
	
	loyOfferUseLmtProdInfoPopValidation = $("#loyOfferUseLmtProdInfoPop").ifvValidation();
}

function initLoyOfferUseLmtProdInfoPopData(data) {
	$("#basGrpCd").val(data.basGrpCd);
	setBasGrpCd();
	
	$("#ridBrdCat").val(data.ridBrdCat);
	$("#brdId").val(data.brdId);
	$("#brdNm").val(data.brdNm);
	
	$("#ridProdCat").val(data.ridProdCat);
	$("#catId").val(data.catId);
	$("#catNm").val(data.catNm);
	
	$("#ridProd").val(data.ridProd);
	$("#prodId").val(data.prodId);
	$("#prodNm").val(data.prodNm);
}

//브랜드 목록 팝업 열기
function loyBrandListPopupOpen() {
    $("#loyBrandListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyBrandListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00296'/>",
        width: '600px',
        close : 'loyBrandListPopupClose'
    });
}

//브랜드 목록 팝업 선택
function loyBrandListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(loyBrandListPopGrid.getCheckedList())) {
		var selData = loyBrandListPopGrid.getCheckedList()[0];
		$("#brdNm").val(selData.brdNm);	//브랜드명
		$("#brdId").val(selData.brdId);	//브랜드아이디
		$("#ridBrdCat").val(selData.rid);	//rid
		
		//브랜드 초기화
		$("#catNm").val("");
		$("#ridProdCat").val("");
		$("#catId").val("");
		
		//상품 초기화
		$("#ridProd").val("");
		$("#prodId").val("");
		$("#prodNm").val("");
		
		//close popup
		loyBrandListPopupClose();
	} else {
		alert("<spring:message code='L00297'/>");
		
		return false;
	}
}

//브랜드 목록 팝업 닫기
function loyBrandListPopupClose() {
	loyBrandListPopup._destroy();
}

//카테고리 목록 팝업 열기
function loyProdCategoryListPopupOpen() {
	var _brdNm = $("#brdNm").val();
	
	if ($.fn.ifvmIsNotEmpty(_brdNm)) {
	    $("#loyProdCategoryListPopup").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="loyProdCategoryListPop"/>',
	        contentType: "ajax",
	        title: "<spring:message code='L00298'/>",
	        width: '600px',
	        close : 'loyProdCategoryListPopupClose'
	    });
	} else {
		alert('<spring:message code="M02014" />');
	}
}

//카테고리 목록 팝업 선택
function loyProdCategoryListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(loyProdCategoryListPopGrid.getCheckedList())) {
		var selData = loyProdCategoryListPopGrid.getCheckedList()[0];
		$("#ridProdCat").val(selData.rid);	
		$("#catId").val(selData.catId);	
		$("#catNm").val(selData.catNm);
		
		//상품 초기화
		$("#ridProd").val("");
		$("#prodId").val("");
		$("#prodNm").val("");
		
		//close popup
		loyProdCategoryListPopupClose();
	} else {
		alert("<spring:message code='L00299'/>");
		
		return false;
	}
}

//카테고리 목록 팝업 닫기
function loyProdCategoryListPopupClose() {
	loyProdCategoryListPopup._destroy();
}

//상품 목록 팝업 열기
function loyProdListPopupOpen() {
	var _catNm = $("#catNm").val();
	
	if ($.fn.ifvmIsNotEmpty(_catNm)) {
	    $("#loyProdListPopup").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="loyProdListPop"/>',
	        contentType: "ajax",
	        title: "<spring:message code='L00300'/>",
	        width: '600px',
	        close : 'loyProdListPopupClose'
	    });
	} else {
		alert('<spring:message code="M02015" />');
	}
}

//상품 목록 팝업 선택
function loyProdListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(loyProdListPopGrid.getCheckedList())) {
		var selData = loyProdListPopGrid.getCheckedList()[0];
		$("#ridProd").val(selData.rid);	
		$("#prodId").val(selData.prodId);
		$("#prodNm").val(selData.prodNm);
		
		//close popup
		loyProdListPopupClose();
	} else {
		alert("<spring:message code='L00301'/>");
		
		return false;
	}
}

//상품 목록 팝업 닫기
function loyProdListPopupClose() {
	loyProdListPopup._destroy();
}

//브랜드 rid 추출
function getRidBrdCat() {
	var data = $.fn.ifvmIsEmptyNull($("#ridBrdCat").val());
	
	return data;
}

//브랜드, 카테고리 rid 추출
function getRidBrdCatAndRidProdCat() {
	var data = {
		ridBrdCat: $.fn.ifvmIsEmptyNull($("#ridBrdCat").val()),
		ridProdCat: $.fn.ifvmIsEmptyNull($("#ridProdCat").val())
	};
	
	return data;
}

//그룹유형 선택 설정
function setBasGrpCd() {
	var _basGrpCd = $("#basGrpCd").val();
	
	//상품-모두 활성
	if (_basGrpCd == "PROD") {
		$("#branArea").show();
		$("#brdNm").attr("required", "true");
		
		$("#cateArea").show();
		$("#catNm").attr("required", "true");
		
		$("#prodArea").show();
		$("#prodNm").attr("required", "true");
	}
	
	//카테고리-브랜드, 카테고리 활성
	else if (_basGrpCd == "CATE") {
		$("#branArea").show();
		$("#brdNm").attr("required", "true");
		
		$("#cateArea").show();
		$("#catNm").attr("required", "true");
		
		$("#prodArea").hide();
		$("#prodNm").removeAttr("required");
	}
	
	//브랜드-브랜드만 활성
	else if (_basGrpCd == "BRAN") {
		$("#branArea").show();
		$("#brdNm").attr("required", "true");
		
		$("#cateArea").hide();
		$("#catNm").removeAttr("required");
		
		$("#prodArea").hide();
		$("#prodNm").removeAttr("required");
	}
	
	loyOfferUseLmtProdInfoPopValidation = $("#loyOfferUseLmtProdInfoPop").ifvValidation();
}

$(document).ready(function() {
	initLoyOfferUseLmtProdInfoPop();
	
	//등록 클릭시
    $('#loyOfferUseLmtProdInfoPopSaveBtn').on('click', function(){
    	loyOfferUseLmtProdInfoPopupSave();
    });
    
    //닫기 클릭시
    $('#loyOfferUseLmtProdInfoPopCancelBtn').on('click', function(){
    	loyOfferUseLmtProdInfoPopupClose();
    });
    
    //상품 목록 팝업
    $('#loyBrandListPopupBtn').on('click', function(){
    	loyBrandListPopupOpen();
    });
    
    //카테고리 목록 팝업
    $('#loyProdCategoryListPopupBtn').on('click', function(){
    	loyProdCategoryListPopupOpen();
    });
    
    //상품 목록 팝업
    $('#loyProdListPopupBtn').on('click', function(){
    	loyProdListPopupOpen();
    });
    
    //그룹유형 선택
	$('#basGrpCd').on('change', function() {
		setBasGrpCd();
    });
    
});
</script>

<div id="loyOfferUseLmtProdInfoPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="loyOfferUseLmtProdInfoPop" >
		<div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00302'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" id="basGrpCd" names="basGrpCd" />
            </div>
        </div>
		<div class="row qt_border" id="branArea">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00303'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="brdNm" names="brdNm" />
                    <ifvm:input type="hidden" readonly="true" id="ridBrdCat" names="ridBrdCat" />
                    <ifvm:input type="hidden" readonly="true" id="brdId" names="brdId" />
                    <span class="input-group-addon" id="loyBrandListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
		</div>
		<div class="row qt_border" id="cateArea">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00304'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="catNm" names="catNm" />
                    <ifvm:input type="hidden" readonly="true" id="ridProdCat" names="ridProdCat" />
                    <ifvm:input type="hidden" readonly="true" id="catId" names="catId" />
                    <span class="input-group-addon" id="loyProdCategoryListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
		</div>
		<div class="row qt_border" id="prodArea">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00305'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="prodNm" names="prodNm" />
                    <ifvm:input type="hidden" readonly="true" id="ridProd" names="ridProd" />
                    <ifvm:input type="hidden" readonly="true" id="prodId" names="prodId" />
                    <span class="input-group-addon" id="loyProdListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
		</div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="loyOfferUseLmtProdInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M01855"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="loyOfferUseLmtProdInfoPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>
<div id="loyBrandListPopup"></div>
<div id="loyProdCategoryListPopup"></div>
<div id="loyProdListPopup"></div>