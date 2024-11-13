<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script>

var selectedOfferObj;
var offerPopupCon;
var apiErrorCodeList;
var offerid;

function getVocPointAcrlRdmData(){
	var reqDto = new Object();
	reqDto.ridChnl = vocPointAcrlRdmPopObj.ridChnl;
	reqDto.chnlNo = vocPointAcrlRdmPopObj.chnlNo;
	reqDto.ridMbr = vocPointAcrlRdmPopObj.rid;
	reqDto.mbrNo = vocPointAcrlRdmPopObj.mbrNo;
	reqDto.identiType = vocPointAcrlRdmPopObj.identiType;
	reqDto.identiVal = vocPointAcrlRdmPopObj.identiVal;
	reqDto.acrlRdmPntAmt = $("#inputPoint").val().replaceAll(",", "");
	reqDto.txnType = $("#inputPointTxnType").val();
	reqDto.txnDtlType = $("#inputPointTxnDtlType").val();
	reqDto.memo = $("#inputVocReason").val();
	reqDto.vocAcrlReasCd = (reqDto.txnType == '100') ? '160' : '260'; // 적립 : 160 | 사용 : 260
	reqDto.offerNo = vocPointAcrlRdmPopObj.offerNo;
	reqDto.offerTypeCd = vocPointAcrlRdmPopObj.offerTypeCd;
	reqDto.offerSubTypeCd = vocPointAcrlRdmPopObj.offerSubTypeCd;
	reqDto.mbrStatCd = vocPointAcrlRdmPopObj.mbrStatCd;
	
	return reqDto;
}

function checkVocPointAcrlRdmData(){
	
	var reqDto = getVocPointAcrlRdmData();
	if(reqDto.acrlRdmPntAmt == null || reqDto.acrlRdmPntAmt == "" || reqDto.acrlRdmPntAmt == "0"){
		alert("<spring:message code='L00513'/>");
		return false;
	} 
	if(reqDto.mbrStatCd != "A"){
		alert("<spring:message code='L00510'/>");
		return false;
	}
	if(reqDto.offerNo == null){
		alert("<spring:message code='L00516'/>");
		return false;
	}
	
	var pntAmt = reqDto.acrlRdmPntAmt * 1;
 	if(pntAmt > 3000){
		alert("3,000 <spring:message code='L00514'/>");
		return false;
	}
	
	return true;
}

function addVocPoint(){
	
	if(!checkVocPointAcrlRdmData()){
		return;
	}
	var reqDto = getVocPointAcrlRdmData();
	
	// Show Loading Circle
	$.ifvProgressControl(true);
	
	$.ifvPostJSON(
		  "<ifvm:action name='addVocPointAcrlRdm'/>"
	    , reqDto
		, function(result) {
	    	alert(getErrorMessage(""+result.errorType));
	    	
	    	// Release Loading Circle
        	$.ifvProgressControl(false);
        	popClose();
         }
		, function(result) {
			
			alert(result.message);
      	  	
      		// Release Loading Circle
        	$.ifvProgressControl(false);
         }
    );
}


function getCommonCode(){
	// 포인트 거래유형
	
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'PNT_TXN_TYPE'
		, enableNA : true
	},function(result) {
		var tmpl = $("#selectOptionTmpl").tmpl(result.rows);
		$("#inputPointTxnType").append(tmpl);
	});
	
	// 포인트 거래상세유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'PNT_TXN_DTL_TYPE'
		, enableNA : true
	},function(result) {
		var tmpl = $("#selectOptionTmpl").tmpl(result.rows);
		
		$("#inputPointTxnDtlType").append(tmpl);
		$("#inputPointTxnDtlType").val("260").prop("selected", "true");
	});
}

function initPopupData2(){
	$("#inputCreateBy").val(ifvmUserInfo.empName);
	$("#inputPoint").val("0");
	getCommonCode();
}

