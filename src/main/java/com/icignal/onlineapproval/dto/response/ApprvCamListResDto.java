package com.icignal.onlineapproval.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : MKTApprvCamListResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결재 캠페인 정보 조회
 */
public class ApprvCamListResDto extends GridPagingItemResDto{
	private String id;               //아이디
	
	private String camType;          //캠페인 유형
	private String camStatus;        //캠페인 상태
	private String endDD;            //종료 일자
	private String statDD;           //시작 일자 
	private String camNm;            //캠페인명
	private String description;      //설명
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCamType() {
		return camType;
	}
	public void setCamType(String camType) {
		this.camType = camType;
	}
	public String getCamStatus() {
		return camStatus;
	}
	public void setCamStatus(String camStatus) {
		this.camStatus = camStatus;
	}
	public String getEndDD() {
		return endDD;
	}
	public void setEndDD(String endDD) {
		this.endDD = endDD;
	}
	public String getStatDD() {
		return statDD;
	}
	public void setStatDD(String statDD) {
		this.statDD = statDD;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	
	

	
	
}
