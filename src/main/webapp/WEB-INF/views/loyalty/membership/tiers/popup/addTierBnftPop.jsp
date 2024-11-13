<%@page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal underline top_well" id="tierBnftAddForm">
<br>
	<div class="row qt_border">
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="유형"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" required="true" id="tierBnftTypeCd" dto="tierBnftTypeCd" names="tierBnftTypeCd" />
		</div>
	</div>
	

	<div class="row qt_border">
		<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="주기"/></label>
		<div class="col-xs-3 control_content">
			<ifvm:inputNew type="select" required="true" id="bnftActCycleCd" dto="bnftActCycleCd" names="bnftActCycleCd" />
		</div>
		
		
		<div class="col-xs-4 control_content">
			<ifvm:inputNew type="select" required="true" id="bnftActRotCycleCd" dto="bnftActRotCycleCd" names="bnftActRotCycleCd" />
		</div>

	</div>
	
	<div class="row qt_border">
			<label class="col-xs-1 control-label"><span class="asterisk">*</span><spring:message code="오퍼"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="text"  id="ofrNo" dto="ofrNo" required="true" disabled="true"/>
			</div>
			
			<div class="col-xs-4 control_content">
				<ifvm:inputNew type="text"  id="ofrNm" dto="ofrNm" required="true" disabled="true"/>
			</div>
			<div class="col-xs-2 control_content">
				<ifvm:inputNew type="text" id="cpnYn" dto="cpnYn" disabled="true" />
			</div>
			<span class="input-group-addon" style="padding: 6px;" id="offerSearchPopBtn">
				<a><i class="fa fa-search"></i></a>
			</span>
			<ifvm:inputNew type="hidden" id="offerRid" label="M00314" conClass="5"  disabled="true"/>
	</div>
	<div class="row qt_border">
	 	    <label class="col-xs-1 control-label"></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" id="ofrSubType" dto="ofrSubType" disabled="true" names="ofrSubType" />
			</div>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="select" id="ofrValType" dto="ofrValType" disabled="true" names="ofrValType" />
			</div>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="text" id="ofrValAmt" className="text-right" dto="ofrValAmt" names="ofrValAmt" />
			</div>
			<div id="textLabel" style="float: left; padding-top: 5px;"></div>

	</div>
	<div class="row qt_border">
			<label class="col-xs-1 control-label"><spring:message code="수량"/></label>
			<div class="col-xs-3 control_content">
				<ifvm:inputNew type="text" id="qty" dto="qty" className="text-right" />
			</div>
			
	</div>
</div>
<div class="pop_btn_area">
	<!-- 등록 -->
	<button class="btn btn-sm btn_gray" id="saveTierBnft" objCode="AddTierBntfPopSaveTierBnft_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L01780"/>
	</button>
	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tierBnftClose" objCode="AddTierBntfPopCloseTierBnft_OBJ">
		<spring:message code="L01781"/>
	</button>
</div>

<div id="offerListPop" class="popup_container"></div>

<script>
var tierBnft_isNew;
var cpnYn=null;
priceFields = ["qty","ofrValAmt"];
function tierBnftInit(){
	if(typeof tierBnftRid === 'undefined' || tierBnftRid == null){
		tierBnft_isNew = true;
	}
	else {
		tierBnft_isNew = false;
		getTierBnft();
	}
}

function getTierBnft() {
	$.ifvSyncPostJSON('<ifvm:action name="getTierBnftDetail"/>',{
		rid  : tierBnftRid
	},function(result) {
		$("#offerRid").val(result.offerRid);
		$("#ofrNm").val(result.offerNm);
		$("#ofrNo").val(result.offerNo);
		$("#ofrSubType").val(result.ofrSubType);
		$("#ofrValAmt").val(result.amt);
		if(result.ofrType=='P') {
			$("#ofrValType").val("F");
			$("#ofrValAmt").attr("disabled",false);
			$("#qty").attr("disabled",true);
	    	$("#qty").val("");
	    	/* $("#textLabel").text("원"); */
		} else {
			$("#ofrValType").val(result.ofrValType);
			$("#ofrValAmt").val(result.ofrValAmt);
			$("#ofrValAmt").attr("disabled",true);
			$("#qty").attr("disabled",false);
			/* $("#textLabel").text("%"); */
		}
		if(result.ofrValType=='R' ) {
        	$("#textLabel").text("%");
        } else if (result.ofrValType=='F' || result.ofrValType=='B') {
        	$("#textLabel").text("원");
        }
		
		cpnYn= result.cpnYn;
		if(cpnYn=='Y') {
			/* $("#qty").attr("disabled",false); */
	    	$("#cpnYn").val("쿠폰");
	    	/* $("#textLabel").text("원"); */
	    } else {
	    	/* $("#qty").attr("disabled",true);
	    	$("#qty").val(""); */
	    	$("#cpnYn").val("");
	    	/* $("#textLabel").text("Point"); */
	    }
		$("#tierBnftTypeCd").val(result.tierBnftTypeCd);
		$("#bnftActCycleCd").val(result.bnftActCycleCd);
		$("#bnftActRotCycleCd").val(result.bnftActRotCycleCd);
		$("#qty").val(result.qty);
		
		priceFields.forEach(function(vf) { 
			var vfVal = $('#' + vf).val();						
			$('#'+ vf).val($.fn.ifvmNumberWithCommas(vfVal));
			$('#' + vf).css("text-align", "right");
		});
	});
}

