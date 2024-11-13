<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal underline top_well underline" id="newFmlyForm">
<br>
	<div class="row qt_border">
		<ifvm:inputNew type="search" id="custNmF" names="custNmF" dto="custNmF" btnFunc="searchMbrPop" label="L00798" labelClass="2" conClass="3" disabled="true" required="true"/>
		<ifvm:inputNew type="text" id="mbrNoF" names="mbrNoF" dto="mbrNoF" label="회원번호" labelClass="2" conClass="3" disabled="true" required="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="relCd" names="relCd" label="L00486" labelClass="2" conClass="8" required="true"/>
		<ifvm:inputNew type="hidden" id="loyPgmRid" names="loyPgmRid" conClass="3" required="true"/>
	</div>
	<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="addNewFmly" objCode="addNewFmlyMbrPop_OBJ">
		<spring:message code="M01855" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="closePopBtn" objCode="closeNewFmlyMbrPop_OBJ">
		<spring:message code="M01856" />
	</button>
</div>
<div id="mbrPopupContainer" class="popup_container"></div>
<script type="text/javascript">
var validation;

function init(){
	var p = pgmRid;
	if(!$.fn.ifvmIsNotEmpty(p)){
		alert('<spring:message code="등록된 프로그램이 없습니다."/>')
	}
	$.fn.ifvmSetSelectOptionCommCode("relCd", "LOY_FAML_REL_CD", null, null, true);
	$("#loyPgmRid").val(p);
}

function searchMbrPop(){
	 $("#mbrPopupContainer").ifvsfPopup({
	        enableModal : true,
	        enableResize : false,
	        contentUrl : '<ifvm:url name="searchFamilyMbr"/>',
	        contentType : "ajax",
	        title : "<spring:message code="L01673"/>",
	        width : '900px',
	        close : 'mbrPopclose',
	 });
}

function mbrPopclose(){
	mbrPopupContainer._destroy();
}

function saveNewFamily(){
	validation = $("#newFmlyForm").ifvValidation();
	
	if(validation.confirm()){
		$.ifvSyncPostJSON('<ifvm:action name="saveNewFmlyMbr"/>', { 
			mbrNo : $("#mbrNoF").val(), 
			relCd : $("#relCd").val(),
			repMbrNo : $("#mbrNo").val()
		}, function(result){
				if(result.message) alert(result.message);
				else alert("패밀리 구성원 가입이 되었습니다.");
				newFmlyPopupContainer._destroy();
				mbrFamilyList._doAjax();
		}, function(result){
				if(result.message) alert(result.message);
				else alert("패밀리 구성원 가입에 실패하였습니다.");
		});
	}
}

$(document).ready(function(){
	init();

	$("#addNewFmly").click(function(){
		if($("#relCd").val() == '05'){
			alert("대표로 가입할수 없습니다.");
		}else{
			saveNewFamily();
		}
	});
	
	$("#closePopBtn").click(function(){
		newFmlyPopupContainer._destroy();
	});
	
});
</script>
