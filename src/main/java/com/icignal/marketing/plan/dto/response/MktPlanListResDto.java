package com.icignal.marketing.plan.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktPlanListResDto extends GridPagingItemResDto {
	/*
	 * 마케팅 플랜 리스트 전체조회 응답 DTO
	 * 
	 * @date 2020. 06. 11.
	 * @author LEE GYEONG YOUNG
	 * 
	 */	
	private String id;
	private String planNo;
	private String planNm;
	private String planPrps;
	private String planStart;
	private String planEnd;
	private String planDesc;
	private String createDate;
	private String name;

	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPlanDesc() {
		return planDesc;
	}
	public void setPlanDesc(String planDesc) {
		this.planDesc = planDesc;
	}
	public String getPlanNo() {
		return planNo;
	}
	public void setPlanNo(String planNo) {
		this.planNo = planNo;
	}
	public String getPlanNm() {
		return planNm;
	}
	public void setPlanNm(String planNm) {
		this.planNm = planNm;
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
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getPlanPrps() {
		return planPrps;
	}
	public void setPlanPrps(String planPrps) {
		this.planPrps = planPrps;
	}
	
	
}
