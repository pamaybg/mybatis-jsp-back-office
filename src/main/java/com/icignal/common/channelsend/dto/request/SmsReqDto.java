package com.icignal.common.channelsend.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;




public class SmsReqDto extends MKTBaseReqDto {
	private String id;     		 		 //아이디
	private String memId;    	     	 //생성자
	private String accntId;      		 //어카운트 ID
	private String camId;        		 //캠페인 ID
	private String contsId;     		 //콘텐츠 ID
	private String agentUserId;          //회원사 아이디
	private String scheduleType;         //발송시점 구분
	private String inputDt;              //DB 입력 시간
	private String sendPlanDt;           //발송 희망 시간
	private String toCallbackNo;         //회신번호
	private String callbackUrl;          //전송할 CALLBACK URL
	private String msgSendType;  	     //메시지 발송 유형
	private String msgType;     	     //메시지 형태
	private String msgSubject;    		 //메시지 제목
	private String msgSbst;              //메시지 내용
	private String venderOfficeCode;     //전송업체 유통망코드
	private String cdrId;    			 //과금ID
	private String revcCallNo;     		 //수신전화번호
	private String revcMemId;            //수신자 회원ID
	private String revcNm;               //수신자 명
	private int fileCnt;                 //전송 파일 개수
	private String fileType1;            //파일 타입 1
	private String fileType2;            //파일 타입 2
	private String fileType3;            //파일 타입 3
	private String fileType4;            //파일 타입 4
	private String fileType5;            //파일 타입 5
	private String filePath1;            //MMS 파일경로1
	private String filePath2;            //MMS 파일경로2
	private String filePath3;            //MMS 파일경로3
	private String filePath4;            //MMS 파일경로4
	private String filePath5;            //MMS 파일경로5
	private String attrib1;      		 //여분 필드 1
	private String attrib2;   		     //여분 필드 2
	private String attrib3;     		 //여분 필드 3
	private String attrib4;     		 //여분 필드 4
	private String attrib5;     		 //여분 필드 5
	private String batSendStatus;        //배치 처리 상태
	private String batSendProcTime;      //배치 전송 처리완료 시간
	private String batSendFailReason;    //배치 전송실패사유
	private String fileName;
	
	//push
	private String accntAppKey;    		 //어카운트별 앱 키값
	private String puthSound;      		 //사운드
	private String revcDeviceId;    	 //수신자 디바이스 ID
	private String revcDeviceType;  	 //수신자 디바이스 유
	private String pushTypeCode;         //push 유형코드
	
	//mms
	private String senderNm;             //보낸 사람 이름
	private String senderEmail;          //보내는 사람 이메일
	private String recvEmail;            //받는 사람 이메일
	private String emailType;
	private String memName;
	
