<%@page import="com.icignal.common.util.CommonUtil"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>

   <meta charset="utf-8" http-equiv="X-UA-Compatible" content="IE=edge">
  <!--  <meta charset="utf-8"> -->

    <title>DESCENTE KOREA CRM</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <!--[if lt IE 9]>
    <script src='${pageContext.request.contextPath}/resources/js/html5shiv.js' type="text/javascript"></script>
    <script src='${pageContext.request.contextPath}/resources/js/respond.min.js' type="text/javascript"></script>
    <![endif]-->
    <script type="text/javascript">
    var frameworkReadyUrl = '<%=CommonUtil.getInstance().getCDNServerUrl()%>/resources';</script>

	<jsp:include page="/WEB-INF/views/layouts/default/ifvFramework.jsp" />
    <jsp:include page="/WEB-INF/views/layouts/default/sessionScript.jsp" />
    <jsp:include page="/WEB-INF/views/voc/main/messageScript.jsp" />

    <jsp:include page="/WEB-INF/views/layouts/default/templete.jsp" />
    <jsp:include page="/WEB-INF/views/layouts/default/common.jsp" />

    <script src='${pageContext.request.contextPath}/resources/js/jspdf/jspdf.min.js' type="text/javascript"></script>
    <script src='${pageContext.request.contextPath}/resources/js/html2canvas/html2canvas.js' type="text/javascript"></script>
    <script src='${pageContext.request.contextPath}/resources/js/html2canvas/html2canvas.svg.js' type="text/javascript"></script>
	<script src='${pageContext.request.contextPath}/resources/js/html2canvas/canvg.min.js' type="text/javascript"></script>

    <link href="${pageContext.request.contextPath}/resources/1.4/ifvGrid/css/jqgrid/ui.jqgrid.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/1.4/ifvGrid/css/jqgrid/jquery-ui-custom.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/1.4/ifvGrid/css/ifvGrid.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/resources/js/lib/ifvGrid.js"></script>

    <script src="${pageContext.request.contextPath}/resources/js/lib/util.js"></script>
    <script src='${pageContext.request.contextPath}/resources/js/lib/uuid.js' type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/js/marketing/popup.js" type="text/javascript"></script>

    <!-- BOOTSTRAP -->
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/notification/SmartNotification.min.js"></script>
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/bootstrap/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/bootstrap/css/smartadmin-production.css">


    <!-- FAVICONS -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon/DESCENTE_logo_BI.png" type="image/x-icon">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon/DESCENTE_logo_BI.png" type="image/x-icon">

    <!-- style -->
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/common/common.css" />
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/style.css" />

    <!-- 박선희/20171109/전체화면 스타일 수정  -->
    <link rel="stylesheet" type="text/css" media="screen" href="${pageContext.request.contextPath}/resources/css/marketing/marketing_style.css" />
	<style>
		html, body {margin: 0; padding: 0; height: 100%;}
		body {position: relative;}
		div {margin: 0; padding: 0;}
		/* .top_bar {width: 100%; height: 40px; background-color: #f00; position: fixed; top: 0; left: 0;} */
		#TSPhone {width: 100%; height: 55px; position: fixed; top: 0; left: 0;}
		.iframe_wrap {width: 100%; height: 100%; padding-top: 55px; overflow-y: auto;}
		iframe.main_iframe {margin: 0; padding: 0; border: 0 none; outline: 0 none; }
	</style>
	<script type='text/javascript' src='${pageContext.request.contextPath}/resources/js/voc/softPhoneOCX.js'></script>
</head>
<body>
<OBJECT ID="TSPhone"
	CLASSID="CLSID:9923C402-2A7C-4AC2-BCEC-53B0F88094A6"
	CODEBASE="CubePhone.CAB#version=2,0,0,1">
</OBJECT>

