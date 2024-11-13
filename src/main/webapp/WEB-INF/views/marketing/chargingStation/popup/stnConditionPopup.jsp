<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var isSearched = false; //회원수 조회 여부

//기간 공통코드 조회
function getCommCodeList1() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'MART_EXT_TERMS'
		, enableNA : false
	}, function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#condExtTerms").append(temp);
	});
}

//주요방문요일 공통코드 조회
function getCommCodeList2() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'MART_MAIN_USE_WEEKDAY'
		, enableNA : true
	}, function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#mainUseWeekday").append(temp);
	});
}

//성별  공통코드 조회
function getCommCodeList3() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'MEMBER_SEX'
		, enableNA : true
	}, function(result) {
		result.rows.push({codeName:"N", markName:"전체"});
		
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#genderCd").append(temp);
	});
}

//생애주기 공통코드 조회
function getCommCodeList4() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'MART_CUST_LIFECYCLE'
		, enableNA : true
	}, function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#segLifeCycleCd").append(temp);
	});
}

//유형 공통코드 조회
function getCommCodeList5() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'MART_CUST_TYPE'
		, enableNA : true
	}, function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#memTypeCd").append(temp);
	});
}


//등급  공통코드 조회
function getCommCodeList6() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'MART_CUST_TIER'
		, enableNA : true
	}, function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#memPhaseCd").append(temp);
	});
}

//연령대 공통코드 조회
function getCommCodeList7() {
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList"/>', {
		groupCode : 'MART_CUST_AGE_RANGE'
		, enableNA : false
	}, function(result) {
		result.rows.push({codeName:"NA", markName:"전체"});
		
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#ageId").append(temp);
	});
}

//조건대상 회원수 추출
function searchMbrCount() {
	
	//회원수 추출 전 캠페인마스터 저장여부 체크
	if(camId == null || camId == '' || camId == 'null') {
		alert('<spring:message code="M00855"/>');
		return false;
	}
	
	//충전량 입력 체크
	if(!($.fn.ifvmIsNotEmpty($("#preFillVolLt").val()))) {
		$.ifvCallValidationBox($("#preFillVolLt"), '<spring:message code="C00024"/>');
		return false;
	}
	
	//방문횟수 입력 체크
	if(!($.fn.ifvmIsNotEmpty($("#preVisitCnt").val()))) {
		$.ifvCallValidationBox($("#preVisitCnt"), '<spring:message code="C00024"/>');
		return false;
	}
	
	var progress1 = $.ifvLoading($("#searchMbrCountBtn"));
	var progress2 = $.ifvLoading($("#conditionSaveBtn"));
	
	var reqObj = {};
	
	reqObj.camId = camId;
	reqObj.chnlNo = chnlNo;
	reqObj.condExtTerms = $("#condExtTerms").val();
	reqObj.preFillVolLt = $("#preFillVolLt").val();
	reqObj.preVisitCnt = $("#preVisitCnt").val();
	reqObj.memPhaseCd = $("#memPhaseCd").val();
	reqObj.memTypeCd = $("#memTypeCd").val();
	reqObj.segLifeCycleCd = $("#segLifeCycleCd").val();
	reqObj.ageId = $("#ageId").val();
	reqObj.genderCd = $("#genderCd").val();
	reqObj.mainUseWeekday = $("#mainUseWeekday").val();
	
	reqObj.condExtTermsMarkName = $("#condExtTerms option:selected").text();
	reqObj.memPhaseCdMarkName = $("#memPhaseCd option:selected").text();
	reqObj.memTypeCdMarkName = $("#memTypeCd option:selected").text();
	reqObj.segLifeCycleCdMarkName = $("#segLifeCycleCd option:selected").text();
	reqObj.ageIdMarkName = $("#ageId option:selected").text();
	reqObj.genderCdMarkName = $("#genderCd option:selected").text();
	reqObj.mainUseWeekdayMarkName = $("#mainUseWeekday option:selected").text();
	
	reqObj.mbrCount = $("#mbrCount").val();
	
	$.ifvPostJSON('<ifvm:action name="getSearchMbrCountByCondition"/>'
	, reqObj
	, function(result) {
		if(result == 'Need to save') {
			alert('<spring:message code="M00855"/>');
		} else {
			$("#mbrCount").val(result);
			$("#mbrCount").text(result);
			
			isSearched = true;
			reqObj.mbrCount = result;
			conditionData = reqObj;
		}
		
		$(progress1).remove();
		$("#searchMbrCountBtn").removeAttr('disabled');
		$(progress2).remove();
		$("#conditionSaveBtn").removeAttr('disabled');
	});
}

