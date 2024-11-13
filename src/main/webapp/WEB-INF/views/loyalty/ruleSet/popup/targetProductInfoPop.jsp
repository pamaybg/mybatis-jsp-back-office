<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var targetProductInfoPopValidation;

function initTargetProductInfoPop() {

	//유형
	//$.fn.ifvmSetSelectOptionCommCode("prodType", "LOY_PROD_TYPE", null, null, true);

	//정액/정률 구분
	$.fn.ifvmSetSelectOptionCommCode("acrlType", "LOY_ACRL_TYPE", null, null, true);

/* 	//area 설정

	//패키지포인트
	if (_promSubType == "P008") {
		var _packType = $("#packType").val();
		$("#prodType").val(_packType);
	}
	else {
		$("#prodType").removeAttr("disabled");
	} */
    //캠페인 정보의 대상상품유형
/*     var strRuleProdType = getRuleProdType();

    if ($.fn.ifvmIsNotEmpty(strRuleProdType) == true) {
        $('#prodType').val(strRuleProdType);
        $('#prodType').attr('disabled', true);

        setProdType();

        targetProductInfoPopValidation = $("#targetProductInfoPop").ifvValidation();
    }
    // 상품 유형이 없을 때
    else {
        alert("<spring:message code='L00524'/>");

        targetProductInfoPopupClose();
        return false ;
    } */
}

function initTargetProductInfoPopData(data) {
	//$("#targetProductInfoPop #prodType").val(data.prodType);
	setProdType();
	$("#targetProductInfoPop #acrlType").val(data.acrlType);
	$("#targetProductInfoPop #acrlTypeNm").val(data.acrlTypeNm);
	$("#targetProductInfoPop #minSalesAmt").val(data.minSalesAmt);
	$("#targetProductInfoPop #promoId").val(data.promoId);
	$("#targetProductInfoPop #acrlAmt").val(data.acrlAmt);
	$("#targetProductInfoPop #prodCate").val(data.prodCate);
	$("#targetProductInfoPop #prodCd").val(data.prodCd);
	$("#targetProductInfoPop #brdId").val(data.brdId);
	$("#targetProductInfoPop #brdNm").val(data.brdNm);
	$("#targetProductInfoPop #prodNm").val(data.prodNm);
}

//브랜드 목록 팝업 열기
function loyBrandListPopupOpen() {
    $("#loyBrandListPopup").ifvsfPopup({
        enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyBrandListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00211'/>",
        width: '600px',
        close : 'loyBrandListPopupClose'
    });
}

//브랜드 선택
function loyBrandListPopupSelect() {
    if ($.fn.ifvmIsNotEmpty(loyBrandListPopGrid.getCheckedList())) {

        var selData = loyBrandListPopGrid.getCheckedList()[0];

        $("#targetProductInfoPop #brdId").val(selData.brdId); //브랜드 ID
        $("#targetProductInfoPop #brdNm").val(selData.brdNm); //브랜드 ID

        //close popup
        loyBrandListPopupClose();
    }
    else {
        alert("<spring:message code='L00212'/>");
        return false;
    }
}

//브랜드 팝업 닫기
function loyBrandListPopupClose() {
    loyBrandListPopup._destroy();
}

//상품 목록 팝업 열기
function loyProdListPopupOpen() {
    $("#loyProdListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyProdListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00209'/>",
        width: '600px',
        close : 'loyProdListPopupClose'
    });
}

//상품 목록 팝업 선택
function loyProdListPopupSelect() {

	if ($.fn.ifvmIsNotEmpty(loyProdListPopGrid.getCheckedList())) {

		var selData = loyProdListPopGrid.getCheckedList()[0];
		$("#targetProductInfoPop #prodCd").val(selData.prodId);	//상품코드
		$("#targetProductInfoPop #prodCate").val(selData.catId);	//카테고리
		$("#targetProductInfoPop #brdId").val(selData.brdId);	    //브랜드ID
		$("#targetProductInfoPop #prodNm").val(selData.prodNm);	//상품코드
		//close popup
		loyProdListPopupClose();
	}
	else {
		alert("<spring:message code='L00210'/>");
		return false;
	}
}

