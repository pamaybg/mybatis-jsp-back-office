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
<div class="pop_inner_wrap">
	<div class="form-horizontal underline" id="mbrTmAgrHistPopWrap">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="hidden" id="rid"   dto="rid" /><!-- 적립기준코드 rid -->
				<ifvm:inputNew type="select" id="cprtType"   dto="cprtType"	required="true"
					label="L01807" labelClass="2" conClass="2" /><!-- 제휴유형-->
				<ifvm:inputNew type="select" id="cprtCmpnDiv"   dto="cprtCmpnDiv"	required="true"
					label="L01808" labelClass="2" conClass="2" /><!-- 제휴사-->
				<ifvm:inputNew type="singleCheckbox" id="tmAgreeYn" label="L01809" values="tmAgreeYn"
							labelClass="2" conClass="2" />
			</div>
			<div class="row">
				<ifvm:inputNew type="select" id="tmAgreeRcpChnl"   dto="tmAgreeRcpChnl"
					label="L01810" labelClass="2" conClass="2" /><!-- TM동의접수채널-->
				<ifvm:inputNew type="text" id="tmAgreeDd"   dto="tmAgreeDd"	disabled="true"
					label="L01811" labelClass="2" conClass="2" /><!-- TM동의일시-->
				<ifvm:inputNew type="search" id="dspmt"   dto="dspmt"	disabled="false"
					label="L01812" labelClass="2" conClass="2" /><!-- TM동의캠페인-->

			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="memCntcDesk"   dto="memCntcDesk"	disabled="true"
					label="L01813" labelClass="2" conClass="2" /><!-- 회원연락처-->
				<ifvm:inputNew type="text" id="chnlNo"   dto="chnlNo"	disabled="true"
					label="L01814" labelClass="2" conClass="2" /><!-- TM동의충전소명-->
				<ifvm:inputNew type="text" id="cprtCmpnTrmDt"   dto="cprtCmpnTrmDt"	disabled="true"
					label="L01816" labelClass="2" conClass="2" /><!-- 제휴사전송일시-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="rmark"   dto="rmark"
					label="L01815" labelClass="2" conClass="10" /><!-- 비고-->
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
    <ifvm:inputNew type="button" btnType="save"	text="L01462" id="addMbrTmInfoBtn"	btnFunc="addMbrTmInfo" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" btnType="close"	text="L00913" btnFunc="addTmAgeHistPopup.close" className="btn_lightGray2"/>
</div>

<script>
	var rid = '<%= cleanXss(request.getParameter("rid")) %>';
	console.log(rid);
	$.ifvGetCommCodeList('select', 'cprtType', '<ifvm:action name="getCommCodeList2"/>', 'ALLIANCE_TYPE', 'loy', false, false);
	$.ifvGetCommCodeList('select', 'cprtCmpnDiv', '<ifvm:action name="getCommCodeList2"/>', 'ALLIANCE_COMPANY_TYPE', 'loy', false, false);
	$.ifvGetCommCodeList('select', 'tmAgreeRcpChnl', '<ifvm:action name="getCommCodeList2"/>', 'ALI_TM_AGRE_CHNL', 'loy', false, false);


	function addMbrTmInfo(){
		var mbrCarHistVali = $("#mbrTmAgrHistPopWrap").ifvValidation();
		if(mbrCarHistVali.confirm() == true){
			var dataObj = $("#mbrTmAgrHistPopWrap").getSubmitData();
			console.log(dataObj);
			dataObj.ridMbr = $.ifvGetParam('rid');
			if($("#mbrTmAgrHistPopWrap #tmAgreeYn").is(":checked")){
				dataObj.tmAgreeYn = "Y";
			}else{
				dataObj.tmAgreeYn = "N";
			}
			var action = (rid != "null") ? '<ifvm:action name="updateMbrTmAgrHist"/>' : '<ifvm:action name="addMbrTmAgrHist"/>';
			$.ifvSyncPostJSON(action, dataObj, function(result) {

				if(result.success){
					(rid != "null") ? msg = '<spring:message code="L01260"/>' : msg ='<spring:message code="L01257"/>'
					alert(msg);
					addTmAgeHistPopup.close(result);
				}

			})
		}
	}


	//상세
	if(rid != "null"){
		var action ='<ifvm:action name="getMbrTmAgrInfo"/>';
		var dataObj = {
				rid : rid
		}
		$.ifvSyncPostJSON(action, dataObj, function(result) {

			if ($.fn.ifvmIsNotEmpty(result)) {
				$("#mbrTmAgrHistPopWrap").dataSetting(result);
				if(result.tmAgreeYn == "Y"){
					$("#mbrTmAgrHistPopWrap #tmAgreeYn").prop("checked",true);

				}
				if(result.tmAgreeDd){
					$("#mbrTmAgrHistPopWrap #tmAgreeDd").val(result.tmAgreeDd.split('.')[0]);
				}
				if(result.cprtCmpnTrmDt){
					$("#mbrTmAgrHistPopWrap input, #mbrTmAgrHistPopWrap select").prop('disabled',true);
					$("#mbrTmAgrHistPopWrap .input-group-addon, #addMbrTmInfoBtn").remove();
				}

			}
		})
	}
</script>