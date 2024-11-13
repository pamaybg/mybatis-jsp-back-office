package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyEventProdEntryResDto extends GridPagingItemResDto{
	private String rid;
	private String mbrNo;
	@Decrypted(masked="custNm")
	private String custNm;
	private String mbrStatus;
	private String bnfYn;
	private String bnfTypeCd;
	private String bnfDt;
	private String createDate;
	private String createBy;
	private String webId;
	@Decrypted(masked="tel")
	private String hhpNo;
	private String ridMbr;
	private String uploadPath;
	private String bnfTypeDtl;
	@Decrypted(masked="none")
	private String unMaskCustNm;
	@Decrypted(masked="none")
	private String unMaskHhp;

	private String age;
	private String sbscTypeCd;
	@MarkName(groupCode = "LOY_SBSC_TYPE_CD", codeField = "sbscTypeCd")
	private String sbscTypeCdNm;
	
	
	public String getSbscTypeCd() {
		return sbscTypeCd;
	}
	public void setSbscTypeCd(String sbscTypeCd) {
		this.sbscTypeCd = sbscTypeCd;
	}
	public String getSbscTypeCdNm() {
		return sbscTypeCdNm;
	}
	public void setSbscTypeCdNm(String sbscTypeCdNm) {
		this.sbscTypeCdNm = sbscTypeCdNm;
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
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getBnfTypeDtl() {
		return bnfTypeDtl;
	}
	public void setBnfTypeDtl(String bnfTypeDtl) {
		this.bnfTypeDtl = bnfTypeDtl;
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
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getUploadPath() {
		return uploadPath;
	}
	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
}
