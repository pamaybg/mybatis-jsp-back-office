package com.icignal.loyalty.faq.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyFaqUploadResDto extends GridPagingItemResDto{
	private String rid;
	/** 제목 */
	private String faqName;
	/** 조회수 */
	private int hitCnt;
	/** 작성자 */
	private String createBy;
	/** 등록일 */
	private String createDate;
	/** 게시일 */
	private String openDate;
	/** 상태(노출여부) */
	private boolean exposureYn;
	
	private String openDt;
	private String faqNm;

	private String lang_nm;

	private String faqStatus;
	private String faqTitle;
	private String faqDesc;

	private String faqLang;
	private String faqSubId;
	private String seq;
	private String faqType;
	private String dpSeq;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFaqName() {
		return faqName;
	}
	public void setFaqName(String faqName) {
		this.faqName = faqName;
	}
	public int getHitCnt() {
		return hitCnt;
	}
	public void setHitCnt(int hitCnt) {
		this.hitCnt = hitCnt;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getOpenDate() {
		return openDate;
	}
	public void setOpenDate(String openDate) {
		this.openDate = openDate;
	}
	public boolean isExposureYn() {
		return exposureYn;
	}
	public void setExposureYn(boolean exposureYn) {
		this.exposureYn = exposureYn;
	}
	public String getLang_nm() {
		return lang_nm;
	}
	public void setLang_nm(String lang_nm) {
		this.lang_nm = lang_nm;
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
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getFaqType() {
		return faqType;
	}
	public void setFaqType(String faqType) {
		this.faqType = faqType;
	}
	public String getDpSeq() {
		return dpSeq;
	}
	public void setDpSeq(String dpSeq) {
		this.dpSeq = dpSeq;
	}
	public String getOpenDt() {
		return openDt;
	}
	public void setOpenDt(String openDt) {
		this.openDt = openDt;
	}

	public String getFaqNm() {
		return faqNm;
	}
	public void setFaqNm(String faqNm) {
		this.faqNm = faqNm;
	}
	
	
}
