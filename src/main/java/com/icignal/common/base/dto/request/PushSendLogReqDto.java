package com.icignal.common.base.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @name : MKTPushSendLogRequestDTO.java
 * @date : 2016. 11. 14.
 * @author : dg.ryu
 * @description : push send log RequestDTO
 */
public class PushSendLogReqDto extends BaseReqDto {
	
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
	private String accntAppKey;          //어카운트별 앱 키값
	private String msgSubject;           //메시지 제목
	private String msgSbst;              //메시지 내용
	private String puthSound;            //사운드
	private String recvDeviceId;         //수신자 디바이스 ID
	private String recvMemId;            //수신자 회원ID
	private String recvDeviceType;       //수신자 디바이스 유
	private String attrib1;              //여분 필드 1
	private String attrib2;              //여분 필드 2
	private String attrib3;              //여분 필드 3
	private String attrib4;              //여분 필드 4
	private String attrib5;              //여분 필드 5
	private String batSendStatus;        //배치 처리 상태
	private String batSendProcTime;      //배치 전송 처리완료 시간
	private String batSendFailCd;        //
	private String batSendFailReason;    //배치 전송실패사유
	private String batSendTgtId;         //배치 대상 ID
	private String camTgtDtlId;          //캠페인 대상자 상세 ID
	private String pushTypeCd;           //PUSH유형코
	
    @Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

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

	public String getAccntAppKey() {
		return accntAppKey;
	}

	public void setAccntAppKey(String accntAppKey) {
		this.accntAppKey = accntAppKey;
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

	public String getPuthSound() {
		return puthSound;
	}

	public void setPuthSound(String puthSound) {
		this.puthSound = puthSound;
	}

	public String getRecvDeviceId() {
		return recvDeviceId;
	}

	public void setRecvDeviceId(String recvDeviceId) {
		this.recvDeviceId = recvDeviceId;
	}

	public String getRecvMemId() {
		return recvMemId;
	}

	public void setRecvMemId(String recvMemId) {
		this.recvMemId = recvMemId;
	}

	public String getRecvDeviceType() {
		return recvDeviceType;
	}

	public void setRecvDeviceType(String recvDeviceType) {
		this.recvDeviceType = recvDeviceType;
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

	public String getPushTypeCd() {
		return pushTypeCd;
	}

	public void setPushTypeCd(String pushTypeCd) {
		this.pushTypeCd = pushTypeCd;
	}
    
    
}
