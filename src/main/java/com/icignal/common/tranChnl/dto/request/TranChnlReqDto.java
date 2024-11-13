package com.icignal.common.tranChnl.dto.request;

import java.util.ArrayList;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : ICNTranChnlRequestDTO.java
 * @date : 2015. 9. 22.
 * @author : 류동균
 * @description : 채널 발송
 */
public class TranChnlReqDto extends MKTBaseReqDto {

	private String id;     		 		 //아이디
	private String memId;    	     	 //생성자
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
	private Long fileSize1;            //파일 타입 1
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
	private String pushTypeVal;          //push 유형코드의 값
	
	private String revcMbrNo;            //수신자 회원번호 
	
	//eamil
	private String senderNm;             //보낸 사람 이름
	private String senderEmail;          //보내는 사람 이메일
	private String recvEmail;            //받는 사람 이메일
	private String emailType;
	private String memName;
	
	//kakao
	private String btnNm;
	private String btnUrl;
	
	//변환 체크
	private String tranceChk;            //개인화 속성 변환 체크
	private String tranceMsg;            //개인화 속성 변환 관련 메세지
	
	//이메일 개인화
	private String etc1 ;
	private String etc2 ;
	private String etc3 ;
	private String etc4 ;
	private String etc5 ;
	private String etc6 ;
	private String etc7 ;
	private String etc8 ;
	private String etc9 ;
	private String etc10;
    private String etc11;
    private String etc12;
    private String etc13;
    private String etc14;
    private String etc15;
    private String etc16;
    
    private String ext;

	private String brazeCamApiKey;
	private String contsPushSubTypeVal;

	private String contentSendType;
	private String authInfoDes;


	public void setEtc(int cnt , String str) {
        if (cnt == 1 ) etc1  = str;
        else if (cnt == 2 ) etc2  = str;
        else if (cnt == 3 ) etc3  = str;
        else if (cnt == 4 ) etc4  = str;
        else if (cnt == 5 ) etc5  = str;
        else if (cnt == 6 ) etc6  = str;
        else if (cnt == 7 ) etc7  = str;
        else if (cnt == 8 ) etc8  = str;
        else if (cnt == 9 ) etc9  = str;
        else if (cnt == 10) etc10 = str;
        else if (cnt == 11) etc11 = str;
        else if (cnt == 12) etc12 = str;
        else if (cnt == 13) etc13 = str;
        else if (cnt == 14) etc14 = str;
        else if (cnt == 15) etc15 = str;
        else if (cnt == 16) etc16 = str;
    }
    
    /**
     * 개인화 값 etc중 값이 존재하는 변수명만 return
     * 
     * @programId : 
     * @name : getEtcArry
     * @date : 2018. 2. 19.
     * @author : jh.kim
     * @table : 
     * @return
     * @description : 
     */
    public ArrayList<String> getEtcList() {
        ArrayList<String> rtnList = new ArrayList<>();

        if (etc1  != null) rtnList.add(etc1);
        if (etc2  != null) rtnList.add(etc2);
        if (etc3  != null) rtnList.add(etc3);
        if (etc4  != null) rtnList.add(etc4);
        if (etc5  != null) rtnList.add(etc5);
        if (etc6  != null) rtnList.add(etc6);
        if (etc7  != null) rtnList.add(etc7);
        if (etc8  != null) rtnList.add(etc8);
        if (etc9  != null) rtnList.add(etc9);
        if (etc10 != null) rtnList.add(etc10);
        if (etc11 != null) rtnList.add(etc11);
        if (etc12 != null) rtnList.add(etc12);
        if (etc13 != null) rtnList.add(etc13);
        if (etc14 != null) rtnList.add(etc14);
        if (etc15 != null) rtnList.add(etc15);
        if (etc16 != null) rtnList.add(etc16);
        
        return rtnList;
    }
    
	public String getPushTypeVal() {
        return pushTypeVal;
    }

    public void setPushTypeVal(String pushTypeVal) {
        this.pushTypeVal = pushTypeVal;
    }

