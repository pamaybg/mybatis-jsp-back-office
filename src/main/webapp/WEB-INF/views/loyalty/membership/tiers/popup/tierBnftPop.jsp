<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script>
var validation;
var camId = null;
var camType = "PROMOTION";

//팝업 닫기
function tiersPopClose() {
	dialog._destroy();
}

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
function getCommCodeList(){
	// 대유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{ groupCode : 'LOY_TIER_BNFT_TYPE1_CD', enableNA : true
	},function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#tierBnftType1").append(temp);
	});
	// 소유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{ groupCode : 'LOY_TIER_BNFT_TYPE2_CD', enableNA : true, parCodeId : $("#tierBnftType1").val()
	},function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#tierBnftType2").append(temp);
	});
	// 제공주기
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{ groupCode : 'LOY_TIER_BNFT_OFFERING_CD', enableNA : true
	},function(result) {
		var temp = $("#commCodeTemplate").tmpl(result.rows);
		$("#splyCyclCd").append(temp);
	});
}; 

//등급목록 조회
function getTierBnft(){
	$.ifvSyncPostJSON('<ifvm:action name="getTierBnft"/>',{tierBnftRid : tierBnftRid }
	,function(result) {
		$("#tierBnftType1").val(result.tierBnftType1Cd);
		$("#tierBnftType2").val(result.tierBnftType2Cd);
		$("#splyCyclCd").val(result.splyCyclCd);
		$("#tierBnftNm").val(result.tierBnftNm);
		$("#tierBnftDesctxt").val(result.tierBnftDesctxt);
		$("#validStartDate").val(result.validStartDate);
		$("#validEndDate").val(result.validEndDate);
		$("#camNm").text(result.camId);
		$("#camNm").val(result.camNm);
		$("#bnftCreateBy").val(result.createBy);
		$("#bnftCreateDate").val(result.createDate);	
		rid = result.rid;
		
	});
}

//등급목록 수정
 function modifyTierBnft(){
	var obj = {};	
	var value = false;
	validation = $("#tierBnftPopFormArea").ifvValidation();
	
	if(validation.confirm()){
		obj.rid = rid;
		obj.ridTiers = tiersRid;
		obj.tierBnftType1Cd = $("#tierBnftType1").val();
		obj.tierBnftType2Cd = $("#tierBnftType2").val();
		obj.splyCyclCd = $("#splyCyclCd").val();
		obj.tierBnftNm = $("#tierBnftNm").val();
		obj.tierBnftDesctxt = $("#tierBnftDesctxt").val();
		obj.validStartDate = $("#validStartDate").val();
		obj.validEndDate = $("#validEndDate").val();
		obj.ridCampMst = $("#camNm").text();
		$.ifvSyncPostJSON('<ifvm:action name="editTierBnft"/>',obj
		,function(result) {
			alert('<spring:message code="M00624"/>');
			tierBnftListInit(tiersRid);
			tiersDtlPopClose();
		});
	}
} 

//등급목록 저장
 function setTierBnft(){
	var obj = {};
	var value = false;
	validation = $("#tierBnftPopFormArea").ifvValidation();

	if(validation.confirm()){
		obj.ridTiers = tiersRid;
		obj.tierBnftType1Cd = $("#tierBnftType1").val();
		obj.tierBnftType2Cd = $("#tierBnftType2").val();
		obj.splyCyclCd = $("#splyCyclCd").val();
		obj.tierBnftNm = $("#tierBnftNm").val();
		obj.tierBnftDesctxt = $("#tierBnftDesctxt").val();
		obj.validStartDate = $("#validStartDate").val();
		obj.validEndDate = $("#validEndDate").val();
		obj.ridCampMst = $("#camNm").text();
		$.ifvSyncPostJSON('<ifvm:action name="setTierBnft"/>',obj
		,function(result) {
			alert('<spring:message code="M00623"/>');
			tierBnftListInit(tiersRid);
			tiersDtlPopClose();
		});
	}
} 

$(document).ready(function(){
	$("#tierBnftPopFormArea").ifvValidation();
	// 달력설정
	setValidCalendar();
	
	// 등급상태 조회
	getCommCodeList();

	// 등급상세 조회
	if(tierBnftRid != null) getTierBnft();
	
	$("#bnftTierNm").val(tierNm);
	
	// 취소 버튼
	$("#tierBnftPopCancel").on("click", tiersDtlPopClose);
	
	// 저장 버튼
 	$("#tierBnftSaveBtn").on("click", function(){
		if(tierBnftRid != null) modifyTierBnft();
		else setTierBnft();
	}); 
	
 	$("#tierBnftType1").on('change', function(){
 		$("#tierBnftType2").empty();
 		// 소유형
 		$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{ groupCode : 'LOY_TIER_BNFT_TYPE2_CD', enableNA : true, parCodeId : $("#tierBnftType1").val()
 		},function(result) {
 			var temp = $("#commCodeTemplate").tmpl(result.rows);
 			$("#tierBnftType2").append(temp);
 		});
 	});
 	
	$('#camBtn').on('click', function(){
		$("#dialog").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="camMstListPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01987" />', 
	        width: '700px',
	        close : 'tiersPopClose'
	    });
	}); 
	

});
</script>

<script id="commCodeTemplate" type="text/x-jquery-tmpl">
<option id="${'${'}codeName}" value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div id='tierBnftPopFormArea'>

	<div class="pop_inner_wrap form-horizontal">
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="L00236"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="bnftTierNm" readonly="true"/>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="L00269"/></label>
	        <div class="col-xs-4 control_content">
		        <div class="input-group">
		            <ifvm:input type="text" id="camNm" readonly="true"/>
					<span class="input-group-addon" id="camBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
				</div>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01974" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="tierBnftType1"/>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01975" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="tierBnftType2"/>
	        </div>
	    </div>
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01976" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="tierBnftNm" maxLength="60"/>
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01977" /></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="select" id="splyCyclCd" />
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
	    <div class="row qt_border">
	        <label class="col-xs-2 control-label"><spring:message code="M01131"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="bnftCreateBy" disabled="true" />
	        </div>
	        <label class="col-xs-2 control-label"><spring:message code="M01132"/></label>
	        <div class="col-xs-4 control_content">
	            <ifvm:input type="text" id="bnftCreateDate" disabled="true" />
	        </div>
	    </div>
	    <div class="row">
	        <label class="col-xs-2 control-label"><spring:message code="M01988" /></label>
	        <div class="col-xs-10 control_content">
	            <ifvm:input type="textarea" id="tierBnftDesctxt" rows="3"/>
	        </div>
	    </div>
	</div>

</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="tierBnftSaveBtn">       
		<i class="glyphicon glyphicon-check"></i>  
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tierBnftPopCancel">         
		<spring:message code="M00284"/>
	</button>  
</div>
