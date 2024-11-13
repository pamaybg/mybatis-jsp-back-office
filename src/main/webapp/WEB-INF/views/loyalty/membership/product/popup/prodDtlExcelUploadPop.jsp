<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var prodChk = true;
var brdDataArr = null;
var catDataArr = null;
var popSelectlId = "chnlNm";

function popupClose(){
	prodDtlDialog._destroy();
}

function brdPopupClose(){
	prodDtlDialog._destroy();

	if($.fn.ifvmIsNotEmpty(brdDataArr)){
		$("#brdNm").text(brdDataArr[0].rid);
		$("#brdNm").val(brdDataArr[0].brdNm);
	}
}

function catPopupClose(){
	prodDtlDialog._destroy();

	if($.fn.ifvmIsNotEmpty(catDataArr)){
		$("#catNm").text(catDataArr[0].rid);
		$("#catNm").val(catDataArr[0].catNm);
	}
}

//등급목록 저장
 function setProdDtl(){
	var obj = {};
	var value = false;
	prodChk = true;
	validation = $("#prodDtlPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.ridChnl    = $("#chnlNm").text();
		obj.ridProdCat = $("#catNm").text();
		obj.ridBrdCat  = $("#brdNm").text();
		obj.prodType   = $("#prodType").val();
		
		var _obj = {
			url : '<ifvm:action name = "setProdMultiDtl"/>',
			fileName : $("#fileName").val(),
			data : {
				ridChnl    : $("#chnlNm").text(),
				ridProdCat : $("#catNm").text(),
				ridBrdCat  : $("#brdNm").text(),
				prodType   : $("#prodType").val()
				
			},
		};
		
		fnExcelUpload.data.formData ={	
				param : JSON.stringify(_obj)
		}
		
		fnExcelUpload.upload();
		$.ifvProgressControl(false);
	}
	else{
		alert('<spring:message code="M01965" />');
		return;
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

function fileSearchFn() {
	fnExcelUpload(
		{
			url: '<ifvm:action name="setProdMultiDtl"/>',
			fileName: $("#fileName").val(),
			data: {
		},
	}, function (result) {
		alert(result.message);
		if(result.success){
			prodDtlExelUploadPopClose();
		}
	}
	, function (){
		// File 선택 후 동작 할 액션을 정의 한다.
		$('#fileName').val(fnExcelUpload.fileName);
	});
}

/**
 * 파일업로드
 */
function fileUploadFn(){
	fileUploadPop ={
		        id : "excelFileUploadPop"
		    };
	fileUploadPop.popup = function (){
			 fileUploadPop.pop = $('#'+fileUploadPop.id).ifvsfPopup({
		            enableModal: true,
		            enableResize: false,
		            contentUrl: '<ifvm:url name="smsExcelFileUploadPop"/>',
		            contentType: "ajax",
		            title: '파일업로드',
		            width: "700px"
		        });
		};
		fileUploadPop.beforeClose = function (obj) {
		};
		fileUploadPop.close = function (obj) {
		        this.beforeClose(obj);
		        this.pop.data('ejDialog')._destroy();
		 };
		 fileUploadPop.popup();
}

$(document).ready(function(){
	prodDtlListSearchInit();
	
	$("#prodDtlPopFormArea").ifvValidation();
	// 취소 버튼
	$("#prodDtlPopCancel").on("click", prodDtlPopClose);

	// 저장 버튼
 	$("#prodDtlSaveBtn").on("click", function(){
		setProdDtl();
	});

	$('#brdBtn').on('click', function(){
		$("#prodDtlDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="brandPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00296"/>',
	        width: '700px',
	        close : 'brdPopupClose'
	    });
	});

	$('#catBtn').on('click', function(){
		$("#prodDtlDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="categoryPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01959" />',
	        width: '700px',
	        close : 'catPopupClose'
	    });
	});

	$('#chnlBtn').on('click', function(){
		$("#prodDtlDialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="chnlPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="L00075"/>',
	        width: '700px',
	        close : 'popupClose'
	    });
	});
});
</script>

<div id='prodDtlPopFormArea'>
	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	       	<label class="col-xs-2 control-label"><spring:message code="M01966" /></label>
	        <div class="col-xs-4 control_content">
		        <div class="input-group">
		            <ifvm:input type="text" id="catNm" readonly="true"/>
					<span class="input-group-addon" id="catBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
				</div>
	        </div>
	        <label class="col-xs-2 control-label"><span class="asterisk">*</span><spring:message code="L00129"/></label>
	        <div class="col-xs-4 control_content">
	            <div class="input-group">
		            <ifvm:input type="text" id="chnlNm" readonly="true" required="true"/>
					<span class="input-group-addon" id="chnlBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
				</div>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <div class="col-xs-6 control_content">
	            <div class="input-group">
		            <ifvm:inputNew type="select" id="prodType" names="prodType" dto="prodType" label="L02455" labelClass="4" conClass="8"/>
				</div>
	        </div>
	        <div class="col-xs-6 control_content">
	        	<ifvm:inputNew type="text" id="fileName" dto="fileName " label="M01858" labelClass="4" conClass="6" disabled="true"  required="true"/>
	    		<ifvm:inputNew type="button" text="L01671"  id="fileSearchBtn" btnFunc="fileSearchFn"/>
	    	</div>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="prodDtlSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="prodDtlPopCancel">
		<spring:message code="M00284"/>
	</button>
</div>
<div id="prodDtlDialog" class="popup_container"></div>
