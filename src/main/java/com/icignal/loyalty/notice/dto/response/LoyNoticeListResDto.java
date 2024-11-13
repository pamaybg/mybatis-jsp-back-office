package com.icignal.loyalty.notice.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyNoticeListResDto extends GridPagingItemResDto {
	
	private String rid;
	/** 제목 */
	private String noticeNm;
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
	
	private String notice_status;
	
	private String lang_nm;

	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getNoticeNm() {
		return noticeNm;
	}
	public void setNoticeNm(String noticeNm) {
		this.noticeNm = noticeNm;
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
	public String getNotice_status() {
		return notice_status;
	}
	public void setNotice_status(String notice_status) {
		this.notice_status = notice_status;
	}
	public String getLang_nm() {
		return lang_nm;
	}
	public void setLang_nm(String lang_nm) {
		this.lang_nm = lang_nm;
	}

}
