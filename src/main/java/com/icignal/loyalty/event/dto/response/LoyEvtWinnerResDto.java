package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyEvtWinnerResDto extends GridPagingItemResDto{
	private String rid;
	private String mbrNo;
	private String custNm;
	private String mbrStatus;
	private String bnfYn;
	private String bnfTypeCd;
	private String bnfDt;
	private String createDate;
	private String createBy;
	private String webId;
	private String hhpNo;
	@Decrypted(masked="none")
	private String unMaskCustNm;
	@Decrypted(masked="none")
	private String unMaskHhp;
	
	
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
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
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
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getMbrStatus() {
		return mbrStatus;
	}
	public void setMbrStatus(String mbrStatus) {
		this.mbrStatus = mbrStatus;
	}
	public String getBnfYn() {
		return bnfYn;
	}
	public void setBnfYn(String bnfYn) {
		this.bnfYn = bnfYn;
	}
	public String getBnfTypeCd() {
		return bnfTypeCd;
	}
	public void setBnfTypeCd(String bnfTypeCd) {
		this.bnfTypeCd = bnfTypeCd;
	}
	public String getBnfDt() {
		return bnfDt;
	}
	public void setBnfDt(String bnfDt) {
		this.bnfDt = bnfDt;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
}
