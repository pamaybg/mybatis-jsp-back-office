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

var clubJoinCondInfoPopValidation;
var ridClubJoinCond = '<%= cleanXss(request.getParameter("rid")) %>';

function clubJoinCondDetailSetting(){
	if(ridClubJoinCond!="null"){
		$.ifvSyncPostJSON('<ifvm:action name="getClubJoinCondTabDtl"/>' , {rid : ridClubJoinCond}
		, function(result) {
			$("#clubJoinCondInfoPopDiv").dataSetting(result);
		})
	}
}

function clubJoinCondPopValidFn(){
	clubJoinCondInfoPopValidation = $("#clubJoinCondInfoPopDiv").ifvValidation();
	if(clubJoinCondInfoPopValidation.confirm()){
		for(var i=0; i<clubJoinCondGrid.getRowData().length;i++){
			var gridObj = clubJoinCondGrid.getRowData()[i];
			if(ridClubJoinCond != gridObj.rid && ( gridObj.catNm ==$("#clubJoinCondInfoPopDiv #catNm").val() && gridObj.prodId == $("#clubJoinCondInfoPopDiv #prodId").val())  ){
				alert("상품이 중복됩니다");
				return false;
			}
		}
			return true;
	}
	return false;
}


function clubJoinCondInfoPopSaveFn(){
	var submitData = {};
	submitData = $("#clubJoinCondInfoPopDiv").getSubmitData();
	submitData.ridClub = clubTypeRid;
	submitData.rid = ridClubJoinCond;
	if(clubJoinCondPopValidFn()){
		$.ifvSyncPostJSON( ridClubJoinCond=="null" ? '<ifvm:action name="addClubJoinCondTab"/>' : '<ifvm:action name="editClubJoinCondTab"/>',submitData
		, function(result) {
			alert("<spring:message code='M00295'/>");
			clubJoinCondGrid.requestData();
			clubJoinCondPopClose();
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
	$("#clubJoinCondInfoPopDiv #catNm").val(categoryObj.catNm);
	$("#clubJoinCondInfoPopDiv #ridProdCat").val(categoryObj.rid);
	clubCategorySearchHelpPopClose();

}

function clubCategorySearchHelpPopClose(){
	clubCategorySearchHelpPop._destroy();
}


function openProdPop(){
	 $("#prodSearchHelpPop").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="clubProdSearchHelp"/>?catNm='+encodeURI(encodeURIComponent($('#clubJoinCondInfoPopDiv #catNm').val())),
	        contentType: "ajax",
	        title: "상품 찾기",
	        width: '700px',
	        close : 'prodSearchHelpPopClose'
	 });
}

function prodSearchHelpPopSave(prodObj){
	$("#clubJoinCondInfoPopDiv #prodId").val(prodObj.prodId);
	$("#clubJoinCondInfoPopDiv #prodNm").val(prodObj.prodNm);
	$("#clubJoinCondInfoPopDiv #ridProd").val(prodObj.rid);
	if(prodObj.ridProdCat!=null){
		$("#clubJoinCondInfoPopDiv #ridProdCat").val(prodObj.ridProdCat);
		$("#clubJoinCondInfoPopDiv #catNm").val(prodObj.catNm);
	}


	prodSearchHelpPopClose();

}

function prodSearchHelpPopClose(){
	prodSearchHelpPop._destroy();
}




function clubJoinCondInfoPopCancelFn(){
	clubJoinCondPopClose();
}

$(document).ready(function() {
	clubJoinCondDetailSetting();
});
</script>

	<div class="pop_inner_wrap form-horizontal" id="clubJoinCondInfoPopDiv" >
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
       	<ifvm:inputNew type="button" btnType="save"    text="L00074"  id="clubJoinCondInfoPopSaveBtn" btnFunc="clubJoinCondInfoPopSaveFn"/>
        <ifvm:inputNew type="button"    text="L00073"  id="clubJoinCondInfoPopCancelBtn" btnFunc="clubJoinCondInfoPopCancelFn"/>
	</div>


<div id="prodSearchHelpPop" class ="popup_container"></div>
<div id="clubCategorySearchHelpPop" class ="popup_container"></div>
