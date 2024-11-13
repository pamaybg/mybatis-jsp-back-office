<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal underline top_well" id="addMbrIntForm">
<br>
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="repMbrNo" names="repMbrNo" label="대표 회원" labelClass="3" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="repCustNm" names="repCustNm" conClass="2" disabled="true"/>	
	</div>
	
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="intMbrNo" names="intMbrNo" label="통합회원" labelClass="3" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="intCustNm" names="intCustNm" conClass="2" required="true" disabled="true"/>
				<span class="input-group-addon" style="padding: 6px;" id="mbrListPopBtn">
					<a><i class="fa fa-search"></i></a>
				</span>
				
	</div>
</div>
<div class="pop_btn_area">
	<!-- 등록 -->
	<button class="btn btn-sm btn_gray" id="btnSave">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L02251"/>
	</button>
	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="addMbrIntPopCancle">
		<spring:message code="L01781"/>
	</button>
</div>

<div id="mbrListPop" class="popup_container"></div>

<script>
var intRidMbr;
function mbrIntInit() {
	$("#repMbrNo").val(mbrNo);
	$("#repCustNm").val(custNm);
}


function mbrListPopup(){
	$("#mbrListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="mbrListPop"/>',
        contentType: "ajax",
        title: '회원 조회',
        width: 900,
        close : 'mbrListClosePop'
	});
}

function mbrListClosePop() {
	mbrListPop._destroy();
}

function saveMbrInt(){
	var validation = $("#addMbrIntForm").ifvValidation();
	//유효성 체크
	if(validation.confirm()){
		var url = '<ifvm:action name="saveMbrInt"/>';
		var varData = null;
		varData = {
				intRidMbr : intRidMbr,
				prevMbrRid : mbr_rid,
				mbrIntCode : mbrIntCode
		};
		$.ifvSyncPostJSON(url, varData
			, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
					addMbrIntClosePop();
					mbrIntListGrid._doAjax();
					mbrDetail();
				}
			}, function(result) {
				if ($.fn.ifvmIsNotEmpty(result.message)) {
					alert(result.message);
					return;
				}
		});
		
	}
}

function tierBnftCancle() {
	addTierBnftClosePop();
}

$(document).ready(function(){
	mbrIntInit();
	
	//닫기
	$("#addMbrIntPopCancle").on("click",function(){
		addMbrIntClosePop();
	});
	
	$("#mbrListPopBtn").click(function(){
		mbrListPopup();
	});
	
	$("#btnSave").click(function(){
		saveMbrInt();
	});
	
});

</script>