function getErrorMessage(code){
	
	var errMsg = "";
	if(code === "0"){
		errMsg = "<spring:message code='L00512'/>";
	} else {
		for(var i=0; i<apiErrorCodeList.length; i++){
			
			if(apiErrorCodeList[i].codeName === code){
				errMsg = apiErrorCodeList[i].markName + " (" + code + ")";
				break;
			}
		}	
	}
	
	if(errMsg == ""){
		errMsg = "<spring:message code='L00511'/> (" + code + ")";
	}
	
	return errMsg;
}

function formNewPopClose(){	
	vocPointAcrlRdmPopObj.offerNo = $("#inputOfferNm").text();
	vocPointAcrlRdmPopObj.offerTypeCd = $("#inputOfferType").text();
	vocPointAcrlRdmPopObj.offerSubTypeCd = $("#inputOfferType").val();
	
	$('#offerPopupCon').ejDialog('destroy');
}

function offerPopClose(){
	
	if(selectedOfferObj != null){
		vocPointAcrlRdmPopObj.offerTypeCd = selectedOfferObj.offerTypeCd;
		vocPointAcrlRdmPopObj.offerSubTypeCd = selectedOfferObj.offerSubTypeCd;
		vocPointAcrlRdmPopObj.offerNo = selectedOfferObj.offerNo;
		$("#inputOfferNm").val(selectedOfferObj.offerNm);
	}
	
	$('#offerPopupCon').ejDialog('destroy');
}

$(document).ready(function(){

	// 포인트 거래유형
	$.ifvSyncPostJSON('<ifvm:action name="getCommCodeList2"/>',{
		groupCode : 'APPR_SERVER_RPLY_CD'
		, enableNA : true
	},function(result) {
		apiErrorCodeList = result.rows;
	});
	
	//$('#inputPoint').ifvSeparateNumber();
	
	initPopupData2();
	
	$("#btnSelectOfferPop").click(function(){
		
		offerPopupCon = $.fn.ifvmPopupOpen('offerPopupCon', '', '<ifvm:url name="MKTOfferListPop"/>',  '<spring:message code="L00515"/>' ,860);
	});
	
	/** Button Handler Start */
	$("#btnVocPointAcrlRdmSave").click(function(){
		addVocPoint();
	});
	$("#btnVocPointAcrlRdmCancel").click(function(){
		popCancelClose();
	});
	/** Button Handler End */
});
</script>

<script id="selectOptionTmpl" type="text/x-jquery-tmpl">
<option value="${'${'}codeName}">${'${'}markName}</option>
</script>

<div class="pop_inner_wrap">
	<div class="form-horizontal">
		<div class="row qt_border store_content_top">
		</div>
		<!-- 테이블명 -->
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="L00505"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="select" id="inputPointTxnType"/>
					</div>
				</div>
			</div>
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="L00506"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="select" id="inputPointTxnDtlType" readonly="true" disabled="true"/>
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="M01870"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" disabled="true" required="true" id="inputOfferNm"/>
						 <input type="hidden" id=inputOfferType value="">
						<span class="input-group-addon" id="btnSelectOfferPop">
								<a><i class="fa fa-search"></i></a>
						</span>
				   </div>
				</div>
			</div>
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="M01661"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" id="inputCreateBy" readonly="true" disabled="true"/>
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-4 control-label"><spring:message code="L00422"/></label>
				<div class="col-xs-8 control_content">
					<div class="input-group">
						<ifvm:input type="text" id="inputPoint" minLength="1"/>
					</div>
				</div>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<div class="col-xs-6"> 
				<label class="col-xs-12 control-label"> * 3,000 <spring:message code="L00508"/></label>
			</div>
		</div>
		<div class="row qt_border store_content_top">
			<label class="col-xs-2 control-label"><spring:message code="L00507"/></label>
			<div class="col-xs-10 control_content">
				<div class="input-group">
					<ifvm:input type="textarea" id="inputVocReason" rows="4" maxLength="300"/>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button id="btnVocPointAcrlRdmSave" class="btn btn-sm btn_gray">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00125"/>
	</button>
	<button id="btnVocPointAcrlRdmCancel" class="btn btn-sm btn_lightGray2 cancel">
		<spring:message code="L00124"/>
	</button>
</div>