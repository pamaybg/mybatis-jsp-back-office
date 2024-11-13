package com.icignal.marketing.plan.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktWorkFlowPlanListReqDto extends MKTBaseReqDto {
	
	/*
	 * 마케팅 플랜 워크플로우 조회 요청 DTO
	 * 
	 * @date 2020. 06. 20.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	private String id;
	private String camStartDd;
	private String camEndDd;
	private String mktPlanId;
	private String camId;
	private String parCamId;
	private String offSetX;
	private String offSetY;
	private String name;
	private String planId;
	
	
	
	public String getPlanId() {
		return planId;
	}
	public void setPlanId(String planId) {
		this.planId = planId;
	}
	public String getCamStartDd() {
		return camStartDd;
	}
	public void setCamStartDd(String camStartDd) {
		this.camStartDd = camStartDd;
	}
	public String getCamEndDd() {
		return camEndDd;
	}
	public void setCamEndDd(String camEndDd) {
		this.camEndDd = camEndDd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
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
	

}
