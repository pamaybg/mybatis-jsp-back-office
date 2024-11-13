<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- 이미지 업로드 -->
<%@ include file="/WEB-INF/views/layouts/default/sessionScript.jsp" %>
<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/common/imgUpload.js'></script>
<div class="page-title">
    <h1>
		QnA &gt; QnA 상세
    </h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-3">※ 답변내용은 최대 4000byte를 넘을 수 없습니다. </div>
	    <div class="col-xs-9 searchbtn_r">
			<ifvm:inputNew type="button" id="btnMasterSave" btnFunc="btnSnsContentSaveClick" btnType="save" text="답변 완료" nuc="true" objCode="qnaMangerbtnMasterSave_OBJ"/>
			<ifvm:inputNew type="button" id="btnList" btnFunc="btnListClick" text="D00024" objCode="qnaManagerbtnList_OBJ"/>
	    </div>
	</div>
	
	<div class="well form-horizontal" id="shareSnsContentForm">
		<!-- 접수  -->
		<div class="row at_border">
			<ifvm:inputNew type="select" id="srStatus" names="srStatus" dto="srStatus" label="접수" nuc="true" labelClass="2" conClass="1"/>	
		</div>
		<!-- SR번호 , SR유형 , 접수일시  -->
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="srNo" names="srNo" dto="srNo" disabled="true" nuc="true" label="SR 번호" labelClass="2" conClass="2"/>
			<ifvm:inputNew type="text" id="srType" names="srType" dto="srType" disabled="true" nuc="true" label="SR 유형" labelClass="1" conClass="2"/>
			<ifvm:inputNew type="text" id="srReqDt" names="srReqDt" dto="srReqDt" disabled="true" nuc="true" label="접수일시" labelClass="1" conClass="2"/>
		</div>
		
		<!-- 전화번호 이메일 -->
		<div class="row qt_border">
			<ifvm:inputNew type="text" id="srTel" names="srTel" dto="srTel" disabled="true" nuc="true" label="연락처" labelClass="2" conClass="2"/>
			<ifvm:inputNew type="text" id="srEmail" names="srEmail" dto="srEmail" disabled="true" nuc="true" label="email" labelClass="1" conClass="2"/>
		</div>
		
		<!-- 접수내용  -->
		<div class="row qt_border">
			<ifvm:inputNew type="textarea" id="srReqTxt" names="srReqTxt" disabled="true" dto="srReqTxt" label="접수내용"  nuc="true" labelClass="2" conClass="8" rows="5" maxLength="2000" />
		</div>
		
		<!-- 답변내용  -->
		<div class="row qt_border">
			<ifvm:inputNew type="textarea" id="srAnsTxt" names="srAnsTxt" dto="srAnsTxt" label="답변내용" nuc="true" labelClass="2" conClass="8" rows="5" maxLength="2000" required="true" />
		</div>
	</div>
</div>
<script>

var backImage = null;
var updateFlag;
var qnaId = $.ifvGetParam('rid');

//이미지 업로드
var imageInfo = new Array();


//공통 조회 조건 목록 설정
function shareSnsContentSearchInit() {
	$.fn.ifvmSetSelectOptionCommCode("srStatus", "SR_STATUS", null, null, true );
}

//disabled
function disabled(){
	var srStatus = $("#srStatus").val();
	$("#srStatus").prop('disabled',true);
	if(srStatus == 'Closed'){
		$("#srAnsTxt").prop('disabled',true);
		$("#btnMasterSave").prop('disabled',true);
	}else{
		$("#srAnsTxt").prop('disabled',false);
		$("#btnMasterSave").prop('disabled',false);
	}
}

$(document).ready(function() {
	
	shareSnsContentSearchInit();
	detailsnsContent(qnaId);
	disabled();
});

function detailsnsContent(qnaId){
	$.ifvSyncPostJSON('<ifvm:action name="getQnaDetail"/>', {
		rid : qnaId
	}, function(result) {
		$("#srStatus").val(result.srStatus);
		$("#srNo").val(result.srNo);
		$("#srType").val(result.srType);
		$("#srReqDt").val(result.srReqDt);
		$("#srTel").val(result.srTel);
		$("#srEmail").val(result.srEmail);
		$("#srReqTxt").val(result.srReqTxt);
		$("#srAnsTxt").val(result.srAnsTxt);
	});
}

function btnSnsContentSaveClick() {
	
	//총 용량 체크 (콘텐츠 내용을 체크하여 총용량을 계산한다.)
	var totalByte = 0;
	var message = $('#srAnsTxt').val();
	var validation = $("#shareSnsContentForm").ifvValidation();
	
	if(confirm('고객님에게 해당 답변내용이 이메일로 발송됩니다.\n발송하시겠습니까?') === false) return;
	if(validation.confirm() === false) return;
	
	for (var i =0; i < message.length; i++) {
	    var currentByte = message.charCodeAt(i);
	    if (currentByte > 128) totalByte += 2;
	    else totalByte++;
	}
	
	if(totalByte > 1332 ){
		alert('답변내용은 최대 4000Byte를 넘을 수 없습니다.')
	}else{
		 $.ifvSyncPostJSON( '<ifvm:action name="updateQnaDetail"/>',{
			 rid : qnaId
			,srStatus : $("#srStatus").val()
		 	,srAnsTxt : $("#srAnsTxt").val()  //답변내용
		 	,srReqTxt : $('#srReqTxt').val()  //접수내용
		 	,srEmail  : $('#srEmail').val()   //이메일
		 	,smtpAnsTxt : $("#srAnsTxt").val().replace(/(?:\r\n|\r|\n)/g, '<br />')
		 	,smtpReqTxt : $('#srReqTxt').val().replace(/(?:\r\n|\r|\n)/g, '<br />')
		 },function(result) {
				if(result.success == true){
					alert('해당 고객님 이메일로 답변이 발송되었습니다.');
					location.href = '<ifvm:url name="qnaManagementList"/>'
				}else{
					alert('<spring:message code="M00029"/>');
				}
			}
		);
	}
}


function btnListClick() {
	qtjs.href('<ifvm:url name="qnaManagementList"/>');
}


</script>