    public String getEtc1() {
        return etc1;
    }

    public void setEtc1(String etc1) {
        this.etc1 = etc1;
    }

    public String getEtc2() {
        return etc2;
    }

    public void setEtc2(String etc2) {
        this.etc2 = etc2;
    }

    public String getEtc3() {
        return etc3;
    }

    public void setEtc3(String etc3) {
        this.etc3 = etc3;
    }

    public String getEtc4() {
        return etc4;
    }

    public void setEtc4(String etc4) {
        this.etc4 = etc4;
    }

    public String getEtc5() {
        return etc5;
    }

    public void setEtc5(String etc5) {
        this.etc5 = etc5;
    }

    public String getEtc6() {
        return etc6;
    }

    public void setEtc6(String etc6) {
        this.etc6 = etc6;
    }

    public String getEtc7() {
        return etc7;
    }

    public void setEtc7(String etc7) {
        this.etc7 = etc7;
    }

    public String getEtc8() {
        return etc8;
    }

    public void setEtc8(String etc8) {
        this.etc8 = etc8;
    }

    public String getEtc9() {
        return etc9;
    }

    public void setEtc9(String etc9) {
        this.etc9 = etc9;
    }

    public String getEtc10() {
        return etc10;
    }

    public void setEtc10(String etc10) {
        this.etc10 = etc10;
    }

    public String getEtc11() {
        return etc11;
    }

    public void setEtc11(String etc11) {
        this.etc11 = etc11;
    }

    public String getEtc12() {
        return etc12;
    }

    public void setEtc12(String etc12) {
        this.etc12 = etc12;
    }

    public String getEtc13() {
        return etc13;
    }

    public void setEtc13(String etc13) {
        this.etc13 = etc13;
    }

    public String getEtc14() {
        return etc14;
    }

    public void setEtc14(String etc14) {
        this.etc14 = etc14;
    }

    public String getEtc15() {
        return etc15;
    }

    public void setEtc15(String etc15) {
        this.etc15 = etc15;
    }

    public String getEtc16() {
        return etc16;
    }

    public void setEtc16(String etc16) {
        this.etc16 = etc16;
    }

    public String getBtnNm() {
        return btnNm;
    }

    public void setBtnNm(String btnNm) {
        this.btnNm = btnNm;
    }

    public String getBtnUrl() {
        return btnUrl;
    }

    public void setBtnUrl(String btnUrl) {
        this.btnUrl = btnUrl;
    }

    public String getRevcMbrNo() {
        return revcMbrNo;
    }

    public void setRevcMbrNo(String revcMbrNo) {
        this.revcMbrNo = revcMbrNo;
    }

    public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
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

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
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

	public String getPushTypeCode() {
		return pushTypeCode;
	}

	public void setPushTypeCode(String pushTypeCode) {
		this.pushTypeCode = pushTypeCode;
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

	public String getExt() {
		return ext;
	}

	public void setExt(String ext) {
		this.ext = ext;
	}

	public Long getFileSize1() {
		return fileSize1;
	}

	public void setFileSize1(Long fileSize1) {
		this.fileSize1 = fileSize1;
	}

	public String getBrazeCamApiKey() {
		return brazeCamApiKey;
	}

	public void setBrazeCamApiKey(String brazeCamApiKey) {
		this.brazeCamApiKey = brazeCamApiKey;
	}

	public String getContsPushSubTypeVal() {
		return contsPushSubTypeVal;
	}

	public void setContsPushSubTypeVal(String contsPushSubTypeVal) {
		this.contsPushSubTypeVal = contsPushSubTypeVal;
	}

	public String getContentSendType() {
		return contentSendType;
	}

	public void setContentSendType(String contentSendType) {
		this.contentSendType = contentSendType;
	}

	public String getAuthInfoDes() {
		return authInfoDes;
	}

	public void setAuthInfoDes(String authInfoDes) {
		this.authInfoDes = authInfoDes;
	}
}
