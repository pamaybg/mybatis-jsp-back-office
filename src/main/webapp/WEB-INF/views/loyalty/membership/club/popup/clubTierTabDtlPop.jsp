<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
	public String cleanXss(String str){ 
		
		if(str != null){
			str = str.replaceAll("<","&lt;"); 
			str = str.replaceAll(">","&gt;"); 
		}
		return str; 
	}
%>
<script>

var clubTierTabDtlPopValidation;
var ridClubTierDtl = '<%= cleanXss(request.getParameter("rid")) %>';

function clubTierDtlDetailSetting(){
	if(ridClubTierDtl!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getClubTierDtlTabDtl"/>' , {rid : ridClubTierDtl}
		, function(result) {
			$("#clubTierTabDtlPopDiv").dataSetting(result);
		})
	}
}

function clubTierDtlPopValidFn(){
	clubTierTabDtlPopValidation = $("#clubTierTabDtlPopDiv").ifvValidation();
	if(clubTierTabDtlPopValidation.confirm()){
		for(var i=0; i<clubTierDtlGrid.getRowData().length;i++){
			var gridObj = clubTierDtlGrid.getRowData()[i];
			if(ridClubTierDtl != gridObj.rid &&  ( gridObj.catNm ==$("#clubTierTabDtlPopDiv #catNm").val() && gridObj.prodId == $("#clubTierTabDtlPopDiv #prodId").val()) ){
				alert("상품이 중복됩니다");
				return false;
			}
		}
			return true;
	}
	return false;
}


function clubTierTabDtlPopSaveFn(){
	var submitData = {};
	submitData = $("#clubTierTabDtlPopDiv").getSubmitData();
	submitData.ridClubTier = clubTierGrid.getCheckedGridData()[0].rid;
	submitData.rid = ridClubTierDtl;
	if(clubTierDtlPopValidFn()){
		$.ifvSyncPostJSON( ridClubTierDtl=="null" ? '<ifvm:action name="addClubTierDtlTab"/>' : '<ifvm:action name="editClubTierDtlTab"/>',submitData
		, function(result) {
			alert("<spring:message code='M00295'/>");
			clubTierDtlGrid.requestData();
			clubTierTabDtlPopClose();
		});
	}
}

function openCategoryPop(){
	$("#clubCategorySearchHelpPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="clubCategorySearchHelp"/>',
        contentType: "ajax",
        title: "카데고리 찾기",
        width: '700px',
        close : 'clubCategorySearchHelpPopClose'
 	});
}

function clubCategorySearchHelpPopSave(categoryObj){
	$("#clubTierTabDtlPopDiv #catNm").val(categoryObj.catNm);
	$("#clubTierTabDtlPopDiv #ridProdCat").val(categoryObj.rid);
	clubCategorySearchHelpPopClose();

}

function clubCategorySearchHelpPopClose(){
	clubCategorySearchHelpPop._destroy();
}


function openProdPop(){
	 $("#prodSearchHelpPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubProdSearchHelp"/>?catNm='+encodeURI(encodeURIComponent($('#clubTierTabDtlPopDiv #catNm').val())),
	        contentType: "ajax",
	        title: "상품 찾기",
	        width: '700px',
	        close : 'prodSearchHelpPopClose'
	 });
}

function prodSearchHelpPopSave(prodObj){
	$("#clubTierTabDtlPopDiv #prodId").val(prodObj.prodId);
	$("#clubTierTabDtlPopDiv #prodNm").val(prodObj.prodNm);
	$("#clubTierTabDtlPopDiv #ridProd").val(prodObj.rid);
	if(prodObj.ridProdCat!=null){
		$("#clubTierTabDtlPopDiv #ridProdCat").val(prodObj.ridProdCat);
		$("#clubTierTabDtlPopDiv #catNm").val(prodObj.catNm);
	}


	prodSearchHelpPopClose();

}

function prodSearchHelpPopClose(){
	prodSearchHelpPop._destroy();
}




function clubTierTabDtlPopCancelFn(){
	clubTierTabDtlPopClose();
}

$(document).ready(function() {
	clubTierDtlDetailSetting();
});
</script>

	<div class="pop_inner_wrap form-horizontal" id="clubTierTabDtlPopDiv" >
		<div class="row">
			<ifvm:inputNew type="search" id="catNm|btnChnlPop" required="true"
						names="catNm" hidId="ridProdCat" hidDto="ridProdCat" dto="catNm"
						disabled="false" btnFunc="openCategoryPop" label="상품카테고리"  nuc ="true"
						labelClass="3" conClass="6" />

		</div>

		<div class="row">
			<ifvm:inputNew type="search" id="prodId|btnChnlPop"
						names="prodId" hidId="ridProd" hidDto="ridProd" dto="prodId"
						disabled="false" btnFunc="openProdPop" label="상품코드"  nuc ="true"
						labelClass="3" conClass="6" />

		</div>

		<div class="row">
			<ifvm:inputNew type="text" id="prodNm" dto="prodNm"  label="상품명" nuc="true" labelClass="3" conClass="6"  maxLength="50" disabled="true" />
		</div>

	</div>
	<div class="pop_btn_area">
       	<ifvm:inputNew type="button" btnType="save"    text="L00074"  id="clubTierTabDtlPopSaveBtn" btnFunc="clubTierTabDtlPopSaveFn"/>
        <ifvm:inputNew type="button"    text="L00073"  id="clubTierTabDtlPopCancelBtn" btnFunc="clubTierTabDtlPopCancelFn"/>
	</div>


<div id="prodSearchHelpPop" class ="popup_container"></div>
<div id="clubCategorySearchHelpPop" class ="popup_container"></div>
