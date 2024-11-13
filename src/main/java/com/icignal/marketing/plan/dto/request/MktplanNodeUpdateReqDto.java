package com.icignal.marketing.plan.dto.request;


import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktplanNodeUpdateReqDto extends MKTBaseReqDto {
	/*
	 * 마케팅 플랜 워크플로우 수정 요청 DTO
	 * 
	 * @date 2020. 06. 20.
	 * @author LEE GYEONG YOUNG
	 * 
	 */
	private String parCamId;
	private String offSetY;
	private String offSetX;
	private String camId;
	    
	public String getOffSetX() {
		return offSetX;
	}
	public void setOffSetX(String offSetX) {
		this.offSetX = offSetX;
	}
	public String getParCamId() {
		return parCamId;
	}
	public void setParCamId(String parCamId) {
		this.parCamId = parCamId;
	}
	public String getOffSetY() {
		return offSetY;
	}
	public void setOffSetY(String offSetY) {
		this.offSetY = offSetY;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	
	

}
