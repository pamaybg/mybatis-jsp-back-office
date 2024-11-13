package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class LoySimpleMbrRegProcReqDto extends MKTBaseReqDto {

	private String empId;
	private String resultFlag;
	private String resultMsg;
	private String cipherKey;
	private String mbrNo;
	
	// 카드 등록
	private String cardNo;    // 필수  
	private String mbrRid;    // 필수
	
	private String cardPw;
	
	public LoySimpleMbrRegProcReqDto(){
		//try {
		    //this.setCipherKey(CryptoManager.getCipherKey());
		//}catch(Exception e){
			//LogUtil.error(e);
		//}
	}
	
	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getResultFlag() {
		return resultFlag;
	}

	public void setResultFlag(String resultFlag) {
		this.resultFlag = resultFlag;
	}

	public String getResultMsg() {
		return resultMsg;
	}

	public void setResultMsg(String resultMsg) {
		this.resultMsg = resultMsg;
	}

	public String getCipherKey() {
		return cipherKey;
	}

	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
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

	public String getMbrRid() {
		return mbrRid;
	}

	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}

	public String getCardPw() {
		return cardPw;
	}

	public void setCardPw(String cardPw) {
		this.cardPw = cardPw;
	}
	
	
	
	
	



}
