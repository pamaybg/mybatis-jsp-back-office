package com.icignal.systemmanagement.dataset.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemGetDatasetListResDto extends GridPagingItemResDto{
	private String owner;
	private String objectName;
	private String objectType;
	private String comments;
	private String columnName;
	
	private String srcQuery;

	
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getObjectName() {
		return objectName;
	}
	public void setObjectName(String objectName) {
		this.objectName = objectName;
	}
	public String getObjectType() {
		return objectType;
	}
	public void setObjectType(String objectType) {
		this.objectType = objectType;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	
	public String getSrcQuery() {
		return srcQuery;
	}
	public void setSrcQuery(String srcQuery) {
		this.srcQuery = srcQuery;
	}
	
}