<!-- 	<div class="top_bar" style=""></div> -->
<div id="iframeWrap" class="iframe_wrap">
	<iframe id="mainIframe" class="main_iframe" src="" frameborder="0" scrolling="no">
	</iframe>
	<!-- 전환시도 팝업 -->
	<div id="modifyCallTransferPop" class="popup_container"></div>
	<!-- 부분녹취 팝업 -->
	<div id="setAlliTypePop" class="popup_container"></div>
	<!-- 본인인증 팝업 -->
	<div id="certiPopup" class="popup_container"></div>
</div>

<script>
	var obj;
	var softphoneData = [];
	var mainIframe = document.getElementById('mainIframe');
	var softPhoneInitData = [];

	var cheight = mainIframe.contentWindow.document.body.clientHeight;
	mainIframe.width = document.body.clientWidth > 1220 ? "100%" : '1220px';
	mainIframe.height = document.body.clientHeight > cheight ? "100%" : cheight + 'px';

	//첫번째 메뉴 URL 확인
	if ($.ifvmGetAuthInfo().authMenuList.length > 0) {
		for (var i=0; i < $.ifvmGetAuthInfo().authMenuList.length; i++) {
			if ($.ifvmGetAuthInfo().authMenuList[i].progPath != "") {
				mainIframe.src = $.ifvmGetAuthInfo().authMenuList[i].progPath.split('.jsp')[0];

				break;
			}
		}
	} else {
		qtjs.href('<ifvm:url name="MKTLogin"/>');
	}

	//컨텐츠페이지 화면 height변경시 호출
	function setParentIframeHeight() {

		if (window.top.document.getElementById('mainIframe') != null) {

			setTimeout(function(){
				var wrapper = document.getElementById('mainIframe').contentWindow.document.getElementById('wrapper');
				var sideMenu = document.getElementById('mainIframe').contentWindow.document.getElementById('sideMenu');
				var leftMenu = document.getElementById('mainIframe').contentWindow.document.getElementById('infavorMenu');
				var wrapperHeight = wrapper.scrollHeight;
				var sideMenuMinHeight = sideMenu.style.minHeight;
				sideMenu.style.minHeight = "auto";
				var sideMenuHeight = sideMenu.scrollHeight;
				var clientHeight = window.top.document.body.clientHeight;

				var setHeight = clientHeight;

				if (setHeight < sideMenuHeight) {
					setHeight = sideMenuHeight;
				}

				if (setHeight < wrapperHeight) {
					setHeight = wrapperHeight;
				}

				window.top.document.getElementById('mainIframe').height = setHeight + "px";
				sideMenu.style.minHeight = sideMenuMinHeight;
				window.top.document.getElementById('mainIframe').style.height = setHeight + "px";
			}, 200);
		}
	}

	//sessionScript.jsp 의 CTI.callId 세팅
	function setCallId(){
		CTI.callId = null;
		CTI.callId = obj[3];
	}

	//sessionScript.jsp 의 CTI.ivrSvcCd 세팅
	function setIvrSvcCd(){
		CTI.ivrSvcCd = null;
		CTI.ivrSvcCd = obj[1];
	}

	//마이핀 IVR 호쩐환 > 신규회원 > 본인인증 팝업
	certiOwnForSp = {
			id : "certiPopup",
			pop : function(pObj){
				var url = '<ifvm:url name="certiOwnPop"/>';
	   			url += '?certiCase=004'
				$("#"+this.id).ifvsfPopup({
		            enableModal : true,
		            enableResize : false,
		            contentUrl : url,
		            contentType : "ajax",
		            title : '<spring:message code="L00741"/>', // 본인 인증
		            width : '500px',
		            params : pObj
		        });
			},
			beforeClose : function(obj){
				console.log(obj);

			},
			close: function(obj){
				if(obj){
					this.beforeClose(obj)
				}
				var _popObj = eval(this.id)
				_popObj._destroy();
			}
	}

	//아이프레임 적용
	$(window).resize(function() {
		var cheight = mainIframe.contentWindow.document.body.clientHeight;
		mainIframe.width = document.body.clientWidth > 1220 ? "100%" : '1220px';
		mainIframe.height = document.body.clientHeight > cheight ? "100%" : cheight + 'px';
	});

	$(document).ready(function() {
		getExtension();
	});
