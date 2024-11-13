package com.icignal.systemmanagement.employee.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemEmployeePopUpResDto  extends GridPagingItemResDto {
	
	
	private String storeId;
	private String storeName;
	private String storeType;
	
	@MarkName(groupCode="ACCOUNT_STATUS",codeField="description")
	private String description;
	private String codeName;
	
	@MarkName(groupCode="COM_DIVISION_TYPE_CD",codeField="markName")
	private String markName;
	private String rid;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMarkName() {
		return markName;
	}
	public void setMarkName(String markName) {
		this.markName = markName;
	}
	public String getStoreId() {
		return storeId;
	}
	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public String getStoreType() {
		return storeType;
	}
	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
}