//기존 조건 존재 시 팝업 세팅
function initConditionPopup() {
	if(conditionData != null) {
		$("#condExtTerms").val(conditionData.condExtTerms);
		$("#preFillVolLt").val(conditionData.preFillVolLt);
		$("#preVisitCnt").val(conditionData.preVisitCnt);
		$("#memPhaseCd").val(conditionData.memPhaseCd);
		$("#memTypeCd").val(conditionData.memTypeCd);
		$("#segLifeCycleCd").val(conditionData.segLifeCycleCd);
		$("#ageId").val(conditionData.ageId);
		$("#genderCd").val(conditionData.genderCd);
		$("#mainUseWeekday").val(conditionData.mainUseWeekday);
	}
}

//찾기버튼 클릭시
$("#searchMbrCountBtn").on("click", function(){ 
	searchMbrCount(); //조건대상 회원수 추출
});

//확인버튼 클릭시
$("#conditionSaveBtn").on("click", function(){ 
	conditionMain.setCondition("");
});

//닫기버튼 클릭시
$("#coditionPopupCloseBtn").on("click", function(){ 
	conditionMain.conditionPopupConClose();
});

$(document).ready(function(){
	getCommCodeList1();
	getCommCodeList2();
	getCommCodeList3();
	getCommCodeList4();
	getCommCodeList5();
	getCommCodeList6();
	getCommCodeList7();
	
	$($("#dialogPopupWrap select")[1]).val("NA").attr('selected', true);
	$($("#dialogPopupWrap select")[2]).val("NA").attr('selected', true);
	$($("#dialogPopupWrap select")[3]).val("NA").attr('selected', true);
	$($("#dialogPopupWrap select")[4]).val("NA").attr('selected', true);
	$($("#dialogPopupWrap select")[5]).val("N").attr('selected', true);
	$($("#dialogPopupWrap select")[6]).val("N").attr('selected', true);

	$("#preFillVolLt").on('keyup', function() {
		if($("#preFillVolLt").val() == 0) {
			$("#preFillVolLt").val(1);
		}
	});
	$("#preVisitCnt").on('keyup', function() {
		if($("#preVisitCnt").val() == 0) {
			$("#preVisitCnt").val(1);
		}
	});
	
	initConditionPopup();
	
	try {
	    if(camStatusCd != 'W' 
			&& (camStatusCd == 'A' //활성
				|| camStatusCd == 'I' //비활성
				|| camStatusCd == 'S' //중지
				|| camStatusCd == 'C' //취소
				|| camStatusCd == 'E' //완료
				|| camStatusCd == '010' //결재진행중
				|| camStatusCd == '090' //승인완료
				|| camStatusCd == '091')) {
			$("#conditionSaveBtn").hide();
			$("#searchMbrCountBtn").attr('disabled',true);
		}
	} catch(e) {
		
	}
});
</script>

