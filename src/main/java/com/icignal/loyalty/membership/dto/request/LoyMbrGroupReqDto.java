/**
 *
 */
package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
  * @fileName : LOYMbrRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2016. 12. 28.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 요청 DTO
  */
public class LoyMbrGroupReqDto  extends CommonDataAuthReqDto {

    private String rid;
    private String cipherKey;
    private String mbrNo;
    private String chnlNm;
    private String memDiv;
    private String tierNm;
    private String mbrStat;
    private String avlPoint;
    private String mbrType;
    private String mbrTypeCd;
	private String mbrStatCd;
	private String cardPass;
	private String chnlRid;

    public LoyMbrGroupReqDto() {
        //try {
            //this.setCipherKey(CryptoManager.getCipherKey());
        //}
       // catch ( Exception e ) {
       //     LogUtil.error(e);
      //  }
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
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

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	public String getMemDiv() {
		return memDiv;
	}

	public void setMemDiv(String memDiv) {
		this.memDiv = memDiv;
	}

	public String getTierNm() {
		return tierNm;
	}

	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}

	public String getMbrStat() {
		return mbrStat;
	}

	public void setMbrStat(String mbrStat) {
		this.mbrStat = mbrStat;
	}

	public String getAvlPoint() {
		return avlPoint;
	}

	public void setAvlPoint(String avlPoint) {
		this.avlPoint = avlPoint;
	}

	public String getMbrType() {
		return mbrType;
	}

	public void setMbrType(String mbrType) {
		this.mbrType = mbrType;
	}

	public String getMbrTypeCd() {
		return mbrTypeCd;
	}

	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}

	public String getMbrStatCd() {
		return mbrStatCd;
	}

	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}

	public String getCardPass() {
		return cardPass;
	}

	public void setCardPass(String cardPass) {
		this.cardPass = cardPass;
	}

	public String getChnlRid() {
		return chnlRid;
	}

	public void setChnlRid(String chnlRid) {
		this.chnlRid = chnlRid;
	}




}
