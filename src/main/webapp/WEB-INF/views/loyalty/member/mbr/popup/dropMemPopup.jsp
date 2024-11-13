<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<style>

.warning_box {
	padding: 15px 15px;
	color: red
}

</style>
<script>
var promotionSearchHelpPopup = null;


/**
 * 취소
 */
function fndropReasonClose() {
	dropMemPopup.close();
}

$(document).ready(function() {

	$("#mbrNoD").val(mbrNo);
	$("#custTypeCdNmD").val(custTypeCdNm);
	$("#custNmD").val(custNm);
	$("#hhpD").val(hhp);
	$("#ciYnD").val(ciYn);
	$("#bizrNoD").val(bizrNo);
	$("#empNoD").val(empNo);
	$("#secsnResnCdNmD").val(secsnResnCdNm);
	$("#secsnResnEtcD").val(secsnResnEtc);
	$("#reSbscResnD").val(reSbscResn);
	$("#secsnDateD").val(secsnDate);

});



</script>

<div class="form-horizontal underline top_well clearfix" id="editMbrPntUsePwForm">
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="mbrNoD" label="회원번호"  labelClass="3" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="custTypeCdNmD" label="고객유형"  labelClass="3" conClass="3" disabled="true"/>
			
			</div>
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="custNmD" label="이름"  labelClass="3" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="hhpD" label="휴대전화번호"  labelClass="3" conClass="3" disabled="true"/>
			</div>		
		</div>
		
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="ciYnD" label="CI값유무"  labelClass="3" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="bizrNoD" label="사업자번호"  labelClass="3" conClass="3" disabled="true"/>
			</div>	
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="empNoD" label="사번"  labelClass="3" conClass="3" disabled="true"/>
				<ifvm:inputNew type="text" id="secsnResnCdNmD" label="탈회사유"  labelClass="3" conClass="3" disabled="true"/>
			</div>							
		</div>	
		<div class="row">
			<div class="col-xs-6">
			    <ifvm:inputNew type="textarea" id="secsnResnEtcD"  conClass="9" label="탈회사유 상세" labelClass="3"  rows="10" maxLength="2000" disabled="true"/>
			</div>		
			<div class="col-xs-6">
			    <ifvm:inputNew type="textarea" id="reSbscResnD"  conClass="9" label="식별키 삭제 사유" labelClass="3"  rows="10" maxLength="2000" disabled="true"/>
			</div>			
		</div>
		<div class="row">
			<div class="col-xs-6">
				<ifvm:inputNew type="text" id="secsnDateD" label="탈회일시"  labelClass="3" conClass="5" disabled="true"/>
			</div>		
		</div>
</div>

<div class="pop_btn_area">
   <ifvm:inputNew type="button" btnType="close"	text="L00913" id="dropReasonClose" btnFunc="fndropReasonClose" className="btn_lightGray2" objCode="dropReasonClose_OBJ"/>
</div>