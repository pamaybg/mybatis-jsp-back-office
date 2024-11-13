package com.icignal.loyalty.custdi.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
@CommCode
public class LoyCustDiListResDto extends GridPagingItemResDto{

	private String rid;
	private String diNm;
	@MarkName(groupCode = "LOY_CUST_TYPE_CD", codeField = "custTypeCd")
	private String custType;
	private String custTypeCd;
	@MarkName(groupCode = "LOY_SBSC_TYPE_CD", codeField = "sbscCd")
	private String sbscCdNm;
	private String sbscCd;
	@MarkName(groupCode = "LOY_CERT_TYPE_CD", codeField = "certTypeCd")
	private String certType;
	private String certTypeCd;
	private String actYn;
	private String createDate;
	private String createBy;
	private String pgmNm;
	
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getDiNm() {
		return diNm;
	}
	public void setDiNm(String diNm) {
		this.diNm = diNm;
	}
	public String getSbscCd() {
		return sbscCd;
	}
	public void setSbscCd(String sbscCd) {
		this.sbscCd = sbscCd;
	}
	public String getActYn() {
		return actYn;
	}
	public void setActYn(String actYn) {
		this.actYn = actYn;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getSbscCdNm() {
		return sbscCdNm;
	}
	public void setSbscCdNm(String sbscCdNm) {
		this.sbscCdNm = sbscCdNm;
	}
	public String getCustTypeCd() {
		return custTypeCd;
	}
	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}
	public String getCustType() {
		return custType;
	}
	public void setCustType(String custType) {
		this.custType = custType;
	}
	public String getCertType() {
		return certType;
	}
	public void setCertType(String certType) {
		this.certType = certType;
	}
	public String getCertTypeCd() {
		return certTypeCd;
	}
	public void setCertTypeCd(String certTypeCd) {
		this.certTypeCd = certTypeCd;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	
}
