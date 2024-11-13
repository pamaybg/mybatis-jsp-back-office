<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="ifvm" tagdir="/WEB-INF/tags" %>

<article data-location="모니터링,서비스 테스트">
	<header>
		<h3>서비스 테스트</h3>
	</header>
	<div class="content">
		<article id="posArt">
			<header>
				<h4>POS 요청/응답 전문</h4>
				<ul class="btn_container">
					<li>
						<ifvm:inputNew
						type="button"
						btnType="send"
						text="전송"
						nuc="true"
						btnFunc="transmitMsg" />
					</li>
					<li>
						<ifvm:inputNew
						type="button"
						btnType="reset"
						text="초기화"
						nuc="true"
						btnFunc="initializeMsg" />
					</li>
				</ul>
			</header>
			<div class="content">
				<div class="form_container" id="msgForm">
					<div class="form_row">
						<div class="col-xs-12 label_top">
							<ifvm:inputNew 
							type="textarea"
							id="reqMsg"
							dto="reqMsg"
							label="요청 전문"
							nuc="true"
							labelClass="2"
							conClass="9"
							rows="16"
							required="true" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-12 label_top">
							<ifvm:inputNew 
							type="textarea"
							id="resMsg"
							dto="resMsg"
							label="응답 전문"
							nuc="true"
							labelClass="2"
							conClass="9"
							rows="16"
							readonly="true" />
						</div>
					</div>
				</div>
			</div>
		</article>
	</div>
	<div class="content">
		<article id="restApiArt">
			<header>
				<h4>Rest API 요청/응답 전문</h4>
				<ul class="btn_container">
					<li>
						<ifvm:inputNew
						type="button"
						btnType="send"
						text="전송"
						nuc="true"
						btnFunc="transmitJson" />
					</li>
					<li>
						<ifvm:inputNew
						type="button"
						btnType="reset"
						text="초기화"
						nuc="true"
						btnFunc="initializeJson" />
					</li>
				</ul>
			</header>
			<div class="content">
				<div class="form_container" id="jsonForm">
					<div class="form_row">
						<div class="col-xs-12">
							<ifvm:inputNew 
							type="text"
							id="targetUrl"
							dto="targetUrl"
							required="true"
							label="서비스 Endpoint"
							nuc="true"
							labelClass="2"
							conClass="9"
							maxLength="200" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-12">
							<ifvm:inputNew
							type="checkbox"
							id="isUsingHmac"
							dto="isUsingHmac"
							label="HMAC 사용 여부"
							text="사용"
							nuc="true"
							labelClass="2"
							conClass="9" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-12 label_top">
							<ifvm:inputNew 
							type="textarea"
							id="reqJson"
							dto="reqJson"
							label="요청 전문"
							nuc="true"
							labelClass="2"
							conClass="9"
							rows="16"
							maxLength="3000" />
						</div>
					</div>
					<div class="form_row">
						<div class="col-xs-12 label_top">
							<ifvm:inputNew 
							type="textarea"
							id="resJson"
							dto="resJson"
							label="응답 전문"
							nuc="true"
							labelClass="2"
							conClass="9"
							rows="16"
							maxLength="3000"
							readonly="true" />
						</div>
					</div>
				</div>
			</div>
		</article>
	</div>
</article>

<script>

var msgFormVali = $("#msgForm").ifvValidation();
var jsonFormVali = $("#jsonForm").ifvValidation();

var confirmMsg = "전송되었습니다.";

//POS 메시지 전송
function transmitMsg() {
	if(msgFormVali.confirm()) {
		var sendData = $("#msgForm").getSubmitData();
		var url = "<ifvm:action name='transmitMsg'/>";
		$.ifvPostJSON(
			url,
			sendData,
			function(_result) {
				$("#msgForm").dataSetting(_result, null, false, []);
				alert(confirmMsg);
			}, null, "#posArt", "bigsize_progressRoll include_progress"
		);
	}
}

//POS 메시지 초기화
function initializeMsg() {
	$("#msgForm").ifvFormClean([]);
}

//Rest API 메시지 전송
function transmitJson() {
	if(jsonFormVali.confirm()) {
		var sendData = $("#jsonForm").getSubmitData();
		var url = "<ifvm:action name='transmitJson'/>";
		$.ifvPostJSON(
			url,
			sendData,
			function(_result) {
				if(_result.message != null) {
					alert(_result.message);
				} else {
					$("#jsonForm").dataSetting(_result, null, false, []);
					alert(confirmMsg);
				}
			}, null, "#restApiArt", "bigsize_progressRoll include_progress"
		);
	}
}

//Rest API 메시지 초기화
function initializeJson() {
	$("#jsonForm").ifvFormClean([]);
	isUsingHmac1.checked = false;
}

</script>