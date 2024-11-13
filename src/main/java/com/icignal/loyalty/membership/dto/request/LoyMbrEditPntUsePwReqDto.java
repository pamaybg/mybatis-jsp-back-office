package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.Loyalty.member.mbr.dto.request.LoyMbrEditPntUsePwRequestDTO
* @date : 2018. 12. 17.
* @author : hy.jun
* @description :
*/
public class LoyMbrEditPntUsePwReqDto extends MKTBaseReqDto {
	private String rid;
	private String ridMbr;
	private String mbrNo;
	private String pntUsePw;
	private String pntResn;
	private String pwdChgNextDate;
	private String ridPgm;
	private Integer plusDateVal;
	private String userPwd;
	private String bfPwd; //이전 패스워드
	private String altTypeCd;
	private String ridCust;
	private String altChnlTypeCd;
	private String ridConts;
	private String srcSystem;
	private String sendStatCd;
	private String plcyCd;
	private String parRid;
	private String ridAlt;
	private String tagNm;
	private String tagVal;
	private String encYn;
	private String ridVal;
	private String custNm;
	
	
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getAltTypeCd() {
		return altTypeCd;
	}
	public void setAltTypeCd(String altTypeCd) {
		this.altTypeCd = altTypeCd;
	}
	public String getRidCust() {
		return ridCust;
	}
	public void setRidCust(String ridCust) {
		this.ridCust = ridCust;
	}
	public String getAltChnlTypeCd() {
		return altChnlTypeCd;
	}
	public void setAltChnlTypeCd(String altChnlTypeCd) {
		this.altChnlTypeCd = altChnlTypeCd;
	}
	public String getRidConts() {
		return ridConts;
	}
	public void setRidConts(String ridConts) {
		this.ridConts = ridConts;
	}
	public String getSrcSystem() {
		return srcSystem;
	}
	public void setSrcSystem(String srcSystem) {
		this.srcSystem = srcSystem;
	}
	public String getSendStatCd() {
		return sendStatCd;
	}
	public void setSendStatCd(String sendStatCd) {
		this.sendStatCd = sendStatCd;
	}


	
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getPntUsePw() {
		return pntUsePw;
	}
	public void setPntUsePw(String pntUsePw) {
		this.pntUsePw = pntUsePw;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getPntResn() {
		return pntResn;
	}
	public void setPntResn(String pntResn) {
		this.pntResn = pntResn;
	}
	public String getRidPgm() {
		return ridPgm;
	}
	public void setRidPgm(String ridPgm) {
		this.ridPgm = ridPgm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getPwdChgNextDate() {
		return pwdChgNextDate;
	}
	public void setPwdChgNextDate(String pwdChgNextDate) {
		this.pwdChgNextDate = pwdChgNextDate;
	}
	public Integer getPlusDateVal() {
		return plusDateVal;
	}
	public void setPlusDateVal(Integer plusDateVal) {
		this.plusDateVal = plusDateVal;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getBfPwd() {
		return bfPwd;
	}
	public void setBfPwd(String bfPwd) {
		this.bfPwd = bfPwd;
	}
	public String getPlcyCd() {
		return plcyCd;
	}
	public void setPlcyCd(String plcyCd) {
		this.plcyCd = plcyCd;
	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getRidAlt() {
		return ridAlt;
	}
	public void setRidAlt(String ridAlt) {
		this.ridAlt = ridAlt;
	}
	public String getTagNm() {
		return tagNm;
	}
	public void setTagNm(String tagNm) {
		this.tagNm = tagNm;
	}
	public String getTagVal() {
		return tagVal;
	}
	public void setTagVal(String tagVal) {
		this.tagVal = tagVal;
	}
	public String getEncYn() {
		return encYn;
	}
	public void setEncYn(String encYn) {
		this.encYn = encYn;
	}
	public String getRidVal() {
		return ridVal;
	}
	public void setRidVal(String ridVal) {
		this.ridVal = ridVal;
	}

}
