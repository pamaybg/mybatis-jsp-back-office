package com.icignal.common.base.dto.response;



/**
 * 그리드 페이징 항목 반환 클래스
 *
 * @author jskim
 *
 */
public class GridPagingItemResDto {
	private int pageNum;
	private int totalPage;
	private int totalCount;

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

}
