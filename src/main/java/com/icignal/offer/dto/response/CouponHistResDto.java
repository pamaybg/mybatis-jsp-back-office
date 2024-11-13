package com.icignal.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class CouponHistResDto extends GridPagingItemResDto {
	
	private String rid;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;
	private String cpnNo;
	
	private String cpnCreateDate;
	
	private String issType;
    @MarkName(groupCode = "LOY_CPN_ISS_TYPE", codeField = "issType")
	private String issTypeNm;
    
    private String rcptNo;
    
    
    
	public String getRcptNo() {
		return rcptNo;
	}
	public void setRcptNo(String rcptNo) {
		this.rcptNo = rcptNo;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getCpnNo() {
		return cpnNo;
	}
	public void setCpnNo(String cpnNo) {
		this.cpnNo = cpnNo;
	}
	public String getIssType() {
		return issType;
	}
	public void setIssType(String issType) {
		this.issType = issType;
	}
	public String getIssTypeNm() {
		return issTypeNm;
	}
	public void setIssTypeNm(String issTypeNm) {
		this.issTypeNm = issTypeNm;
	}
	public String getCpnOccurDt() {
		return cpnOccurDt;
	}
	public void setCpnOccurDt(String cpnOccurDt) {
		this.cpnOccurDt = cpnOccurDt;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getRidUsedChnl() {
		return ridUsedChnl;
	}
	public void setRidUsedChnl(String ridUsedChnl) {
		this.ridUsedChnl = ridUsedChnl;
	}
	public String getCpnLstusedDt() {
		return cpnLstusedDt;
	}
	public void setCpnLstusedDt(String cpnLstusedDt) {
		this.cpnLstusedDt = cpnLstusedDt;
	}
	public String getCpnCreateDate() {
		return cpnCreateDate;
	}
	public void setCpnCreateDate(String cpnCreateDate) {
		this.cpnCreateDate = cpnCreateDate;
	}
	private String cpnOccurDt;
	private String mbrNo;
	private String ridUsedChnl;
	private String cpnLstusedDt;


     
}
