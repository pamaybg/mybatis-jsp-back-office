package com.icignal.loyalty.faq.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyFaqListResDto extends GridPagingItemResDto  {

	private String rid;
	/** 제목 */
	private String faqNm;
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

	private String faq_status;

	private String lang_nm;

	private String seq;
	private String faqType;
	
	private String faqType_e;
	private String seq_e;
	private String faqNm_e;
	private String faqDesc_e; 
	private String openDt_e;
	private String faq_status_e;


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

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getFaqNm() {
		return faqNm;
	}

	public void setFaqNm(String faqNm) {
		this.faqNm = faqNm;
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

	public String getFaq_status() {
		return faq_status;
	}

	public void setFaq_status(String faq_status) {
		this.faq_status = faq_status;
	}

	public String getLang_nm() {
		return lang_nm;
	}

	public void setLang_nm(String lang_nm) {
		this.lang_nm = lang_nm;
	}

	public String getFaqType_e() {
		return faqType_e;
	}

	public void setFaqType_e(String faqType_e) {
		this.faqType_e = faqType_e;
	}

	public String getSeq_e() {
		return seq_e;
	}

	public void setSeq_e(String seq_e) {
		this.seq_e = seq_e;
	}

	public String getFaqNm_e() {
		return faqNm_e;
	}

	public void setFaqNm_e(String faqNm_e) {
		this.faqNm_e = faqNm_e;
	}

	public String getFaqDesc_e() {
		return faqDesc_e;
	}

	public void setFaqDesc_e(String faqDesc_e) {
		this.faqDesc_e = faqDesc_e;
	}

	public String getOpenDt_e() {
		return openDt_e;
	}

	public void setOpenDt_e(String openDt_e) {
		this.openDt_e = openDt_e;
	}

	public String getFaq_status_e() {
		return faq_status_e;
	}

	public void setFaq_status_e(String faq_status_e) {
		this.faq_status_e = faq_status_e;
	}

	


}
