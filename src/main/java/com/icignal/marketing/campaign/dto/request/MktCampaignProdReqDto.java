package com.icignal.marketing.campaign.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktCampaignProdReqDto extends CommonDataAuthReqDto{

	private String id;
	private String camId;
	private String prodId;
	private String name;
	private List<MktCampaignProdReqDto> prodList;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public List<MktCampaignProdReqDto> getProdList() {
		return prodList;
	}

	public void setProdList(List<MktCampaignProdReqDto> prodList) {
		this.prodList = prodList;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
