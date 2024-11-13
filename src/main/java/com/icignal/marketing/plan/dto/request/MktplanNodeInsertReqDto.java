package com.icignal.marketing.plan.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktplanNodeInsertReqDto extends MKTBaseReqDto {
	/*
	 * 마케팅 플랜 디테일 워크플로우 캠페인 노드 생성을 위한 삽입 DTO
	 * 
	 * @date 2020. 06. 11.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	private String id;
	private String mktPlanId;
	private String camId;
	private String parCamId;
	private String offSetX;
	private String offSetY;
	
	public String getMktPlanId() {
		return mktPlanId;
	}

	public void setMktPlanId(String mktPlanId) {
		this.mktPlanId = mktPlanId;
	}
	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}

	public String getParCamId() {
		return parCamId;
	}

	public void setParCamId(String parCamId) {
		this.parCamId = parCamId;
	}

	public String getOffSetX() {
		return offSetX;
	}

	public void setOffSetX(String offSetX) {
		this.offSetX = offSetX;
	}

	public String getOffSetY() {
		return offSetY;
	}

	public void setOffSetY(String offSetY) {
		this.offSetY = offSetY;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
