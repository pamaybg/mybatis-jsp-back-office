<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal underline top_well underline" id="FmlyDetailForm">
<br>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="fmlyNm" names="fmlyNm" dto="fmlyNm" label="패밀리명" labelClass="2" conClass="8" required="true" placeholder="예) 회원명 + 패밀리"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="search" id="custNm" names="custNm" dto="custNm" label="대표회원명" btnFunc="searchChiefMbr" labelClass="2" conClass="8" disabled="true" required="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="mbrNo" names="mbrNo" dto="mbrNo" label="회원번호" labelClass="2" conClass="3" disabled="true" required="true"/>
		<ifvm:inputNew type="text" id="pgmNm" names="pgmNm" dto="pgmNm" label="프로그램" labelClass="2" conClass="3" disabled="true" required="true"/>
		<ifvm:inputNew type="hidden" id="ridPgm" names="ridPgm" dto="ridPgm" conClass="3" disabled="true" required="true"/>
	</div>
	<%-- <div class="row qt_border">
		<ifvm:inputNew type="text" id="createBy" names="createBy" dto="createBy" label="생성자" labelClass="2" conClass="3" disabled="true" required="true"/>
		<ifvm:inputNew type="date" id="applDate" names="applDate" dto="applDate" label="신청일" labelClass="2" conClass="3" disabled="true" required="true"/>
	</div> --%>
	<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="addNewFmlyBtn" objCode="addNewFmly_OBJ">
		<spring:message code="M01855" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="closePopBtn" objCode="closeNewFmly_OBJ">
		<spring:message code="M01856" />
	</button>
</div>
<div id="mbrPopupContainer" class="popup_container"></div>
<script type="text/javascript">

function saveFmlyDetail(){
	var validation = $('#FmlyDetailForm').ifvValidation();
	if(validation.confirm()) {
		$.ifvSyncPostJSON('<ifvm:action name="saveNewFmly"/>',{
			repMbrNo : $("#mbrNo").val(),
			fmlyNm : $("#fmlyNm").val()
		},function(result){
			if(result.message) alert(result.message);
			else alert("패밀리 가입이 완료 되었습니다.");
			addFmlyPopupContainer._destroy();
			familyList._doAjax();
		},function(result){
			if(result.message) alert(result.message);
			else alert("패밀리 가입 실패");
		})
	}
}

function searchChiefMbr(){
	$("#mbrPopupContainer").ifvsfPopup({
        enableModal : true,
        enableResize : true,
        contentUrl : '<ifvm:url name="chiefMbrListPop"/>',
        contentType : "ajax",
        title : "<spring:message code="대표회원조회"/>",
        width : '1100px',
        close : 'searchChiefMbrPopupClose',
     });
}


function searchChiefMbrPopupClose(){
	mbrPopupContainer._destroy();
}

$(document).ready(function(){
	
	$("#addNewFmlyBtn").click(function(){
		saveFmlyDetail();
	});
	
	$("#closePopBtn").click(function(){
		addFmlyPopupContainer._destroy();
	});
	
});
</script>