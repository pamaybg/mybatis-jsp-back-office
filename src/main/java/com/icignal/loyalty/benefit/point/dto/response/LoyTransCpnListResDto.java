package com.icignal.loyalty.benefit.point.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@CommCode
@PersonalData
public class LoyTransCpnListResDto  extends GridPagingItemResDto{

	private String rid;
	private String ofrNm;
	private String cpnNo;
	private String mbrNo;
	
	@Decrypted(masked="none")
	private String custNm;

	private String custStatCd;
	private String custStatCdNm;
	
	private String ofrType;
    @MarkName(groupCode = "LOY_OFR_TYPE", codeField = "ofrType")
	private String ofrTypeNm;
	private String ofrsubType;
    @MarkName(groupCode = "LOY_OFR_SUB_TYPE", codeField = "ofrsubType")
	private String ofrsubTypeNm;
    
	private String cpnStateCd;
    @MarkName(groupCode = "LOY_CPN_STAT_CD", codeField = "cpnStateCd")
	private String cpnStateCdNm;
	private String cpnIssueDt;
	private String cpnLstUsedDt;
	private String createDate;
	
	private String srcType;
	
	private String ofrValType;
    @MarkName(groupCode = "LOY_OFR_VAL_TYPE", codeField = "ofrValType")
	private String ofrValTypeNm;

	private String ofrValAmt;

	private String ridMbr;
	
	
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getOfrValType() {
		return ofrValType;
	}
	public void setOfrValType(String ofrValType) {
		this.ofrValType = ofrValType;
	}
	public String getOfrValTypeNm() {
		return ofrValTypeNm;
	}
	public void setOfrValTypeNm(String ofrValTypeNm) {
		this.ofrValTypeNm = ofrValTypeNm;
	}
	public String getOfrValAmt() {
		return ofrValAmt;
	}
	public void setOfrValAmt(String ofrValAmt) {
		this.ofrValAmt = ofrValAmt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getCpnNo() {
		return cpnNo;
	}
	public void setCpnNo(String cpnNo) {
		this.cpnNo = cpnNo;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getOfrType() {
		return ofrType;
	}
	public void setOfrType(String ofrType) {
		this.ofrType = ofrType;
	}
	public String getOfrsubType() {
		return ofrsubType;
	}
	public void setOfrsubType(String ofrsubType) {
		this.ofrsubType = ofrsubType;
	}
	public String getCpnIssueDt() {
		return cpnIssueDt;
	}
	public void setCpnIssueDt(String cpnIssueDt) {
		this.cpnIssueDt = cpnIssueDt;
	}
	public String getCpnLstUsedDt() {
		return cpnLstUsedDt;
	}
	public void setCpnLstUsedDt(String cpnLstUsedDt) {
		this.cpnLstUsedDt = cpnLstUsedDt;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getOfrsubTypeNm() {
		return ofrsubTypeNm;
	}
	public void setOfrsubTypeNm(String ofrsubTypeNm) {
		this.ofrsubTypeNm = ofrsubTypeNm;
	}
	public String getOfrTypeNm() {
		return ofrTypeNm;
	}
	public void setOfrTypeNm(String ofrTypeNm) {
		this.ofrTypeNm = ofrTypeNm;
	}
	public String getCpnStateCd() {
		return cpnStateCd;
	}
	public void setCpnStateCd(String cpnStateCd) {
		this.cpnStateCd = cpnStateCd;
	}
	public String getCpnStateCdNm() {
		return cpnStateCdNm;
	}
	public void setCpnStateCdNm(String cpnStateCdNm) {
		this.cpnStateCdNm = cpnStateCdNm;
	}
	public String getSrcType() {
		return srcType;
	}
	public void setSrcType(String srcType) {
		this.srcType = srcType;
	}

	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getCustStatCd() {
		return custStatCd;
	}
	public void setCustStatCd(String custStatCd) {
		this.custStatCd = custStatCd;
	}
	public String getCustStatCdNm() {
		return custStatCdNm;
	}
	public void setCustStatCdNm(String custStatCdNm) {
		this.custStatCdNm = custStatCdNm;
	}
	
	
}
