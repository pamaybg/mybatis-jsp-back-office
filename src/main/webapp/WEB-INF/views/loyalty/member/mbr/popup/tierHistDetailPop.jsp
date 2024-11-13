<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="form-horizontal underline top_well" id="chnlSettleAddForm">
<br>
	<div class="row qt_border">
				<ifvm:inputNew type="textarea" maxLength="150" id="tierMnlReasonDesc" disabled="true" dto="tierMnlReasonDesc" label="변경사유" labelClass="2" conClass="9" rows="5"/>
	
	</div>

	<div class="row qt_border">
				<ifvm:inputNew type="text" id="approvalReqNm" names="approvalReqNm" label="결제요청자" disabled="true" labelClass="2" conClass="3" />
				<ifvm:inputNew type="text" id="approvalReqDate" names="approvalReqDate" label="결재요청일자" disabled="true" labelClass="2" conClass="3" />
				
	</div>
	<div class="row qt_border">
				<ifvm:inputNew type="text" id="approvalResNm" names="approvalResNm" label="승인자"  disabled="true" labelClass="2" conClass="3" />
				<ifvm:inputNew type="text" id="approvalResDate" names="approvalResDate" label="승인일자" disabled="true" labelClass="2" conClass="3" />
	</div>

</div>
<div class="pop_btn_area">

	<!-- 닫기 -->
	<button class="btn btn-sm btn_gray btn_lightGray2" id="tierDetailPopCancel" objCode="tierDetailPopCancel">
		<spring:message code="L01781"/>
	</button>
</div>
<div id="tierHistDetailPop" class="popup_container"></div>

<script type="text/javascript">

function getHistDetail() {
	$.ifvSyncPostJSON('<ifvm:action name="getTierDetailPop"/>', {
		rid : tierHistRid
	}, function(result) {
		$("#tierMnlReasonDesc").val(result.tierMnlReasonDesc);
		$("#approvalReqNm").val(result.reqNm);
		$("#approvalReqDate").val(result.createDate);
		$("#approvalResNm").val(result.resNm);
		$("#approvalResDate").val(result.lastApvDd);
	}, function(result) {
		alert(result.message);
	});
}


$(document).ready(function(){
	getHistDetail();
	
	$("#tierDetailPopCancel").click(function(){
		tierHistDetailClosePop();
	});
});

</script>