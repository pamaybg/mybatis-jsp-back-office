<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal underline top_well" id="modifyTierPop">
<br>
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="tierMbrNo" names="tierMbrNo" label="회원번호" labelClass="2" conClass="2" disabled="true"/>
				<ifvm:inputNew type="text" id="custNm" names="custNm" conClass="2" disabled="true"/>	
	</div>
	
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="tierGrpNm" names="tierGrpNm" label="등급그룹" labelClass="2" conClass="3" disabled="true"/>
	</div>
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="prevTierNm" names="prevTierNm" label="이전등급" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="search" id="modifyTierNm" names="modifyTierNm" label="변경등급" labelClass="2" conClass="3" required="true" disabled="true" btnFunc="modifyTierListPop"/>
	</div>
	<div class="row qt_border" id="apprDiv">
				<ifvm:inputNew type="text" id="approvalReqNm" names="approvalReqNm" label="결제요청자" labelClass="2" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="approvalNm" names="approvalNm" label="승인자" labelClass="2" conClass="3" disabled="true"/>
				<span class="input-group-addon" style="padding: 6px;" id="empListPopupBtn">
					<a><i class="fa fa-search"></i></a>
				</span>
	</div>
	<div class="row qt_border">
				<ifvm:inputNew type="select" id="tierMnlReasonCd" names="tierMnlReasonCd" label="변경사유 유형" labelClass="2" conClass="3"/>
				<ifvm:inputNew type="date" id="modifyTierDate" names="modifyTierDate" label="적용종료일" labelClass="2" conClass="3"/>
	</div>
	<div class="row qt_border">
				
			<ifvm:inputNew type="textarea" maxLength="150" id="tierMnlReasonDesc" dto="tierMnlReasonDesc" label="사유" labelClass="2" conClass="9" rows="6"/>		</div>
	</div>
</div>
<div class="pop_btn_area">
	<!-- 등록 -->
	<button class="btn btn-sm btn_gray" id="btnSave" objCode="modifyTierPopSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="저장"/>
	</button>
	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="modifyTierCancel" objCode="modifyTierPopCancel_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<div id="tierPop" class="popup_container"></div>
<div id="empListPop" class="popup_container"></div>

<script>
var MgtPlcyCheck = false;
var ridTier = null;
var empRid = null; 
var orgRid= null;
var modifySeqNo = null;
var tierRstCd = null;
function tierModifyInit() {
	$("#tierMbrNo").val(mbrNo);
	$("#custNm").val(custNm);
	$("#tierGrpNm").val(tierGrpNm);
	$("#prevTierNm").val(tierNm);
	$("#approvalReqNm").val(ifvmUserInfo.empName);
	$("modifyTierDate").val(modifyTierDate);
	
	$.fn.ifvmSetSelectOptionCommCode("tierMnlReasonCd", "LOY_TIER_MNL_REASON_CD", null, null, true);

}

function tierApproValInit() {
	$.ifvSyncPostJSON('<ifvm:action name="getTierMgtPlcy"/>', {
		pgmRid : pgmRid
	}, function(result) {
		if ($.fn.ifvmIsNotEmpty(result)) {
			if(result.success) {
				$("#apprDiv").show();
				MgtPlcyCheck=true;
				
			} else {
				$("#apprDiv").hide();
				MgtPlcyCheck=false;
				
			}
		}
	}, function(result) {
		if(!result.success) {
			$("#apprDiv").hide();
		//alert(result.message);
		MgtPlcyCheck=false;
		}
	});
}


function modifyTierListPop() {
	$("#tierPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="tierPop"/>',
        contentType: "ajax",
        title: '등급 조회',
        width: 900,
        close : 'tierListClosePop'
	});
}

function tierListClosePop() {
	tierListPop._destroy();
}

function empListPopup(){
	$("#empListPop").ifvsfPopup({
		enableModal : true,
        enableResize: false,
        contentUrl: '<ifvm:url name="empListCommonPop"/>',
        contentType: "ajax",
        title: '직원 조회',
        width: 900,
        close : 'empListClosePop'
	});
}

function empListClosePop() {
	empListPop._destroy();
}

function modifyTier(){
	var validation = $("#modifyTierPop").ifvValidation();
	//유효성 체크
	if(validation.confirm()){
		var url = MgtPlcyCheck? '<ifvm:action name="saveApproval"/>' : '<ifvm:action name="modifyTiers"/>';
 		//var url = '<ifvm:action name="modifyTiers"/>';
		var varData = null;
		if(seqNo>modifySeqNo) {
			tierRstCd = 'D';
		} else if (seqNo<modifySeqNo) {
			tierRstCd = 'U';
		} else if (seqNo==modifySeqNo) {
			tierRstCd = 'R';
		}
		
		/* var tierReason = null; */
		tierReason = "회원명 : "+custNm+"("+mbrNo+")"+"\n"+"등급그룹 : "+tierGrpNm+"\n"+"이전등급 : "+prevTierNm+"\n"+"변경등급 : "+tierNm+"\n"+"결재요청자 : "+ifvmUserInfo.empName+"\n"+"승인자 : "+$("#approvalNm").val()+"\n"+"변경사유 유형 : "+$("#tierMnlReasonCd").val()+"\n"+"사유 : "+$("#tierMnlReasonDesc").val();
		varData = {
				tierGrpRid		       	: tierGrpRid,
				mbrRid					: mbr_rid,
				mbrNo					: mbrNo,
				custNm      			: custNm,
				tierRid					: ridTier,
				modifyTierNm			: $("#modifyTierNm").val(),
				/* modifyTierRid	    : modifyTierRid, */
				tierNm   				: $("#tierBnftTypeCd").val(),
				approvalReqNm	        : $("#approvalReqNm").val(),
				approvalNm	   			: $("#approvalNm").val(),
				empId	   			    : empRid,
				reqEmpId			    : ifvmUserInfo.empId,
				tierMnlReasonDesc	    : $("#tierMnlReasonDesc").val(),
				upKeepMm			    : $("#modifyTierDate").val(),
				reqEmpDivId				: ifvmUserInfo.orgId,
				mbrTierCol    	    	: mbrTierCol,
				tierGrpNm 				: tierGrpNm,
				prevTierRid  			: prevTierRid,
				tierHistRid				: tierHistRid,
				modifyOrgID				: orgRid,
				tierReason 			    : tierReason,
				tierRstCd               : tierRstCd,
				tierMnlReasonCd         : $("#tierMnlReasonCd").val(),
		};
		$.ifvSyncPostJSON(url, varData
			, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert(result.message);
					modifyTierClose();
					TierListGrid._doAjax();
					mbrDetail();
				}
			}, function(result) {
				
		});
		
	}
}

function tierBnftCancle() {
	addTierBnftClosePop();
}

function setValidCalendar() {	
	var modifyTierDate = $("#modifyTierDate");

	//vaildStartDt.val($.ifvGetTodayDate());

	modifyTierDate.ifvDateChecker({
		
	});
}

$(document).ready(function(){
	setValidCalendar();//달력셋팅
	
	tierApproValInit();
	
	tierModifyInit();
	
	//닫기
	$("#modifyTierCancel").on("click",function(){
		modifyTierClose();
	});
	
	//$("#modifyTierListPopBtn").click(function(){
	//	modifyTierListPop();
	//});
	
	$("#empListPopupBtn").click(function(){
		empListPopup();
	});
	
	$("#btnSave").click(function(){
		modifyTier();
	});
	
});

</script>