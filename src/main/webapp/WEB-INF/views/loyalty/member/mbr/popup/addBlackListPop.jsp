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
	<div class="form-horizontal underline" id="mbrBlackListPopWrap">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="select" id="regStatCd"   dto="regStatCd" required='true'
					label="L01069" labelClass="2" conClass="2" /><!-- 부정회원구분-->
				<ifvm:inputNew type="select" id="actnDiv"   dto="actnDiv"	disabled="true"
					label="L01070" labelClass="2" conClass="2" /><!-- 조치구분-->
				<ifvm:inputNew type="text" id="regDtlRsnMemo"   dto="regDtlRsnMemo"
					label="L01071" labelClass="2" conClass="2" /><!-- 비고-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="ridChnl"   dto="ridChnl"
					label="L01072" labelClass="2" conClass="2" /><!-- 관련충전소-->
				<ifvm:inputNew type="text" id="cardNo"   dto="cardNo"
					label="L01073" labelClass="2" conClass="2" /><!-- 카드번호-->
				<ifvm:inputNew type="text" id="totAcuPoint"   dto="totAcuPoint"
					label="L01074" labelClass="2" conClass="2" /><!-- 총적립포인트-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="tgtMonth"   dto="tgtMonth"
					label="L01075" labelClass="2" conClass="2" /><!-- 대상월-->
				<ifvm:inputNew type="text" id="maxChargeExcsPoint"   dto="maxChargeExcsPoint"
					label="L01076" labelClass="2" conClass="2" /><!-- 최대충전초과포인트-->
				<ifvm:inputNew type="hidden" id="rid"   dto="rid"
					label="L01076" labelClass="2" conClass="2" />
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
    <ifvm:inputNew type="button" text="L00817" btnFunc="addMbrBlackListInfo" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" text="L00073" btnFunc="addMbrBlackListPopup.close" className="btn_lightGray2"/>
</div>

<script>
	var rid = '<%= cleanXss(request.getParameter("rid")) %>';
	$.ifvGetCommCodeList('select', 'regStatCd', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CLAIM_CD', 'loy', false, false);
	$.ifvGetCommCodeList('select', 'actnDiv', '<ifvm:action name="getCommCodeList2"/>', 'CLAIM_MANAGE_TYPE', 'loy', false, false);

	$("#regStatCd").change(function(){
		var statCd  = $(this).find('option:selected').val();
		if(statCd == 'C20'){
			$("#actnDiv").prop('disabled',false).empty();
			$.ifvGetCommCodeList('select', 'actnDiv', '<ifvm:action name="getCommCodeList2"/>', 'CLAIM_MANAGE_TYPE', 'loy', false, false);
		}else{
			$("#actnDiv").empty().prop('disabled',true);
		}
	})

	function addMbrBlackListInfo(){
		var mbrCarHistVali = $("#mbrBlackListPopWrap").ifvValidation();
		if(mbrCarHistVali.confirm() == true){
			var dataObj = $("#mbrBlackListPopWrap").getSubmitData();
			console.log(dataObj);
			dataObj.ridCust = gMbrDetail.data.ridCust;
			dataObj.ridMbr = gMbrDetail.data.rid;

			var action = (rid != "null") ? '<ifvm:action name="updateMbrBlackHist"/>' : '<ifvm:action name="addMbrBlackHist"/>';
			$.ifvSyncPostJSON(action, dataObj, function(result) {

				if(result.success){
					(rid != "null") ? msg = '<spring:message code="L01260"/>' : msg ='<spring:message code="L01257"/>'
					alert(msg);
					addMbrBlackListPopup.close(result);
				}
			})
		}
	}

	if(rid != "null"){
		var action ='<ifvm:action name="getMbrBlackInfo"/>';
		var dataObj = {
				rid : rid
		}
		$.ifvSyncPostJSON(action, dataObj, function(result) {

			if ($.fn.ifvmIsNotEmpty(result)) {
				$("#mbrBlackListPopWrap").dataSetting(result);
				$("#regStatCd").trigger('change');
				$("#mbrBlackListPopWrap").dataSetting(result);

			}
		})
	}


</script>