<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id="dialogPopupWrap">
	<!-- 조건선택영역1 기간, 충전량 ... -->
	<div id="conditionFirstArea" class="pop_inner_wrap form-horizontal">
		<div class="row group_box_line popup_contents_height" id="conditionFirstCon">
			<div class="row qt_border"/>
			<div class="row qt_border">
			    <label class="col-xs-2 control-label"><spring:message code="M00607"/></label>    
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="select" id="condExtTerms" names="condExtTerms"/>
			    </div>
			</div>
			<div class="row qt_border">
			    <label class="col-xs-2 control-label"><spring:message code="M02066"/></label>    
			    <div class="col-xs-2 control_content">
			        <ifvm:input type="number" id="preFillVolLt" names="preFillVolLt" maxLength="10"/>
			    </div>
			    <label class="col-xs-2 control-label" style="text-align:left;"><spring:message code="S00020"/></label>
			    <label class="col-xs-2 control-label"><spring:message code="S00021"/></label>    
			    <div class="col-xs-2 control_content">
			        <ifvm:input type="number" id="preVisitCnt" names="preVisitCnt" maxLength="10"/>
			    </div>
			    <label class="col-xs-2 control-label" style="text-align:left;"><spring:message code="S00022"/></label>    
			</div>
		</div>
	</div>
	
	<div class="row qt_border"/>
	<div class="row qt_border"/>
	
	<!-- 조건선택영역2 E1등급, 고객유형 ... -->
	<div id="conditionSecondArea" class="pop_inner_wrap form-horizontal">
		<div class="row group_box_line popup_contents_height" id="conditionSecondCon">
			<div class="row qt_border"/>
			<div class="row qt_border">
			    <label class="col-xs-2 control-label"><spring:message code="L00324"/></label>    
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="select" id="memPhaseCd" names="memPhaseCd"/>
			    </div>
			    <label class="col-xs-2 control-label"><spring:message code="M02328"/></label>    
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="select" id="memTypeCd" names="memTypeCd"/>
			    </div>
			</div>
			<div class="row qt_border">
			    <label class="col-xs-2 control-label"><spring:message code="S00024"/></label>    
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="select" id="segLifeCycleCd" names="segLifeCycleCd"/>
			    </div>
			    <label class="col-xs-2 control-label"><spring:message code="S00025"/></label>    
			    <div class="col-xs-4 control_content">
			    	<ifvm:input type="select" id="ageId" names="ageId"/>
			    </div>
			</div>
			<div class="row qt_border">
			    <label class="col-xs-2 control-label"><spring:message code="V00124"/></label>    
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="select" id="genderCd" names="genderCd"/>
			    </div>
			    <label class="col-xs-2 control-label"><spring:message code="S00026"/></label>    
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="select" id="mainUseWeekday" names="mainUseWeekday"/>
			    </div>
			</div>
		</div>
	</div>
	
	<!-- 찾기버튼영역 -->
	<div class="pop_btn_area" style="background-color: transparent;border-top: transparent;margin-top: 0px;">
	    <button class="btn btn-sm" id="searchMbrCountBtn"> <!-- 찾기 -->
	        <spring:message code="S00028"/>
	    </button> 
	</div>
	
	<!-- 조건추출 회원수 -->
	<div id="searchMbrCountArea" class="pop_inner_wrap form-horizontal">
		<div class="row group_box_line popup_contents_height" id="searchMbrCountCon">
			<div class="row qt_border"/>
			<div class="row qt_border">
			    <label class="col-xs-2 control-label"><spring:message code="S00027"/></label>
			    <div class="col-xs-4 control_content">
			        <ifvm:input type="text" id="mbrCount" names="mbrCount" readonly="readonly" disabled="true"/>
			    </div>
			    <label class="col-xs-1 control-label" style="text-align:left;"><spring:message code="M01196"/></label>
			</div>
		</div>
	</div>
	
	<!-- 최하단 확인,닫기버튼 영역 -->
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="conditionSaveBtn"> <!-- 확인 -->
	        <spring:message code="C00039" />
		</button>
	    <button class="btn btn-sm" id="coditionPopupCloseBtn"> <!-- 닫기 -->
	        <spring:message code="I00404"/>
	    </button> 
	</div>
</div>