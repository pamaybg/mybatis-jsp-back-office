package com.icignal.systemmanagement.condition.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;


/**
 * @name : getConditionList
 * @date : 2015. 10. 13.
 * @author : 장  용
 * @description : 템플릿 프롬프트 검증
 */
public class SystemGetConditionListReqDto extends MKTGridPagingReqDto {
	
	private String screenId;		//화면 아이디
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
