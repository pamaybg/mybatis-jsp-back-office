package com.icignal.marketing.plan.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktplanNodeDeleteReqDto extends MKTBaseReqDto {

	/*
	 * 마케팅 플랜 워크플로우 노드 삭제 요청 DTO
	 * 
	 * @date 2020. 06. 20.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	public String camId;

	public String getcamId() {
		return camId;
	}

	public void setcamId(String camId) {
		this.camId = camId;
	}

}
