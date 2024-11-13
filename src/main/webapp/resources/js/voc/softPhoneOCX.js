//내선번호 조회
function getExtension(){
	$.ifvSyncPostJSON(MESSAGE.SoftphoneOCX.action.getExtension,{
		empId : $.ifvmGetUserInfo().empId
		, crmuserRid : $.ifvmGetUserInfo().id
	},function(result) {
		softPhoneInitData = [];
		
		softPhoneInitData.push(result.ctiIp);
		softPhoneInitData.push(result.ctiPort);
		softPhoneInitData.push(result.ctiBackIp);
		softPhoneInitData.push(result.agentData);
		softPhoneInitData.push(result.agentGroup);
		softPhoneInitData.push(result.extension);
		
		if(result.extension != null && result.extension != ""){
			InitSoftPhone();
		}
	});
}

//softPhone OCX init
function InitSoftPhone() {
//	TSPhone.InitIte(result.ctiIp, result.ctiPort, result.ctiBackIp, result.agentData, result.agentGroup, result.extension, result.extension);
	TSPhone.InitIte(softPhoneInitData[0], softPhoneInitData[1], softPhoneInitData[2], softPhoneInitData[3]
					, softPhoneInitData[4], softPhoneInitData[5], softPhoneInitData[5]);
}

//eventData 파싱
function eventDataParsing(eventData){
	obj = null;
	
	obj = eventData.split('|');
}

////전화 걸기
function localSoftMakeCall(pMakeCallNum, pUEIData){
//	TSPhone.LocalSoftMakeCall(pMakeCallNum, pUEIData, "");
	TSPhone.LocalSoftMakeCall(pMakeCallNum, "", "");
}

//카드 비밀번호 변경
function changeCardPwd(memNo){
	TSPhone.PasswordIVR(memNo);
}

//전환시도 팝업
function modifyCallTransferPop(){
	$("#modifyCallTransferPop").ifvsfPopup({
		enableModal : true,
		enableResize: false,
		contentUrl: MESSAGE.SoftphoneOCX.url.modifyCallTransferPop,
		contentType: "ajax",
		title: MESSAGE.SoftphoneOCX.title_MSG_V00144,
		width: 600,
		close : 'modifyCallTransferPopClose'
	});
}