function offerListPopup() {
    var targetFields = { name : "ofrNm", rid : "offerRid",no : "ofrNo",ofrSubType : "ofrSubType"};
    $.fn.ifvmSearchHelpOpen(targetFields, null,  'offerListPop', '<ifvm:url name="offerPop"/>', '오퍼 등록');
   
}

function offerPopupClose() {
	offerListPop._destroy();
}

function saveTierBnft(){
	var validation = $("#tierBnftAddForm").ifvValidation();

	//유효성 체크
	if(validation.confirm()){
		if(seqNo=='1') {
			if($("#tierBnftTypeCd").val() == 'TW' || $("#tierBnftTypeCd").val() == 'TR') {
			alert("1순위 등급에는 승급유형을 넣을수 없습니다.");
			return;
			}
		}
		
		if($("#tierBnftTypeCd").val()=='TA' && $("#bnftActCycleCd").val()=='ONE') {
			alert("상시유형에는 주기유형 1회를 넣을 수 없습니다.");
			return;
		}
		
		if($("#tierBnftTypeCd").val()=='TU' && $("#bnftActRotCycleCd").val()!='NONE') {
			alert("승급유형에는 해당없음 반복주기만 가능합니다.");
			return;
		}
		
			qty = parseInt($("#qty").val().replace(/,/g,""));
			ofrValAmt = parseInt($("#ofrValAmt").val().replace(/,/g,""));

 		var url = tierBnft_isNew? '<ifvm:action name="saveTierBnft"/>' : '<ifvm:action name="modifyTierBnft"/>';
		var varData = null;
		varData = {
				rid		       			: tierBnftRid,
				tierRid					: tierRid,
				tierBnftTypeCd			: $("#tierBnftTypeCd").val(),
				bnftActCycleCd   		: $("#bnftActCycleCd").val(),
				bnftActRotCycleCd	    : $("#bnftActRotCycleCd").val(),
				offerRid	   			: $("#offerRid").val(),
				qty						: qty,
				amt						: ofrValAmt
		};
		$.ifvSyncPostJSON(url, varData
			, function(result) {
				if ($.fn.ifvmIsNotEmpty(result)) {
					alert("<spring:message code="C00094" />");
					addTierBnftClosePop();
					gettierBnftList();
					tierBnft_isNew = false;
				}
			}, function(result) {
				if(result.message) {
					alert(result.message);
					return;
				}
				else {
					alert("<spring:message code="M02248" />");
					return;
				}
		});
	}
}

function setCommaKeyup(){
	priceFields.forEach(function(vf) { 
		$('#' + vf).keyup(function() {
			var vfVal = $('#' + vf).val();						
			$('#'+ vf).val($.fn.ifvmNumberWithCommas(vfVal));
			$('#' + vf).css("text-align", "right");
		});
	})
}

function tierBnftCancle() {
	addTierBnftClosePop();
}

$(document).ready(function(){
	$.fn.ifvmSetSelectOptionCommCode("tierBnftTypeCd", "LOY_TIER_BNFT_TYPE_CD", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("bnftActCycleCd", "LOY_TIER_BNFT_ACT_CYCLE", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("bnftActRotCycleCd", "LOY_TIER_BNFT_ACT_ROT_CYCLE", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("ofrSubType", "LOY_OFR_SUB_TYPE", null, null, false);
	$.fn.ifvmSetSelectOptionCommCode("ofrValType", "LOY_OFR_VAL_TYPE", null, null, false);

	tierBnftInit();
	
	//닫기
	$("#tierBnftClose").on("click",function(){
		tierBnftCancle();
	});
	
	$("#offerSearchPopBtn").click(function(){
		offerListPopup();
	});
	
	$("#saveTierBnft").click(function(){
		saveTierBnft();
	});
	
	setCommaKeyup();
	
});

</script>