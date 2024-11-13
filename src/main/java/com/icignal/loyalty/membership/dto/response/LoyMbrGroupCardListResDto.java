/**
 *
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
  * @fileName : LOYMbrRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2016. 12. 28.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 응답 DTO
  */
public class LoyMbrGroupCardListResDto  extends GridPagingItemResDto {

    private String rid;    
    private String mbrRid;
    private String cardNo;
    private String cardPwd;
    private String cardKndNm;
    private String stat;
    private String createDate;
    private String loseDt;
    
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getCardPwd() {
		return cardPwd;
	}
	public void setCardPwd(String cardPwd) {
		this.cardPwd = cardPwd;
	}
	public String getCardKndNm() {
		return cardKndNm;
	}
	public void setCardKndNm(String cardKndNm) {
		this.cardKndNm = cardKndNm;
	}
	public String getStat() {
		return stat;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getLoseDt() {
		return loseDt;
	}
	public void setLoseDt(String loseDt) {
		this.loseDt = loseDt;
	}






}
