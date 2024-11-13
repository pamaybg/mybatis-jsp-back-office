package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyDupMbrListResDto extends GridPagingItemResDto {
	private String memcreDt	     ;
	private String mbrStCd		 ;
	private String authYn		 ;
	private String mbrNo		 ;
	private String custNm		 ;
	
	@Decrypted(masked = "none")
	private String hpNo			 ;
	
	@Decrypted(masked = "none")
	private String emailaddr	 ;
	private String birthDt		 ;
	private String svrLastDt	 ;
	private String ridMbr        ;
	private String ridCust       ;
	private String leaveDt 		        ;
	private String leaveReas            ;
	private String wpRid                ;
	private String chnlAgreSms	        ;
	private String chnlAgreSmsDt        ;
	private String chnlAgrePushDt       ;
	private String mktAgrUse	        ;
	private String chnlAgrePush			;
	private Integer usePnt	;
	private Integer preAcrlPnt ;
	

	public Integer getUsePnt() {
		return usePnt;
	}
	public void setUsePnt(Integer usePnt) {
		this.usePnt = usePnt;
	}
	public Integer getPreAcrlPnt() {
		return preAcrlPnt;
	}
	public void setPreAcrlPnt(Integer preAcrlPnt) {
		this.preAcrlPnt = preAcrlPnt;
	}
	public String getChnlAgrePush() {
		return chnlAgrePush;
	}
	public void setChnlAgrePush(String chnlAgrePush) {
		this.chnlAgrePush = chnlAgrePush;
	}
	public String getLeaveDt() {
		return leaveDt;
	}
	public void setLeaveDt(String leaveDt) {
		this.leaveDt = leaveDt;
	}
	public String getLeaveReas() {
		return leaveReas;
	}
	public void setLeaveReas(String leaveReas) {
		this.leaveReas = leaveReas;
	}
	public String getWpRid() {
		return wpRid;
	}
	public void setWpRid(String wpRid) {
		this.wpRid = wpRid;
	}
	public String getChnlAgreSms() {
		return chnlAgreSms;
	}
	public void setChnlAgreSms(String chnlAgreSms) {
		this.chnlAgreSms = chnlAgreSms;
	}
	public String getChnlAgreSmsDt() {
		return chnlAgreSmsDt;
	}
	public void setChnlAgreSmsDt(String chnlAgreSmsDt) {
		this.chnlAgreSmsDt = chnlAgreSmsDt;
	}
	public String getChnlAgrePushDt() {
		return chnlAgrePushDt;
	}
	public void setChnlAgrePushDt(String chnlAgrePushDt) {
		this.chnlAgrePushDt = chnlAgrePushDt;
	}
	public String getMktAgrUse() {
		return mktAgrUse;
	}
	public void setMktAgrUse(String mktAgrUse) {
		this.mktAgrUse = mktAgrUse;
	}
	public String getMemcreDt() {
		return memcreDt;
	}
	public void setMemcreDt(String memcreDt) {
		this.memcreDt = memcreDt;
	}
	public String getMbrStCd() {
		return mbrStCd;
	}
	public void setMbrStCd(String mbrStCd) {
		this.mbrStCd = mbrStCd;
	}
	public String getAuthYn() {
		return authYn;
	}
	public void setAuthYn(String authYn) {
		this.authYn = authYn;
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
	public String getHpNo() {
		return hpNo;
	}
	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}
	public String getEmailaddr() {
		return emailaddr;
	}
	public void setEmailaddr(String emailaddr) {
		this.emailaddr = emailaddr;
	}
	public String getBirthDt() {
		return birthDt;
	}
	public void setBirthDt(String birthDt) {
		this.birthDt = birthDt;
	}
	public String getSvrLastDt() {
		return svrLastDt;
	}
	public void setSvrLastDt(String svrLastDt) {
		this.svrLastDt = svrLastDt;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}


}
