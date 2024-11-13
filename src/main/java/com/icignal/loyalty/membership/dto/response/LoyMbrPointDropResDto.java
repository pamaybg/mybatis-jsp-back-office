package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyMbrPointDropResDto extends GridPagingItemResDto{

	private String mbrNo	  ;
	@Decrypted(masked = "custNm")
	private String custNm	  ;
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStTypeCd")
	private String mbrStCd	  ;
	private String expPoint	  ;
	private String expDate	  ;
	private String baseDate	  ;
	private String expyymm    ;
	private String rid		  ;
	private String mbrStTypeCd;


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
	public String getMbrStCd() {
		return mbrStCd;
	}
	public void setMbrStCd(String mbrStCd) {
		this.mbrStCd = mbrStCd;
	}
	public String getExpPoint() {
		return expPoint;
	}
	public void setExpPoint(String expPoint) {
		this.expPoint = expPoint;
	}
	public String getExpDate() {
		return expDate;
	}
	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}
	public String getBaseDate() {
		return baseDate;
	}
	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}
	public String getExpyymm() {
		return expyymm;
	}
	public void setExpyymm(String expyymm) {
		this.expyymm = expyymm;
	}
	public String getMbrStTypeCd() {
		return mbrStTypeCd;
	}
	public void setMbrStTypeCd(String mbrStTypeCd) {
		this.mbrStTypeCd = mbrStTypeCd;
	}
	

}
