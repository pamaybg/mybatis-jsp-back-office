package com.icignal.marketing.plan.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktPlanUpdateListDto extends MKTBaseReqDto{
	/*
	 * 마케팅 플랜 리스트 수정 DTO
	 * 
	 * @date 2020. 06. 11.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	private String id;
	private String planNo;
	private String planNm;
	private String planProps;
	private String planStart;
	private String planEnd;
	private String planDesc;
	private String createBy;
	private String createDate;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public String getPlanProps() {
		return planProps;
	}
	public void setPlanProps(String planProps) {
		this.planProps = planProps;
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
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	private String name;

}
