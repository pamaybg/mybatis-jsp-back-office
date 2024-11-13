<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div class="pop_inner_wrap">
	<div class="form-horizontal underline" id="mbrGroupPopWrap">
		<div class="form-horizontal top_well">
			<div class="row">
				<ifvm:inputNew type="select" id="ouTypeCd"   dto="ouTypeCd" required="true"
					label="L01456" labelClass="2" conClass="2" /><!-- 단체 유형-->
				<ifvm:inputNew type="text" id="chnlNm"   dto="chnlNm" required="true"
					label="L01457" labelClass="2" conClass="2" /><!-- 단체 상호-->
				<ifvm:inputNew type="text" id="mbrbsCdadd"   dto="mbrbsCdadd"    required="true"
					label="L01458" labelClass="2" conClass="2" /><!-- 단체 약호-->
			</div>
			<div class="row">
				<ifvm:inputNew type="search" id="parChnlNm"   dto="parChnlNm"    required="true"
					label="L01459" labelClass="2" conClass="2" /><!-- 상위가맹점-->
				<ifvm:inputNew type="text" id="bizrNo"   dto="bizrNo"    required="true"
					label="L01460" labelClass="2" conClass="2" /><!-- 사업자번호-->
				<ifvm:inputNew type="text" id="reprNm"   dto="reprNm"
					label="L01461" labelClass="2" conClass="2" /><!-- 대표자명-->
			</div>
		</div>
	</div>
</div>
<div class="pop_btn_area">
    <ifvm:inputNew type="button" text="L00817" btnFunc="addMbrCarHistInfo" className="btn_lightGray2"/>
    <ifvm:inputNew type="button" text="L00073" btnFunc="gMbrGroupList.addMbrGroup.close" className="btn_lightGray2"/>
</div>
<script>
	$.ifvGetCommCodeList('select', 'mbrGroupPopWrap #ouTypeCd', '<ifvm:action name="getCommCodeList2"/>', 'PARTNER_TYPE', 'loy', false, false, true);

	function addMbrCarHistInfo(){
		var mbrCarHistVali = $("#mbrGroupPopWrap").ifvValidation();
		if(mbrCarHistVali.confirm() == true){
			var dataObj = $("#mbrGroupPopWrap").getSubmitData();
			console.log(dataObj);
			/* dataObj.ridMbr = $.ifvGetParam('rid');
			var action = '<ifvm:action name="addMbrCarHist"/>';
			$.ifvSyncPostJSON(action, dataObj, function(result) {

				if(result.success){
					alert('<spring:message code="L01257"/>');
					addMbrCarHistPopup.close(result);

				}

			}) */
		}
	}

</script>