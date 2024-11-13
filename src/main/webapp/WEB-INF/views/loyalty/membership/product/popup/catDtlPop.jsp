<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var catChk = true;
var oldCatId = null;
var catDataArr = null;
var parRid = null;
var oldParRid = null;

function catPopupClose() {
	catPopDialog._destroy();

	if($.fn.ifvmIsEmpty(catDataArr) == false){
		parRid = catDataArr[0].rid;
		$("#parCatId").val(catDataArr[0].catId);
		$("#parCatNm").val(catDataArr[0].catNm);
	}
}

//등급목록 조회
function getCatDtl(){
	$.ifvSyncPostJSON('<ifvm:action name="getCategoryDtl"/>',{ rid : rid , catId : catId }
	,function(result) {
		$("#parCatId").val(result.parCatId);
		$("#parCatNm").val(result.parCatNm);
		$("#categoryId").val(result.catId);
		$("#categoryNm").val(result.catNm);
		$("#catDesctxt").val(result.catDesctxt);
		rid = result.rid;
		oldParRid = result.parRid;
		oldCatId = result.catId;

	});
}

//등급목록 수정
 function modifyCatDtl(){
	var obj = {};
	var value = false;
	catChk = true;
	validation = $("#catDtlPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.rid = rid;
		obj.parRid = parRid==null?oldParRid:parRid;
		obj.catId = $("#categoryId").val();
		obj.catNm = $("#categoryNm").val();
		obj.catDesctxt = $("#catDesctxt").val();
		if(oldCatId != $("#categoryId").val()){
			$.ifvSyncPostJSON('<ifvm:action name="getCategoryChk"/>',obj
			,function(result) {
				if(result.cnt > 0) catChk = false;
			});
		}
		if(catChk){
			$.ifvSyncPostJSON('<ifvm:action name="editCategoryDtl"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				getCategoryList();
				categoryPopupClose();
			});
		}else{
			alert('<spring:message code="M01958" />');
			return;
		}
	}
}

//등급목록 저장
 function setCatDtl(){
	var obj = {};
	var value = false;
	catChk = true;
	validation = $("#catDtlPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.parRid = parRid;
		obj.catId = $("#categoryId").val();
		obj.catNm = $("#categoryNm").val();
		obj.catDesctxt = $("#catDesctxt").val();
		$.ifvSyncPostJSON('<ifvm:action name="getCategoryChk"/>',obj
		,function(result) {
			if(result.cnt > 0) catChk = false;
		});
		if(catChk){
			$.ifvSyncPostJSON('<ifvm:action name="setCategoryDtl"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				getCategoryList();
				categoryPopupClose();
			});
		}else{
			alert('<spring:message code="M01958" />');
			return;
		}
	}
}

function searchParCategory(){
	$("#catPopDialog").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="categoryPop"/>',
        contentType: "ajax",
        title: '<spring:message code="상위 카테고리 조회" />',
        width: '800px',
        close : 'catPopupClose'
    });
}

$(document).ready(function(){
	$("#catDtlPopFormArea").ifvValidation();

	// 등급상세 조회
	if(rid != null) getCatDtl();

	// 취소 버튼
	$("#catDtlPopCancel").on("click", categoryPopupClose);

	// 저장 버튼
 	$("#catDtlSaveBtn").on("click", function(){
		if(rid != null) modifyCatDtl();
		else setCatDtl();
	});

});
</script>

<div id='catDtlPopFormArea'>
	<div class="form-horizontal">
	    <div class="row qt_border">
	            <ifvm:inputNew type="search" id="parCatId" readonly="true" btnFunc="searchParCategory" label="M01960" labelClass="2" conClass="4"/>
	            <ifvm:inputNew type="text" id="parCatNm" readonly="true" label="M01961" labelClass="2" conClass="4"/>
	    </div>
	    <div class="row qt_border">
	            <ifvm:inputNew type="text" id="categoryId" maxLength="60" required="true" label="M01962" labelClass="2" conClass="4"/>
	            <ifvm:inputNew type="text" id="categoryNm" maxLength="60" required="true" label="M01963" labelClass="2" conClass="4"/>
	    </div>
	    <div class="row">
	            <ifvm:inputNew type="textarea" id="catDesctxt" label="M01964" labelClass="2" conClass="10"/>
	    </div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="catDtlSaveBtn" objCode="catDtlSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="catDtlPopCancel" objCode="catDtlPopCancel_OBJ">
		<spring:message code="M00284"/>
	</button>
</div>
<div id="catPopDialog" class="popup_container"></div>