</script>
<!-- 소프트폰 툴바 -->
<script language="javascript" for="TSPhone" event='CallEvent(eventType,eventData)'>
	if(eventType == '6'){
		setTimeout(eventDataParsing(eventData),50);
	}else if(eventType == '7'){
		setTimeout(eventDataParsing(eventData),50);
		setTimeout(setCallId(),50);
		setTimeout(setIvrSvcCd(),50);

		if(obj[0] == "I" && obj[1] == "01"){
			//보너스 카드 등록
			setTimeout(registerCardNo(obj),50);
		}else if(obj[0] == "I" && (
				obj[1] == "04" || obj[1] == "07" || obj[1] == "13"
				|| obj[1] == "21" || obj[1] == "23" || obj[1] == "24"
				|| obj[1] == "25" || obj[1] == "26" || obj[1] == "27"
				|| obj[1] == "22") ){
			//일반 문의- 회원조회 화면 전화
			setTimeout(askGeneral(obj),50);
		}else if(obj[0] == "O"){
			//Outbound Call 시 이력정보 저장
			setTimeout(outboundCallHst(obj),50);
		}
	}else if(eventType == '8'){
		//HangUp(통화종료 이력저장)
		setTimeout(eventDataParsing(eventData),50);
		setTimeout(callEnd(obj),50);
	}else if(eventType == '20'){
		//호전환이력저장
		setTimeout(eventDataParsing(eventData),50);
		setTimeout(setIvrSvcCd(),50);

		setTimeout(callTransferHst(obj, softphoneData),50);
	}else if(eventType == '21'){
		setTimeout(eventDataParsing(eventData),50);
		setTimeout(setIvrSvcCd(),50);

		if(obj[0] == "P" && obj[1] == "14"){
			//마이핀(IVR 호전환)
			setTimeout(checkMypinOnIVR(obj),50);
		}else if(obj[0] == "P" && obj[1] == "15"){
			//신규 비밀번호(IVR 호전환)
			if(!obj[11]){
				//IVR 에서 비밀번호 실패 횟수를 초과하였을 때, 실패 메시지 출력
				alert(MESSAGE.SoftphoneOCX.title_MSG_V00225);
			}else{
				setTimeout(resetPwdOnIVR(obj),50);
			}
		}else if(obj[0] == "P" && obj[1] == "10"){
			//비밀번호 변경(IVR 호전환)
			if(!obj[11]){
				//IVR 에서 비밀번호 실패 횟수를 초과하였을 때, 실패 메시지 출력
				alert(MESSAGE.SoftphoneOCX.title_MSG_V00224);
			}else{
				setTimeout(changePwdOnIVR(obj),50);
			}
		}
	}else if(eventType == '22'){
		setTimeout(eventDataParsing(eventData),50);
		setTimeout(setIvrSvcCd(),50);
	}
</script>
<script language="javascript" for="TSPhone" event='CallButtonEvent(eventType)'>
	if(eventType  == '10'){
		$("#modifyCallTransferPop").ifvsfPopup({
			enableModal : true,
			enableResize: false,
			contentUrl: MESSAGE.SoftphoneOCX.url.modifyCallTransferPop,
			contentType: "ajax",
			title: MESSAGE.SoftphoneOCX.title_MSG_V00144,
			width: 600,
			close : 'modifyCallTransferPopClose'
		});
	}else if(eventType  == '19'){
		$("#setAlliTypePop").ifvsfPopup({
	       enableModal : true,
		   enableResize: false,
		   contentUrl: MESSAGE.SoftphoneOCX.url.setAlliTypePop,
		   contentType: "ajax",
		   title: MESSAGE.SoftphoneOCX.title_MSG_V00143,
		   width: 600,
		   close : 'setAlliTypePopClose'
		});
	}
</script>

</body>
</html>
