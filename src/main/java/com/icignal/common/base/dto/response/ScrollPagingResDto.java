package com.icignal.common.base.dto.response;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.util.CommonUtil.ORDER_BY;

/**
 * 스크롤 페이징 반환 클래스
 * 
 * @author jskim
 *
 */
public class ScrollPagingResDto extends StatusResDto {
	private Integer remainCount;
	private int records;
	private String lastCreateDate;
	private String createDateColumn;
	private String filterKey;
	private String filterValue;
	private ORDER_BY orderBy;
	private Object expandObj;

	private List<Object> rows;

	public int getRecords() {
		return records;
	}

	public void setRecords(int records) {
		this.records = records;
	}

	public String getLastCreateDate() {
		return lastCreateDate;
	}

	public void setLastCreateDate(String lastCreateDate) {
		this.lastCreateDate = lastCreateDate;
	}

	public String getFilterKey() {
		return filterKey;
	}

	public void setFilterKey(String filterKey) {
		this.filterKey = filterKey;
	}

	public String getFilterValue() {
		return filterValue;
	}

	public void setFilterValue(String filterValue) {
		this.filterValue = filterValue;
	}

	public Object getExpandObj() {
		return expandObj;
	}

	public void setExpandObj(Object expandObj) {
		this.expandObj = expandObj;
	}

	public List<Object> getRows() {
		if (this.rows == null) {
			this.rows = new ArrayList<Object>();
		}
		return rows;
	}

	public void setRows(List<Object> rows) {
		this.rows = rows;
	}

	public ORDER_BY getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(ORDER_BY orderBy) {
		this.orderBy = orderBy;
	}

	public String getCreateDateColumn() {
		return createDateColumn;
	}

	public void setCreateDateColumn(String createDateColumn) {
		this.createDateColumn = createDateColumn;
	}

	public Integer getRemainCount() {
		if (this.remainCount == null) {
			this.remainCount = 0;
		}
		return remainCount;
	}

	public void setRemainCount(Integer remainCount) {
		this.remainCount = remainCount;
	}

}
