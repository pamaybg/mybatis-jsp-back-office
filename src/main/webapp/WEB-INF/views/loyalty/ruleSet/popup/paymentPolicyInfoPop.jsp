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
var paymentPolicyInfoPopValidation;
var paymentPolicyOpenType = '<%= cleanXss(request.getParameter("paymentPolicyOpenType")) %>';
var isEdit = '<%= cleanXss(request.getParameter("isEdit")) %>';


function initPaymentPolicyInfoPop() {
	$.fn.ifvmSetSelectOptionCommCode("saveDiv", "LOY_ACRL_TYPE", null, null, true);
	//채널유형
	paymentPolicyInfoPopValidation = $("#paymentPolicyInfoPopDiv").ifvValidation();

	
	$(".family").css("display", "none");
	$(".family").attr("required", false);
	$(".sale").css("display", "none");
	$(".sale").attr("required", false);
	$(".tier").css("display", "none");
	$(".tier").attr("required", false);
	$("select#saveDiv").attr("disabled", false);
	
	switch(paymentPolicyOpenType){
	case "F" : //가구화프로모션
		$(".family").css("display", "");
		$(".family").attr("required", true);
		$("select#saveDiv").val("AMT");
		$("select#saveDiv").attr("disabled", true);
		break;
	case "S" : //금액대별 판매
		$(".sale").css("display", "");
		$(".sale").attr("required", true);
		break;
	case "A" : //구매금액횟수(누적)포인트
		$(".accumul").css("display", "");
		$(".accumul").attr("required", true);
		break;
	case "T" : //등급가산, 승급업
		$(".tier").css("display", "");
		$(".tier").attr("required", true);
		break;
	default :
		$(".family").css("display", "none");
		$(".family").attr("required", false);
		$("select#saveDiv").attr("disabled", false);	
		$(".sale").css("display", "none");
		$(".sale").attr("required", false);
		$(".tier").css("display", "none");
		$(".tier").attr("required", false);
		
		break;
	}
	
}
function initPaymentPolicyInfoPopData(data){
	/* $("#paymentPolicyInfoPopDiv #tierCd").val(data.custGradeCd);
	$("#paymentPolicyInfoPopDiv #tierNm").val(data.tierNm); */
	$("#paymentPolicyInfoPopDiv #saveDiv").val(data.acrlType);
	$("#paymentPolicyInfoPopDiv #amount").val(data.acrlAmt);
	$("#paymentPolicyInfoPopDiv #familyCnt").val(data.mbrCnt);
	$("#paymentPolicyInfoPopDiv #purchaseAmt").val(data.minAmt);
	$("#paymentPolicyInfoPopDiv #purchaseCnt").val(data.minCnt);
	$("#paymentPolicyInfoPopDiv #tierNm").val(data.tierNm);
	/* $("#paymentPolicyInfoPopDiv #tierRid").val(data.tierRid); */
}


//팝업 닫기
function tierPopupClose() {
	tierInfoPopup._destroy();
}


/* function tierInfoPopupSave(){
	if ($.fn.ifvmIsNotEmpty(loyTierListPopGrid.getCheckedList())) {
		var data = loyTierListPopGrid.getCheckedList()[0];

		$("#paymentPolicyInfoPopDiv #tierCd").val(data.tierCd);
		$("#paymentPolicyInfoPopDiv #tierNm").val(data.tierNm);
		$("#paymentPolicyInfoPopDiv #tierRid").val(data.ridTier);


	}
	tierInfoPopup._destroy();
}
function tierInfoPopupClose(){
	tierInfoPopup._destroy();
} */




$(document).ready(function() {
	initPaymentPolicyInfoPop();

	//등록 클릭시
    $('#paymentPolicyInfoPopSaveBtn').on('click', function(){

    		paymentPolicyInfoPopupSave();
    });

    //닫기 클릭시
    $('#paymentPolicyInfoPopCancelBtn').on('click', function(){
    	paymentPolicyInfoPopupClose();
    });


	if(isEdit=="Y"){
		initPaymentPolicyInfoPopData(selPaymentPolicyData);
	}
	
	
	//기본등급 팝업
	$('#tierBtn').on('click', function(){
		$("#tierInfoPopup").ifvsfPopup({
			enableModal : true,
	        enableResize: false,
	        contentUrl: '<ifvm:url name="loyTierDtlInfoPop"/>',
	        contentType: "ajax",
	        title: '<spring:message code="M01996" />',
	        width: 600,
	        close : 'tierPopupClose'
	    });
	});
	


});
</script>

	<div class="pop_inner_wrap form-horizontal" id="paymentPolicyInfoPopDiv" >
		<%-- <div class="row qt_border">
	       <label class="col-xs-3 control-label"><span class="asterisk">*</span> <spring:message code="L00235"/></label>
	        <div class="col-xs-9 control_content">
	            <div class="input-group">
		            <ifvm:input type="text" id="tierCd"  required="true" readonly="true"/>
					<span class="input-group-addon" id="tierSearchBtn">
					<a><i class="fa fa-search"></i></a>
					</span>
					<ifvm:inputNew type="hidden" id="tierRid" maxLength="50"  dto="tierRid"     labelClass="0" conClass="2" />
				</div>
	        </div>
		</div> --%>

		<%-- <div class="row qt_border">
	       <label class="col-xs-3 control-label"><span class="asterisk">*</span> <spring:message code="L00236"/></label>
	        <div class="col-xs-9 control_content">
	            <div class="input-group">
		            <ifvm:input type="text" id="tierNm" required="true" readonly="true"/>
				</div>
	        </div>
		</div> --%>
		
		<!-- 회원 등급  -->
		<div class="row qt_border tier">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>회원등급</label>
			<div class="col-xs-6 control_content">
				<div class="input-group">
					<ifvm:input id="tierNm" className="tier"  type="text"  readonly="true"/>
					<span class="input-group-addon" id="tierBtn" class="tier">
						<a><i class="fa fa-search"></i></a>
					</span>
				</div>
			</div>
		</div>
		
		
		<!-- 인원  -->
		<div class="row qt_border family">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>인원</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="number" className="text-right family" required="false" id="familyCnt" names="familyCnt" />
                </div>
            </div>
		</div>
		
		<!-- 구매금액 -->
		<div class="row qt_border family sale accumul">
			<label class="col-xs-3 control-label"><span class="asterisk sale">*</span> 구매금액</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="number" className="text-right" id="purchaseAmt" names="purchaseAmt" />
                </div>
            </div>
		</div>
		
		<!-- 구매횟수 -->
		<div class="row qt_border family accumul">
			<label class="col-xs-3 control-label">구매횟수</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="number" className="text-right" id="purchaseCnt" names="purchaseCnt" />
                </div>
            </div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>적립구분</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="select"  required="true" id="saveDiv" names="saveDiv" />
                </div>
            </div>
		</div>

		<div class="row qt_border">
			<label class="col-xs-3 control-label"><span class="asterisk">*</span>적립금액/적립률</label>
            <div class="col-xs-9 control_content">
                <div class="input-group">
                    <ifvm:input type="number" className="text-right"  required="true" id="amount" names="amount" />
                </div>
            </div>
		</div>
	</div>
	<div class="pop_btn_area">
	    <button class="btn btn-sm" id="paymentPolicyInfoPopSaveBtn">
	        <i class="glyphicon glyphicon-check"></i>
	        <spring:message code='M01855'/>
	    </button>
	    <button class="btn btn-sm" id="paymentPolicyInfoPopCancelBtn">
	        <spring:message code="M00441"/>
	    </button>
	</div>

<div id="tierInfoPopup" class ="popup_container"></div>