package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyLimitMbrResDto extends GridPagingItemResDto{
	
	private String rid;//RID
	private String ridMbr;//ridMbr
	private String mbrNo;//회원번호
	
	@Decrypted(masked="custNm")
	private String custNm;//회원명
	private String startDt;//시작일
	private String endDt;//종료일
	private String status;//상태
	private String statusCd;//상태코드
	private String limDesc;//제한사유
	private String relDesc;//해지사유
	@Decrypted(masked="none")
	private String unMaskCustNm;
	
	
	public String getUnMaskCustNm() {
		return unMaskCustNm;
	}
	public void setUnMaskCustNm(String unMaskCustNm) {
		this.unMaskCustNm = unMaskCustNm;
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
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getStatusCd() {
		return statusCd;
	}
	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}
	public String getLimDesc() {
		return limDesc;
	}
	public void setLimDesc(String limDesc) {
		this.limDesc = limDesc;
	}
	public String getRelDesc() {
		return relDesc;
	}
	public void setRelDesc(String relDesc) {
		this.relDesc = relDesc;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
}
