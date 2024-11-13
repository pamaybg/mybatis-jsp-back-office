<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var oldProdId = null;
var prodChk = true;
var brdDataArr;
var catDataArr;
var popSelectlId = "chnlNm";


//등급목록 조회
function getProdDtl(rid){
	$.ifvSyncPostJSON('<ifvm:action name="getProdDtl"/>',{rid : rid }
	,function(result) {
		/* $("#brdNm").val(result.brdNm);
		$("#brdNm").text(result.ridBrdCat); */
		
		$("#catNm").val(result.catNm);
		$("#catNm").text(result.ridProdCat);
		$("#chnlNm").val(result.chnlNm);
		$("#chnlNm").text(result.ridChnl);
		$("#chnlRid").val(result.ridChnl);
		$("#prodId").val(result.prodId);
		$("#prodNm").val(result.prodNm);
		$("#prodColor").val(result.color);
		$("#prodCreateBy").val(result.createBy);
		$("#prodCreateDate").val(result.createDate);
		if(result.prodAmt == null) $("#prodAmt").val(0);
		else $("#prodAmt").val(setComma(result.prodAmt));
		$.fn.ifvmSetSelectOptionCommCode("prodType", "LOY_PROD_TYPE", result.prodTypeCd, null, true );
		rid = result.rid;
		oldProdId = result.prodId;

	});
}

//등급목록 수정
 function modifyProdDtl(){
	var obj = {};
	var value = false;
	prodChk = true;
	validation = $("#prodDtlPopFormArea").ifvValidation();
	if(validation.confirm()){
		obj.rid = rid;
		/* obj.ridBrdCat = $("#brdNm").text(); */
		obj.ridProdCat = $("#catNm").text();
		obj.ridChnl = $("#chnlRid").val();
		obj.prodId = $("#prodId").val();
		obj.prodNm = $("#prodNm").val();
		obj.prodType = $("#prodType").val();
		obj.prodColor = $("#prodColor").val();
		obj.prodAmt = parseInt(($("#prodAmt").val()).replace(/,/g,""));
		if(oldProdId != $("#prodId").val()){
			$.ifvSyncPostJSON('<ifvm:action name="getProdChk"/>',obj
			,function(result) {
				if(result.cnt > 0) prodChk = false;
			});
		}
		if(prodChk){
			$.ifvSyncPostJSON('<ifvm:action name="editProdDtl"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				prodDialog._destroy();
				qtjs.href('<ifvm:url name="prodListNew"/>');
				//getProdList();
			});
		}else{
			alert('<spring:message code="M01965" />');
			return;
		}
	}
}

//등급목록 저장
 function setProdDtl(){
	var obj = {};
	var value = false;
	prodChk = true;
	validation = $("#prodDtlPopFormArea").ifvValidation();
	if(validation.confirm()){
		/* obj.ridBrdCat = $("#brdNm").text(); */
		
		obj.ridProdCat = $("#catNm").text();
		obj.ridChnl = $("#chnlRid").val();
		obj.prodId = $("#prodId").val();
		obj.prodNm = $("#prodNm").val();
		obj.prodType = $("#prodType").val();
		obj.prodColor = $("#prodColor").val();
		obj.prodAmt = parseInt(($("#prodAmt").val()).replace(/,/g,""));
		$.ifvSyncPostJSON('<ifvm:action name="getProdChk"/>',obj
		,function(result) {
			if(result.cnt > 0) prodChk = false;
		});
		if(prodChk){
			$.ifvSyncPostJSON('<ifvm:action name="setProdDtl"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				prodDialog._destroy();
				qtjs.href('<ifvm:url name="prodListNew"/>');
				//getProdList();
			});
		}else{
			alert('<spring:message code="M01965" />');
			return;
		}
	}
}

function setComma(n) {
     var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
     n += '';                          // 숫자를 문자열로 변환
     while (reg.test(n)) {
        n = n.replace(reg, '$1' + ',' + '$2');
     }
     return n;
}

//공통 조회 조건 목록 설정
function prodDtlListSearchInit() {
	$.fn.ifvmSetSelectOptionCommCode("prodType", "LOY_PROD_TYPE", null, null, true );
}

function getCategoryPop(){
	$("#categoryDtlDialog").ifvsfPopup({
		enableModal : true,
        enableResize: true,
        contentUrl: '<ifvm:url name="categoryPop"/>',
        contentType: "ajax",
        title: '<spring:message code="M01959" />',
        width: '700px',
        close : 'catPopupClose'
    });
}
function catPopupClose(){
	categoryDtlDialog._destroy();
	
	if($.fn.ifvmIsNotEmpty(catDataArr)){
		$("#catNm").text(catDataArr[0].rid);
		$("#catNm").val(catDataArr[0].catNm);
	}
}



