package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyMbrRecomHistoryResDto extends GridPagingItemResDto {
	private String rcmType;
	
	@Decrypted(masked = "custNm")
	private String custNm;
	private String webId;
	
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStatTypeCd")
	private String mbrStatCd;
	private String rcmCd;
	private String joinDate;
	private String mbrNo;
	private String rcmmHist;
	private String rid;
	private String serialNo;
	private String ridMbr;
	private String mbrStatTypeCd;
	
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getRcmType() {
		return rcmType;
	}
	public void setRcmType(String rcmType) {
		this.rcmType = rcmType;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getWebId() {
		return webId;
	}
	public void setWebId(String webId) {
		this.webId = webId;
	}
	public String getRcmCd() {
		return rcmCd;
	}
	public void setRcmCd(String rcmCd) {
		this.rcmCd = rcmCd;
	}
	public String getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(String joinDate) {
		this.joinDate = joinDate;
	}
	public String getMbrStatCd() {
		return mbrStatCd;
	}
	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}
	public String getRcmmHist() {
		return rcmmHist;
	}
	public void setRcmmHist(String rcmmHist) {
		this.rcmmHist = rcmmHist;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSerialNo() {
		return serialNo;
	}
	public void setSerialNo(String serialNo) {
		this.serialNo = serialNo;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getMbrStatTypeCd() {
		return mbrStatTypeCd;
	}
	public void setMbrStatTypeCd(String mbrStatTypeCd) {
		this.mbrStatTypeCd = mbrStatTypeCd;
	}
	
	
	
}

