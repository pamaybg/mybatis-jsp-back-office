<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="form-horizontal top_well underline" id="clubOfferDetail">
<br>
	<div class="row qt_border">
		<ifvm:inputNew type="search" id="ofrNm" names="ofrNm" dto="ofrNm" btnFunc="getOfferList"  label="M00314" labelClass="2" conClass="8"  disabled="true" required="true" />
		<ifvm:inputNew type="hidden" id="ridOfr" names="ridOfr" dto="ridOfr" label="M00314" conClass="5"  disabled="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="bnftTypeCd" names="bnftTypeCd" dto="bnftTypeCd" label="M02942" labelClass="2" conClass="8" />	
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="select" id="acrlCycleTypeCd" names="acrlCycleTypeCd" dto="acrlCycleTypeCd" label="M00893" labelClass="2" conClass="8"/>	
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="ofrAmt" names="ofrAmt" dto="ofrAmt" label="O00026" labelClass="2" conClass="4" />	
	</div>
	<br>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="saveOfferBtn" objCode="clubOfferDetailSave_OBJ">
		<spring:message code="M01855" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="cancelOfferBtn" objCode="clubOfferDetailCancel_OBJ">
		<spring:message code="I00404" />
	</button>
</div>
<div id="offerPopContainer" class="popup_container"></div>

<script type="text/javascript">

function getOfferList(){
    var targetFields = { name : "ofrNm", rid : "ridOfr" };
    $.fn.ifvmSearchHelpOpen(targetFields, null, 'offerPopContainer', '<ifvm:url name="offerPop"/>', '<spring:message code="M00794"/>');
}

var getClubOfferDetail= {
		init : function(){	
			
			if (typeof clubOfferRid === 'undefined' || clubOfferRid == null) {
				isNew = true;		
				$("#ofrNm").val("");
				$("#ridOfr").val("");
				$("#ofrAmt").val("");
				$.fn.ifvmSetSelectOptionCommCode("bnftTypeCd", "LOY_CLUB_BNFT_TYPE_CD", null, null, true);
				$.fn.ifvmSetSelectOptionCommCode("acrlCycleTypeCd", "LOY_CLUB_ACRL_CYCLE_TYPE", null, null, true);
			}
			else{
				isNew = false;
				$.ifvSyncPostJSON('<ifvm:action name="getClubOfferDetail"/>',{
					rid : clubOfferRid
				},function(result){
					$("#ofrNm").val(result.ofrNm);
					$("#ridOfr").val(result.ridOfr);
					$("#ofrAmt").val(result.ofrAmt);
					$.fn.ifvmSetSelectOptionCommCode("bnftTypeCd", "LOY_CLUB_BNFT_TYPE_CD", result.bnftTypeCd, null, true);
					$.fn.ifvmSetSelectOptionCommCode("acrlCycleTypeCd", "LOY_CLUB_ACRL_CYCLE_TYPE", result.acrlCycleTypeCd, null, true);
				});
			}
			$("#ofrAmt").ifvNumberOnly();
		}, 
		save : function(){
			var tUrl = isNew? '<ifvm:action name="saveClubOfferDetail"/>' : '<ifvm:action name="modifyClubOfferDetail"/>';
			var tData = null;
			var amt = parseInt($("#ofrAmt").val().replace(/,/g,""));
			tData = {
				rid : clubOfferRid,
				parRid : clubRid,
				ridOfr : $("#ridOfr").val(),
				ofrAmt : amt,
				bnftTypeCd : $("#bnftTypeCd").val(),
				acrlCycleTypeCd : $("#acrlCycleTypeCd").val()
			};
			$.ifvSyncPostJSON(tUrl, tData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094"/>");
						clubOfferDetailPopupClose();
						clubOfferList._doAjax();
					}
				}, function(result) {
					alert('<spring:message code="M02248"/>');
			});
		}
}

$(document).ready(function(){
	
	getClubOfferDetail.init();
	
	$("#saveOfferBtn").click(function(){
		var validation = $("#clubOfferDetail").ifvValidation();
		if(validation.confirm()) getClubOfferDetail.save();
		else return;
	});
	
	$("#cancelOfferBtn").click(function(){
		clubOfferDetailPopupClose();
	});
});
</script>