package com.icignal.loyalty.promotion.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2015. 11.24
 * @author : 안형욱
 * @description : 캠페인 템플릿 노드 리스트
 */
public class LoyCampaignGetTempNodeListReqDto extends CommonDataAuthReqDto {
	
	private String tempMstId;		//템플릿 마스터 ID
	private String camTypeCd;		//캠페인 유형 코드
	private String camPrpsCd;		//캠페인 목적 코드

	private String authType;		//권한 코드

	public String getTempMstId() {
		return tempMstId;
	}
	public void setTempMstId(String tempMstId) {
		this.tempMstId = tempMstId;
	}
	public String getCamTypeCd() {
		return camTypeCd;
	}
	public void setCamTypeCd(String camTypeCd) {
		this.camTypeCd = camTypeCd;
	}
	public String getCamPrpsCd() {
		return camPrpsCd;
	}
	public void setCamPrpsCd(String camPrpsCd) {
		this.camPrpsCd = camPrpsCd;
	}
	public String getAuthType() {return authType;}
	public void setAuthType(String authType) {this.authType = authType;}
}
