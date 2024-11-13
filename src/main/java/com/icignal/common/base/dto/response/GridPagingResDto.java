package com.icignal.common.base.dto.response;

import java.util.ArrayList;
import java.util.List;


/**
 * 그리드 페이징 반환 클래스
 * 
 * @author jskim
 *
 */
public class GridPagingResDto<T> extends StatusResDto {
	private int page;
	private int total;
	private int records;
	private int index;
	private String id;
	private Object expandObj;
	private List<T> rows;

	public int getPage() {
		if(this.page == 0) {
			this.page = 1;
		}
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getTotal() {
//		if(this.total == 0) {
//			this.total = 1;
//		}
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<T> getRows() {
		if(this.rows == null) {
			this.rows = new ArrayList<T>();
		}
		return rows;
	}
	public void setRows(List<T> results) {
		this.rows = results;
	}
	/*@Override
	public String toString() {
		return "JqGridResponseDTO [page=" + page + ", total=" + total + ", id="
				+ id + ", rows=" + rows + "]";
	}*/
	public GridPagingResDto(int page, int total, String id, List<T> rows) {
		super();
		this.page = page;
		this.total = total;
		this.id = id;
		this.rows = rows;
	}
	public GridPagingResDto() {
		super();
	}
	public GridPagingResDto(Boolean success, String message) {
		super(success, message);
	}
	public int getRecords() {
		return records;
	}
	public void setRecords(int records) {
		this.records = records;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public Object getExpandObj() {
		return expandObj;
	}
	public void setExpandObj( Object expandObj) {
		this.expandObj = expandObj;
	}





}