function getChannelPop(){
	$("#chnlPopupContainer").ifvsfPopup({
		enableModal : true,
        enableResize: true,
        contentUrl: '<ifvm:url name="chnlListPop"/>',
        contentType: "ajax",
        title: '<spring:message code="L00075"/>',
        width: '700px',
        close : 'chnlPopupClose'
    });
}

function chnlPopupClose(){
	chnlPopupContainer._destroy();
}


$(document).ready(function(){
	$("#prodDtlPopFormArea").ifvValidation();
	
	// 공통코드 조회
	prodDtlListSearchInit()
	
	// 등급상세 조회
	if(rid != null) getProdDtl(rid);

	// 취소 버튼
	$("#prodDtlPopCancel").on("click", function(){
		prodDialog._destroy();
	});

	// 저장 버튼
 	$("#prodDtlSaveBtn").on("click", function(){
		if(rid != null) modifyProdDtl();
		else setProdDtl();
	});
	
 	$("#prodAmt").ifvNumberOnly()

	/* $('#brdBtn').on('click', function(){
		$("#prodDtlDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="brandPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00296"/>',
	        width: '700px',
	        close : 'brdPopupClose'
	    });
	});*/

/* 	$('#catBtn').on('click', function(){
		$("#prodDtlDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="categoryPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01959" />',
	        width: '700px',
	        close : 'catPopupClose'
	    });
	}); */

	/* $('#chnlBtn').on('click', function(){
		$("#prodDtlDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="chnlPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00075"/>',
	        width: '700px',
	        close : 'popupClose'
	    });
	}); */

});
</script>

<div id='prodDtlPopFormArea'>
	<div class="pop_inner_wrap form-horizontal">
	<br>
	    <div class="row qt_border">
	       	<label class="col-xs-2 "><spring:message code="상품 카테고리" /></label>
	        <div class="col-xs-4 control_content">
		        <div class="input-group">
		            <ifvm:inputNew type="search" id="catNm" readonly="true" btnFunc="getCategoryPop"/>
				</div>
	        </div>
			<label class="col-xs-2 "><span class="asterisk">*</span><spring:message code="L00129"/></label>
	        <div class="col-xs-4 control_content">
	            <div class="input-group">
		            <ifvm:inputNew type="search" id="chnlNm"  required="true" btnFunc="getChannelPop"/>
		             <ifvm:inputNew type="hidden" id="chnlRid" conClass="2"/>
				</div>
	        </div>

	        <%-- <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00164"/></label>
	        <div class="col-xs-4 control_content">
	            <div class="input-group">
		            <ifvm:input type="text" id="brdNm" readonly="true" required="true"/>
					<span class="input-group-addon" id="brdBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
				</div>
	        </div> --%>
	    </div>

	    <div class="row qt_border">
	    	<label class="col-xs-2 "><spring:message code="L00293"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="text" id="prodNm" maxLength="60"/>
	        </div>
	        <label class="col-xs-2 "><span class="asterisk">*</span><spring:message code="M01968" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="text" id="prodId" maxLength="60" required="true"/>
	        </div>
	    </div>
	    
	    <div class="row qt_border">
	        <label class="col-xs-2 ">비고</label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="text" id="prodColor" maxLength="9" />
	        </div>
	        <label class="col-xs-2 "><spring:message code="L02455"/></label>
			<div class="col-xs-4 control_content">
	            <ifvm:inputNew type="select" id="prodType" names="prodType" dto="prodType" />
	        </div>
	    </div>
	   	<div class="row">
	    	<label class="col-xs-2 ">상품 금액</label>
	        <div class="col-xs-10 control_content">
	            <ifvm:inputNew type="text" id="prodAmt" maxLength="12" />
	        </div>
	    </div>
	    <div class="row">
	        <label class="col-xs-2 "><spring:message code="M01131"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="text" id="prodCreateBy" disabled="true" />
	        </div>
	        
	        <label class="col-xs-2 "><spring:message code="M01132"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:inputNew type="text" id="prodCreateDate" disabled="true" />
	        </div>
	    </div>
	</div>
</div>
<br>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="prodDtlSaveBtn" objCode="prodDtlSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="prodDtlPopCancel" objCode="prodDtlPopCancel_OBJ">
		<spring:message code="M00284"/>
	</button>
</div>
<div id="chnlPopupContainer" class="popup_container"></div>
<div id="categoryDtlDialog" class="popup_container"></div>
