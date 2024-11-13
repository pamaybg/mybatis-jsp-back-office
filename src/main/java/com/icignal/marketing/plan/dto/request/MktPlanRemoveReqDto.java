package com.icignal.marketing.plan.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktPlanRemoveReqDto extends MKTBaseReqDto {
	/*
	 * 마케팅 플랜 리스트 삭제 요청 DTO
	 * 
	 * @date 2020. 06. 11.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
}
