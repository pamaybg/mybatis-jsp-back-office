package com.icignal.common.base.dto.request;

/**
 * @name : infavor.base.dto.request
 * @date : 2016. 11. 14.
 * @author : dg.ryu
 * @description : email send log RequestDTO
 */
public class EmailSendLogReqDto extends BaseReqDto {
	
	private String id;                   //아이디
	private String createBy;             //생성자
	private String modifyBy;             //수정자
	private String type;                 //유형
	private String camId;                //캠페인 ID
	private String mktExeInfoItemId;     //캠페인 실행 아이템 ID
	private String contsId;              //콘텐츠 ID
	private String itemSeq;              //항목 SEQ
	private String agentUserId;          //회원사 아이디
	private String scheduleType;         //발송시점 구분
	private String inputDt;              //DB 입력 시간
	private String sendPlanDt;           //발송 희망 시간
	private String senderNm;             //발신자 이름
	private String senderEmail;          //발신 이메일
	private String recvEmail;            //수신자 이메일
	private String recvMemId;            //수신자 회원ID
	private String recvNm;               //수신자 이름
	private String msgSubject;           //메시지 제목
	private String msgSbst;              //이메일 내용
	private String fileCnt;              //전송 파일 개수
	private String fileType1;            //파일 타입 1
	private String fileType2;            //파일 타입 2
	private String fileType3;            //파일 타입 3
	private String filePath1;            //파일 경로 1
	private String filePath2;            //파일 경로 2
	private String filePath3;            //파일 경로 3
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

	
	public String getCreateBy() {
		return createBy;
	}

	
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	
	public String getModifyBy() {
		return modifyBy;
	}

	
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
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
