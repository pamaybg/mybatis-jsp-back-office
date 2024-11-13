package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyDormancyResDto extends GridPagingItemResDto{

	private String mbrNo 		;
	private String ecommMbrNo	;
	private String custNm		;
	private String mbrLockDt	;
	private String svrLastMbr	;
	private String chnlNm		;
	private String rid		    ;
	
	@Decrypted(masked = "tel")
	private String hhpNo;
	@Decrypted(masked = "email")
	private String emailAddr;
	private String appr1Zip;
	private String appr1Dflt;
	private String appr1Dtl;
	private String birthDt;
	
	@MarkName(groupCode="LOY_GEN_CD", codeField="gengbnTypeCd")
	private String genGbnCdNm;
	private String gengbnTypeCd;

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
	public String getMbrLockDt() {
		return mbrLockDt;
	}
	public void setMbrLockDt(String mbrLockDt) {
		this.mbrLockDt = mbrLockDt;
	}
	public String getSvrLastMbr() {
		return svrLastMbr;
	}
	public void setSvrLastMbr(String svrLastMbr) {
		this.svrLastMbr = svrLastMbr;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getEmailAddr() {
		return emailAddr;
	}
	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}
	public String getAppr1Zip() {
		return appr1Zip;
	}
	public void setAppr1Zip(String appr1Zip) {
		this.appr1Zip = appr1Zip;
	}
	public String getAppr1Dflt() {
		return appr1Dflt;
	}
	public void setAppr1Dflt(String appr1Dflt) {
		this.appr1Dflt = appr1Dflt;
	}
	public String getAppr1Dtl() {
		return appr1Dtl;
	}
	public void setAppr1Dtl(String appr1Dtl) {
		this.appr1Dtl = appr1Dtl;
	}
	public String getBirthDt() {
		return birthDt;
	}
	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}
	public String getGenGbnCdNm() {
		return genGbnCdNm;
	}
	public void setGenGbnCdNm(String genGbnCdNm) {
		this.genGbnCdNm = genGbnCdNm;
	}
	public String getEcommMbrNo() {
		return ecommMbrNo;
	}
	public void setEcommMbrNo(String ecommMbrNo) {
		this.ecommMbrNo = ecommMbrNo;
	}
	public String getGengbnTypeCd() {
		return gengbnTypeCd;
	}
	public void setGengbnTypeCd(String gengbnTypeCd) {
		this.gengbnTypeCd = gengbnTypeCd;
	}
	



}
