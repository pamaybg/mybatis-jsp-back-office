package com.icignal.loyalty.faq.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonCondReqDto;

public class LoyFaqUploadReqDto extends CommonCondReqDto {
	private String faqNm; //FAQ 제목
	private String openDate; //FAQ 게시일
	private String faqDesc; //FAQ 상세내용
	private String faqStatus; //FAQ 노출 여부
	private Boolean updateFlag; //수정여부
	
	private String faqSt;
	
	private String faqId;

	private String faqLang;
	private String faqMasterId;
	private String faqSubId;
	private String seq;
	private String faqType;
	private String dpSeq;

	private String rid;
	
	private String uploadValidCheck;
	private String fileName;
	private List<LoyFaqUploadReqDto> array;
	private int cnt;
	private boolean message;

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
	public String getFaqNm() {
		return faqNm;
	}
	public void setFaqNm(String faqNm) {
		this.faqNm = faqNm;
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
	public String getUploadValidCheck() {
		return uploadValidCheck;
	}
	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public List<LoyFaqUploadReqDto> getArray() {
		return array;
	}
	public void setArray(List<LoyFaqUploadReqDto> array) {
		this.array = array;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getFaqSt() {
		return faqSt;
	}
	public void setFaqSt(String faqSt) {
		this.faqSt = faqSt;
	}
	public boolean isMessage() {
		return message;
	}
	public void setMessage(boolean message) {
		this.message = message;
	}
	
	
	
}
