package com.icignal.systemmanagement.commcode.dto.request;

import javax.validation.constraints.NotNull;

import com.icignal.common.base.dto.request.GridPagingReqDto;

/**
 * @name : MKTCommCondListRequestDTO.java
 * @date : 2015. 9. 22.
 * @author : 장용
 * @description : 공통 조건 조회
 */
public class MKTCommonCondListRequestDTO extends GridPagingReqDto {
	
    @NotNull
	private String screenId;
    private String accntId;
    
	public String getScreenId() {
		return screenId;
	}

	public void setScreenId(String screenId) {
		this.screenId = screenId;
	}

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	
}

	
