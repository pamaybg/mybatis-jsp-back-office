package com.icignal.loyalty.faq.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyFaqDetailResDto extends StatusResDto{

	private String faqStatus;
	private String faqTitle;
	private String faqDesc;
	private String openDate;

	private String faqLang;
	private String faqSubId;
	private String seq;
	private String faqType;
	private String dpSeq;


	public String getDpSeq() {
		return dpSeq;
	}
	public void setDpSeq(String dpSeq) {
		this.dpSeq = dpSeq;
	}
	public String getFaqType() {
		return faqType;
	}
	public void setFaqType(String faqType) {
		this.faqType = faqType;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getFaqStatus() {
		return faqStatus;
	}
	public void setFaqStatus(String faqStatus) {
		this.faqStatus = faqStatus;
	}
	public String getFaqTitle() {
		return faqTitle;
	}
	public void setFaqTitle(String faqTitle) {
		this.faqTitle = faqTitle;
	}
	public String getFaqDesc() {
		return faqDesc;
	}
	public void setFaqDesc(String faqDesc) {
		this.faqDesc = faqDesc;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public String getFaqLang() {
		return faqLang;
	}
	public void setFaqLang(String faqLang) {
		this.faqLang = faqLang;
	}
	public String getFaqSubId() {
		return faqSubId;
	}
	public void setFaqSubId(String faqSubId) {
		this.faqSubId = faqSubId;
	}


}
