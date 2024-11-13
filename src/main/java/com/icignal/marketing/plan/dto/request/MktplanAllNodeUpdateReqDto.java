package com.icignal.marketing.plan.dto.request;

import java.util.List;


import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktplanAllNodeUpdateReqDto extends MKTBaseReqDto {
	/*
	 * 마케팅 플랜 워크플로우 모든 노드 요청DTO
	 * 
	 * @date 2020. 06. 20.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	private List<MktplanNodeUpdateReqDto> nodeList;
	

	public List<MktplanNodeUpdateReqDto> getNodeList() {
		return nodeList;
	}

	public void setNodeList(List<MktplanNodeUpdateReqDto> nodeList) {
		this.nodeList = nodeList;
	}
	
}
