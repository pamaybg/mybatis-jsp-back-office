package com.icignal.loyalty.faq.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class LoyFaqInsertReqDto extends CommonCondReqDto {

	private String faqName; //FAQ 제목
	private String openDate; //FAQ 게시일
	private String faqDesc; //FAQ 상세내용
	private String faqStatus; //FAQ 노출 여부
	private Boolean updateFlag; //수정여부

	private String faqId;

	private String faqLang;

	private String faqMasterId;
	private String faqSubId;
	private String seq;
	private String faqType;
	private String dpSeq;

	private String rid;

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
	public String getFaqName() {
		return faqName;
	}
	public void setFaqName(String faqName) {
		this.faqName = faqName;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public String getFaqDesc() {
		return faqDesc;
	}
	public void setFaqDesc(String faqDesc) {
		this.faqDesc = faqDesc;
	}
	public String getFaqStatus() {
		return faqStatus;
	}
	public void setFaqStatus(String faqStatus) {
		this.faqStatus = faqStatus;
	}
	public Boolean getUpdateFlag() {
		return updateFlag;
	}
	public void setUpdateFlag(Boolean updateFlag) {
		this.updateFlag = updateFlag;
	}
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
	public String getFaqMasterId() {
		return faqMasterId;
	}
	public void setFaqMasterId(String faqMasterId) {
		this.faqMasterId = faqMasterId;
	}
	public String getFaqSubId() {
		return faqSubId;
	}
	public void setFaqSubId(String faqSubId) {
		this.faqSubId = faqSubId;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
}
