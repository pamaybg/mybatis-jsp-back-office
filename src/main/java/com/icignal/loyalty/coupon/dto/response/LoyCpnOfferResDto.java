package com.icignal.loyalty.coupon.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyCpnOfferResDto extends StatusResDto{
	
    //카드번호
	private String rid;
	private String commitYn;
	private String mbrNo;
	private String cardNo;
	private String mbrCNo;
	private String mbrCCardNo; 
	private String mbrCBrNo;
	private String issueChnlNo;
	
	private String rst;
	private String rstCd;
	private String rstMsg;
	private String ofrNo;
	private String chnlRid;
	private String chnlNm;
	private String chnlNo;
	
	public String getChnlRid() {
		return chnlRid;
	}
	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getCommitYn() {
		return commitYn;
	}
	public void setCommitYn(String commitYn) {
		this.commitYn = commitYn;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getMbrCNo() {
		return mbrCNo;
	}
	public void setMbrCNo(String mbrCNo) {
		this.mbrCNo = mbrCNo;
	}
	public String getMbrCCardNo() {
		return mbrCCardNo;
	}
	public void setMbrCCardNo(String mbrCCardNo) {
		this.mbrCCardNo = mbrCCardNo;
	}
	public String getMbrCBrNo() {
		return mbrCBrNo;
	}
	public void setMbrCBrNo(String mbrCBrNo) {
		this.mbrCBrNo = mbrCBrNo;
	}
	public String getIssueChnlNo() {
		return issueChnlNo;
	}
	public void setIssueChnlNo(String issueChnlNo) {
		this.issueChnlNo = issueChnlNo;
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
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}

}
