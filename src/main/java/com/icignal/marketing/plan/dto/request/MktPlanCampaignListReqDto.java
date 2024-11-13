package com.icignal.marketing.plan.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktPlanCampaignListReqDto extends CommonDataAuthReqDto{
	/*
	 * 마케팅 플랜 디테일 신규 버튼 전체조회 요청 DTO
	 * 
	 * @date 2020. 06. 11.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	private String id;
	private String dispNo;
	private String camTypecd;
	private String CamNm;
	private String camStatuscd;
	private String camStartdd;
	private String camEnddd;
	private String name;
	private String createDate;
	private String createBy;

	
	public String getCamTypecd() {
		return camTypecd;
	}
	public void setCamTypecd(String camTypecd) {
		this.camTypecd = camTypecd;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDispNo() {
		return dispNo;
	}
	public void setDispNo(String dispNo) {
		this.dispNo = dispNo;
	}
	public String getCamNm() {
		return CamNm;
	}
	public void setCamNm(String camNm) {
		CamNm = camNm;
	}
	public String getCamStatuscd() {
		return camStatuscd;
	}
	public void setCamStatuscd(String camStatuscd) {
		this.camStatuscd = camStatuscd;
	}
	public String getCamStartdd() {
		return camStartdd;
	}
	public void setCamStartdd(String camStartdd) {
		this.camStartdd = camStartdd;
	}
	public String getCamEnddd() {
		return camEnddd;
	}
	public void setCamEnddd(String camEnddd) {
		this.camEnddd = camEnddd;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	
}