	//변환 체크
	private String tranceChk;            //개인화 속성 변환 체크
	private String tranceMsg;            //개인화 속성 변환 관련 메세지
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getContsId() {
		return contsId;
	}
	public void setContsId(String contsId) {
		this.contsId = contsId;
	}
	public String getAgentUserId() {
		return agentUserId;
	}
	public void setAgentUserId(String agentUserId) {
		this.agentUserId = agentUserId;
	}
	public String getScheduleType() {
		return scheduleType;
	}
	public void setScheduleType(String scheduleType) {
		this.scheduleType = scheduleType;
	}
	public String getInputDt() {
		return inputDt;
	}
	public void setInputDt(String inputDt) {
		this.inputDt = inputDt;
	}
	public String getSendPlanDt() {
		return sendPlanDt;
	}
	public void setSendPlanDt(String sendPlanDt) {
		this.sendPlanDt = sendPlanDt;
	}
	public String getToCallbackNo() {
		return toCallbackNo;
	}
	public void setToCallbackNo(String toCallbackNo) {
		this.toCallbackNo = toCallbackNo;
	}
	public String getCallbackUrl() {
		return callbackUrl;
	}
	public void setCallbackUrl(String callbackUrl) {
		this.callbackUrl = callbackUrl;
	}
	public String getMsgSendType() {
		return msgSendType;
	}
	public void setMsgSendType(String msgSendType) {
		this.msgSendType = msgSendType;
	}
	public String getMsgType() {
		return msgType;
	}
	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}
	public String getMsgSubject() {
		return msgSubject;
	}
	public void setMsgSubject(String msgSubject) {
		this.msgSubject = msgSubject;
	}
	public String getMsgSbst() {
		return msgSbst;
	}
	public void setMsgSbst(String msgSbst) {
		this.msgSbst = msgSbst;
	}
	public String getVenderOfficeCode() {
		return venderOfficeCode;
	}
	public void setVenderOfficeCode(String venderOfficeCode) {
		this.venderOfficeCode = venderOfficeCode;
	}
	public String getCdrId() {
		return cdrId;
	}
	public void setCdrId(String cdrId) {
		this.cdrId = cdrId;
	}
	public String getRevcCallNo() {
		return revcCallNo;
	}
	public void setRevcCallNo(String revcCallNo) {
		this.revcCallNo = revcCallNo;
	}
	public String getRevcMemId() {
		return revcMemId;
	}
	public void setRevcMemId(String revcMemId) {
		this.revcMemId = revcMemId;
	}
	public String getRevcNm() {
		return revcNm;
	}
	public void setRevcNm(String revcNm) {
		this.revcNm = revcNm;
	}
	public int getFileCnt() {
		return fileCnt;
	}
	public void setFileCnt(int fileCnt) {
		this.fileCnt = fileCnt;
	}
	public String getFileType1() {
		return fileType1;
	}
	public void setFileType1(String fileType1) {
		this.fileType1 = fileType1;
	}
	public String getFileType2() {
		return fileType2;
	}
	public void setFileType2(String fileType2) {
		this.fileType2 = fileType2;
	}
	public String getFileType3() {
		return fileType3;
	}
	public void setFileType3(String fileType3) {
		this.fileType3 = fileType3;
	}
	public String getFileType4() {
		return fileType4;
	}
	public void setFileType4(String fileType4) {
		this.fileType4 = fileType4;
	}
	public String getFileType5() {
		return fileType5;
	}
	public void setFileType5(String fileType5) {
		this.fileType5 = fileType5;
	}
	public String getFilePath1() {
		return filePath1;
	}
	public void setFilePath1(String filePath1) {
		this.filePath1 = filePath1;
	}
	public String getFilePath2() {
		return filePath2;
	}
	public void setFilePath2(String filePath2) {
		this.filePath2 = filePath2;
	}
	public String getFilePath3() {
		return filePath3;
	}
	public void setFilePath3(String filePath3) {
		this.filePath3 = filePath3;
	}
	public String getFilePath4() {
		return filePath4;
	}
	public void setFilePath4(String filePath4) {
		this.filePath4 = filePath4;
	}
	public String getFilePath5() {
		return filePath5;
	}
	public void setFilePath5(String filePath5) {
		this.filePath5 = filePath5;
	}
	public String getAttrib1() {
		return attrib1;
	}
	public void setAttrib1(String attrib1) {
		this.attrib1 = attrib1;
	}
	public String getAttrib2() {
		return attrib2;
	}
	public void setAttrib2(String attrib2) {
		this.attrib2 = attrib2;
	}
	public String getAttrib3() {
		return attrib3;
	}
	public void setAttrib3(String attrib3) {
		this.attrib3 = attrib3;
	}
	public String getAttrib4() {
		return attrib4;
	}
	public void setAttrib4(String attrib4) {
		this.attrib4 = attrib4;
	}
	public String getAttrib5() {
		return attrib5;
	}
	public void setAttrib5(String attrib5) {
		this.attrib5 = attrib5;
	}
	public String getBatSendStatus() {
		return batSendStatus;
	}
	public void setBatSendStatus(String batSendStatus) {
		this.batSendStatus = batSendStatus;
	}
	public String getBatSendProcTime() {
		return batSendProcTime;
	}
	public void setBatSendProcTime(String batSendProcTime) {
		this.batSendProcTime = batSendProcTime;
	}
	public String getBatSendFailReason() {
		return batSendFailReason;
	}
	public void setBatSendFailReason(String batSendFailReason) {
		this.batSendFailReason = batSendFailReason;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getAccntAppKey() {
		return accntAppKey;
	}
	public void setAccntAppKey(String accntAppKey) {
		this.accntAppKey = accntAppKey;
	}
	public String getPuthSound() {
		return puthSound;
	}
	public void setPuthSound(String puthSound) {
		this.puthSound = puthSound;
	}
	public String getRevcDeviceId() {
		return revcDeviceId;
	}
	public void setRevcDeviceId(String revcDeviceId) {
		this.revcDeviceId = revcDeviceId;
	}
	public String getRevcDeviceType() {
		return revcDeviceType;
	}
	public void setRevcDeviceType(String revcDeviceType) {
		this.revcDeviceType = revcDeviceType;
	}
	public String getSenderNm() {
		return senderNm;
	}
	public void setSenderNm(String senderNm) {
		this.senderNm = senderNm;
	}
	public String getSenderEmail() {
		return senderEmail;
	}
	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}
	public String getRecvEmail() {
		return recvEmail;
	}
	public void setRecvEmail(String recvEmail) {
		this.recvEmail = recvEmail;
	}
	public String getTranceChk() {
		return tranceChk;
	}
	public void setTranceChk(String tranceChk) {
		this.tranceChk = tranceChk;
	}
	public String getTranceMsg() {
		return tranceMsg;
	}
	public void setTranceMsg(String tranceMsg) {
		this.tranceMsg = tranceMsg;
	}
	public String getEmailType() {
		return emailType;
	}
	public void setEmailType(String emailType) {
		this.emailType = emailType;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
    public String getPushTypeCode() {
        return pushTypeCode;
    }
    public void setPushTypeCode(String pushTypeCode) {
        this.pushTypeCode = pushTypeCode;
    }
	
	
	
}
