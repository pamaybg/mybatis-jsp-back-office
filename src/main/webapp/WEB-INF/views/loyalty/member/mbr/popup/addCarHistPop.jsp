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
	<div class="form-horizontal underline" id="mbrCarHistPopWrap">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="hidden" id="rid"   dto="rid" /><!-- 적립기준코드 rid -->
				<ifvm:inputNew type="select" id="makr"   dto="makr"
					label="L01080" labelClass="2" conClass="2" /><!-- 제조사-->
				<ifvm:inputNew type="select" id="carModel"   dto="carModel"	required="true"
					label="L01081" labelClass="2" conClass="2" /><!-- 차량모델-->
				<ifvm:inputNew type="text" id="carNm"   dto="carNm"    required="true"
					label="L01082" labelClass="2" conClass="2" /><!-- 차량명-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="carNo"   dto="carNo"
					label="L01083" labelClass="2" conClass="2" /><!-- 차량번호-->
				<ifvm:inputNew type="text" id="dspmt"   dto="dspmt"
					label="L01084" labelClass="2" conClass="2" /><!-- 배기량-->
				<ifvm:inputNew type="select" id="autoYn"   dto="autoYn"
					label="L01085" labelClass="2" conClass="2" /><!-- 차량기어-->
			</div>
			<div class="row">
				<ifvm:inputNew type="select" id="useYn"   dto="useYn"
					label="L01086" labelClass="2" conClass="2" /><!-- 주요사용여부-->
				<ifvm:inputNew type="date" id="puDd"   dto="puDd"
					label="L01087" labelClass="2" conClass="2" /><!-- 구입일자-->
				<ifvm:inputNew type="date" id="insurDd"   dto="insurDd"
					label="L01088" labelClass="2" conClass="2" /><!-- 보험일자-->
			</div>
			<div class="row">
				<ifvm:inputNew type="text" id="icom"   dto="icom"
					label="L01089" labelClass="2" conClass="2" /><!-- 보험사-->
				<ifvm:inputNew type="text" id="mkngYy"   dto="mkngYy"
					label="L01090" labelClass="2" conClass="2" /><!-- 연식-->
				<ifvm:inputNew type="select" id="usePrps"   dto="usePrps"
					label="L01091" labelClass="2" conClass="2" /><!-- 사용용도-->
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
    <ifvm:inputNew type="button" btnType="save"	text="L01462" btnFunc="addMbrCarHistInfo" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" btnType="close"	text="L00913" btnFunc="addMbrCarHistPopup.close" className="btn_lightGray2"/>
</div>

<script>
var rid = '<%= cleanXss(request.getParameter("rid")) %>';
	$.ifvGetCommCodeList('select', 'makr', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CAR_COMP', 'loy', false, false);
	$.ifvGetCommCodeList('select', 'carModel', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CAR_CD', 'loy', false, false);
	$.ifvGetCommCodeList('select', 'autoYn', '<ifvm:action name="getCommCodeList2"/>', 'MEMBER_CAR_GEAR', 'loy', false, false);
	$.ifvGetCommCodeList('select', 'usePrps', '<ifvm:action name="getCommCodeList2"/>', 'CAR_USAGE_TYPE', 'loy', false, false);
	$.ifvGetCommCodeList('select', 'useYn', '<ifvm:action name="getCommCodeList2"/>', 'YES_NO_FLAG', 'loy', false, false);

	var puDd  = $('#puDd');
	puDd.val();
	puDd.ifvDateChecker({});
    var insurDd  = $('#insurDd');
    insurDd.val();
    insurDd.ifvDateChecker({});

	function addMbrCarHistInfo(){
		var mbrCarHistVali = $("#mbrCarHistPopWrap").ifvValidation();
		if(mbrCarHistVali.confirm() == true){
			var dataObj = $("#mbrCarHistPopWrap").getSubmitData();
			console.log(dataObj);
			dataObj.ridMbr = $.ifvGetParam('rid');
			var action = (rid != "null") ? '<ifvm:action name="updateMbrCarHist"/>' : '<ifvm:action name="addMbrCarHist"/>';
			$.ifvSyncPostJSON(action, dataObj, function(result) {

				if(result.success){
					(rid != "null") ? msg = '<spring:message code="L01260"/>' : msg ='<spring:message code="L01257"/>'
					alert(msg);
					addMbrCarHistPopup.close(result);
				}

			})
		}
	}

	if(rid != "null"){
		var action ='<ifvm:action name="getMbrCarHistInfo"/>';
		var dataObj = {
				rid : rid
		}
		$.ifvSyncPostJSON(action, dataObj, function(result) {

			if ($.fn.ifvmIsNotEmpty(result)) {
				$("#mbrCarHistPopWrap").dataSetting(result);

			}
		})
	}


</script>