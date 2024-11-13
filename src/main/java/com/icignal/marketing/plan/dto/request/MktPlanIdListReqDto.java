package com.icignal.marketing.plan.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktPlanIdListReqDto extends MKTBaseReqDto{
	/*
	 * 마케팅 플랜 리스트 특정 조회 요청 DTO
	 * 
	 * @date 2020. 06. 11.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	private String id;
	private String planNm;
	private String planPrps;
	private String planStart;
	private String planEnd;
	private String planDesc;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPlanNm() {
		return planNm;
	}
	public void setPlanNm(String planNm) {
		this.planNm = planNm;
	}
	public String getPlanPrps() {
		return planPrps;
	}
	public void setPlanPrps(String planPrps) {
		this.planPrps = planPrps;
	}
	public String getPlanStart() {
		return planStart;
	}
	public void setPlanStart(String planStart) {
		this.planStart = planStart;
	}
	public String getPlanEnd() {
		return planEnd;
	}
	public void setPlanEnd(String planEnd) {
		this.planEnd = planEnd;
	}
	public String getPlanDesc() {
		return planDesc;
	}
	public void setPlanDesc(String planDesc) {
		this.planDesc = planDesc;
	}
}
