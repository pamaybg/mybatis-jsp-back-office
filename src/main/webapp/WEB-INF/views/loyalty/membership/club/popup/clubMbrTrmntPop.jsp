<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var ridClubMbr;<%--  = '<%= request.getParameter("ridClubMbr") %>'; --%>
var isNew = true;  //신규 여부. 신규: true, 수정 : false
var validation;


function trmntPopSelctBoxSetting(){
	$.fn.ifvmSetSelectOptionCommCode("clubReasCd", "LOY_CLUB_ CNCL_CD", null, null, true);
}






function trmntSaveFn() {

	if(validation.confirm()){
		var v_obj = {};
		v_obj = $("#clubTrmntDiv").getSubmitData();

		v_obj.rid = clubMbrGridList.getCheckedGridData()[0].rid;
		$.ifvSyncPostJSON('<ifvm:action name="trmntLoyClubMbr"/>', v_obj
			, function(result) {
				alert("탈퇴되었습니다.");

				clubMbrGridList.requestData();
				clubMbrPopClose();
			},function(result){

		});
	}
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



$(document).ready(function(){
	trmntPopSelctBoxSetting();

	$("#trmntSaveBtn").click(function(){
		trmntSaveFn();
    });

	$("#trmntCloseBtn").click(function(){
		clubMbrPopClose();
    });

	validation = $("#clubTrmntDiv").ifvValidation();
});

</script>

<!-- 관계 -->
<script id="famlwkRelCdTemp" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>



<div class="well underline form-horizontal" id="clubTrmntDiv" >
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="clubReasCd"  dto="clubReasCd" required="true" names="clubReasCd" label="탈퇴 사유" nuc="true" labelClass="4" conClass="4"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="clubReasEtc" dto="clubReasEtc"  label="사유 상세" nuc="true" labelClass="4" conClass="6"  maxLength="50" />
	</div>
</div>

<div class="pop_btn_area">
	<button id="trmntSaveBtn" class="btn btn-sm btn_gray">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00170" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="trmntCloseBtn"><spring:message code="M00441" /></button>
</div>

