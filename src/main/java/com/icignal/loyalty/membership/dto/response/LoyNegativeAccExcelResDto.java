package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@CommCode
@PersonalData
public class LoyNegativeAccExcelResDto extends GridPagingItemResDto{
	private String apprDate;
	private String ridMbr;
	private String mbrNo;
	@Decrypted(masked = "none")
	private String custNm;

	private String genCd;
	@MarkName(groupCode="LOY_GEN_CD", codeField="genCd")
	private String genCdNm;
	
	@Decrypted(masked = "none")
	private String mobilePhone;
	
	private String chnlNo;
	private String chnlNm;
	private Integer cnt;
	
	
	public String getApprDate() {
		return apprDate;
	}
	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getGenCd() {
		return genCd;
	}
	public void setGenCd(String genCd) {
		this.genCd = genCd;
	}
	public String getGenCdNm() {
		return genCdNm;
	}
	public void setGenCdNm(String genCdNm) {
		this.genCdNm = genCdNm;
	}
	public String getMobilePhone() {
		return mobilePhone;
	}
	public void setMobilePhone(String mobilePhone) {
		this.mobilePhone = mobilePhone;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public Integer getCnt() {
		return cnt;
	}
	public void setCnt(Integer cnt) {
		this.cnt = cnt;
	}

}
