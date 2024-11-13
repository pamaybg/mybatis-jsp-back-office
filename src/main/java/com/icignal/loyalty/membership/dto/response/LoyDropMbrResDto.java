/**
 *
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
  * @fileName : LOYMbrRequestDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2016. 12. 28.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 응답 DTO
  */

@PersonalData
@CommCode
public class LoyDropMbrResDto  extends GridPagingItemResDto {
	
	private String rid;
	private String mbrNo;
    private String custNo;
	private String tierNm;
	private String ridMbrSecsn;
	private String secsnResnEtc;
	private String secsnDate;
	@Decrypted(masked = "webId")
	private String userId;
	
    @MarkName(groupCode="LOY_SECSN_REASON_CD", codeField="secsnResnCd")
	private String secsnResnCdNm;
	private String secsnResnCd;
	private String loginInfoRid;
	@Decrypted(masked = "none")
	private String unMaskUserId;
	private String ridCust;
	private String custTypeCd;
    @MarkName(groupCode="LOY_CUST_TYPE_CD", codeField="custTypeCd")
	private String custTypeCdNm;
	private String reSbscResn;
	@Decrypted(masked = "custNm")
	private String custNm;
	@Decrypted(masked = "tel")
	private String hhp;
	@Decrypted(masked = "none")
	private String unMaskCustNm;
	@Decrypted(masked = "none")
	private String unMaskHhp;
	private String ciYn;
	private String empNo;
	private String bizrNo;
	
	
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getCiYn() {
		return ciYn;
	}
	public void setCiYn(String ciYn) {
		this.ciYn = ciYn;
	}
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
	}
	public String getUnMaskHhp() {
		return unMaskHhp;
	}
	public void setUnMaskHhp(String unMaskHhp) {
		this.unMaskHhp = unMaskHhp;
	}
	public String getCustTypeCdNm() {
		return custTypeCdNm;
	}
	public void setCustTypeCdNm(String custTypeCdNm) {
		this.custTypeCdNm = custTypeCdNm;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getReSbscResn() {
		return reSbscResn;
	}
	public void setReSbscResn(String reSbscResn) {
		this.reSbscResn = reSbscResn;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getUnMaskUserId() {
		return unMaskUserId;
	}
	public void setUnMaskUserId(String unMaskUserId) {
		this.unMaskUserId = unMaskUserId;
	}
	public String getLoginInfoRid() {
		return loginInfoRid;
	}
	public void setLoginInfoRid(String loginInfoRid) {
		this.loginInfoRid = loginInfoRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getRidMbrSecsn() {
		return ridMbrSecsn;
	}
	public void setRidMbrSecsn(String ridMbrSecsn) {
		this.ridMbrSecsn = ridMbrSecsn;
	}
	public String getSecsnResnEtc() {
		return secsnResnEtc;
	}
	public void setSecsnResnEtc(String secsnResnEtc) {
		this.secsnResnEtc = secsnResnEtc;
	}
	public String getSecsnDate() {
		return secsnDate;
	}
	public void setSecsnDate(String secsnDate) {
		this.secsnDate = secsnDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSecsnResnCdNm() {
		return secsnResnCdNm;
	}
	public void setSecsnResnCdNm(String secsnResnCdNm) {
		this.secsnResnCdNm = secsnResnCdNm;
	}
	public String getSecsnResnCd() {
		return secsnResnCd;
	}
	public void setSecsnResnCd(String secsnResnCd) {
		this.secsnResnCd = secsnResnCd;
	}



}