//부분녹취 팝업
function setAlliTypePop(){
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

//보너스 카드 등록
function registerCardNo(obj){
	$.ifvSyncPostJSON(MESSAGE.SoftphoneOCX.action.callScreenPopup,{
		scd : obj[1]
		, cardPasswd : obj[6]
		, cardNo : obj[10]
		, ani : obj[2]
		, interactionId : obj[3]
		, ssn : obj[5]
	},function(result) {
		$("#mainIframe").attr("src",MESSAGE.SoftphoneOCX.url.voiceMailBoxList+"?callContactRid="+result.message);
	});
}

//일반 문의- 회원조회 화면 전화
function askGeneral(obj){
	$.ifvSyncPostJSON(MESSAGE.SoftphoneOCX.action.callScreenPopup,{
		scd : obj[1]
		, ani : obj[2]
		, interactionId : obj[3]
	},function(result) {
		$("#mainIframe").attr("src",MESSAGE.SoftphoneOCX.url.mbrList+"?mbrNo="+result.message+"&ivrSvcCd="+obj[1]);
	});
}

//신규 비밀번호(IVR 호전환)
function resetPwdOnIVR(obj){
	$.ifvSyncPostJSON(MESSAGE.SoftphoneOCX.action.callScreenPopup,{
		scd : obj[1]
		, interactionId : obj[3]
		, cnu : obj[4]
		, ssn : obj[8]
		, cardPasswd : obj[11]
	},function(result) {
		if(result.success){
			$("#mainIframe").attr("src",MESSAGE.SoftphoneOCX.url.mbrList+"?mbrNo="+result.message+"&ivrSvcCd="+obj[1]);
			alert(MESSAGE.SoftphoneOCX.title_MSG_V00252); //신규 비밀번호 등록에 성공하였습니다.
		}else{
			alert(result.message);
		}
	},function(result){
		alert(result.message);
	});
}

//마이핀(IVR 호전환)
function checkMypinOnIVR(obj){
	$.ifvSyncPostJSON(MESSAGE.SoftphoneOCX.action.callScreenPopup,{
		scd : obj[1]
		, ssn : obj[8]
	},function(result) {
		if(result.success){
			//해당하는 회원이 있는 경우
			$("#mainIframe").attr("src",MESSAGE.SoftphoneOCX.url.mbrList+"?mbrNo="+result.message+"&ivrSvcCd="+obj[1]);
			alert(MESSAGE.SoftphoneOCX.title_MSG_V00253); //마이핀인증에 성공하였습니다. 마이핀번호에 해당하는 회원이 존재합니다. 회원 상세화면으로 이동합니다.
		}else{
			alert(result.message);
		}
	},function(result){
		if(result.errorType == "10"){
			//해당하는 회원이 없는 경우
			alert(MESSAGE.SoftphoneOCX.title_MSG_V00291); //마이핀인증에 성공하였습니다. 마이핀번호에 해당하는 회원이 존재하지 않습니다. 본인인증 화면으로 전환합니다.
			var tObj = new Object();
			tObj.spMypinNum = result.message;
			
			//실명인증 팝업 호출
			certiOwnForSp.pop(tObj);
		}else{
			alert(result.message);
		}
	});
}

//비밀번호 변경(IVR 호전환)
function changePwdOnIVR(obj){
	$.ifvSyncPostJSON(MESSAGE.SoftphoneOCX.action.callScreenPopup,{
		scd : obj[1]
		, interactionId : obj[3]
		, cnu : obj[4]
		, ssn : obj[8]
		, cardPasswd : obj[11]
	},function(result) {
		if(result.success){
			$("#mainIframe").attr("src",MESSAGE.SoftphoneOCX.url.mbrList+"?mbrNo="+result.message+"&ivrSvcCd="+obj[1]);
			alert(MESSAGE.SoftphoneOCX.title_MSG_V00254); //비밀번호 변경에 성공하였습니다.
		}else{
			alert(result.message);
		}
	},function(result){
		alert(result.message);
	});
}

//호전환이력저장
function callTransferHst(obj, softphoneData){
	$.ifvSyncPostJSON(MESSAGE.SoftphoneOCX.action.callTransferHst,{
		ssn : obj[6]
		, ani : obj[0]
		, interactionId : obj[7]
		, allianceName : softphoneData[0] 	/* ALLIANCE_NAME */
		, acnCd : softphoneData[1] 			/* ALLIANCE_CONTACT_NUM */
		, allianceTypeCd : softphoneData[2] /* ALLIANCE_TYPE_CD */
	},function(result) {
		if(result.success){
			$("#mainIframe").attr("src",MESSAGE.SoftphoneOCX.url.callbackList+"?mbrNo="+result.message);
		}else{
			alert(result.message);
		}
	},function(result){
		alert(result.message);
	});
}

//Outbound Call 시 이력정보 저장
function outboundCallHst(obj){
	$.ifvSyncPostJSON(MESSAGE.SoftphoneOCX.action.outboundCallHst,{
		ani : obj[2]
		, interactionId : obj[3]
	},function(result) {
		
	});
}

//HangUp(통화종료 이력저장)
function callEnd(obj){
	$.ifvSyncPostJSON(MESSAGE.SoftphoneOCX.action.callEnd,{
		interactionId : obj[0]
//		interactionId : CTI.callId
	},function(result) {
		
	});
}

//소프트폰 툴바 존재 여부 확인
function isExistOCX(){
	var boolean = false;
	
	if(window.parent.document.getElementById('TSPhone')){
		boolean = true;
	}else{
		boolean = false;
	}
	
	return boolean;
}
