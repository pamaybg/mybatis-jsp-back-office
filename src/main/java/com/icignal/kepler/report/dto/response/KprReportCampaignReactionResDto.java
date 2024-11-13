package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRReportCampaignReactionResponseDTO
 * 2. 파일명	: KPRReportCampaignReactionResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprReportCampaignReactionResDto extends GridPagingItemResDto{
	private String camNm;		//캠페인명
	private String camTerm;		//기간
	private String chnlTypeCd;	//채널유형
	private String extraCnt;	//전체 대상자수
	private String chnlCnt;		//채널 전송 건 수
	private String respCnt;		//반응 건 수
	private String responRate;	//반응률
	private String openCnt;		//오픈수
	
	private String camId;		//캠페인 아이디
	private String pushYn;    	//PUSH 발송여부
	private String emailYn;  	//EMAIL 발송여부
	private String lmsYn;       //LMS발송여부
	private String smsYn;       //SMS 발송여부
	private String tgtAmt;		//추출 대상자수
	
	private String recvDt;		//반응일자
	private String recvHh;
	private String ageCd;
	private String gendCd;
	private String recvCnt;		//수신고객수
	private String pushCnt;		//PUSH열람 고객수
	private String emailCnt;	//EMAIL열람 고객수
	
	private String yyyyMmDd;	//구매일자
	private String purCnt;		//구매 고객수
	private String rcptCnt;		//영수증 건수
	private String txnAmt;		//총 구매금액
	private String amtRcptCnt;	//건단가
	private String amtPurCnt;	//객단가
	private String startDd;		//캠페인 시작시간
	private String endDd;		//캠페인 종료 시간
	
	public String getStartDd() {
		return startDd;
	}
	public void setStartDd(String startDd) {
		this.startDd = startDd;
	}
	public String getEndDd() {
		return endDd;
	}
	public void setEndDd(String endDd) {
		this.endDd = endDd;
	}
	public String getYyyyMmDd() {
		return yyyyMmDd;
	}
	public void setYyyyMmDd(String yyyyMmDd) {
		this.yyyyMmDd = yyyyMmDd;
	}
	public String getPurCnt() {
		return purCnt;
	}
	public void setPurCnt(String purCnt) {
		this.purCnt = purCnt;
	}
	public String getRcptCnt() {
		return rcptCnt;
	}
	public void setRcptCnt(String rcptCnt) {
		this.rcptCnt = rcptCnt;
	}
	public String getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(String txnAmt) {
		this.txnAmt = txnAmt;
	}
	public String getRecvDt() {
		return recvDt;
	}
	public void setRecvDt(String recvDt) {
		this.recvDt = recvDt;
	}
	public String getRecvHh() {
		return recvHh;
	}
	public void setRecvHh(String recvHh) {
		this.recvHh = recvHh;
	}
	public String getAgeCd() {
		return ageCd;
	}
	public void setAgeCd(String ageCd) {
		this.ageCd = ageCd;
	}
	public String getGendCd() {
		return gendCd;
	}
	public void setGendCd(String gendCd) {
		this.gendCd = gendCd;
	}
	public String getRecvCnt() {
		return recvCnt;
	}
	public void setRecvCnt(String recvCnt) {
		this.recvCnt = recvCnt;
	}
	public String getPushCnt() {
		return pushCnt;
	}
	public void setPushCnt(String pushCnt) {
		this.pushCnt = pushCnt;
	}
	public String getPushYn() {
		return pushYn;
	}
	public void setPushYn(String pushYn) {
		this.pushYn = pushYn;
	}
	public String getEmailYn() {
		return emailYn;
	}
	public void setEmailYn(String emailYn) {
		this.emailYn = emailYn;
	}
	public String getLmsYn() {
		return lmsYn;
	}
	public void setLmsYn(String lmsYn) {
		this.lmsYn = lmsYn;
	}
	public String getSmsYn() {
		return smsYn;
	}
	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
	}
	public String getTgtAmt() {
		return tgtAmt;
	}
	public void setTgtAmt(String tgtAmt) {
		this.tgtAmt = tgtAmt;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamTerm() {
		return camTerm;
	}
	public void setCamTerm(String camTerm) {
		this.camTerm = camTerm;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getExtraCnt() {
		return extraCnt;
	}
	public void setExtraCnt(String extraCnt) {
		this.extraCnt = extraCnt;
	}
	public String getChnlCnt() {
		return chnlCnt;
	}
	public void setChnlCnt(String chnlCnt) {
		this.chnlCnt = chnlCnt;
	}
	public String getRespCnt() {
		return respCnt;
	}
	public void setRespCnt(String respCnt) {
		this.respCnt = respCnt;
	}
	public String getResponRate() {
		return responRate;
	}
	public void setResponRate(String responRate) {
		this.responRate = responRate;
	}
	public String getOpenCnt() {
		return openCnt;
	}
	public void setOpenCnt(String openCnt) {
		this.openCnt = openCnt;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getEmailCnt() {
		return emailCnt;
	}
	public void setEmailCnt(String emailCnt) {
		this.emailCnt = emailCnt;
	}
	public String getAmtRcptCnt() {
		return amtRcptCnt;
	}
	public void setAmtRcptCnt(String amtRcptCnt) {
		this.amtRcptCnt = amtRcptCnt;
	}
	public String getAmtPurCnt() {
		return amtPurCnt;
	}
	public void setAmtPurCnt(String amtPurCnt) {
		this.amtPurCnt = amtPurCnt;
	}
	
	
	
}
