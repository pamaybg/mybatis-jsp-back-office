package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@CommCode
@PersonalData
public class LoyDormancyPredResDto extends GridPagingItemResDto{

	private String rid         ;
	private String mbrNo       ;
	private String ecommMbrNo	;
	private String custNm      ;
	
	@MarkName(groupCode="LOY_MBR_STAT_CD", codeField="mbrStTypeCd")
	private String mbrStCd     ;
	private String dormancyDt  ;
	private String svrLastDt   ;
	@Decrypted(masked = "custNm")
	private String chnlNm      ;
	private String mbrStTypeCd ;

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
	public String getDormancyDt() {
		return dormancyDt;
	}
	public void setDormancyDt(String dormancyDt) {
		this.dormancyDt = dormancyDt;
	}
	public String getSvrLastDt() {
		return svrLastDt;
	}
	public void setSvrLastDt(String svrLastDt) {
		this.svrLastDt = svrLastDt;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getEcommMbrNo() {
		return ecommMbrNo;
	}
	public void setEcommMbrNo(String ecommMbrNo) {
		this.ecommMbrNo = ecommMbrNo;
	}
	public String getMbrStTypeCd() {
		return mbrStTypeCd;
	}
	public void setMbrStTypeCd(String mbrStTypeCd) {
		this.mbrStTypeCd = mbrStTypeCd;
	}
	


}
