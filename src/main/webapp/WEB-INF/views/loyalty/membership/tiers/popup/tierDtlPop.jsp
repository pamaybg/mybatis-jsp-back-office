<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var rid;
var oldSeq;

// 달력설정
function setValidCalendar() {
    var startDate = $("#validStartDate");
    var endDate = $("#validEndDate");

   	startDate.val($.ifvGetTodayDate());
   	endDate.val("2999-12-31");

	startDate.ifvDateChecker({
		minDate : "today",
		maxDate : endDate

	});

	endDate.ifvDateChecker({
		minDate : startDate
	});

}
// 같은 순서일 경우 기간중복 발생 여부 체크 true == '같은 순서 등급의 유효 기간이 중복됩니다. 다시 설정해주세요.' 메세지 처리
function chkValid(vStartDt,vEndDt){
	var value = false;
	var valSdt = false;
	var valEdt = false;
	var strDt = $("#validStartDate").val();
	var endDt = $("#validEndDate").val();

	// 입력시작일, 종료일 값 사이 중복 db시작일 비교
	if(vStartDt <= strDt && strDt <= vEndDt){
		valSdt = true;
	}else{
		valSdt = false;
	}
	// 입력시작일, 종료일 값 사이 중복 db종료일 비교
	if(vStartDt <= endDt && endDt <= vEndDt){
		valEdt = true;
	}else{
		valEdt = false;
	}
	// 시작일, 종료일중 기간이 중복되면 true
	if((valSdt || valEdt) == true){
		value = true;
	}else if((valSdt && valEdt) == false){
		value = false;
	}

	return value;
}

// 등급상태 조회
function getTierCdStatComboList(){
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{ groupCode : 'LOY_TIER_MST_STAT_CD', enableNA : false
	},function(result) {
		var temp = $("#tierStatTemplate").tmpl(result.rows);
		$("#tierCdStatCd").append(temp);
	});
};

//등급목록 조회
function getTier(){
	$.ifvSyncPostJSON('<ifvm:action name="getTierDtl"/>',{tiersRid : tiersRid , ridTierGroup : ridTierGroup }
	,function(result) {
		$("#tierCd").val(result.tierCd);
		$("#dtlTierNm").val(result.tierNm);
		$("#seqNo").val(result.seqNo);
		$("#validStartDate").val(result.validStartDate);
		$("#validEndDate").val(result.validEndDate);
		$("#tierCdStatCd").val(result.tierCdStatCd);
		$("#dtlCreateBy").val(result.createBy);
		$("#dtlCreateDate").val(result.createDate);
		rid = result.rid;
		oldSeq = result.seqNo;
	});
}

//등급목록 수정
 function modifyTier(){
	var obj = {};
	var value = false;
	validation = $("#tierPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.rid = rid;
		obj.ridTierGroup = ridTierGroup;
		obj.tierCd = $("#tierCd").val();
		obj.tierNm = $("#dtlTierNm").val();
		obj.seqNo = $("#seqNo").val();
		obj.validStartDate = $("#validStartDate").val().replaceAll('-','');
		obj.validEndDate = $("#validEndDate").val().replaceAll('-','');

		obj.tierCdStatCd = $("#tierCdStatCd").val();
		if(oldSeq != $("#seqNo").val()){
			$.ifvSyncPostJSON('<ifvm:action name="chkValid"/>',obj
			,function(result) {
				if(result != null){
					value = chkValid(result.validStartDate, result.validEndDate);
				}
			});
		}
		if(value == false){
			$.ifvSyncPostJSON('<ifvm:action name="editTierDtl"/>',obj
			,function(result) {
				alert('<spring:message code="M00624"/>');
				tiersListInit();
				tiersDtlPopClose();
			});
		}else{
			alert('<spring:message code="M01989" />');
		}
	}
}

//등급목록 저장
 function setTier(){
	var obj = {};
	var value = false;
	validation = $("#tierPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.ridTierGroup = ridTierGroup;
		obj.tierCd = $("#tierCd").val();
		obj.tierNm = $("#dtlTierNm").val();
		obj.seqNo = $("#seqNo").val();
		obj.validStartDate = $("#validStartDate").val();
		obj.validEndDate = $("#validEndDate").val();
		obj.tierCdStatCd = $("#tierCdStatCd").val();
		$.ifvSyncPostJSON('<ifvm:action name="chkValid"/>',obj
		,function(result) {
			if(result != null){
				value = chkValid(result.validStartDate, result.validEndDate);
			}
		});
		if(value == false){
		 	$.ifvSyncPostJSON('<ifvm:action name="setTierDtl"/>',obj
			,function(result) {
				alert('<spring:message code="M00623"/>');
				tiersListInit();
				tiersDtlPopClose();
			});
		}else{
			alert('<spring:message code="M01989"/>');
		}
	}
}

$(document).ready(function(){
	$("#tierPopFormArea").ifvValidation();
	// 달력설정
	setValidCalendar();

	// 등급상태 조회
	getTierCdStatComboList();

	// 등급상세 조회
	if(tiersRid != null) getTier();

	// 취소 버튼
	$("#tierPopCancel").on("click", tiersDtlPopClose);

	// 저장 버튼
 	$("#tierSaveBtn").on("click", function(){
		if(tiersRid != null) modifyTier();
		else setTier();
	});

	// 숫자만 입력 가능
	$("input[id=seqNo]").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi,''));
		}
	});


});
</script>

<script id="tierStatTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='tierPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="L00235"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="tierCd"  maxLength="24"/>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="L00236"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="dtlTierNm" maxLength="60"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01972" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="seqNo" maxLength="2"/>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01973" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="tierCdStatCd" />
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="L00391"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="date" id="validStartDate" names="validStartDate"/>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="L00393"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="date" id="validEndDate" />
	        </div>
	    </div>
	    <div class="row">
	        <label class="col-xs-2 control-label"><spring:message code="M01131"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="dtlCreateBy" disabled="true" />
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01132"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="dtlCreateDate" disabled="true" />
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="tierSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tierPopCancel">
		<spring:message code="M00284"/>
	</button>
</div>