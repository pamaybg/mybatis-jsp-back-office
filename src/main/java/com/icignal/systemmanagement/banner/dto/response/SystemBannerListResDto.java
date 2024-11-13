package com.icignal.systemmanagement.banner.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemBannerListResDto extends GridPagingItemResDto{

	private String rid;
	/** 제목 */
	private String bannerNm;
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

	private String banner_status;

	private String lang_nm;
	private String bannerSeq;

	public String getBannerSeq() {
		return bannerSeq;
	}
	public void setBannerSeq(String bannerSeq) {
		this.bannerSeq = bannerSeq;
	}

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getBannerNm() {
		return bannerNm;
	}
	public void setBannerNm(String bannerNm) {
		this.bannerNm = bannerNm;
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
	public String getBanner_status() {
		return banner_status;
	}
	public void setBanner_status(String banner_status) {
		this.banner_status = banner_status;
	}
	public String getLang_nm() {
		return lang_nm;
	}
	public void setLang_nm(String lang_nm) {
		this.lang_nm = lang_nm;
	}

}
