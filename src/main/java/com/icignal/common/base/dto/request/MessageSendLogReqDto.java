package com.icignal.common.base.dto.request;

/**
 * @name : infavor.base.dto.request
 * @date : 2016. 11. 14.
 * @author : dg.ryu
 * @description : message send log RequestDTO
 */
public class MessageSendLogReqDto extends BaseReqDto {
	
	private String id;                   //아이디
	private String type;                 //유형
	private String camId;                //캠페인 ID
	private String mktExeInfoItemId;     //캠페인 실행 아이템 ID
	private String contsId;              //콘텐츠 ID
	private String itemSeq;              //항목 SEQ
	private String agentUserId;          //회원사 아이디
	private String scheduleType;         //발송시점 구분
	private String inputDt;              //DB 입력 시간
	private String sendPlanDt;           //발송 희망 시간
	private String toCallbackNo;         //회신번호
	private String callbackUrl;          //전송할 CALLBACK URL
	private String msgSendType;          //메시지 발송 유형
	private String msgType;              //메시지 형태
	private String msgSubject;           //메시지 제목
	private String msgSbst;              //메시지 내용
	private String venderOfficeCode;     //전송업체 유통망코드
	private String cdrId;                //과금ID
	private String recvCallNo;           //수신전화번호
	private String recvMemId;            //수신자 회원ID
	private String recvNm;               //수신자 명
	private String fileCnt;              //전송 파일 개수
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
	private String filePathFilename1;    //파일경로1 파일명
	private String filePathFilename2;    //파일경로2 파일명
	private String filePathFilename3;    //파일경로3 파일명
	private String filePathFilename4;    //파일경로4 파일명
	private String filePathFilename5;    //파일경로5 파일명
	private String attrib1;              //여분 필드 1
	private String attrib2;              //여분 필드 2
	private String attrib3;              //여분 필드 3
	private String attrib4;              //여분 필드 4
	private String attrib5;              //여분 필드 5
	private String batSendStatus;        //배치 처리 상태
	private String batSendProcTime;      //배치 전송 처리완료 시간
	private String batSendFailCd;        //배치 전송 실패 사유 코드
	private String batSendFailReason;    //배치 전송실패사유
	private String batSendTgtId;         //배치 대상 ID
	private String camTgtDtlId;          //캠페인 대상자 상세 ID

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}

	public String getMktExeInfoItemId() {
		return mktExeInfoItemId;
	}

	public void setMktExeInfoItemId(String mktExeInfoItemId) {
		this.mktExeInfoItemId = mktExeInfoItemId;
	}

	public String getContsId() {
		return contsId;
	}

	public void setContsId(String contsId) {
		this.contsId = contsId;
	}

	public String getItemSeq() {
		return itemSeq;
	}

	public void setItemSeq(String itemSeq) {
		this.itemSeq = itemSeq;
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

	public String getRecvCallNo() {
		return recvCallNo;
	}

	public void setRecvCallNo(String recvCallNo) {
		this.recvCallNo = recvCallNo;
	}

	public String getRecvMemId() {
		return recvMemId;
	}

	public void setRecvMemId(String recvMemId) {
		this.recvMemId = recvMemId;
	}

	public String getRecvNm() {
		return recvNm;
	}

	public void setRecvNm(String recvNm) {
		this.recvNm = recvNm;
	}

	public String getFileCnt() {
		return fileCnt;
	}

	public void setFileCnt(String fileCnt) {
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

	public String getFilePathFilename1() {
		return filePathFilename1;
	}

	public void setFilePathFilename1(String filePathFilename1) {
		this.filePathFilename1 = filePathFilename1;
	}

	public String getFilePathFilename2() {
		return filePathFilename2;
	}

	public void setFilePathFilename2(String filePathFilename2) {
		this.filePathFilename2 = filePathFilename2;
	}

	public String getFilePathFilename3() {
		return filePathFilename3;
	}

	public void setFilePathFilename3(String filePathFilename3) {
		this.filePathFilename3 = filePathFilename3;
	}

	public String getFilePathFilename4() {
		return filePathFilename4;
	}

	public void setFilePathFilename4(String filePathFilename4) {
		this.filePathFilename4 = filePathFilename4;
	}

	public String getFilePathFilename5() {
		return filePathFilename5;
	}

	public void setFilePathFilename5(String filePathFilename5) {
		this.filePathFilename5 = filePathFilename5;
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

	public String getBatSendFailCd() {
		return batSendFailCd;
	}

	public void setBatSendFailCd(String batSendFailCd) {
		this.batSendFailCd = batSendFailCd;
	}

	public String getBatSendFailReason() {
		return batSendFailReason;
	}

	public void setBatSendFailReason(String batSendFailReason) {
		this.batSendFailReason = batSendFailReason;
	}

	public String getBatSendTgtId() {
		return batSendTgtId;
	}

	public void setBatSendTgtId(String batSendTgtId) {
		this.batSendTgtId = batSendTgtId;
	}

	public String getCamTgtDtlId() {
		return camTgtDtlId;
	}

	public void setCamTgtDtlId(String camTgtDtlId) {
		this.camTgtDtlId = camTgtDtlId;
	}
}
