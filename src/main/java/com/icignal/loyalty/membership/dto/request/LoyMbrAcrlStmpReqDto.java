package com.icignal.loyalty.membership.dto.request;

/**
* @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrAcrlStmpRequestDTO
* @date : 2019. 4. 18.
* @author : hy.jun
* @description :
*/
public class LoyMbrAcrlStmpReqDto {
	private String rid; //포인트 거래 RID
	private String pntTxnType1Cd;
	private String pntTxnType2Cd;
	
	//스탬프 적립 프로시저 관련
	private String mbrNo;
	private String apprDate;
	private String apprNo;
	private String rst;
	private String rstCd;
	private String rstMsg;
	private String pushMsgH;
	private String pushMsgB;
	private String mbrNoAcrl; //적립처리된 회원번호
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPntTxnType1Cd() {
		return pntTxnType1Cd;
	}
	public void setPntTxnType1Cd(String pntTxnType1Cd) {
		this.pntTxnType1Cd = pntTxnType1Cd;
	}
	public String getPntTxnType2Cd() {
		return pntTxnType2Cd;
	}
	public void setPntTxnType2Cd(String pntTxnType2Cd) {
		this.pntTxnType2Cd = pntTxnType2Cd;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	public String getApprNo() {
		return apprNo;
	}
	public void setApprNo(String apprNo) {
		this.apprNo = apprNo;
	}
	public String getRst() {
		return rst;
	}
	public void setRst(String rst) {
		this.rst = rst;
	}
	public String getRstCd() {
		return rstCd;
	}
	public void setRstCd(String rstCd) {
		this.rstCd = rstCd;
	}
	public String getRstMsg() {
		return rstMsg;
	}
	public void setRstMsg(String rstMsg) {
		this.rstMsg = rstMsg;
	}
	public String getPushMsgH() {
		return pushMsgH;
	}
	public void setPushMsgH(String pushMsgH) {
		this.pushMsgH = pushMsgH;
	}
	public String getPushMsgB() {
		return pushMsgB;
	}
	public void setPushMsgB(String pushMsgB) {
		this.pushMsgB = pushMsgB;
	}
	public String getMbrNoAcrl() {
		return mbrNoAcrl;
	}
	public void setMbrNoAcrl(String mbrNoAcrl) {
		this.mbrNoAcrl = mbrNoAcrl;
	}
}
