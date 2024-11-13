package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class UIObjectListReqDto extends GridPagingReqDto {
	
	private String objTypeCd;
	private String pgmId;

	
	public String getObjTypeCd() {
		return objTypeCd;
	}
	public void setObjTypeCd(String objTypeCd) {
		this.objTypeCd = objTypeCd;
	}
	public String getPgmId() {
		return pgmId;
	}
	public void setPgmId(String pgmId) {
		this.pgmId = pgmId;
	}
}
