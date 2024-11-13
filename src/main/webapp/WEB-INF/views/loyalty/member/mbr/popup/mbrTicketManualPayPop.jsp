<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
</script>

<!-- *********************************** 
노출 : 회원번호
설정 select : 티켓지급유형 (포인트차감, 이벤트 등등)
수량 text 입력 : 숫자체크
입력값으로 procedure call
*********************************** -->
 
 
 <%-- 
<div class="form-horizontal underline top_well" id="regDeviceDetailForm">
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="regMbrNo" dto="regMbrNo" label="회원번호" nuc="true" labelClass="3" conClass="7" disabled="true" required="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="" dto="serialNo" label="티켓 지급 유형" nuc="true" labelClass="3" conClass="7" required="true"/>
	</div>
	<div class="row qt_border">
		<ifvm:inputNew type="text" id="trNo" dto="trNo" label="지급 티켓 수량" nuc="true" labelClass="3" conClass="7"/>
	</div>
</div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="regDeviceSaveBtn">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="M00280"/>
	</button>
	<button class="btn btn-sm btn_gray btn_lightGray2" id="regDeviceCancelBtn">
		<spring:message code="M00284"/>
	</button>
</div>
 --%>