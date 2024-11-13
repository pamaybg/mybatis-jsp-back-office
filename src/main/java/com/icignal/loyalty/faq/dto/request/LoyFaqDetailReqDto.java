package com.icignal.loyalty.faq.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class LoyFaqDetailReqDto extends CommonCondReqDto {
	
	private String faqId;
	private String faqLang;

	public String getFaqId() {
		return faqId;
	}

	public void setFaqId(String faqId) {
		this.faqId = faqId;
	}

	public String getFaqLang() {
		return faqLang;
	}

	public void setFaqLang(String faqLang) {
		this.faqLang = faqLang;
	}

}
