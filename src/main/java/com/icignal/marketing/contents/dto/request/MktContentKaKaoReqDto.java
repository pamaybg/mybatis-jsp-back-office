package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktContentKaKaoReqDto extends CommonDataAuthReqDto {
	private String ridContsMst;
	private String seq;
	private String type;
	private String btnName;
	private String pcUrl;
	private String mobileUrl;
	private String counts;
	private String createBy;
	private String modifyBy;
	private String contsTypeCd;
	private String ridOfr;
	private String ridSurv;
	private String comOfrType;
	private String surveyNm;


	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getCounts() {
		return counts;
	}
	public void setCounts(String counts) {
		this.counts = counts;
	}
	public String getRidContsMst() {
		return ridContsMst;
	}
	public void setRidContsMst(String ridContsMst) {
		this.ridContsMst = ridContsMst;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getBtnName() {
		return btnName;
	}
	public void setBtnName(String btnName) {
		this.btnName = btnName;
	}
	public String getPcUrl() {
		return pcUrl;
	}
	public void setPcUrl(String pcUrl) {
		this.pcUrl = pcUrl;
	}
	public String getMobileUrl() {
		return mobileUrl;
	}
	public void setMobileUrl(String mobileUrl) {
		this.mobileUrl = mobileUrl;
	}

	public String getContsTypeCd() {
		return contsTypeCd;
	}

	public void setContsTypeCd(String contsTypeCd) {
		this.contsTypeCd = contsTypeCd;
	}

	public String getRidOfr() {
		return ridOfr;
	}

	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}

	public String getRidSurv() {
		return ridSurv;
	}

	public void setRidSurv(String ridSurv) {
		this.ridSurv = ridSurv;
	}

	public String getComOfrType() {
		return comOfrType;
	}

	public void setComOfrType(String comOfrType) {
		this.comOfrType = comOfrType;
	}

	public String getSurveyNm() {
		return surveyNm;
	}

	public void setSurveyNm(String surveyNm) {
		this.surveyNm = surveyNm;
	}
}
