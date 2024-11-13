package com.icignal.systemmanagement.responseinfo.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class SystemDelResponseInfoReqDto extends MKTBaseReqDto{

	private String id;			//반응정보 아이디
	private String modifyBy;	//수정자 
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	
	
	
	
}
