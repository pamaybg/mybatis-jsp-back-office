<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>

var brandListPopup;
var categoryListPopup;
var productListPopup;

function initProductDtlPopData(data) {

    $("#productDtlPopWrap #rid").val(data.rid);
    
    $("#productDtlPopWrap #ridProd").val(data.ridProd);
    $("#productDtlPopWrap #prodId").val(data.prodId);
    $("#productDtlPopWrap #prodNm").val(data.prodNm);
      
    $("#productDtlPopWrap #posProdCnt").val(data.posProdCnt);
    $("#productDtlPopWrap #posProdCd").val(data.posProdCd);
    $("#productDtlPopWrap #posBcodeNo").val(data.posBcodeNo);
    $("#productDtlPopWrap #posChnlCd").val(data.posChnlCd);
    $("#productDtlPopWrap #posProdAmt").val(data.posProdAmt);
}

/**
 * 상품 목록 팝업 열기
 */
function productListPopupOpen() {
    productListPopup = $("#prodListPopup").ifvsfPopup({
        enableModal : true,
        enableResize : false,
        contentUrl : '<ifvm:url name="productListPop"/>',
        contentType : "ajax",
        title : "<spring:message code='L00300'/>",
        width : 600,
        close : 'productListPopupClose'
    });
}
function productListPopupClose() {
    productListPopup.ejDialog('destroy');
}
//상품 목록 팝업 선택
function productListPopupSelect() {
    if ($.fn.ifvmIsNotEmpty(productListPopGrid.getCheckedList())) {
        var selData = productListPopGrid.getCheckedList()[0];
        $("#ridProd").val(selData.rid); 
        $("#prodId").val(selData.prodId);
        $("#prodNm").val(selData.prodNm);
        
        //close popup
        productListPopupClose();
    }
    else {
        alert("<spring:message code='L00301'/>");
        return false;
    }
}

$(document).ready(function() {

    // 상품 검색
    $('#productListPopupBtn').on('click', function() {
        productListPopupOpen();
    });
    
    // 저장
    $('#productDtlPopSaveBtn').on('click', function() {
        productAdd();
    });

    // 취소 
    $('#productDtlPopCancelBtn').on('click', function() {
        productDtlPopClose();
    });
    
    $("#posProdCnt").onlyNumber();
    
    $("#posProdAmt").keyup(function (event) {
   		if($("#discountAmount").val() > 2147483647) {
   			$("#discountAmount").val("2147483647");
   		}
	});
});

</script>

<div id="productDtlPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="productDtlPop" >
        <ifvm:input type="hidden" id="rid" names="rid" />
        
		<div class="row qt_border" id="prodArea">
        
            <%-- 상품명 --%>
			<label class="col-xs-3 control-label"><spring:message code='L00305'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" id="prodNm" names="prodNm" />
                    <ifvm:input type="hidden" readonly="true" id="ridProd" names="ridProd" />
                    <ifvm:input type="hidden" readonly="true" id="prodId" names="prodId" />
                    <span class="input-group-addon" id="productListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span> 
                </div>
            </div>
		</div>
        
        <div class="row qt_border">
        
            <%-- POS 제품수량 --%>
            <label class="col-xs-3 control-label"><spring:message code='M02285'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" id="posProdCnt" names="posProdCnt" maxLength="32"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- POS 제품코드 --%>
            <label class="col-xs-3 control-label"><spring:message code='M02286'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" id="posProdCd" names="posProdCd" maxLength="32"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- POS 바코드번호 --%>
            <label class="col-xs-3 control-label"><spring:message code='M02287'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" id="posBcodeNo" names="posBcodeNo" maxLength="32"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- POS 원가 --%>
            <label class="col-xs-3 control-label"><spring:message code='M02442'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="number" id="posProdAmt" names="posProdAmt"/>
            </div>
        </div>
        <div class="row qt_border">
        
            <%-- POS 공급업체코드 --%>
            <label class="col-xs-3 control-label"><spring:message code='M02443'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="text" id="posChnlCd" names="posChnlCd" maxLength="32"/>
            </div>
        </div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="productDtlPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code="M01855"/>
	    </button> 
	    <button class="btn btn-sm btn_lightGray2" id="productDtlPopCancelBtn">         
	        <spring:message code="M00441"/>
	    </button> 
	</div>
</div>
<div id="brandListPopup"></div>
<div id="categoryListPopup"></div>
<div id="prodListPopup"></div>