//상품 목록 팝업 닫기
function loyProdListPopupClose() {
	loyProdListPopup._destroy();
}

//카테고리 목록 팝업 열기
function loyProdCategoryListPopupOpen() {
    $("#loyProdCategoryListPopup").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="loyProdCategoryListPop"/>',
        contentType: "ajax",
        title: "<spring:message code='L00211'/>",
        width: '600px',
        close : 'loyProdCategoryListPopupClose'
    });
}

//카테고리 목록 팝업 선택
function loyProdCategoryListPopupSelect() {
	if ($.fn.ifvmIsNotEmpty(loyProdCategoryListPopGrid.getCheckedList())) {
		var selData = loyProdCategoryListPopGrid.getCheckedList()[0];

		$("#prodCate").val(selData.catId);	//상품코드

		//close popup
		loyProdCategoryListPopupClose();
	}
	else {
		alert("<spring:message code='L00212'/>");
		return false;
	}
}

//카테고리 목록 팝업 닫기
function loyProdCategoryListPopupClose() {
	loyProdCategoryListPopup._destroy();
}

//유형에 따른 설정
function setProdType() {
	var _prodType = $("#prodType").val();

	$("#targetProductInfoPop #prodCate").val("");
	$("#targetProductInfoPop #prodCd").val("");
	$("#targetProductInfoPop #brdId").val("");

	//브랜드별
	/* if (_prodType == "BRAND") {
        $("#targetProductInfoPop #brandArea").show();
        $("#targetProductInfoPop #categoryArea").hide();
        $("#targetProductInfoPop #modelArea").hide();

        $("#targetProductInfoPop #loyBrandListPopupBtn").show();
        $("#targetProductInfoPop #loyProdCategoryListPopupBtn").hide();

        $("#targetProductInfoPop #prodCate").removeAttr("required");
        $("#targetProductInfoPop #prodCd").removeAttr("required");
        $("#targetProductInfoPop #brdId").attr("required", "true");
	} */

	//모델별 - 제품별
	/* else if (_prodType == "MODE_DI") {
        $("#targetProductInfoPop #brandArea").show();
        $("#targetProductInfoPop #categoryArea").show();
		$("#targetProductInfoPop #modelArea").show();

		$("#targetProductInfoPop #loyBrandListPopupBtn").hide();
		$("#targetProductInfoPop #loyProdCategoryListPopupBtn").hide();

        $("#targetProductInfoPop #prodCate").attr("required", "true");
		$("#targetProductInfoPop #prodCd").attr("required", "true");
        $("#targetProductInfoPop #brdId").attr("required", "true");
	} */
    //상품군 - 카테고리
    /* else if (_prodType == "PROD_GP") {
        $("#targetProductInfoPop #brandArea").hide();
        $("#targetProductInfoPop #categoryArea").show();
        $("#targetProductInfoPop #modelArea").hide();

        $("#targetProductInfoPop #loyBrandListPopupBtn").hide();
        $("#targetProductInfoPop #loyProdCategoryListPopupBtn").show();

        $("#targetProductInfoPop #prodCate").attr("required", "true");
        $("#targetProductInfoPop #prodCd").removeAttr("required");
        $("#targetProductInfoPop #brdId").removeAttr("required");
    }
 */



	targetProductInfoPopValidation = $("#targetProductInfoPop").ifvValidation();
}

function getNumber(obj){
    var num01;
    var num02;
    num01 = obj.value;
    num02 = num01.replace(/\D/g,""); //숫자가 아닌것을 제거, 
                                     //즉 [0-9]를 제외한 문자 제거; /[^0-9]/g 와 같은 표현
    num01 = setComma(num02); //콤마 찍기
    obj.value =  num01;
}

function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환         
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }         
    return n;
}

