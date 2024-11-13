<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="form-horizontal underline top_well" id="termsVersionDetail">
<br>
	<div class="row">
		<div class="col-xs-6" >
			<ifvm:inputNew type="select" id="mktRcvChnlCd" names="mktRcvChnlCd" dto="mktRcvChnlCd"  label="L02600" labelClass="3" conClass="9" required="true"/>
		</div>
		<div class="col-xs-6" >
			<ifvm:inputNew type="date" id="startDate" names="startDate" label="L00153" labelClass="3" conClass="9" required="true" />	
		</div>
	</div>
	<br>
	<div class="row">
		<div class="col-xs-6" >
			<ifvm:inputNew type="text" id="seqNo" names="seqNo" dto="seqNo" label="M00240" labelClass="3" conClass="2" required="true" />	
		</div>
		<div class="col-xs-6">
			<ifvm:inputNew type="select" id="rcvUseYn" names="rcvUseYn" dto="rcvUseYn" label="M02513" labelClass="3" conClass="4" required="true" />	
		</div>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray"  id="btnSave" objCode="termsRcvChnlPopSave_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="C00164" />
	</button> 
	<button class="btn btn-sm btn_lightGray2" id="btnCancel" objCode="termsRcvChnlPopCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var isNew;
var chnlRid;

function initRcvDetail() {
    var startDate = $("#startDate");
	
   	startDate.val($.ifvGetTodayDate());

	startDate.ifvDateChecker({
		minDate : "today",
	});
	
	$.fn.ifvmSetSelectOptionCommCode("rcvUseYn", "COM_STAT_TYPE_3_CD", null, null, true);
	//$.fn.ifvmSetSelectOptionCommCode("mktRcvChnl", "LOY_CUST_AGRE_TYPE_CD", null, null, true);
	$.fn.ifvmSetSelectOptionCommCodeSyncSelfJoin("mktRcvChnlCd", "LOY_CUST_AGRE_TYPE_CD", null, 'C1', true);
	
	if (typeof chnlRid === 'undefined' || chnlRid ==null)	
		isNew = true;

	else	{
		isNew = false;
		//약관이 활성일때는 항목을 수정 할 수 없습니다.
		if($("#statCd").val()=='A') {
			$("#mktRcvChnlCd").attr('disabled', true);
			$("#startDate").attr('disabled', true);
		}
		getRcvChnlDetail();
	}
}

function getRcvChnlDetail(){
	$.ifvSyncPostJSON('<ifvm:action name="getRcvChnlDetail"/>',{
		rid : chnlRid,
		parRid : parRid
	},function(result) {
		$("#mktRcvChnlCd").val(result.mktRcvChnlCd),
		$("#startDate").val(result.startDate),
		$("#rcvUseYn").val(result.useYn),
		$("#seqNo").val(result.seqNo)
		
	});
}

function saveRcvChnlDetail(){
		var validation = $("#termsVersionDetail").ifvValidation();
		if(validation.confirm()){
			var tUrl = isNew? '<ifvm:action name="saveTermsRcvChnl"/>' : '<ifvm:action name="modifyTermsRcvChnl"/>';
			var tData = null;
			tData = {
					ridTermsM : parRid,
					rid : chnlRid,
					mktRcvChnlCd : $("#mktRcvChnlCd").val(),
					startDate : $("#startDate").val(),
					useYn : $("#rcvUseYn").val(),
					seqNo : $("#seqNo").val()
			};
			
			$.ifvSyncPostJSON(tUrl, tData
				, function(result) {
					if ($.fn.ifvmIsNotEmpty(result)) {
						alert("<spring:message code="C00094" />");
					}
					termsRcvChnlPopupClose();
					rcvChnlList._doAjax();
				}, function(result) {
					if(result.message != null) alert(result.message);
					else alert("<spring:message code="M02248" />");
			});
		}
}

$(document).ready(function(){
	initRcvDetail();
	
	$("#btnSave").click(function(){
		 saveRcvChnlDetail();
	});
	
	$("#btnCancel").click(function(){
		termsRcvChnlPopupClose();
	});
});
</script>