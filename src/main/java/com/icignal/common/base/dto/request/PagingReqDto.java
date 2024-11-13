package com.icignal.common.base.dto.request;

/**
 * 페이징 최상위 요청 클래스
 *
 * @author jskim
 */
public class PagingReqDto extends BaseReqDto {
	private int initSize;
	private int pageSize;
	private int pageNum = 0;

	private int skipCount = 0;

	private String searchText;

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public void setSkipCount(int skipCount) {
		this.skipCount = skipCount;
	}

	public int getSkipCount() {
		if (this.skipCount != 0) {
			return this.skipCount;
		}

		if (this.pageNum == 0) {
			return 0;
		}

		return (this.pageNum - 1) * this.pageSize + this.initSize;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public int getInitSize() {
		return initSize;
	}

	public void setInitSize(int initSize) {
		this.initSize = initSize;
	}

	@Override
	public String toString() {
		return "PagingRequest [initSize=" + initSize + ", pageSize=" + pageSize
				+ ", pageNum=" + pageNum + ", skipCount=" + skipCount
				+ ", searchText=" + searchText + "]";
	}

}