//천단위 구분자 설정
function setThousandSeparator() {
   //천단위 구분자 넣을 요소 아이디 배열
   var targets = ['minSalesAmt'];
   
   $.each(targets, function(i,e) {
      $('#'+e).on('change', function() {
         getNumber(this);
      });
      $('#'+e).on('keyup', function() {
         getNumber(this);
      });
   });
}

 $(document).ready(function() {
	initTargetProductInfoPop();
	
	setThousandSeparator();
	
	//등록 클릭시
    $('#targetProductInfoPopSaveBtn').on('click', function() {
    	targetProductInfoPopupSave();
    });

    //닫기 클릭시
    $('#targetProductInfoPopCancelBtn').on('click', function() {
    	targetProductInfoPopupClose();
    });

	//유형
	$("[name='prodType']").on('change', function() {
		setProdType();
    });

    //브랜드 목록 팝업
    $('#loyBrandListPopupBtn').on('click', function() {
        loyBrandListPopupOpen();
    });

    //상품 목록 팝업
    $('#loyProdListPopupBtn').on('click', function() {
    	loyProdListPopupOpen();
    });

    //카테고리 목록 팝업
    $('#loyProdCategoryListPopupBtn').on('click', function() {
    	loyProdCategoryListPopupOpen();
    });

    $("input[val-opt=decimalComma]").keyup(function() {
        $(this).val($.fn.ifvmDecimalWithCommas(this.value));
    });
});
</script>

<div id="targetProductInfoPopWrap">
	<div class="pop_inner_wrap form-horizontal" id="targetProductInfoPop" >
		<div class="row qt_border">
           <%--  <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00213'/></label>
            <div class="col-xs-9 control_content">
                <ifvm:input type="select" required="true" disabled="true" id="prodType" names="prodType" />
            </div> --%>
        <!-- 상품 프로모션 코드 -->
         <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L02443'/></label>
            <div class="col-xs-5 control_content">
                <ifvm:input type="text" disabled="true" id="promoId" names="promoId" />
            </div>
            <span class="detail_txt">(저장시 자동 생성됩니다)</span>
        </div> 
        <!-- 정액/정률 구분 -->
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00214'/></label>
            <div class="col-xs-5 control_content">
                <ifvm:input type="select" required="true" id="acrlType" names="acrlType" />
            </div>
        </div>
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00215'/></label>
            <div class="col-xs-5 control_content">
                <%-- <ifvm:input type="text" valOpt="decimalComma" required="true" id="acrlAmt" names="acrlAmt" maxLength="8" /> --%>
                <ifvm:input type="number"   className="text-right" required="true" id="acrlAmt" names="acrlAmt"  maxLength="8"/>
            </div>
        </div>
        <!-- 적용 최소금액  -->
        <div class="row qt_border">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L02444'/></label>
            <div class="col-xs-5 control_content">
                <ifvm:input type="text"   className="text-right" required="true" id="minSalesAmt" names="minSalesAmt"  maxLength="8"/>
            </div>
            <span class="detail_txt">(부터 적용)</span>
        </div>
        <%-- 브랜드 --%>
        <%-- <div class="row qt_border" id="brandArea">
            <label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='M00365'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" id="brdId" names="brdId" readonly="true" required="true"/>
                    <ifvm:input type="hidden"  id="brdNm" names="brdNm" />
                    <span class="input-group-addon" id="loyBrandListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span>
                </div>
            </div>
        </div> --%>
        <%-- 카테고리 --%>
		<%-- <div class="row qt_border" id="categoryArea">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00216'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="prodCate" names="prodCate" />
                    <span class="input-group-addon" id="loyProdCategoryListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span>
                </div>
            </div>
		</div> --%>
        <%-- 제품 --%>
		<%-- <div class="row qt_border" id="modelArea">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span><spring:message code='L00217'/></label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="text" readonly="true" required="true" id="prodCd" names="prodCd" />
                    <ifvm:input type="hidden"  id="prodNm" names="prodNm" />
                    <span class="input-group-addon" id="loyProdListPopupBtn">
                        <a><i class="fa fa-search"></i></a>
                    </span>
                </div>
            </div>
		</div> --%>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm btn_gray" id="targetProductInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        저장
	    </button>
	    <button class="btn btn-sm btn_lightGray2" id="targetProductInfoPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>
</div>
<div id="loyBrandListPopup"></div>
<div id="loyProdListPopup"></div>
<div id="loyProdCategoryListPopup"></div>