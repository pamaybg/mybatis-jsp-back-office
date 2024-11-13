<%@page trimDirectiveWhitespaces="true" %>
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
var ridClub = '<%= cleanXss(request.getParameter("rid")) %>';
var isNew = true;  //신규 여부. 신규: true, 수정 : false
var validation;



function clubMbrDuplicateCheck(){

	for(var i=0; i< clubMbrGridList.getRowData().length;i++ ){
		var mbrObj = clubMbrGridList.getRowData()[i];
		if($("#clubMbrPopAddForm #mbrNo").val() == mbrObj.mbrNo){
			return false
		}
	}
	return true;
}

//저장
function saveSubmit(){
	if(!clubMbrDuplicateCheck()){
		alert("이미 가입된 회원입니다.");
		return;
	}
	$.ifvSyncPostJSON(isNew ? '<ifvm:action name="addLoyClubMbr"/>' : '<ifvm:action name="editLoyClubMbr"/>', getObjForSubmit()
	, function(result) {
		alert('<spring:message code="L00127"/>');
		clubMbrGridList.requestData();
		clubMbrPopClose();


	},
	function(result) {
		alert(result.message);
		clubMbrGridList.requestData();
	}

	);
}


/*
submit을 위한 form 데이터 파라미터 세팅
*/
function getObjForSubmit(){
	var v_obj = {};

	if(isNew) { //신규
		v_obj = {
					ridClub     :  ridClub,
					ridMbr      :  $("#ridMbr").val(),
					ridTier     :  $("#clubMbrPopAddForm #ridTier").val()
		};

	}else {  //수정
		v_obj = {
				ridClub     :  ridClub,
				ridMbr      :  $("#ridMbr").val(),
				ridTier     :  $("#clubMbrPopAddForm #ridTier").val()
		};
	}

	return v_obj;

}

//저장 버튼클릭 시 동작
function actionSave() {

	if(validation.confirm())  saveSubmit();
}






function mbrSearchHelpPopFn(){

	$("#mbrSearchHelpPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrSearchHelp"/>',
        contentType: "ajax",
        width: 600,
        title: '회원 찾기',

		close : function(obj) {
			if(typeof obj.event !="undefined"){
				$("#mbrNo").val(obj.event.mbrNo);
				$("#mbrNm").val(obj.event.custNm);
				$("#ridMbr").val(obj.event.rid);
			}
			mbrSearchHelpPop._destroy();
		}

    });
}

function clubMbrPopTierSetting(){
	$("#clubMbrPopAddForm #tierNm").val($("#clubForm #ridBasicTier option:selected").text());
	$("#clubMbrPopAddForm #ridTier").val($("#clubForm #ridBasicTier option:selected").val());
}



$(document).ready(function(){

	$("#btnAddInfoSave").click(function(){
		actionSave();
    });

	$("#btnAddInfoClosePop").click(function(){
		clubMbrPopClose();
    });

	validation = $("#clubMbrPopAddForm").ifvValidation();

	clubMbrPopTierSetting();


});

</script>

<!-- 관계 -->
<script id="famlwkRelCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>



<div class="well underline form-horizontal" id="clubMbrPopAddForm" >
	<div class="row qt_border">
		<ifvm:inputNew type="search" id="mbrNo|mbrSearchHelpPopBtn" required="true"
						names="mbrNo" hidId="ridMbr" hidDto="ridMbr" dto="mbrNo"
						disabled="true" btnFunc="mbrSearchHelpPopFn" label="회원번호"  nuc ="true"
						labelClass="4" conClass="6" />
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="mbrNm" disabled="true" dto="mbrNm" required="true" label="회원명" nuc="true" labelClass="4" conClass="6"  maxLength="50" />
	</div>

	<div class="row qt_border">
		<ifvm:inputNew type="text" id="tierNm" disabled="true" dto="tierNm" required="true" label="등급명" nuc="true" labelClass="4" conClass="6"  maxLength="50" />
		<ifvm:inputNew type="hidden" id="ridTier" dto="ridTier" />
	</div>
</div>

<div class="pop_btn_area">
	<button id="btnAddInfoSave" class="btn btn-sm btn_gray">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00170" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnAddInfoClosePop"><spring:message code="M00441" /></button>
</div>

<div id="mbrSearchHelpPop" class="popup_container content_container"></div>
