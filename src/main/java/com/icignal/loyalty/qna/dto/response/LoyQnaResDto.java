package com.icignal.loyalty.qna.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@CommCode
@PersonalData
public class LoyQnaResDto extends GridPagingItemResDto{
	
	@MarkName(groupCode = "SR_STATUS", codeField = "srStatusCd")
	private String srStatus;
	private String srNo;
	private String srStatusCd;
	@MarkName(groupCode = "FAQ_TYPE", codeField = "srTypeCd")
	private String srType;
	private String srReqDt;
	@Decrypted(masked = "none")
	private String srTel;
	@Decrypted(masked = "none")
	private String srEmail;
	private String srReqTxt;
	private String srAnsTxt;
	
	private String rid;
	private String mbrNo;
	@Decrypted(masked = "custNm")
	private String custNm;
	private String srCmpltDt;
	private String managerNm;
	private String receipt;
	
	private String srTypeCd;
	
	
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
	public String getSrCmpltDt() {
		return srCmpltDt;
	}
	public void setSrCmpltDt(String srCmpltDt) {
		this.srCmpltDt = srCmpltDt;
	}
	public String getManagerNm() {
		return managerNm;
	}
	public void setManagerNm(String managerNm) {
		this.managerNm = managerNm;
	}
	public String getReceipt() {
		return receipt;
	}
	public void setReceipt(String receipt) {
		this.receipt = receipt;
	}
	public String getSrStatus() {
		return srStatus;
	}
	public void setSrStatus(String srStatus) {
		this.srStatus = srStatus;
	}
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}
	public String getSrType() {
		return srType;
	}
	public void setSrType(String srType) {
		this.srType = srType;
	}
	public String getSrReqDt() {
		return srReqDt;
	}
	public void setSrReqDt(String srReqDt) {
		this.srReqDt = srReqDt;
	}
	public String getSrTel() {
		return srTel;
	}
	public void setSrTel(String srTel) {
		this.srTel = srTel;
	}
	public String getSrEmail() {
		return srEmail;
	}
	public void setSrEmail(String srEmail) {
		this.srEmail = srEmail;
	}
	public String getSrReqTxt() {
		return srReqTxt;
	}
	public void setSrReqTxt(String srReqTxt) {
		this.srReqTxt = srReqTxt;
	}
	public String getSrAnsTxt() {
		return srAnsTxt;
	}
	public void setSrAnsTxt(String srAnsTxt) {
		this.srAnsTxt = srAnsTxt;
	}
	public String getSrTypeCd() {
		return srTypeCd;
	}
	public void setSrTypeCd(String srTypeCd) {
		this.srTypeCd = srTypeCd;
	}
	public String getSrStatusCd() {
		return srStatusCd;
	}
	public void setSrStatusCd(String srStatusCd) {
		this.srStatusCd = srStatusCd;
	}
	
	
}
